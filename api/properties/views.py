from django.shortcuts import render
from rest_framework import permissions
from rest_framework.generics import ListCreateAPIView

from . models import House, HouseVisuals
from . serializers import HouseSerializer
# Create your views here.
class HouseView(ListCreateAPIView):
    permission_classes = [permissions.IsAuthenticated]
    queryset = House.objects.all()
    serializer_class = HouseSerializer

    def get_queryset(self):
        if not self.request.user.is_authenticated:
            return House.objects.none()
        if self.request.user.is_landlord or self.request.user.is_staff:
            # return self.queryset.filter(user = self.request.user)
            return self.queryset.all()
        else:
            return self.queryset.none()
        
    def perform_create(self, serializer):
        house=serializer.save(user = self.request.user)
        for visual in self.request.data.getlist("house_visuals"):
            HouseVisuals.objects.create(house = house, image = visual)
        return super().perform_create(serializer)
         
    