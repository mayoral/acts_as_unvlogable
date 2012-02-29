# ----------------------------------------------
#  Class for Youtube (youtube.com)
#  http://www.youtube.com/watch?v=25AsfkriHQc
# ----------------------------------------------


class VgYoutube
  
  def initialize(url=nil, options={})
    object = YouTubeIt::Client.new({})
    @url = url
    @video_id = @url.query_param('v')
    @details = object.video_by(@video_id)
    @details.instance_variable_set(:@noembed, false)
    raise if @details.blank?
  end
  
  def title
    @details.title
  end
  
  def thumbnail
    @details.thumbnails.first.url
  end
  
  def duration
    @details.duration
  end
  
  def embed_url
    @details.media_content.first.url if @details.noembed == false
  end
  
  # options 
  #   You can read more about the youtube player options in 
  #   http://code.google.com/intl/en/apis/youtube/player_parameters.html
  #   Use them in options (ex {:rel => 0, :color1 => '0x333333'})
  # 
  def embed_html(width=640, height=360, options={})
    "<iframe width='#{width}' height='#{height}' src='#{embed_url}#{options.map {|k,v| "&#{k}=#{v}"}}' frameborder='0' allowfullscreen></iframe>" if @details.noembed == false
  end
  
  
  def flv
    doc = URI::parse("http://www.youtube.com/get_video_info?&video_id=#{@video_id}").read
    CGI::unescape(doc.split("&fmt_url_map=")[1].split("&")[0]).split("|")[1].split(",")[0]
  end
  
  def download_url
    flv
  end

  def service
    "Youtube"
  end

end