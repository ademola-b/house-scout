from django.urls import path

from . views import HouseView


urlpatterns = [
    path('', HouseView.as_view(), name="Housing Property"),
]
