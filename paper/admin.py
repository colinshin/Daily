import time

import xlwt
from django.contrib import admin
from django.http import HttpResponse
from django.utils.http import urlquote
from .models import Record, Department

admin.site.site_title = "Daily Report"
admin.site.site_header = "Daily Report"


@admin.register(Record)
class RecordAdmin(admin.ModelAdmin):
    list_display = ['name', 'department', 'employee_no', 'business_direction', 'task_progress', 'tomorrow_task', 'group']
    actions = ['export_excel']
    search_fields = ['name', 'employee_no']

    def has_delete_permission(self, request, obj=None):# 禁用删除按钮
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
            department = Department.objects.filter(leader_id=request.user.id).first()
            if department:
                # 是部门负责人
                return qs.filter(department=department)
            else:
                return qs.filter(creator=request.user)

    def export_excel(self, request, queryset):
        str_time = time.strftime("%Y%m%d", time.localtime())
        # field_names = [field.name for field in Record._meta.fields]  # 模型所有字段名
        field_names = ['id', 'name', 'employee_no', 'business_direction', 'task_progress',
                       'tomorrow_task', 'pub_date']  # 模型所有字段名
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
        wid1.width = 50 * 50
        wid2 = wb_sheet.col(1)
        wid2.width = 50 * 50
        wid3 = wb_sheet.col(2)
        wid3.width = 50 * 50
        wid4 = wb_sheet.col(3)
        wid4.width = 50 * 50
        wid5 = wb_sheet.col(4)
        wid5.width = 120 * 120
        wid5 = wb_sheet.col(5)
        wid5.width = 120 * 120
        wb_sheet.write(0, 0, '编号', header_style)
        wb_sheet.write(0, 1, '姓名', header_style)
        wb_sheet.write(0, 2, '工号', header_style)
        wb_sheet.write(0, 3, '方向', header_style)
        wb_sheet.write(0, 4, '任务及进度', header_style)
        wb_sheet.write(0, 5, '明日计划', header_style)
        wb_sheet.write(0, 6, '业务组', header_style)
        style = xlwt.XFStyle()  # 初始化来样式源百
        font = xlwt.Font()  # 为样式创建字体度
        style.font = font  # 设定样式
        al = xlwt.Alignment()
        al.horz = 0x02  # 设置水平居中
        al.vert = 0x01  # 设置垂直居中
        style.alignment = al
        style.alignment.wrap = 1  # 自动知换行

        style1 = xlwt.XFStyle()  # 初始化来样式源百
        style1.font = font  # 设定样式
        al1 = xlwt.Alignment()
        al1.vert = 0x01  # 设置垂直居中
        style1.alignment = al1
        style1.alignment.wrap = 1  # 自动知换行
        tall_style = xlwt.easyxf('font:height 800')  # 36pt
        line = 0
        for obj in queryset:  # 遍历选择的对象列表
            column = 0
            line = line + 1
            this_row = wb_sheet.row(line)
            this_row.set_style(tall_style)
            for field in field_names:
                each_cell = getattr(obj, field)
                if field not in field_names2:
                    wb_sheet.write(line, column, each_cell, style)
                else:
                    wb_sheet.write(line, column, each_cell, style1)
                column = column + 1
            # data = [f'{getattr(obj, field)}' for field in field_names]  # 将模型属性值的文本格式组成列表
            # wb_sheet.append(data)  # 写入模型属性值
        response = HttpResponse(content_type='application/vnd.ms-excel')
        filename = urlquote('工作日报')  # 导出数据 中文文件名称 变成下载.xls
        response['Content-Disposition'] = 'attachment;filename=%s' % filename + str(str_time) + '.xlsx'
        # response['Content-Disposition'] = 'attachment;filename=' + str(str_time) +'.xlsx'
        wb.save(response)
        return response

    export_excel.short_description = '导出Excel'

    def save_model(self, request, obj, form, change):
        if change:  # 更改的时候
            obj.creator = request.user
        super(RecordAdmin, self).save_model(request, obj, form, change)


# admin.site.register(Record)
# admin.site.register(Department)
@admin.register(Department)
class DepartmentAdmin(admin.ModelAdmin):
    list_display = ['id', 'name', 'leader', 'super_department']

    def has_delete_permission(self, request, obj=None):# 禁用删除按钮
        if request.user.is_superuser:
            return True
        return False

