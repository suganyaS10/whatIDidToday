Application Set Up in Local

Clone this repository

git clone 'https://github.com/suganyaS10/whatIDidToday.git'

cd to the project directory and run bundle install

This application uses mysql as Database.

check the database configuration in config/database.yml and modify it accordingly

Then run rake db:create rake db:migrate rake seed:sample (To seed initial data. this loads an admin user and few tasks with likes and comments)

run

rails s

open the application in browser

Log in using

Email: admin123@gmail.com password: admin123

You can also Register yourself or Login