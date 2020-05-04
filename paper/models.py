from django.conf import settings
from django.db import models


class Department(models.Model):
    name = models.CharField(max_length=100, null=False, unique=True, verbose_name='部门名称')
    leader = models.ForeignKey(settings.AUTH_USER_MODEL, null=False, verbose_name='部门主管',
                               on_delete=models.DO_NOTHING)
    super_department = models.ForeignKey('self', null=True, on_delete=models.DO_NOTHING,
                                         default=0, verbose_name='父级部门', related_name='children')
    create_time = models.DateTimeField(auto_now_add=True)
    update_time = models.DateTimeField(auto_now=True)

    def __str__(self):
        return self.name

    @property
    def children(self):
        return [c for c in Department.objects.all().filter('super_department =', self)]

    @classmethod
    def get_from_id(cls, entity_id):
        return Department.objects.filter('id=', entity_id).first()

    class Meta:
        # 复数形式，如果只设置verbose_name，在Admin会显示为“产品信息s”
        verbose_name_plural = "部门"
        verbose_name = "部门"


class Record(models.Model):
    name = models.CharField(max_length=100, null=False, verbose_name='姓名')
    employee_no = models.CharField(max_length=80, null=False, verbose_name='工号')
    business_direction = models.CharField(max_length=100, null=False, verbose_name='方向')
    task_progress = models.TextField(max_length=200, null=False, verbose_name='工作进度')
    tomorrow_task = models.TextField(max_length=200, verbose_name='明日计划')
    group = models.CharField(max_length=200, null=False, verbose_name='业务组')
    department = models.ForeignKey(Department,  on_delete=models.CASCADE, null=False, verbose_name='部门')
    creator = models.ForeignKey(settings.AUTH_USER_MODEL, null=False, verbose_name='创建人', on_delete=models.DO_NOTHING)
    pub_date = models.DateField('日报日期')
    create_time = models.DateTimeField(auto_now_add=True)
    update_time = models.DateTimeField(auto_now=True)

    def __str__(self):
        return self.name

    class Meta:
        # 复数形式，如果只设置verbose_name，在Admin会显示为“产品信息s”
        verbose_name_plural = "日报"
        verbose_name = "日报"


# class Menu(models.Model):
#     """ 菜单表"""
#     caption = models.CharField(max_length=32)
#     parent = models.ForeignKey('Menu', null=True, blank=True, on_delete=models.DO_NOTHING)  # 自关联
#
#     def __str__(self):
#         caption_list = [self.caption, ]
#         p = self.parent
#         while p:  # 如果有父级菜单，一直向上寻找
#             caption_list.insert(0, p.caption)
#             p = p.parent
#
#         return "-".join(caption_list)
#
#
# class Permission(models.Model):
#     """权限表"""
#     title = models.CharField(max_length=64)
#     url = models.CharField(max_length=255)
#     menu = models.ForeignKey('Menu', null=True, blank=True, on_delete=models.DO_NOTHING)  # 和菜单是1对多关系
#
#     def __str__(self):
#         return '权限名称:  %s--------权限所在菜单   %s' % (self.title, self.menu)
#
#
# class Role(models.Model):
#     """角色表"""
#     rolename = models.CharField(max_length=32)
#     permission = models.ManyToManyField('Permission')
#
#     def __str__(self):
#         return '角色:  %s--------权限   %s' % (self.rolename, self.permission)
#
#
# class UserInfo(models.Model):
#     """用户表"""
#     name = models.CharField(max_length=32)
#     pwd = models.CharField(max_length=64)
#     rule = models.ManyToManyField('Role')
#
#     def __str__(self):
#         return self.name


