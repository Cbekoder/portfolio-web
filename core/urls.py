from django.conf import settings
from django.conf.urls.static import static
from django.contrib import admin
from django.shortcuts import redirect
from django.urls import include, path
from django.urls.conf import re_path

from apps.main.views import HomePage
from core.swagger.schema import swagger_urlpatterns

urlpatterns = [
    # path('admin/', admin.site.urls),
    path('', HomePage.as_view()),
    re_path(r'^.*$', lambda request: redirect('/')),
]

urlpatterns += swagger_urlpatterns

if settings.DEBUG:
    urlpatterns += static(settings.MEDIA_URL, document_root=settings.MEDIA_ROOT)
    urlpatterns += static(settings.STATIC_URL, document_root=settings.STATIC_ROOT)

