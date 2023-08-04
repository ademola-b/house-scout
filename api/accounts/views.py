from django.shortcuts import render
from dj_rest_auth.registration.views import RegisterView
from rest_framework import status

from rest_framework.response import Response
from . serializers import CustomRegisterSerializer
# Create your views here.
class CustomRegisterView(RegisterView):
    serializer_class = CustomRegisterSerializer

    def create(self, request):
        serializer = self.get_serializer(data=request.data)
        serializer.is_valid(raise_exception=True)
        self.perform_create(serializer)
        return Response(serializer.data, status=status.HTTP_201_CREATED)
