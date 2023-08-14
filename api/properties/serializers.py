from rest_framework import serializers

from accounts.serializers import UserDetailsSerializer
from . models import House


class HouseSerializer(serializers.ModelSerializer):

    class Meta:
        model = House
        fields = [
            'house_id', 
            'name',
            'desc',
            'amount', 
            'address',
            'longitude',
            'latitude',
            'radius', 
            'status', 
        ]