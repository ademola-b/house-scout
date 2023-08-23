from django.urls import path

from . views import HouseView, PropertyUpdate


urlpatterns = [
    path('', HouseView.as_view(), name="Housing Property"),
    path('<str:status>/', HouseView.as_view(), name="Housing Property"),
    path('<str:pk>/modify/', PropertyUpdate.as_view(), name="Update and Delete Property Detail"),
]
