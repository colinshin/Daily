import time
from io import BytesIO

import xlwt
from django.contrib import admin
from django.http import HttpResponse
from django.utils.http import urlquote
from .models import Record, Department, Direction, Group, UserProfile, User, Project, Company, Region

admin.site.site_title = "Daily Report"
admin.site.site_header = "Daily Report"


@admin.register(Project)
class ProjectAdmin(admin.ModelAdmin):

    list_display = ('id', 'name')


@admin.register(Company)
class CompanyAdmin(admin.ModelAdmin):

    list_display = ('id', 'name')


@admin.register(Region)
class RegionAdmin(admin.ModelAdmin):

    list_display = ('id', 'name')


@admin.register(UserProfile)
class UserProfileAdmin(admin.ModelAdmin):
    list_display = ('user', 'employee_no', 'depart', 'group', 'direction')

    def get_readonly_fields(self, request, obj=None):
        """
        Hook for specifying custom readonly fields.
        """
        # 本想用 path 里的 add 来判断
        print(request.path)
        # 根据 obj 是否为空来判断
        if obj:
            self.readonly_fields = ["user"]
        else:
            self.readonly_fields = []
        return self.readonly_fields

    # 新增或者修改数据时，设置外键的可选值
    def formfield_for_foreignkey(self, db_field, request, **kwargs):
        print(request.path)
        if db_field.name == 'user' and request.user.is_superuser:
            user_id_list = UserProfile.objects.filter().all().values_list('user_id', flat=True)
            kwargs["queryset"] = User.objects.exclude(id__in=user_id_list)
        return super(UserProfileAdmin, self).formfield_for_foreignkey(db_field, request, **kwargs)


