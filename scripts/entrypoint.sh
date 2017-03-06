#!/bin/bash

# replace any Environment Variables that match config.yml files that also have dist files.
# in the app/config directory
# ei. paramaters.yml
#
#  ENV DATABASE_HOST dbserver
#  paramaters.yml line:
#  database_host: localhost
#  is changed to:
#  database_host: dbserver
#
# NOTE: lowercase ENV will not work: ENV database_host dbsever will fail.

# start the richarvey/nginx-php-fpm start.sh command

cd $PROJECT_DIR

# Try auto install for composer
if [ -f $PROJECT_DIR/composer.lock ]; then
  # TODO: fix --no-dev
  php /usr/bin/composer install --no-interaction
  echo "Ran Composer!"
fi
  echo "Aftercomposer run!"

for f in $PROJECT_DIR/app/config/*.yml
do
    # Check for .dist file we don't want to modify permenent yaml files
    if [ -f $f'.dist' ]; then
        # backup the file for input.file > output.file
        cp -f $f $f.input

        # Replace 'key: value' with variables set in environment. Uppercase the match
        perl -p -e 's/(^\s*)(\w*)(\s*:\s*)(.*$)/defined $ENV{uc$2} ? $1.$2.$3."$ENV{uc$2}" : $&/eg' $f.input > $f

        # Remove the inputfile
        rm $f.input
    fi
done

php $PROJECT_DIR/bin/console cache:warmup --env=prod

exec /start.sh
