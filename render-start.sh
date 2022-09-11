#!/usr/bin/env bash
set -e # exit on error

source helpers/variables.sh


subcommand=$1
case $subcommand in
  server)
    gunicorn --bind :$PORT --workers 4 --worker-class uvicorn.workers.UvicornWorker saleor.asgi:application
    ;;
  worker)
    celery -A saleor --app=saleor.celeryconf:app worker --loglevel=info -E
    ;;
  cron)
    python3 manage.py update_exchange_rates --all
    ;;
  *)
    echo "Unknown subcommand"
    ;;
esac