@admin.register(Record)
class RecordAdmin(admin.ModelAdmin):

    list_display = ['name', 'department', 'employee_no', 'direction', 'task_progress', 'tomorrow_task',
                    'group', 'pub_date']
    list_filter = ('department',)  # 过滤器
    exclude = ('creator', 'name', 'department', 'employee_no', 'direction', 'group', 'region', 'company', 'project')
    actions = ['export_excel']
    search_fields = ['name', 'employee_no', 'pub_date']

    def get_readonly_fields(self, request, obj=None):
        """
        Hook for specifying custom readonly fields.
        """
        # 本想用 path 里的 add 来判断
        print(request.path)
        # 根据 obj 是否为空来判断
        if obj:
            self.readonly_fields = []
        else:
            self.readonly_fields = []
        return self.readonly_fields

    def has_delete_permission(self, request, obj=None):  # 禁用删除按钮
        if request.user.is_superuser:
            return False
        return True

    def get_queryset(self, request):
        """
        函数作用：使当前登录的用户只能看到自己的日报
        """
        qs = super(RecordAdmin, self).get_queryset(request)
        if request.user.is_superuser:
            return qs
        else:
            departments = Department.objects.filter(leader_id=request.user.id).all().values_list('id', flat=True)
            if len(departments) > 0:
                # 是部门负责人
                return qs.filter(department__in=departments)
            else:
                return qs.filter(creator=request.user)

    def save_model(self, request, obj, form, change):
        if change:
            pass
        else:
            userprofile = UserProfile.objects.filter(user_id=request.user.id).first()
            obj.name = request.user.username
            obj.employee_no = userprofile.employee_no
            obj.department = userprofile.depar
            obj.group = userprofile.group
            obj.creator = request.user
            obj.company = userprofile.company
            obj.project = userprofile.project
            obj.region = userprofile.region
            obj.direction = userprofile.direction
        super(RecordAdmin, self).save_model(request, obj, form, change)  # this is daily file

    def export_excel(self, request, queryset):
        str_time = time.strftime("%Y%m%d", time.localtime())

        filename = urlquote('daily report')
        response = HttpResponse(content_type='application/vnd.ms-excel')
        response['Content-Disposition'] = 'attachment;filename=%s' % filename + str(str_time) + '.xls'

        wb = xlwt.Workbook(encoding='utf8')

        sheet = wb.add_sheet(str(str_time), cell_overwrite_ok=True)
        sheet = self._set_header(sheet)
        sheet = self._set_with(sheet)

        field_names = ['name', 'employee_no', 'group', 'task_progress',
                       'overall', 'tomorrow_task', 'direction',
                       'project', 'region', 'company']
        shot_names = ['task_progress', 'overall', 'tomorrow_task']
        direction_names = Direction.objects.filter().all().values_list("name",
                                                                       flat=True)

        data_list, names = self._organize_data(direction_names, queryset,
                                               field_names, shot_names)
        self._write_excel(data_list, sheet, field_names, shot_names, names)

        output = BytesIO()
        wb.save(output)

        output.seek(0)
        response.write(output.getvalue())
        return response

    export_excel.short_description = '导出Excel'

    def _write_excel(self, result_list, sheet, field_names, short_names, names):
        """

        :return:
        :param result_list:
        :param sheet:
        :param field_names:
        :param shot_names:
        :param names:
        :return:
        """
        style = xlwt.XFStyle()
        font = xlwt.Font()
        style.font = font
        al = xlwt.Alignment()
        al.horz = 0x02
        al.vert = 0x01
        style.alignment = al
        style.alignment.wrap = 1

        borders = xlwt.Borders()  # Create borders
        borders.left = xlwt.Borders.MEDIUM
        borders.right = xlwt.Borders.MEDIUM
        borders.top = xlwt.Borders.MEDIUM
        borders.bottom = xlwt.Borders.MEDIUM

        borders.left_colour = 0x3A
        borders.right_colour = 0x3A
        borders.top_colour = 0x3A
        borders.bottom_colour = 0x3A

        style1 = xlwt.XFStyle()
        style1.font = font
        al1 = xlwt.Alignment()
        al1.vert = 0x01
        al1.horz = 0x01
        style1.alignment = al1
        style1.alignment.wrap = 1
        style1.borders = borders
        tall_style = xlwt.easyxf('font:height 800')  # 36pt

        style.borders = borders
        merge_line = 0
        line = 0
        group_name = names[0]
        project_name = names[1]
        company_name = names[2]
        for data_list in result_list:
            direct = None
            start_line = line + 1
            for data_dict in data_list:
                direct = data_dict.get('direction')
                column = 0
                line = line + 1
                this_row = sheet.row(line)
                this_row.set_style(tall_style)
                for field in field_names:
                    each_cell = data_dict.get(field)
                    if field not in short_names:
                        sheet.write(line, column, each_cell, style)
                    else:
                        sheet.write(line, column, each_cell, style1)

    def _organize_data(self, direction_names, queryset, field_names, shot_names):

        """

        :param direction_names:
        :param queryset:
        :param field_names:
        :param shot_names:
        :return:
        """
        group_name = None
        project_name = None
        company_name = None
        result_list = []
        for direct_name in direction_names:
            data_list = []
            for obj in queryset:
                if group_name is None or project_name is None or \
                        company_name is None:
                    group_name = obj.group.name
                    project_name = obj.project
                    company_name = obj.company
                direct = getattr(obj, 'direction').name
                if direct_name == direct:
                    data_dict = dict()
                    for field in field_names:
                        each_cell = getattr(obj, field)
                        if field not in shot_names:
                            if field in ['group', 'direction']:
                                data_dict.update({field: each_cell.name})
                            else:
                                data_dict.update({field: each_cell})
                        else:
                            data_dict.update({field: each_cell})
                    data_list.append(data_dict)
            if len(data_list) > 0:
                result_list.append(data_list)
        return result_list, (group_name, project_name, company_name)

    def _set_header(self, sheet):
        """

        :param sheet:
        :return:
        """

        style_heading = xlwt.easyxf("""
                        font:
                            name Arial,
                            colour_index black,
                            bold on,
                            height 0x0120;
                        align:
                            wrap off,
                            vert center,
                            horiz center;
                        pattern:
                            pattern solid,
                            fore-colour yellow;
                        borders:
                            left THIN,
                            right THIN,
                            top THIN,
                            bottom THIN;
                        """)

        sheet.write(0, 0, 'name', style_heading)
        sheet.write(0, 1, 'employee_no', style_heading)
        sheet.write(0, 2, 'yewuzu', style_heading)
        sheet.write(0, 3, 'jinrimubiao', style_heading)
        sheet.write(0, 4, 'zongtijindu', style_heading)
        sheet.write(0, 5, 'mingrijihua', style_heading)
        sheet.write(0, 6, 'yewuzifenzu', style_heading)
        sheet.write(0, 7, 'suoshuxiangmu', style_heading)
        sheet.write(0, 8, 'suozaidi', style_heading)
        sheet.write(0, 9, 'suoshugongsi', style_heading)
        return sheet

    def _set_with(self, wb_sheet):
        """

        :param wb_sheet:
        :return:
        """
        wid1 = wb_sheet.col(0)
        wid1.width = 50 * 50
        wid2 = wb_sheet.col(1)
        wid2.width = 50 * 50
        wid3 = wb_sheet.col(2)
        wid3.width = 70 * 70
        wid4 = wb_sheet.col(3)
        wid4.width = 100 * 100
        wid5 = wb_sheet.col(4)
        wid5.width = 100 * 100
        wid5 = wb_sheet.col(5)
        wid5.width = 100 * 100
        wid6 = wb_sheet.col(6)
        wid6.width = 90 * 90
        wid7 = wb_sheet.col(7)
        wid7.width = 70 * 70
        wid8 = wb_sheet.col(8)
        wid8.width = 50 * 50
        wid9 = wb_sheet.col(9)
        wid9.width = 70 * 70
        return wb_sheet


@admin.register(Department)
class DepartmentAdmin(admin.ModelAdmin):
    list_display = ['id', 'name', 'leader', 'super_department']

    def has_delete_permission(self, request, obj=None):  # 禁用删除按钮
        if request.user.is_superuser:
            return True
        return False


@admin.register(Direction)
class DirectionAdmin(admin.ModelAdmin):
    list_display = ['id', 'name']

    def has_delete_permission(self, request, obj=None):  # 禁用删除按钮
        if request.user.is_superuser:
            return True
        return False

    def has_add_permission(self, request, obj=None):
        # 禁用添加按钮
        if request.user.is_superuser:
            return True
        return False


@admin.register(Group)
class GroupAdmin(admin.ModelAdmin):
    list_display = ['id', 'name']

    def has_delete_permission(self, request, obj=None):  # 禁用删除按钮
        if request.user.is_superuser:
            return True
        return False

    def has_add_permission(self, request, obj=None):
        # 禁用添加按钮
        if request.user.is_superuser:
            return True
        return False

