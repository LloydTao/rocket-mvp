echo ""
echo "- - - -"

echo ""
echo "This script will set up the Django project from scratch."
echo "It is ideal for first-time setup, or to do a hard reset."

echo ""
echo "*** Any local environment and database will be lost! ***"

echo ""
echo "Full list of changes:"

echo ""
echo "- Delete any existing environment (.env)"
echo "- Build local environment (.env)"
echo "- Set secret key for Django"
echo "- Delete any existing database"
echo "- Build and migrate database"
echo "- Load test data"
echo "- Create a Django superuser"

echo ""
read -p "Continue (y/n)? " CONT

if [ "$CONT" = "y" ]; then
  
  DJANGO_SECRET_KEY=$(tr -dc A-Za-z0-9 </dev/urandom | head -c 32)
  
  DEFAULT_USER="admin"
  DEFAULT_MAIL="admin@ignitetherocket.io"
  DEFAULT_PASS=$(tr -dc A-Za-z0-9 </dev/urandom | head -c 32)
  
  echo "Done!"
  echo ""
  echo "Deleting existing local environment..."
  
  rm -rf ".env"
  
  echo "Done!"
  echo ""
  echo "Building local environment..."
  
  python -m venv ".env"
  source ".env/Scripts/activate"
  cd "backend"
  pip install -r "requirements.txt"
  
  echo "Done!"
  echo ""
  echo "Deleting existing database..."
  
  rm -rf "db.sqlite3"
  
  echo "Done!"
  echo ""
  echo "Setting Django secret key..."
  
  export DJANGO_SECRET_KEY=$DJANGO_SECRET_KEY
  
  echo "Done!"
  echo ""
  echo "Applying database migrations..."
  
  python manage.py migrate
  
  echo "Done!"
  echo ""
  echo "Creating Django superuser..."
  
  export DJANGO_SUPERUSER_USERNAME=$DEFAULT_USER
  export DJANGO_SUPERUSER_PASSWORD=$DEFAULT_PASS
  export DJANGO_SUPERUSER_EMAIL=$DEFAULT_MAIL
  python manage.py createsuperuser --noinput
  
  echo "Done!"
  echo ""
  echo "Loading test data..."
  
  python manage.py loaddata "accounts/fixtures/testdata-users.json"
  
  echo "Done!"
  
  echo ""
  echo "Superuser credentials: "
  
  echo ""
  echo "- Username: $DEFAULT_USER"
  echo "- Email:    $DEFAULT_MAIL"
  echo "- Password: $DEFAULT_PASS"
  
else
  
  echo ""
  echo "Okay. Nothing has been changed.";
  
fi

echo ""
