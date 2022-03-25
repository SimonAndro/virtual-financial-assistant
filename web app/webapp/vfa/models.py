import email
from pyexpat import model
from tkinter import CASCADE
from django.db import models
from django.contrib.auth.models import User

# Create your models here.

class Account(models.Model):
    owner = models.ForeignKey(User, on_delete=models.SET_NULL, null=True)
    account_type = models.CharField(max_length=20)
    account_num = models.IntegerField()
    balance = models.FloatField()
    opened_on = models.DateTimeField(auto_now_add=True)
    updated_on = models.DateTimeField(auto_now=True)
    account_status = models.CharField(max_length=20)
    
    