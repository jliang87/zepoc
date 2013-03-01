Heroku Ruby Client
==================

The Heroku Ruby Client is used to interact with the Heroku API from Ruby.

For more about the Heroku API see <http://api-docs.heroku.com>.

[![Build Status](https://secure.travis-ci.org/heroku/heroku.rb.png)](https://secure.travis-ci.org/heroku/heroku.rb)

Usage
-----

Start by creating a connection to Heroku with your credentials:

    require 'heroku-api'

    heroku = Heroku::API.new(:api_key => API_KEY)                           # use API Key
    heroku = Heroku::API.new(:username => USERNAME, :password => PASSWORD)  # use username and password
    heroku = Heroku::API.new(:headers => {'User-Agent' => 'custom'})        # use custom header

NOTE: You can leave out the `:api_key` if `ENV['HEROKU_API_KEY']` is set instead.

Now you can make requests to the api.

Requests
--------

What follows is an overview of commands you can run for the client.

For additional details about any of the commands, see the [API docs](http://api-docs.heroku.com).

### Add-ons

    heroku.delete_addon(APP, ADD_ON)    # remove the ADD_ON add-on from the app named APP
    heroku.post_addon(APP, ADD_ON)      # add ADD_ON add-on to an the app named APP
    heroku.put_addon(APP, ADD_ON)       # update the ADD_ON add-on on the app named APP
    heroku.get_addons                   # see a listing of all available add-ons
    heroku.get_addons(APP)              # see listing of installed add-ons for the app named APP

### Apps

    heroku.delete_app(APP)                  # delete the app named APP
    heroku.get_apps                         # get a list of your apps
    heroku.get_app(APP)                     # get info about the app named APP
    heroku.post_app                         # create an app with a generated name and the default stack
    heroku.post_app_maintenance(APP, '1')   # toggle maintenance mode for the app named APP
    heroku.post_app('name' => 'app')        # create an app with a specified name, APP
    heroku.put_app('name' => 'myapp')       # update an app to have a different name

### Collaborators

    heroku.delete_collaborator(APP, 'email@example.com')   # remove 'email@example.com' collaborator from APP app
    heroku.get_collaborators(APP)                          # list collaborators for APP app
    heroku.post_collaborator(APP, 'email@example.com')     # add 'email@example.com' collaborator to APP app

### Config Variables

    heroku.delete_config_var(APP, KEY)               # remove KEY key from APP app
    heroku.get_config_vars(APP)                      # get list of config vars for APP app
    heroku.put_config_vars(APP, KEY => 'value')      # set KEY key to 'value' for APP app

### Domains

    heroku.delete_domain(APP, 'example.com')   # remove the 'example.com' domain from the APP app
    heroku.get_domains(APP)                    # list configured domains for the APP app
    heroku.post_domain(APP, 'example.com')     # add 'example.com' domain to the APP app

### Keys

    heroku.delete_key('user@hostname.local') # remove the 'user@hostname.local' key
    heroku.delete_keys                       # remove all keys
    heroku.get_keys                          # list configured keys
    heroku.post_key('key data')              # add key defined by 'key data'

### Logs

    heroku.get_logs(APP) # return logs information for APP app

### Processes

    heroku.get_ps(APP)                               # list current processes for APP app
    heroku.post_ps(APP, 'command')                   # run 'command' command in context of APP app
    heroku.post_ps_restart(APP)                      # restart all processes for APP app
    heroku.post_ps_scale(APP, TYPE, QTY)             # scale TYPE type processes to QTY for APP app
    heroku.post_ps_stop(APP, 'ps' => 'web.1')        # stop 'web.1' process for APP app
    heroku.post_ps_stop(APP, 'type' => 'web')        # stop all 'web' processes for APP app
    heroku.post_ps_restart(APP, 'ps' => 'web.1')     # restart 'web.1' process for APP app
    heroku.put_dynos(APP, DYNOS)                     # set number of dynos for bamboo app APP to DYNOS
    heroku.put_workers(APP, WORKERS)                 # set number of workers for bamboo app APP to WORKERS
    heroku.post_ps_scale(APP, 'worker', WORKERS)     # set number of workers for cedar app APP to WORKERS
    
### Releases

    heroku.get_releases(APP)       # list of releases for the APP app
    heroku.get_release(APP, 'v#')  # get details of 'v#' release for APP app
    heroku.post_release(APP, 'v#') # rollback APP app to 'v#' release

### Stacks

    heroku.get_stack(APP)          # list available stacks
    heroku.put_stack(APP, STACK) # migrate APP app to STACK stack

### User

    heroku.get_user                  # list user info

Mock
----

For practice or testing you can also use a simulated Heroku:

    require 'heroku-api'

    heroku = Heroku::API.new(:api_key => API_KEY, :mock => true)

After that commands should still behave the same, but they will only modify some local data instead of updating the state of things on Heroku.

Tests
-----

To run tests, first set `ENV['HEROKU_API_KEY']` to your api key.  Then use `bundle exec rake` to run mock tests or `MOCK=false bundle exec rake` to run integration tests.

Meta
----

Released under the [MIT license](http://www.opensource.org/licenses/mit-license.php).