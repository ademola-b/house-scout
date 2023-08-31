from django.contrib.auth.models import AbstractUser
from django.db import models

# Create your models here.
class CustomUser(AbstractUser):
    email = models.EmailField(unique=True)
    phone = models.CharField(max_length=15, null=True, blank=True)
    is_landlord = models.BooleanField(default=False)
    profile_pix = models.ImageField(upload_to="images/profile_pix", default="images/profile_pix/default.jpg")
    gender = models.CharField(choices=[("male", "male"), ("female", "female")], null=True, blank=True)
    address = models.CharField(max_length=1000, null=True, blank=True)

from django.contrib.auth import get_user_model
from django.contrib.auth.backends import ModelBackend

class EmailBackend(ModelBackend):
    def authenticate(self, request, username=None, password=None, **kwargs):
        UserModel = get_user_model()
        try:
            user = UserModel.objects.get(username=username)
        except UserModel.DoesNotExist:
            try:
                user = UserModel.objects.get(email=username)
            except UserModel.DoesNotExist:
                # Run the default password hasher once to reduce the timing
                # difference between an existing and a nonexistent user (#20760).
                UserModel().set_password(password)
            else:
                if user.check_password(password) and self.user_can_authenticate(user):
                    return user
        else:
            if user.check_password(password) and self.user_can_authenticate(user):
                return user

