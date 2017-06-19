module ApplicationHelper

  def modal_button_tag content, action = nil, method: :post, **options
    action, content = content, nil unless action
    is_button = !options.delete(:link)

    if tag_class = options.delete(:class)
      tag_class.join(' ') if tag_class.is_a? Array
    else
      tag_class = is_button ? 'btn btn-primary' : ''
    end
    tag_class.with_word! 'show-modal'

    tag_data = options.delete(:data) || {}
    tag_data.merge! options.extract! :disable_cache

    if is_button
      tag_options = options.extract! :type, :name
      tag_options.reverse_merge! type: :button, name: nil
    else
      tag_options = {}
    end

    tag_options.merge! data: tag_data
    tag_options.merge! class: tag_class

    options.merge! options.extract! :request_params

    tag_content = capture do
      concat content if content
      concat capture yield if block_given?
      capture do
        form_tag action, method: method, class: 'hidden' do
          options.each { |key, value| concat hidden_field_tag key, value, id: nil }
        end
      end.tap { |form| concat form }
    end

    is_button ? button_tag(tag_content, tag_options) : link_to(tag_content, '#', tag_options)
  end

  def sub_category_cover(sub_category)
    @sub_category = sub_category
    if @sub_category.picture.present?
      "background: url('#{ @sub_category.picture.url(:subcatcover) }') no-repeat top left"
    end
  end

  def current_locale
    session[:locale] || :en
  end

  def home_page_description
    case current_locale.to_sym
    when :es
      'Plataforma social especializada en deportes extremos: Snowboard, Ski, Surf, Skate… Aprende, Comparte y Busca entre las mejores marcas internacionales y locales'
    else
      'Social platform specialized in extreme sports: Snowboard, Ski, Surf, Skate… Learn, Share and Search between the best international and local brands'
    end
  end

end
