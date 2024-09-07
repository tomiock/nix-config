{ inputs
, outputs
, lib
, config
, pkgs
, ...
}: {

  home.sessionVariables = {
    EDITOR = "nvim";
    TERMINAL = "alacritty";
    GDK_BACKEND = "wayland";
    GTK_USE_PORTAL = "1";
    QT_QPA_PLATFORM = "wayland";
    QT_WAYLAND_DISABLE_WINDOWDECORATION = "1";
    QT_AUTO_SCREEN_SCALE_FACTOR = "1";
    MOZ_ENABLE_WAYLAND = "1";
  };

  programs.eza.enable = true;
  programs.zoxide.enable = true;
  programs.zoxide.enableZshIntegration = true;
  programs.bat.enable = true;
  programs.ripgrep.enable = true;

  programs.zsh = {
    enable = true;
    autocd = true;

    autosuggestion.enable = true;
    enableCompletion = true;
    syntaxHighlighting.enable = true;

    shellAliases = {
      ls = "exa";
      sl = "exa";
      l = "exa -la";
      la = "exa --all --oneline";
      ip = "ip --color=auto";
      c = "clear";
      grep = "rg";
      cat = "bat --style plain";
      cd = "z";
      pip = "uv";
      open = "papers";
      view = "eog";
      # transforms and removes pptx files
      pptx2pdf = "soffice --headless --convert-to pdf *.pptx";
      pptx2pdf_rm = "soffice --headless --convert-to pdf *.pptx && rm *.pptx";
    };

    oh-my-zsh = {
      enable = true;
      theme = "kolo";
      plugins = [
        "git"
      ];
    };

    initExtra = "
      if [[ -n $SSH_CONNECTION ]]; then
        PROMPT='%B%F{magenta}%n@%m %c%B%F{green}\${vcs_info_msg_0_}%B%F{magenta} %{$reset_color%}%% '
      else
        PROMPT='%B%F{magenta}%c%B%F{green}\${vcs_info_msg_0_}%B%F{magenta} %{$reset_color%}%% '
      fi
    ";
  };

  programs.tmux = {
    enable = true;
    baseIndex = 1;
    keyMode = "vi";
    mouse = true;
    shortcut = "a";
    sensibleOnTop = true;

    extraConfig = ''

      bind '"' split-window -v -c "#{pane_current_path}"
      bind % split-window -h -c "#{pane_current_path}"
      bind c new-window -c "#{pane_current_path}"

    '';
  };

  programs.thefuck = {
    enable = true;
  };

  programs.fzf = {
    enable = true;
    enableZshIntegration = true;
  };

  programs.git = {
    enable = true;
    userName = "tomiock";
    userEmail = "ockier1@gmail.com";
    aliases = {
      pu = "push";
      cm = "commit";
      s = "status";
      d = "diff";
      ds = "diff --staged";
    };
  };
}
