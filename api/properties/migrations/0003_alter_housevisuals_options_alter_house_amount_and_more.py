# Generated by Django 4.2.4 on 2023-08-16 00:31

from django.db import migrations, models
import django.db.models.deletion


class Migration(migrations.Migration):

    dependencies = [
        ('properties', '0002_remove_house_visuals_housevisuals'),
    ]

    operations = [
        migrations.AlterModelOptions(
            name='housevisuals',
            options={'verbose_name_plural': 'House Visuals'},
        ),
        migrations.AlterField(
            model_name='house',
            name='amount',
            field=models.CharField(max_length=12),
        ),
        migrations.AlterField(
            model_name='housevisuals',
            name='house',
            field=models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, related_name='house_visuals', to='properties.house'),
        ),
    ]
