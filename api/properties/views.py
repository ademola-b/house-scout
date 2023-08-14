from django.shortcuts import render
from rest_framework.generics import ListCreateAPIView

from . models import House
from . serializers import HouseSerializer
# Create your views here.
class HouseView(ListCreateAPIView):
    queryset = House.objects.all()
    serializer_class = HouseSerializer