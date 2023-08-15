import base64
from django.core.files.storage import default_storage

from rest_framework import serializers

from accounts.serializers import UserDetailsSerializer
from . models import House, HouseVisuals

class HouseVisualSerializer(serializers.ModelSerializer):
    image_mem = serializers.SerializerMethodField('image_memory')
    class Meta:
        model = HouseVisuals
        fields = ['visual_id','image_mem']

    def image_memory(request, image:HouseVisuals):
        if image.image.name is not None:
            with default_storage.open(image.image.name, 'rb') as loadedfile:
                return base64.b64encode(loadedfile.read())



class HouseSerializer(serializers.ModelSerializer):

    # house_visuals = serializers.ListField(
    #     child = serializers.FileField(allow_empty_file=False, use_url=False)
    # )
    house_visuals = HouseVisualSerializer(many=True, read_only=True)
    user = UserDetailsSerializer(read_only=True)

    class Meta:
        model = House
        fields = '__all__'
        
        # [
        #     'house_id', 
        #     'name',
        #     'desc',
        #     'amount', 
        #     'address',
        #     'house',
        #     'longitude',
        #     'latitude',
        #     'radius', 
        #     'status', 
        # ]
    
    # def create(self, validated_data):
    #     validated_data.pop('house_visuals', None)
    #     return super().create(validated_data)