module ViewHelper

  def modal_link(text = 'Modal link', add_class = nil, message = nil)
    data = { toggle: 'modal', target: '#SignInModal' }
    data[:message] = message if message.present?

    content_tag(:a, text, class: add_class, data: data)
  end

  def guide_video_with_share(guide)
    video_url = VideoInfo.new(guide.video_url).embed_url
    content_tag(:div, class: 'embed-responsive embed-responsive-16by9') do
      content_tag(:iframe, '', class: 'embed-responsive-item', allowfullscreen: 'allowfullscreen', src: video_url)
    end
  end

  def video_with_share(video)
    content_tag(:div, class: 'embed-responsive embed-responsive-16by9') do
      content_tag(:iframe, '', class: 'embed-responsive-item', allowfullscreen: 'allowfullscreen', src: video.url)
    end
  end
end
