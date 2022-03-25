from unicodedata import name
from django.urls import path
from . import views

urlpatterns = [
    path('', views.home, name='home'),
    path('login', views.loginPage, name="login"),
    path('logout', views.logoutUser, name="logout"),
    path('register', views.registerPage, name="register"),
    path('services', views.services, name="services"),
    path('user-dashboard/<str:pk>/', views.userDashboard, name="user-dashboard"),
]