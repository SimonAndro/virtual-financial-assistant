# Generated by Django 4.0.2 on 2022-03-24 06:42

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('vfa', '0001_initial'),
    ]

    operations = [
        migrations.AlterField(
            model_name='account',
            name='account_num',
            field=models.IntegerField(),
        ),
    ]
