from allauth.account.adapter import get_adapter

from rest_framework import serializers
from dj_rest_auth.serializers import UserDetailsSerializer
from dj_rest_auth.registration.serializers import RegisterSerializer
from . models import CustomUser

class CustomRegisterSerializer(RegisterSerializer):

    is_landlord = serializers.BooleanField()

    def get_cleaned_data(self):
        super(CustomRegisterSerializer, self).get_cleaned_data()
        return {
            'username': self.validated_data.get('username', ''),
            'password1': self.validated_data.get('password1', ''),
            'password2': self.validated_data.get('password2', ''),
            'email': self.validated_data.get('email', ''),
            'is_landlord': self.validated_data.get('is_landlord', ''),
        }
    
    def save(self, request):
        adapter = get_adapter()
        user = adapter.new_user(request)
        self.cleaned_data = self.get_cleaned_data()
        user = adapter.save_user(request, user, self, commit=False)
        
        user.is_landlord = self.cleaned_data.get('is_landlord')
        user.save()
        self.custom_signup(request, user)
        return user

class UserDetailsSerializer(UserDetailsSerializer):
    class Meta(UserDetailsSerializer.Meta):
        fields = [
            'pk',
            'username',
            'email',
            'first_name',
            'last_name',
            'is_landlord'
        ]

