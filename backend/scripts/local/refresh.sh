echo ""
echo "- - - -"

echo ""
echo "This script will refresh the Django project."
echo "It's useful for if you've fetched changes or restarted your terminal."

echo ""
echo "A Django secret key will be set, and a new admin will be created."

echo ""
echo "Full list of changes:"

echo ""
echo "- Activate local environment (.env)"
echo "- Update Python packages"
echo "- Set secret key for Django"
echo "- Migrate database"
echo "- Create a Django superuser"

echo ""
read -p "Continue (y/n)? " CONT

if [ "$CONT" = "y" ]; then
  
  DJANGO_SECRET_KEY=$(tr -dc A-Za-z0-9 </dev/urandom | head -c 32)
  
  SALT=$(tr -dc A-Za-z0-9 </dev/urandom | head -c 4)
  
  DEFAULT_USER="admin-${SALT}"
  DEFAULT_MAIL="admin-${SALT}@ignitetherocket.io"
  DEFAULT_PASS=$(tr -dc A-Za-z0-9 </dev/urandom | head -c 32)
  
  echo "Done!"
  echo ""
  echo "Activating local environment..."
  
  source ".env/Scripts/activate"
  
  echo "Done!"
  echo ""
  echo "Updating local environment..."
  
  cd "backend"
  pip install -r "requirements.txt"
  
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
