from django.contrib import admin
from .models import Category,Post,Comment,Like,Reply

# Register your models here.
admin.site.register([Category,Post,Comment,Like,Reply])