## README

### Resouce

* Ruby 2.2.3

* Rails 4.2.4

* Mysql

### About System

* Admin

* User

### How to Contribute

* Create your branch

* Code

* Push to your branch

* Creat Pull Request

### How to Develop

* We have separate two sides: User side and Admin side

* Each side will have different layout, controller

* All css, js, images of template should be in ``` vendor ``` directory

* Admin layout and User layout should not include stylesheets of each other


### Before start

##### Install mysql ( if not yet )

```
sudo apt-get install mysql-server mysql-client libmysqlclient-dev
```

##### Update db

```
rake db:seed
```

### How to use

* Check if user has role admin

```
user.role.admin?
```
#### how to generator templates for admin

bin/rails g admin:scaffold_controller Post title:string content:text --parent_controller=admin

PS: with model Post {:title, :contnet}

* Root page
 * Authenticated user
 * Unauthenticated user
 * Admin Root user

