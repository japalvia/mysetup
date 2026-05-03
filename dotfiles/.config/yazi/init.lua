require("projects"):setup({
    save = {
        method = "yazi",
    },
    last = {
        update_after_save = true,
        update_after_load = true,
        update_before_quit = true,
        load_after_start = true,
    },
    merge = {
        quit_after_merge = false,
    },
    notify = {
        enable = true,
        title = "Projects",
        timeout = 3,
        level = "info",
    },
})
