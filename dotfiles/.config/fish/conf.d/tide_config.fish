# Tide settings from `tide configure` (lean, one line, transient prompt) kept in git
# so the prompt is reproducible without running it. Colors are in tide_gruvbox.fish.
# fish_variables (universal vars) is not tracked, so on a fresh host tide's defaults
# (e.g. tide_cmd_duration_threshold) are missing. Seed them once as universal vars:
# the prompt is rendered by a background `fish -c` job that only inherits universals.
if not set -q --universal tide_cmd_duration_threshold
    set -g _tide_color_dark_blue 0087AF
    set -g _tide_color_dark_green 5FAF00
    set -g _tide_color_gold D7AF00
    set -g _tide_color_green 5FD700
    set -g _tide_color_light_blue 00AFFF
    set -U VIRTUAL_ENV_DISABLE_PROMPT true
    while read -l line
        eval set -U $line
    end <(status dirname)/../functions/tide/configure/configs/lean.fish
end

set -g tide_aws_icon \uf270
set -g tide_bun_icon \U000f0cd3
set -g tide_character_icon \u276f
set -g tide_character_vi_icon_default \u276e
set -g tide_character_vi_icon_replace \u25b6
set -g tide_character_vi_icon_visual V
set -g tide_cmd_duration_icon
set -g tide_crystal_icon \ue62f
set -g tide_direnv_icon \u25bc
set -g tide_distrobox_icon \U000f01a7
set -g tide_docker_icon \uf308
set -g tide_elixir_icon \ue62d
set -g tide_gcloud_icon \U000f02ad
set -g tide_git_icon
set -g tide_go_icon \ue627
set -g tide_java_icon \ue256
set -g tide_jobs_icon \uf013
set -g tide_kubectl_icon \U000f10fe
set -g tide_nix_shell_icon \uf313
set -g tide_node_icon \ue24f
set -g tide_os_icon \uf303
set -g tide_php_icon \ue608
set -g tide_private_mode_icon \U000f05f9
set -g tide_prompt_icon_connection ' '
set -g tide_pulumi_icon \uf1b2
set -g tide_pwd_icon
set -g tide_pwd_icon_home
set -g tide_pwd_icon_unwritable \uf023
set -g tide_python_icon \U000f0320
set -g tide_ruby_icon \ue23e
set -g tide_rustc_icon \ue7a8
set -g tide_shlvl_icon \uf120
set -g tide_status_icon \u2714
set -g tide_status_icon_failure \u2718
set -g tide_terraform_icon \U000f1062
set -g tide_toolbox_icon \ue24f
set -g tide_vi_mode_icon_default D
set -g tide_vi_mode_icon_insert I
set -g tide_vi_mode_icon_replace R
set -g tide_vi_mode_icon_visual V
set -g tide_zig_icon \ue6a9
set -g tide_prompt_add_newline_before false
set -g tide_prompt_transient_enabled true
set -g tide_right_prompt_items status cmd_duration context jobs direnv bun node python rustc java php pulumi ruby go gcloud kubectl distrobox toolbox terraform aws nix_shell crystal elixir zig time
