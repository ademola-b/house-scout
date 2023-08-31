from django.shortcuts import render
from rest_framework import permissions
from rest_framework import status as stats
from rest_framework.generics import ListCreateAPIView, RetrieveUpdateDestroyAPIView
from rest_framework.response import Response


from . models import House, HouseVisuals
from . serializers import HouseSerializer
# Create your views here.
class HouseView(ListCreateAPIView):
    permission_classes = [permissions.IsAuthenticated]
    queryset = House.objects.all()
    serializer_class = HouseSerializer

    def get_queryset(self):
        status = self.kwargs.get('status')
        owner = self.kwargs.get('owner')
        if not self.request.user.is_authenticated:
            return House.objects.none()
        if self.request.user.is_landlord or self.request.user.is_staff:
            if status:
                if status == 'available':
                    return self.queryset.filter(user = self.request.user, status = 'available')
                elif status == 'rented-out':
                    return self.queryset.filter(user = self.request.user, status = 'rented-out')
                # to write a permission to handle if a wrong choice is provided               
            else:
                print("i did")
                return self.queryset.filter(user = self.request.user)
       
        elif not self.request.user.is_landlord:
            if owner:
                print("i did1")
                return self.queryset.filter(user__pk = owner)
            elif status:
                return self.queryset.none()

            
            print("i did12")
            return self.queryset.filter(status = 'available')
        
        else:
            return self.queryset.none()
            
    def perform_create(self, serializer):
        house=serializer.save(user = self.request.user)
        for visual in self.request.data.getlist("house_visuals"):
            HouseVisuals.objects.create(house = house, image = visual)
        return super().perform_create(serializer)
    
class PropertyUpdate(RetrieveUpdateDestroyAPIView):
    queryset = House.objects.all()
    serializer_class = HouseSerializer

    def perform_update(self, serializer):
        house = serializer.save(user = self.request.user)
        print(self.request.data)

        
        for visual in self.request.data.getlist("house_visuals"):
            HouseVisuals.objects.update_or_create(house = house, defaults={"image": visual})
            # house = HouseVisuals.objects.filter(house = house)

            # if house:
            #     house.image = visual
            # else:
            #     HouseVisuals.objects.create(house = house, image = visual)
        # house.save()
                
        return super().perform_update(serializer)
         
    