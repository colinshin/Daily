from django.db import models
from django.contrib.auth.models import User


class Department(models.Model):
    name = models.CharField(max_length=100, null=False, unique=True, verbose_name='部门名称')
    leader = models.ForeignKey(User, null=False, verbose_name='部门主管',
                               on_delete=models.DO_NOTHING)
    super_department = models.ForeignKey('self', null=True, on_delete=models.DO_NOTHING,
                                         default=None, verbose_name='父级部门', related_name='children')
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


class Group(models.Model):
    """ 业务组 """
    name = models.CharField(max_length=32, null=False, unique=True, verbose_name='名称')
    create_time = models.DateTimeField(auto_now_add=True)
    update_time = models.DateTimeField(auto_now=True)

    def __str__(self):
        return self.name

    class Meta:
        # 复数形式，如果只设置verbose_name，在Admin会显示为“产品信息s”
        verbose_name_plural = "业务组"
        verbose_name = "业务组"


class Direction(models.Model):
    """ 方向 """
    name = models.CharField(max_length=32, null=False, unique=True, verbose_name='名称')
    create_time = models.DateTimeField(auto_now_add=True)
    update_time = models.DateTimeField(auto_now=True)

    def __str__(self):
        return self.name

    class Meta:
        # 复数形式，如果只设置verbose_name，在Admin会显示为“产品信息s”
        verbose_name_plural = "方向"
        verbose_name = "方向"


class Record(models.Model):
    name = models.CharField(max_length=100, null=False, verbose_name='姓名')
    employee_no = models.CharField(max_length=80, null=False, verbose_name='工号')
    task_progress = models.TextField(max_length=200, null=False, verbose_name='今日任务')
    tomorrow_task = models.TextField(max_length=200, verbose_name='明日计划')
    Overall = models.TextField(max_length=200, verbose_name='总体进度')
    project = models.TextField(max_length=200,  null=False, verbose_name='所属项目')
    region = models.TextField(max_length=200,  null=False, verbose_name='所在地区')
    company = models.TextField(max_length=200,  null=False, verbose_name='所属公司')
    direction = models.ForeignKey(Direction, on_delete=models.DO_NOTHING, null=False, verbose_name='方向')
    group = models.ForeignKey(Group, on_delete=models.DO_NOTHING,  null=False, verbose_name='业务组')
    department = models.ForeignKey(Department,  on_delete=models.CASCADE, null=False, verbose_name='部门')
    creator = models.ForeignKey(User, null=False, verbose_name='创建人', on_delete=models.DO_NOTHING)
    pub_date = models.DateField('日报日期')
    create_time = models.DateTimeField(auto_now_add=True)
    update_time = models.DateTimeField(auto_now=True)

    def __str__(self):
        return self.name

    class Meta:
        # 复数形式，如果只设置verbose_name，在Admin会显示为“产品信息s”
        verbose_name_plural = "日报"
        verbose_name = "日报"


class Project(models.Model):
    """ 菜单表"""
    name = models.CharField(max_length=32, null=False, verbose_name='项目名')
    create_time = models.DateTimeField(auto_now_add=True)
    update_time = models.DateTimeField(auto_now=True)  # 自关联

    def __str__(self):
        return self.name

    class Meta:
        # 复数形式，如果只设置verbose_name，在Admin会显示为“产品信息s”
        verbose_name_plural = "项目"
        verbose_name = "项目"


class Region(models.Model):
    """ 菜单表"""
    name = models.CharField(max_length=32, null=False, verbose_name='地区名')
    create_time = models.DateTimeField(auto_now_add=True)
    update_time = models.DateTimeField(auto_now=True)  # 自关联

    def __str__(self):
        return self.name

    class Meta:
        # 复数形式，如果只设置verbose_name，在Admin会显示为“产品信息s”
        verbose_name_plural = "地区"
        verbose_name = "地区"


class Company(models.Model):
    """ 菜单表"""
    name = models.CharField(max_length=32, null=False, verbose_name='公司名')
    create_time = models.DateTimeField(auto_now_add=True)
    update_time = models.DateTimeField(auto_now=True)  # 自关联

    def __str__(self):
        return self.name

    class Meta:
        # 复数形式，如果只设置verbose_name，在Admin会显示为“产品信息s”
        verbose_name_plural = "公司"
        verbose_name = "公司"


class UserProfile(models.Model):
    user = models.OneToOneField(User, on_delete=models.CASCADE, related_name='profile', verbose_name="用户")
    employee_no = models.CharField(max_length=80, null=False, verbose_name='工号')
    depart = models.ForeignKey(Department,  on_delete=models.CASCADE, null=False, verbose_name='部门')
    direction = models.ForeignKey(Direction,  on_delete=models.CASCADE, null=False, verbose_name='方向')
    group = models.ForeignKey(Group,  on_delete=models.CASCADE, null=False, verbose_name='业务组')
    project = models.ForeignKey(Project,  on_delete=models.CASCADE, null=False, verbose_name='所属项目')
    region = models.ForeignKey(Region,  on_delete=models.CASCADE, null=False, verbose_name='所在地区')
    company = models.ForeignKey(Company,  on_delete=models.CASCADE, null=False, verbose_name='所属公司')
    create_time = models.DateTimeField(auto_now_add=True)
    update_time = models.DateTimeField(auto_now=True)

    # 应该加上这步，表示显示时返回的是自定义信息，而不是 object 形式
    def __unicode__(self):              # __str__ on Python 3
        return self.user.username

    class Meta:
        # 复数形式，如果只设置verbose_name，在Admin会显示为“产品信息s”
        verbose_name_plural = "用户属性"
        verbose_name = "用户属性"


#    class Menu(models.Model):
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


