# Generated by Django 4.2.4 on 2023-08-30 21:41

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('accounts', '0003_alter_customuser_profile_pix'),
    ]

    operations = [
        migrations.AlterField(
            model_name='customuser',
            name='profile_pix',
            field=models.ImageField(default='images/profile_pix/default.jpg', upload_to='images/profile_pix'),
        ),
    ]
