set -o errexit
pip install -r requirements.txt


python manage.py migrate

python manage.py collectstatic --noinput

echo "from django.contrib.auth import get_user_model; \
User = get_user_model(); \
username='${DJANGO_SUPERUSER_USERNAME}'; \
exists = User.objects.filter(username=username).exists(); \
exit(0) if exists else User.objects.create_superuser(username='${DJANGO_SUPERUSER_USERNAME}', email='${DJANGO_SUPERUSER_EMAIL}', password='${DJANGO_SUPERUSER_PASSWORD}')" | python manage.py shell
