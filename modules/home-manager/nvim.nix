
{ config, pkgs, inputs, ... }:

{

  nixpkgs = {
    overlays = [
      (final: prev: {
        vimPlugins = prev.vimPlugins // {

          #Plugins that does not have a nix package
          own-auto-session = prev.vimUtils.buildVimPlugin {
            name = "auto-session";
            src = inputs.plugin-auto-session;
          };

          own-nvim-tree = prev.vimUtils.buildVimPlugin {
            name = "nvim-tree";
            src = inputs.plugin-nvim-tree;
          };

        };
      })
    ];
  };

  programs.neovim = 
  {
    enable = true;
    viAlias = true;
    vimAlias = true;
    vimdiffAlias = true;

    extraPackages = with pkgs; [
      lua-language-server
      xclip
      wl-clipboard
    ];

    plugins = with pkgs.vimPlugins; [

      #-----------------Lsp plugins------------------
       lazy-nvim
       nvim-lspconfig
       mason-nvim
       none-ls-nvim
       alpha-nvim
       bufferline-nvim
       nvim-colorizer-lua
       nvim-comment
       dressing-nvim
       conform-nvim
       gitsigns-nvim
       nvim-lint
       lualine-nvim
       nvim-autopairs
       nvim-cmp
       nvim-surround
       nvim-treesitter-textobjects
       nvim-treesitter
       nvim-web-devicons
       telescope-nvim
       which-key-nvim

 #     {
 #       plugin = nvim-lspconfig;
 #       type = "lua";
 #       config = builtins.readFile(./nvim/lua/jack/plugins/lsp/lspconfig.lua);
 #     }

 #     {
 #       plugin = mason-nvim;
 #       type = "lua";
 #       config = builtins.readFile(./nvim/lua/jack/plugins/lsp/mason.lua);
 #     }

 #     {
 #       plugin = none-ls-nvim;
 #       type = "lua";
 #       config = builtins.readFile(./nvim/lua/jack/plugins/lsp/none-ls.lua);
 #     }

 #     #-----------------End of lsp plugins-----------

 #     
 #     #-----------------Regular plugins-----------

 #     {
 #       plugin = lazy-nvim;
 #       type = "lua";
 #       config = builtins.readFile(./nvim/lua/jack/lazy.lua);
 #     }

 #     {
 #       plugin = alpha-nvim;
 #       type = "lua";
 #       config = builtins.readFile(./nvim/lua/jack/plugins/alpha-nvim.lua);
 #     }

 #     {
 #       plugin = bufferline-nvim;
 #       type = "lua";
 #       config = builtins.readFile(./nvim/lua/jack/plugins/bufferline.lua);
 #     }

 #     {
 #       plugin = nvim-colorizer-lua;
 #       type = "lua";
 #       config = builtins.readFile(./nvim/lua/jack/plugins/colorizer.lua);
 #     }

 #     {
 #       plugin = nvim-comment;
 #       type = "lua";
 #       config = builtins.readFile(./nvim/lua/jack/plugins/comment.lua);
 #     }

 #     {
 #       plugin = dressing-nvim;
 #       type = "lua";
 #       config = builtins.readFile(./nvim/lua/jack/plugins/dressing.lua);
 #     }

 #     {
 #       plugin = conform-nvim;
 #       type = "lua";
 #       config = builtins.readFile(./nvim/lua/jack/plugins/formatting.lua);
 #     }

 #     {
 #       plugin = gitsigns-nvim;
 #       type = "lua";
 #       config = builtins.readFile(./nvim/lua/jack/plugins/gitsigns.lua);
 #     }

 #     {
 #       plugin = nvim-lint;
 #       type = "lua";
 #       config = builtins.readFile(./nvim/lua/jack/plugins/linting.lua);
 #     }

 #     {
 #       plugin = lualine-nvim;
 #       type = "lua";
 #       config = builtins.readFile(./nvim/lua/jack/plugins/lualine.lua);
 #     }

 #     {
 #       plugin = nvim-autopairs;
 #       type = "lua";
 #       config = builtins.readFile(./nvim/lua/jack/plugins/nvim-autopairs.lua);
 #     }

 #     {
 #       plugin = nvim-cmp;
 #       type = "lua";
 #       config = builtins.readFile(./nvim/lua/jack/plugins/nvim-cmp.lua);
 #     }

 #     {
 #       plugin = nvim-surround;
 #       type = "lua";
 #       config = builtins.readFile(./nvim/lua/jack/plugins/nvim-surround.lua);
 #     }

 #     {
 #       plugin = nvim-treesitter-textobjects;
 #       type = "lua";
 #       config = builtins.readFile(./nvim/lua/jack/plugins/nvim-treesitter-text-objects.lua);
 #     }

 #     {
 #       plugin = nvim-treesitter;
 #       type = "lua";
 #       config = builtins.readFile(./nvim/lua/jack/plugins/nvim-treesitter.lua);
 #     }

 #     {
 #       plugin = nvim-web-devicons;
 #       type = "lua";
 #       config = builtins.readFile(./nvim/lua/jack/plugins/nvim-web-devicons.lua);
 #     }

 #     {
 #       plugin = telescope-nvim;
 #       type = "lua";
 #       config = builtins.readFile(./nvim/lua/jack/plugins/telescope.lua);
 #     }

 #     {
 #       plugin = which-key-nvim;
 #       type = "lua";
 #       config = builtins.readFile(./nvim/lua/jack/plugins/which-key.lua);
 #     }

    ];

    extraLuaConfig = ''
      ${builtins.readFile ./nvim/lua/jack/core/options.lua}
      ${builtins.readFile ./nvim/lua/jack/core/keymaps.lua}
    '';

    # extraLuaConfig = ''
 #${builtins.readFile ./nvim/lua/jack/plugins/init.lua}

      # ${builtins.readFile ./nvim/lua/jack/plugins/colorscheme.lua}
    #   ${builtins.readFile ./nvim/options.lua}
    #   ${builtins.readFile ./nvim/plugin/lsp.lua}
    #   ${builtins.readFile ./nvim/plugin/cmp.lua}
    #   ${builtins.readFile ./nvim/plugin/telescope.lua}
    #   ${builtins.readFile ./nvim/plugin/treesitter.lua}
    #   ${builtins.readFile ./nvim/plugin/other.lua}
    # '';
  };
}

