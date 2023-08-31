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
    desc = models.CharField(max_length=2000, blank=True, null=True)
    amount = models.CharField(max_length=12)
    address = models.CharField(max_length=1000, blank=True, null=True)
    category = models.CharField(choices=[("rent", "rent"), ("lease", "lease")], default="rent", max_length=7)
    bedroom = models.IntegerField(default=0)
    bathroom = models.IntegerField(default=0)
    kitchen = models.IntegerField(default=0)
    furnished_type = models.CharField(choices=[("unfurnished", "unfurnished"), ("semi-furnished", "semi-furnished"), ("fully-furnished", "fully-furnished")], default="unfurnished")
    tenant_type = models.CharField(choices=[("family", "family"), ("bachelor", "bachelor")], default="bachelor")

    
    longitude = models.CharField(max_length = 50, blank=True, null=True)
    latitude = models.CharField(max_length = 50, blank=True, null=True)
    radius = models.CharField(max_length = 3, blank=True, null=True)
    status = models.CharField(max_length=50, choices= [("available", "available"), ("rented-out", "rented-out")], default="available")

    def __str__(self):
        return '{0} - {1}'.format(self.user.username, self.name)
    
class HouseVisuals(models.Model):
    visual_id = models.UUIDField(default=uuid.uuid4, unique=True, editable=False, primary_key=True)
    index = models.IntegerField(default=0)
    house = models.ForeignKey(House, on_delete=models.CASCADE, related_name="house_visuals")
    image = models.ImageField(upload_to='images/house_images', null=True, blank=True)

    class Meta:
        verbose_name_plural = "House Visuals"
    
    def __str__(self):
        return '{0}'.format(self.house.name)

