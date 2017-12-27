i = 0
items = ""
Dir.glob("svg/*.svg").each do |file|
	i +=1
	#render svg

	#thumbnails
	svg_path = file
	thumb_out_path = svg_path.gsub(/svg$/,"jpg").gsub(/^svg/,"static/img/thumbs")
	thumb_path = thumb_out_path.gsub(/static\//,"")
	sys_call =
	"cat #{svg_path} | docker run -i dbtek/librsvg rsvg-convert -f png -w 250 > #{thumb_out_path}"
	#puts sys_call
	unless File.exists? thumb_out_path
		`#{sys_call}`
	end

	#full size
	svg_path = file
	out_path = svg_path.gsub(/svg$/,"jpg").gsub(/^svg/,"static/img")
	img_path = out_path.gsub(/static\//,"")
	sys_call =
	"cat #{svg_path} | docker run -i dbtek/librsvg rsvg-convert -f png -w 800 > #{out_path}"
	#puts sys_call
	unless File.exists? out_path
		`#{sys_call}`
	end

	#make content file
	string=<<eof
+++
showonlyimage = true
draft = false
image = "#{img_path}"
date = "2016-11-05T18:25:22+05:30"
title = "Name of the work #{"%.2d" % i}"
weight = 0
+++
eof
	#IO.write("content/portfolio/#{"%.2d" % i}.md", string)

items +=<<eof
	[[items]]
	title = "Only £19.95"
	image = "#{img_path}"
	thumb = "#{thumb_path}"
	alt = "Sunstrakt Print"
	description = "Add a vibrant geometric punch to any room. This is a beautiful 30cm (12\\") square archival ink-jet print on acid-free 310gsm fine-art paper.<br><br><form action=\\"https://www.paypal.com/cgi-bin/webscr\\" method=\\"post\\" target=\\"_top\\"> <input type=\\"hidden\\" name=\\"cmd\\" value=\\"_s-xclick\\"> <input type=\\"hidden\\" name=\\"hosted_button_id\\" value=\\"2V5M6DAWPFUD6\\"> <input type=\\"image\\" src=\\"https://www.paypalobjects.com/en_US/GB/i/btn/btn_buynowCC_LG.gif\\" border=\\"0\\" name=\\"submit\\" alt=\\"PayPal – The safer, easier way to pay online!\\"> <img alt=\\"\\" border=\\"0\\" src=\\"https://www.paypalobjects.com/en_GB/i/scr/pixel.gif\\" width=\\"1\\" height=\\"1\\"> </form>"
	url = ""
eof

#add this one to the rest
#items += next_item

end

#print them all to the file
IO.write("data/items.toml", items)
