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

4. Generate a User from devise

5. Set default devise configurations

5. Generate a private controller to get confirmation that devise/jwt are setup properly

6. Generate users sessions and registrations controllers to manage the tokens
7. Override the default devise routes in the routes.rb

8. Perform secret key configuration so that the token is not shared publicly
9. Configure the devise-jwt in devise.rb

10. Generate jwt_denylist model 
11. Update the user model for JWT