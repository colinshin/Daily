from django.shortcuts import render
from django.shortcuts import reverse,redirect
# Create your views here.
from django.http import HttpResponse, HttpResponseRedirect


def index(request):
    return HttpResponseRedirect('/admin/login')