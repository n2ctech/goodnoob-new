json.title t('.edit_a_photo')
json.body render partial: 'photos/edit', formats: %i(html), locals: {photo: @photo}
json.footer yield :action
