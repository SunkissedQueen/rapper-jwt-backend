## References
[Dakota L Martinez](https://github.com/DakotaLMartinez/rails-devise-jwt-tutorial)  
[Villy Siu](https://medium.com/@villysiu/authenticate-user-with-devise-gem-and-devise-jwt-in-react-application-1-2-a869477a2cb3)
[Elyse Montano](https://github.com/elysemontano/apartment-app-backend)

## 1. Create initial API configuration
- $ rails new rapper_app_backend -d postgresql -T
- $ cd rapper_app_backend
- $ rails db:create
- $ rails s
- $ bundle add rspec-rails
- $ rails generate rspec:install
- $ git branch -m main
- $ git remote add origin https://github.com/SunkissedQueen/rapper-jwt-backend.git
- $ git branch -m main
- $ git status
- $ ga .
- $ gcmsg "initial commit"
- $ git push origin main

## 2. Add the appropriate ruby gems for devise and jwt setup
```rb
  # in the Gemfile
  # CORS allows rails to accept requests from any origin *
  gem 'rack-cors'
  # ‘devise’ and ‘devise-jwt’ for authentication and the dispatch and revocation of JWT tokens
  gem 'devise'
  gem 'devise-jwt'
  # 'dotenv-rails' is for storing secret key in ENV file
  gem 'dotenv-rails', groups: [:development, :test]
```
## 3. cors.rb file
- Create config/initializers/cors.rb file
- Add the authorization code for devise/JWT to the cors.rb file
```rb
  # config/initializers/cors.rb
  # "Authorization" header exposed to dispatch and receive JWT tokens in Auth headers
  Rails.application.config.middleware.insert_before 0, Rack::Cors do
    allow do
      origins '*'
      resource(
      '*',
      headers: :any,
      expose: ["Authorization"],
      methods: [:get, :patch, :put, :delete, :post, :options, :show]
      )
    end
  end
```
- $ bundle install

## 4. Generate a User from devise
- $ rails generate devise:install
- $ rails generate devise User
- $ rails db:migrate

## 5. Set default devise default configurations
```rb
  # Configurations we will need to make our app work properly with Devise. 
  # set up the default url options for the Devise mailer in our development environment
  # config/environments/development.rb
  config.action_mailer.default_url_options = { host: 'localhost', port: 3000 }

  # instruct Devise to listen for logout requests via a get request instead of the default delete
  # config/initializers/devise.rb

  # Find this line:
  config.sign_out_via = :delete
  # And replace it with this:
  config.sign_out_via = :get

  # set our navigational formats to empty in the generated devise since this is an API that will not use views
  # config/initializers/devise.rb
  # ==> Navigation configuration
  config.navigational_formats = []
```

## 5. Controllers and route for devise/jwt
- When the user signs in, Devise creates a user session which shows authentication. We need to create two controllers (sessions, registrations) to handle sign ups and sign ins.
- The private test will give confirmation that a jwt is successfully generated. 
### Generate a private controller 
- $ rails g controller private test
***NOTE: this syntax allows a controller to be created with a method***
```rb
  # to get confirmation that devise/jwt are setup properly after authenication
  class PrivateController < ApplicationController
    before_action :authenticate_user!
    def test
      render json: {
        message: "This is a private message for #{current_user.email} you should only see if you've got a correct token"
      }
    end
  end
```
### Generate users sessions and registrations controllers
- $ rails g devise:controllers users -c sessions registrations
- Now, we have to tell devise to respond to JSON requests by adding the following methods in the RegistrationsController and SessionsController.
```rb
  # app/users/registrations_controller.rb
  class Users::RegistrationsController < Devise::RegistrationsController
    respond_to :json
    def create
      build_resource(sign_up_params)
      resource.save
      sign_in(resource_name, resource)
      render json: resource
    end
  end
  # app/users/sessions_controller.rb
  class Users::SessionsController < Devise::SessionsController
    respond_to :json
    private
    def respond_with(resource, _opts = {})
      render json: resource
    end
    def respond_to_on_destroy
      render json: { message: "Logged out." }
    end
  end
```
7. Override the default devise routes in the routes.rb
```rb
  Rails.application.routes.draw do
    get 'private/test'
    devise_for :users, path: '', path_names: {
      sign_in: 'login',
      sign_out: 'logout',
      registration: 'signup'
    },
    controllers: {
      sessions: 'users/sessions',
      registrations: 'users/registrations'
    }
  end
```

8. Perform secret key configuration so that the token is not shared publicly
9. Configure the devise-jwt in devise.rb

10. Generate jwt_denylist model 
11. Update the user model for JWT