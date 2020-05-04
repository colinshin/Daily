from django.conf.urls import url
from django.urls import path

from . import views
from django.views.generic.base import RedirectView

urlpatterns = [
    url(r'^favicon\.ico$', RedirectView.as_view(url=r'static/image/favicon.ico')),
    path('', views.index, name='index'),
]