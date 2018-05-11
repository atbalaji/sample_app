module MicropostsHelper
	include ActsAsTaggableOn::TagsHelper
	def render_hash(content)
		content=h(content)
		new_text = content.gsub(/#[a-zA-Z0-9_]*/) do |match|
    	link_to match,tag_url(match)
    	
    end
    new_text.html_safe
    end


	def render_with_hashtags(content)
    	content_words = h(content).split(" ")
    	content_with_links = content_words.map do |word| 
      	if word[0]==("#")
	         link_to word, microposts_url
      	else
	        word
      	end
     end
    content_with_links.join(" ").html_safe
  end 
end
