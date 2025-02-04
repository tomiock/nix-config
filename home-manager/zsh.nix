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

  home.sessionPath = [
    "$HOME/.local/bin"
    "$HOME/bin"
    "$HOME/.nix-profile/bin" #binaries for non-nixOS
    "$HOME/.nix-profile/share/applications"
  ];

  programs.eza.enable = true;
  programs.zoxide.enable = true;
  programs.zoxide.enableZshIntegration = true;
  programs.bat.enable = true;
  programs.ripgrep.enable = true;

  programs.bash = {
    enable = true;
    shellAliases = {
      n = "nvim";
    };
  };

  programs.zsh = {
    enable = true;
    autocd = true;

    autosuggestion.enable = true;
    enableCompletion = true;
    syntaxHighlighting.enable = true;

    shellAliases = {
      n = "nvim";
      N = "nvim";

      b = "btm";

      ls = "exa";
      sl = "exa";
      l = "exa -la";
      la = "exa --all --oneline";

      ip = "ip --color=auto";
      c = "clear";
      grep = "rg";
      cat = "bat --style plain";
      cd = "z";
      cdd = "cd";
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
    prefix = "C-a";
    sensibleOnTop = true;

    extraConfig = ''

      bind '"' split-window -v -c "#{pane_current_path}"
      bind % split-window -h -c "#{pane_current_path}"
      bind | split-window -h -c "#{pane_current_path}"
      bind - split-window -v -c "#{pane_current_path}"

      bind c new-window -c "#{pane_current_path}"

      # Vi-style pane navigation
      bind -r H select-pane -L
      bind -r J select-pane -D
      bind -r K select-pane -U
      bind -r L select-pane -R

      bind -n M-Left select-pane -L
      bind -n M-Right select-pane -R
      bind -n M-Up select-pane -U
      bind -n M-Down select-pane -D

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

    ignores = [
      "*~"
      ".cache/"
      "**/.cache/"
      ".venv/"
      "**/.venv/"
      ".vscode/"
      "**/.vscode/"
      ".jukit/"
      "**/.jukit/"
      ".ipynb_checkpoints/"
      "**/.ipynb_checkpoints/"
      "*.pyc"
    ];

    extraConfig = {
      init = {
        defaultBranch = "main";
      };
    };
  };
}
