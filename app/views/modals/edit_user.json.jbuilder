json.title 'Edit User'
json.body render partial: 'users/edit', formats: %i(html), locals: body_locals
json.footer yield :action
