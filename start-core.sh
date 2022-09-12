export RSA_PRIVATE_KEY=$(cat /etc/secrets/saleor-rsa-secret)

python manage.py migrate --no-input
gunicorn --bind :$PORT --workers 4 --worker-class uvicorn.workers.UvicornWorker saleor.asgi:application
