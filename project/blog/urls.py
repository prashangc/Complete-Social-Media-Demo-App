from django.urls import path
from rest_framework.authtoken.views import obtain_auth_token  
from .views import *

urlpatterns = [
    path('posts/', PostView.as_view()),
    path('categorys/', CategoryView.as_view()),
    path('addlike/', AddALike.as_view()), 
    path('addComment/', AddComment.as_view()), 
    path('addReply/', AddReply.as_view()), 
    path('login/', obtain_auth_token), 
    path('register/', Registernow.as_view()), 

]
