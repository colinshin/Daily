import time

import xlwt
from django.contrib import admin
from django.http import HttpResponse
from django.utils.http import urlquote
from .models import Record, Department, Direction, Group, UserProfile,User

admin.site.site_title = "Daily Report"
admin.site.site_header = "Daily Report"


@admin.register(UserProfile)
class ProfileAdmin(admin.ModelAdmin):
    list_display = ('user', 'employee_no', 'depart', 'group', 'direction')

    # 新增或者修改数据时，设置外键的可选值
    def formfield_for_foreignkey(self, db_field, request, **kwargs):
        if db_field.name == 'user' and request.user.is_superuser:
            user_id_list = UserProfile.objects.filter().all().values_list('user_id', flat=True)
            kwargs["queryset"] = User.objects.exclude(id__in=user_id_list)
        return super(ProfileAdmin, self).formfield_for_foreignkey(db_field, request, **kwargs)


@admin.register(Record)
class RecordAdmin(admin.ModelAdmin):

    list_display = ['name', 'department', 'employee_no', 'direction', 'task_progress', 'tomorrow_task',
                    'group', 'pub_date']
    list_filter = ('department',)  # 过滤器
    exclude = ('creator', 'name', 'department', 'employee_no', 'direction', 'group')
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

    def export_excel(self, request, queryset):
        str_time = time.strftime("%Y%m%d", time.localtime())
        # field_names = [field.name for field in Record._meta.fields]  # 模型所有字段名
        field_names = ['name', 'employee_no', 'group', 'task_progress',
                       'tomorrow_task', 'direction']  # 模型所有字段名  'pub_date'
        field_names2 = ['task_progress', 'tomorrow_task']  # 模型所有字段名
        header_style = xlwt.XFStyle()  # 初始化来样式源百
        font2 = xlwt.Font()  # 为样式创建字体度
        font2.colour_index = 0xFF00
        font2.bold = True
        font2.height = 0x0160
        header_style.font = font2  # 设定样式
        al2 = xlwt.Alignment()
        al2.horz = 0x02  # 设置水平居中
        al2.vert = 0x01  # 设置垂直居中
        header_style.alignment = al2


        wb = xlwt.Workbook(encoding='utf-8')  # 开始创建excel
        wb_sheet = wb.add_sheet(str(str_time), cell_overwrite_ok=True)  # excel中的表名
        wid1 = wb_sheet.col(0)
        wid1.width = 70 * 70
        wid2 = wb_sheet.col(1)
        wid2.width = 70 * 70
        wid3 = wb_sheet.col(2)
        wid3.width = 70 * 70
        wid4 = wb_sheet.col(3)
        wid4.width = 120 * 120
        wid5 = wb_sheet.col(4)
        wid5.width = 120 * 120
        wid5 = wb_sheet.col(5)
        wid5.width = 70 * 70
        wb_sheet.write(0, 0, '姓名', header_style)
        wb_sheet.write(0, 1, '工号', header_style)
        wb_sheet.write(0, 2, '方向', header_style)
        wb_sheet.write(0, 3, '任务及进度', header_style)
        wb_sheet.write(0, 4, '明日计划', header_style)
        wb_sheet.write(0, 5, '业务组', header_style)
        style = xlwt.XFStyle()  # 初始化来样式源百
        font = xlwt.Font()  # 为样式创建字体度
        style.font = font  # 设定样式
        al = xlwt.Alignment()
        al.horz = 0x02  # 设置水平居中
        al.vert = 0x01  # 设置垂直居中
        style.alignment = al
        style.alignment.wrap = 1  # 自动知换行

        borders = xlwt.Borders()  # Create borders
        borders.left = xlwt.Borders.MEDIUM  # 添加边框-虚线边框
        borders.right = xlwt.Borders.MEDIUM  # 添加边框-虚线边框
        borders.top = xlwt.Borders.MEDIUM  # 添加边框-虚线边框
        borders.bottom = xlwt.Borders.MEDIUM  # 添加边框-虚线边框
        '''
        May be: NO_LINE, THIN, MEDIUM, DASHED, DOTTED, THICK, DOUBLE, 
        HAIR, MEDIUM_DASHED, THIN_DASH_DOTTED, MEDIUM_DASH_DOTTED, 
        THIN_DASH_DOT_DOTTED, MEDIUM_DASH_DOT_DOTTED, SLANTED_MEDIUM_DASH_DOTTED, 
        or 0x00 through 0x0D.
        '''
        borders.left_colour = 0x90  # 边框上色
        borders.right_colour = 0x90
        borders.top_colour = 0x90
        borders.bottom_colour = 0x90

        style.borders = borders
        header_style.borders = borders

        style1 = xlwt.XFStyle()  # 初始化来样式源百
        style1.font = font  # 设定样式
        al1 = xlwt.Alignment()
        al1.vert = 0x01  # 设置垂直居中
        style1.alignment = al1
        style1.alignment.wrap = 1  # 自动知换行
        style1.borders = borders
        tall_style = xlwt.easyxf('font:height 800')  # 36pt
        line = 0
        group_names = Group.objects.filter().all().values_list("name", flat=True)
        result_list = []
        for group_name in group_names:
            data_list = []
            for obj in queryset:
                if group_name == getattr(obj, 'group'):
                    data_dict = dict()
                    for field in field_names:
                        each_cell = getattr(obj, field)
                        if field not in field_names2:
                            if field in ['group', 'direction']:
                                data_dict.update({field: each_cell.name})
                            else:
                                data_dict.update({field: each_cell})
                        else:
                            data_dict.update({field: each_cell})
                    data_list.append(data_dict)
            result_list.append(data_list)
        for data_list in result_list:
            for data_dict in data_list:
                column = 0
                line = line + 1
                this_row = wb_sheet.row(line)
                this_row.set_style(tall_style)
                for field in field_names:
                    each_cell = data_dict.get(field)
                    if field not in field_names2:
                        if field in ['group', 'direction']:
                            wb_sheet.write(line, column, each_cell, style)
                        else:
                            wb_sheet.write(line, column, each_cell, style)
                    else:
                        wb_sheet.write(line, column, each_cell, style1)
                    column = column + 1
        response = HttpResponse(content_type='application/vnd.ms-excel')
        filename = urlquote('工作日报')  # 导出数据 中文文件名称 变成下载.xls
        response['Content-Disposition'] = 'attachment;filename=%s' % filename + str(str_time) + '.xlsx'
        wb.save(response)
        return response

    export_excel.short_description = '导出Excel'

    def save_model(self, request, obj, form, change):
        if change:  # 更改的时候
            pass
        else:  # 新增的时候
            userprofile = UserProfile.objects.filter(user_id=request.user.id).first()
            obj.name = request.user.username
            obj.employee_no = userprofile.employee_no
            obj.department = userprofile.depart
            obj.group = userprofile.group
            obj.creator = request.user
        super(RecordAdmin, self).save_model(request, obj, form, change)


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

