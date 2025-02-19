# 1. Python 3.12 bazasidan foydalanamiz
FROM python:3.12

# 2. Muhit o‘zgaruvchilarni o‘rnatamiz
ENV PYTHONDONTWRITEBYTECODE 1
ENV PYTHONUNBUFFERED 1
ENV CRYPTOGRAPHY_DONT_BUILD_RUST 1

# 3. Kerakli tizim paketlarini o‘rnatamiz
RUN apt-get update && \
    apt-get install -y --no-install-recommends gcc netcat-traditional

# 4. Loyihani joylashtirish uchun direktoriyalarni yaratamiz
WORKDIR /home/app/web

# 5. `requirements` fayllarini ko‘chiramiz va kutubxonalarni o‘rnatamiz
COPY requirements/ .
RUN pip install --upgrade pip
RUN pip install --no-cache-dir -r production.txt

# 6. Loyihani konteyner ichiga ko‘chiramiz
COPY . .

# 7. Migratsiyalarni bajarish
RUN python manage.py migrate

# 8. Statik fayllarni yig‘ish
RUN python manage.py collectstatic --noinput

# 9. Gunicorn orqali serverni ishga tushiramiz
CMD ["gunicorn", "--bind", "0.0.0.0:8000", "core.wsgi:application"]
