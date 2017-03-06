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

for f in $PROJECT_DIR/app/config/*.yml
do
    # Check for .dist file we don't want to modify permenent yaml files
    if [ -f $f'.dist' ]; then
        # backup the file for input.file > output.file
        cp -f $f $f.input

        # Replace 'key: value' with variables set in environment. Uppercase the match
        perl -p -e 's/(^\s*)(\w*)(\s*:\s*)(.*$)/defined $ENV{uc$2} ? $1.$2.$3."$ENV{uc$2}" : $&/eg' $f.bak > $f

        # Remove the inputfile
        rm $f.input
    fi
done

# start the richarvey/nginx-php-fpm start.sh command
sh /start.sh
