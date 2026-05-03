-- Enable overlay mode
swayimg.enable_overlay(true)

-- Set background color for transparent images (white)
swayimg.viewer.set_image_background(0xffffffff)

-- Disable top-left text block in viewer mode
swayimg.viewer.set_text("topleft", {})
