import uuid
from django.contrib.postgres.fields import ArrayField
from django.db import models

from accounts.models import CustomUser
# Create your models here.
def house_images_dir(instance, filename):
    return '{0}/{1}/{2}'.format('images', instance.user.username, filename)


class House(models.Model):
    house_id = models.UUIDField(default=uuid.uuid4, unique=True, editable=False, primary_key=True)
    user = models.ForeignKey(CustomUser, on_delete=models.CASCADE)
    name = models.CharField(max_length=30)
    desc = models.CharField(max_length=2000)
    amount = models.CharField(max_length=6)
    address = models.CharField(max_length=1000)
    longitude = models.CharField(max_length = 50)
    latitude = models.CharField(max_length = 50)
    radius = models.CharField(max_length = 3)
    status = models.CharField(max_length=50, choices= [("available", "available"), ("rented-out", "rented-out")], default="available")

    def __str__(self):
        return '{0} - {1}'.format(self.user.username, self.name)
    
class HouseVisuals(models.Model):
    visual_id = models.UUIDField(default=uuid.uuid4, unique=True, editable=False, primary_key=True)
    house = models.ForeignKey(House, on_delete=models.CASCADE, related_name="house_visuals")
    image = models.ImageField(upload_to='images/house_images', null=True, blank=True)

    class Meta:
        verbose_name_plural = "House Visuals"

