-- Enable overlay mode
swayimg.enable_overlay(true)

-- Set background color for transparent images (white)
swayimg.viewer.set_image_background(0xffffffff)

-- Scale images to fit available window space on open
swayimg.viewer.set_default_scale("fit")

-- Disable top-left text block in viewer mode
swayimg.viewer.set_text("topleft", {})

-- Bind q to quit in all modes
swayimg.viewer.on_key("q", function()
  swayimg.exit()
end)

swayimg.slideshow.on_key("q", function()
  swayimg.exit()
end)

swayimg.gallery.on_key("q", function()
  swayimg.exit()
end)
