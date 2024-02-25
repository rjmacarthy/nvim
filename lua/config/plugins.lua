return {
  -- ╭─────────────────────────────────────────────────────────╮
  -- │ Themes                                                  │
  -- ╰─────────────────────────────────────────────────────────╯
  {
    "folke/tokyonight.nvim",
    lazy = false,
    priority = 1000,
    config = function()
      -- load the colorscheme here
      vim.cmd([[colorscheme tokyonight]])
      require("config.colorscheme")
    end,
  },
  { "nvim-lua/plenary.nvim" },
  {
    "nvim-tree/nvim-web-devicons",
    config = function()
      require("nvim-web-devicons").setup({ default = true })
    end,
  },
  {
    "goolord/alpha-nvim",
    lazy = false,
    config = function()
      require("plugins.alpha")
    end,
  },

  -- ╭─────────────────────────────────────────────────────────╮
  -- │ Treesitter                                              │
  -- ╰─────────────────────────────────────────────────────────╯
  {
    "nvim-treesitter/nvim-treesitter",
    event = "BufReadPre",
    config = function()
      require("plugins.treesitter")
    end,
    dependencies = {
      "hiphish/rainbow-delimiters.nvim",
      "JoosepAlviste/nvim-ts-context-commentstring",
      "nvim-treesitter/nvim-treesitter-textobjects",
      "RRethy/nvim-treesitter-textsubjects",
    },
  },

  -- ╭─────────────────────────────────────────────────────────╮
  -- │ Navigating (Telescope/Tree/Refactor)                    │
  -- ╰─────────────────────────────────────────────────────────╯
  {
    "nvim-pack/nvim-spectre",
    lazy = true,
    keys = {
      {
        "<Leader>pr",
        "<cmd>lua require('spectre').open_visual({select_word=true})<CR>",
        desc = "refactor",
      },
      {
        "<Leader>pr",
        "<cmd>lua require('spectre').open_visual()<CR>",
        mode = "v",
        desc = "refactor",
      }
    }
  },
  {
    "nvim-telescope/telescope.nvim",
    lazy = false,
    config = function()
      require("plugins.telescope")
    end,
    dependencies = {
      { "nvim-lua/popup.nvim" },
      { "nvim-lua/plenary.nvim" },
      { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
      { "cljoly/telescope-repo.nvim" },
    },
  },
  {
    "kevinhwang91/nvim-bqf",
    ft = "qf",
    init = function()
      require('plugins.bqf-init')
    end,
  },
  {
    "nvim-tree/nvim-tree.lua",
    cmd = {
      "NvimTreeOpen",
      "NvimTreeClose",
      "NvimTreeToggle",
      "NvimTreeFindFile",
      "NvimTreeFindFileToggle",
    },
    keys = {
      { "<C-e>", "<cmd>lua require('nvim-tree.api').tree.toggle()<CR>", desc = "NvimTree" },
    },
    config = function()
      require("plugins.tree")
    end,
  },
  {
    "gbprod/stay-in-place.nvim",
    lazy = false,
    config = true, -- run require("stay-in-place").setup()
  },
  {
    "chentoast/marks.nvim",
    event = "BufEnter",
    config = true,
  },

  -- ╭─────────────────────────────────────────────────────────╮
  -- │ LSP Base                                                │
  -- ╰─────────────────────────────────────────────────────────╯
  {
    "neovim/nvim-lspconfig",
    lazy = false,
    dependencies = {
      "mason.nvim",
      "williamboman/mason-lspconfig.nvim",
      "hrsh7th/cmp-nvim-lsp",
    },
    servers = nil,
  },
  {
    "williamboman/mason.nvim",
    cmd = "Mason",
    keys = {
      { "<leader>cm", "<cmd>Mason<cr>", desc = "Mason" },
    },
  },

  -- ╭─────────────────────────────────────────────────────────╮
  -- │ LSP Cmp                                                 │
  -- ╰─────────────────────────────────────────────────────────╯
  {
    "hrsh7th/nvim-cmp",
    event = "InsertEnter",
    config = function()
      require("plugins.cmp")
    end,
    dependencies = {
      "hrsh7th/cmp-nvim-lua",
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "hrsh7th/cmp-cmdline",
      "hrsh7th/cmp-calc",
      "saadparwaiz1/cmp_luasnip",
      {
        "L3MON4D3/LuaSnip",
        dependencies = "rafamadriz/friendly-snippets",
        build = "make install_jsregexp",
        config = function()
          require("luasnip.loaders.from_vscode").lazy_load { paths = { vim.fn.stdpath("config") .. "/snippets" } }
        end
      },
      {
        cond = EcoVim.plugins.ai.tabnine.enabled,
        "tzachar/cmp-tabnine",
        build = "./install.sh",
      },
      {
        "David-Kunz/cmp-npm",
        config = function()
          require("plugins.cmp-npm")
        end,
      },
      {
        "zbirenbaum/copilot-cmp",
        cond = EcoVim.plugins.ai.copilot.enabled,
        config = function()
          require("copilot_cmp").setup()
        end,
      },
      "petertriho/cmp-git",
    },
  },

  -- ╭─────────────────────────────────────────────────────────╮
  -- │ LSP Addons                                              │
  -- ╰─────────────────────────────────────────────────────────╯
  {
    "stevearc/dressing.nvim",
    event = "VeryLazy",
    dependencies = "MunifTanjim/nui.nvim",
    config = function()
      require("plugins.dressing")
    end,
  },
  { "onsails/lspkind-nvim" },
  {
    "folke/trouble.nvim",
    cmd = { "TroubleToggle", "Trouble" },
    config = function()
      require("plugins.trouble")
    end,
  },
  { "nvim-lua/popup.nvim" },
  {
    "SmiteshP/nvim-navic",
    config = function()
      require("plugins.navic")
    end,
    dependencies = "neovim/nvim-lspconfig",
  },
  {
    "pmizio/typescript-tools.nvim",
    event = { "BufReadPre", "BufNewFile" },
    ft = { "typescript", "typescriptreact" },
    dependencies = {
      "nvim-lua/plenary.nvim",
      "neovim/nvim-lspconfig",
    },
    config = function()
      require("plugins.typescript-tools")
    end,
  },
  {
    "axelvc/template-string.nvim",
    event = "InsertEnter",
    ft = {
      "javascript",
      "typescript",
      "javascriptreact",
      "typescriptreact",
    },
    config = true, -- run require("template-string").setup()
  },
  {
    "dmmulroy/tsc.nvim",
    cmd = { "TSC" },
    config = true,
  },
  {
    "dnlhc/glance.nvim",
    config = function()
      require("plugins.glance")
    end,
    cmd = { "Glance" },
    keys = {
      { "gd", "<cmd>Glance definitions<CR>",      desc = "LSP Definition" },
      { "gr", "<cmd>Glance references<CR>",       desc = "LSP References" },
      { "gm", "<cmd>Glance implementations<CR>",  desc = "LSP Implementations" },
      { "gy", "<cmd>Glance type_definitions<CR>", desc = "LSP Type Definitions" },
    },
  },
  {
    "antosha417/nvim-lsp-file-operations",
    event = "LspAttach",
    dependencies = {
      { "nvim-lua/plenary.nvim" },
      { "nvim-tree/nvim-tree.lua" },
    },
    config = function()
      require("lsp-file-operations").setup()
    end
  },
  {
    "ThePrimeagen/refactoring.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
    },
    cmd = "Refactor",
    keys = {
      { "<leader>re", ":Refactor extract ",              mode = "x",          desc = "Extract function" },
      { "<leader>rf", ":Refactor extract_to_file ",      mode = "x",          desc = "Extract function to file" },
      { "<leader>rv", ":Refactor extract_var ",          mode = "x",          desc = "Extract variable" },
      { "<leader>ri", ":Refactor inline_var",            mode = { "x", "n" }, desc = "Inline variable" },
      { "<leader>rI", ":Refactor inline_func",           mode = "n",          desc = "Inline function" },
      { "<leader>rb", ":Refactor extract_block",         mode = "n",          desc = "Extract block" },
      { "<leader>rf", ":Refactor extract_block_to_file", mode = "n",          desc = "Extract block to file" },
    },
    config = true
  },

  -- ╭─────────────────────────────────────────────────────────╮
  -- │ General                                                 │
  -- ╰─────────────────────────────────────────────────────────╯
  { "AndrewRadev/switch.vim", lazy = false },
  {
    "Wansmer/treesj",
    lazy = true,
    cmd = { "TSJToggle", "TSJSplit", "TSJJoin" },
    keys = {
      { "gJ", "<cmd>TSJToggle<CR>", desc = "Toggle Split/Join" },
    },
    config = function()
      require("treesj").setup({
        use_default_keymaps = false,
      })
    end,
  },
  {
    "numToStr/Comment.nvim",
    lazy = false,
    dependencies = "JoosepAlviste/nvim-ts-context-commentstring",
    config = function()
      require("plugins.comment")
    end,
  },
  {
    "LudoPinelli/comment-box.nvim",
    lazy = false,
    keys = {
      { "<leader>ac", "<cmd>lua require('comment-box').llbox()<CR>", desc = "comment box" },
      { "<leader>ac", "<cmd>lua require('comment-box').llbox()<CR>", mode = "v",          desc = "comment box" },
    }
  },
  {
    "akinsho/nvim-toggleterm.lua",
    lazy = false,
    branch = "main",
    config = function()
      require("plugins.toggleterm")
    end,
    keys = {
      { "<Leader>at", "<cmd>ToggleTerm direction=float<CR>", desc = "terminal float" }
    }
  },
  { "tpope/vim-repeat",           lazy = false },
  { "tpope/vim-speeddating",      lazy = false },
  { "dhruvasagar/vim-table-mode", ft = { "markdown" } },
  {
    "smoka7/multicursors.nvim",
    event = "VeryLazy",
    dependencies = {
      'nvim-treesitter/nvim-treesitter',
      'smoka7/hydra.nvim',
    },
    opts = {
      hint_config = {
        border = EcoVim.ui.float.border or "rounded",
        position = 'bottom',
        show_name = false,
      }
    },
    keys = {
      {
        '<LEADER>m',
        '<CMD>MCstart<CR>',
        desc = 'multicursor',
      },
      {
        '<LEADER>m',
        '<CMD>MCvisual<CR>',
        mode = "v",
        desc = 'multicursor',
      },
      {
        '<C-Down>',
        '<CMD>MCunderCursor<CR>',
        desc = 'multicursor down',
      },
    },
  },
  {
    "nacro90/numb.nvim",
    lazy = false,
    config = function()
      require("plugins.numb")
    end,
  },
  {
    "folke/todo-comments.nvim",
    lazy = false,
    event = "BufEnter",
    config = function()
      require("plugins.todo-comments")
    end,
  },
  {
    "folke/zen-mode.nvim",
    cmd = { "ZenMode" },
    config = function()
      require("plugins.zen")
    end,
    cond = EcoVim.plugins.zen.enabled,
  },
  {
    "folke/twilight.nvim",
    config = true,
    cond = EcoVim.plugins.zen.enabled,
  },
  {
    "folke/flash.nvim",
    event = "VeryLazy",
    opts = {
      char = {
        keys = { "f", "F", "t", "T" },
      }
    },
    keys = {
      { "s", mode = { "n", "x", "o" }, function() require("flash").jump() end,   desc = "Flash" },
      { "r", mode = "o",               function() require("flash").remote() end, desc = "Remote Flash" },
    },
  },
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    lazy = true,
    config = function()
      require("plugins.which-key")
    end,
  },
  {
    "ecosse3/galaxyline.nvim",
    config = function()
      require("plugins.galaxyline")
    end,
    event = "VeryLazy",
  },
  {
    "echasnovski/mini.bufremove",
    version = "*",
    config = function()
      require("mini.bufremove").setup({
        silent = true,
      })
    end,
  },
  {
    "akinsho/bufferline.nvim",
    event = "VeryLazy",
    dependencies = {
      "nvim-tree/nvim-web-devicons",
      "echasnovski/mini.bufremove",
    },
    version = "*",
    config = function()
      require("plugins.bufferline")
    end,
    keys = {
      { "<Space>1",    "<cmd>BufferLineGoToBuffer 1<CR>" },
      { "<Space>2",    "<cmd>BufferLineGoToBuffer 2<CR>" },
      { "<Space>3",    "<cmd>BufferLineGoToBuffer 3<CR>" },
      { "<Space>4",    "<cmd>BufferLineGoToBuffer 4<CR>" },
      { "<Space>5",    "<cmd>BufferLineGoToBuffer 5<CR>" },
      { "<Space>6",    "<cmd>BufferLineGoToBuffer 6<CR>" },
      { "<Space>7",    "<cmd>BufferLineGoToBuffer 7<CR>" },
      { "<Space>8",    "<cmd>BufferLineGoToBuffer 8<CR>" },
      { "<Space>9",    "<cmd>BufferLineGoToBuffer 9<CR>" },
      { "<A-1>",       "<cmd>BufferLineGoToBuffer 1<CR>" },
      { "<A-2>",       "<cmd>BufferLineGoToBuffer 2<CR>" },
      { "<A-3>",       "<cmd>BufferLineGoToBuffer 3<CR>" },
      { "<A-4>",       "<cmd>BufferLineGoToBuffer 4<CR>" },
      { "<A-5>",       "<cmd>BufferLineGoToBuffer 5<CR>" },
      { "<A-6>",       "<cmd>BufferLineGoToBuffer 6<CR>" },
      { "<A-7>",       "<cmd>BufferLineGoToBuffer 7<CR>" },
      { "<A-8>",       "<cmd>BufferLineGoToBuffer 8<CR>" },
      { "<A-9>",       "<cmd>BufferLineGoToBuffer 9<CR>" },
      { "<Leader>bb",  "<cmd>BufferLineMovePrev<CR>",                desc = "Move back" },
      { "<Leader>bl",  "<cmd>BufferLineCloseLeft<CR>",               desc = "Close Left" },
      { "<Leader>br",  "<cmd>BufferLineCloseRight<CR>",              desc = "Close Right" },
      { "<Leader>bn",  "<cmd>BufferLineMoveNext<CR>",                desc = "Move next" },
      { "<Leader>bp",  "<cmd>BufferLinePick<CR>",                    desc = "Pick Buffer" },
      { "<Leader>bP",  "<cmd>BufferLineTogglePin<CR>",               desc = "Pin/Unpin Buffer" },
      { "<Leader>bsd", "<cmd>BufferLineSortByDirectory<CR>",         desc = "Sort by directory" },
      { "<Leader>bse", "<cmd>BufferLineSortByExtension<CR>",         desc = "Sort by extension" },
      { "<Leader>bsr", "<cmd>BufferLineSortByRelativeDirectory<CR>", desc = "Sort by relative dir" },
    }
  },
  {
    "rcarriga/nvim-notify",
    config = function()
      require("notify").setup({
        background_colour = "#000000",
      })
    end,
    init = function()
      local banned_messages = {
        "No information available",
        "LSP[tsserver] Inlay Hints request failed. Requires TypeScript 4.4+.",
        "LSP[tsserver] Inlay Hints request failed. File not opened in the editor.",
      }
      vim.notify = function(msg, ...)
        for _, banned in ipairs(banned_messages) do
          if msg == banned then
            return
          end
        end
        return require("notify")(msg, ...)
      end
    end,
  },
  {
    "vuki656/package-info.nvim",
    event = "BufEnter package.json",
    config = function()
      require("plugins.package-info")
    end,
  },
  {
    "iamcco/markdown-preview.nvim",
    build = "cd app && npm install",
    setup = function()
      vim.g.mkdp_filetypes = { "markdown" }
    end,
    ft = { "markdown" },
  },
  {
    "airblade/vim-rooter",
    event = "VeryLazy",
    config = function()
      vim.g.rooter_patterns = EcoVim.plugins.rooter.patterns
      vim.g.rooter_silent_chdir = 1
      vim.g.rooter_resolve_links = 1
    end,
  },
  {
    "Shatur/neovim-session-manager",
    lazy = false,
    config = function()
      require("plugins.session-manager")
    end,
    keys = {
      { "<Leader>ps", "<cmd>SessionManager available_commands<CR>",   desc = "session manager" },
      { "<Leader>pS", "<cmd>SessionManager save_current_session<CR>", desc = "save session" },
    }
  },
  {
    "kylechui/nvim-surround",
    version = "*", -- Use for stability; omit to use `main` branch for the latest features
    event = "VeryLazy",
    config = true,
  },
  {
    "kevinhwang91/nvim-ufo",
    dependencies = "kevinhwang91/promise-async",
    config = function()
      vim.keymap.set("n", "zR", require("ufo").openAllFolds)
      vim.keymap.set("n", "zM", require("ufo").closeAllFolds)
      vim.keymap.set("n", "zr", require("ufo").openFoldsExceptKinds)
    end,
  },
  {
    "echasnovski/mini.align",
    lazy = false,
    version = "*",
    config = function()
      require("mini.align").setup()
    end,
  },
  {
    "echasnovski/mini.ai",
    lazy = false,
    version = "*",
    config = function()
      require("mini.ai").setup()
    end,
  },
  {
    "rareitems/printer.nvim",
    event = "BufEnter",
    ft = {
      "lua",
      "javascript",
      "typescript",
      "javascriptreact",
      "typescriptreact",
    },
    config = function()
      require("plugins.printer")
    end,
  },
  {
    "lukas-reineke/indent-blankline.nvim",
    event = "BufReadPre",
    main = "ibl",
    config = function()
      require("plugins.indent")
    end,
  },
  {
    "folke/noice.nvim",
    cond = EcoVim.plugins.experimental_noice.enabled,
    lazy = false,
    config = function()
      require("plugins.noice")
    end,
  },
  {
    "chrisgrieser/nvim-spider",
    cond = EcoVim.plugins.jump_by_subwords.enabled,
    lazy = true,
    keys = { "w", "e", "b", "ge" },
    config = function()
      vim.keymap.set({ "n", "o", "x" }, "W", "w", { desc = "Normal w" })
      vim.keymap.set({ "n", "o", "x" }, "w", "<cmd>lua require('spider').motion('w')<CR>", { desc = "Spider-w" })
      vim.keymap.set({ "n", "o", "x" }, "e", "<cmd>lua require('spider').motion('e')<CR>", { desc = "Spider-e" })
      vim.keymap.set({ "n", "o", "x" }, "b", "<cmd>lua require('spider').motion('b')<CR>", { desc = "Spider-b" })
      vim.keymap.set(
        { "n", "o", "x" },
        "ge",
        "<cmd>lua require('spider').motion('ge')<CR>",
        { desc = "Spider-ge" }
      )
    end,
  },

  -- ╭─────────────────────────────────────────────────────────╮
  -- │ Snippets & Language & Syntax                            │
  -- ╰─────────────────────────────────────────────────────────╯
  {
    "chrisgrieser/nvim-scissors",
    dependencies = "nvim-telescope/telescope.nvim", -- optional
    opts = {
      snippetDir = vim.fn.stdpath("config") .. "/snippets",
    },
    keys = {
      "<Leader>asa",
      "<Leader>ase",
    },
    config = function()
      local present, wk = pcall(require, "which-key")
      if not present then
        return
      end

      wk.register({
        a = {
          s = {
            name = "Snippets",
            a = { '<cmd>lua require("scissors").addNewSnippet()<CR>', 'Add new snippet' },
            e = { '<cmd>lua require("scissors").editSnippet()<CR>', 'Edit snippet' },
          }
        }
      }, {
        mode = "n",     -- NORMAL mode
        prefix = "<leader>",
        silent = true,  -- use `silent` when creating keymaps
        noremap = true, -- use `noremap` when creating keymaps
        nowait = false, -- use `nowait` when creating keymaps
      })

      wk.register({
        a = {
          s = {
            name = "Snippets",
            a = { '<cmd>lua require("scissors").addNewSnippet()<CR>', 'Add new snippet from selection' },
          }
        }
      }, {
        mode = "x",     -- VISUAL mode
        prefix = "<leader>",
        silent = true,  -- use `silent` when creating keymaps
        noremap = true, -- use `noremap` when creating keymaps
        nowait = false, -- use `nowait` when creating keymaps
      })
    end
  },
  {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    config = function()
      require("plugins.autopairs")
    end,
  },
  {
    "NvChad/nvim-colorizer.lua",
    config = function()
      require("plugins.colorizer")
    end,
  },
  {
    "js-everts/cmp-tailwind-colors",
    config = true,
  },
  {
    "razak17/tailwind-fold.nvim",
    opts = {
      min_chars = 50,
    },
    dependencies = { "nvim-treesitter/nvim-treesitter" },
    ft = { "html", "svelte", "astro", "vue", "typescriptreact" },
  },
  {
    "MaximilianLloyd/tw-values.nvim",
    keys = {
      { "<Leader>cv", "<CMD>TWValues<CR>", desc = "Tailwind CSS values" },
    },
    opts = {
      border = EcoVim.ui.float.border or "rounded", -- Valid window border style,
      show_unknown_classes = true                   -- Shows the unknown classes popup
    }
  },
  {
    "laytan/tailwind-sorter.nvim",
    cmd = {
      "TailwindSort",
      "TailwindSortOnSaveToggle"
    },
    dependencies = { "nvim-treesitter/nvim-treesitter", "nvim-lua/plenary.nvim" },
    build = "cd formatter && npm i && npm run build",
    config = true,
  },

  -- ╭─────────────────────────────────────────────────────────╮
  -- │ AI                                                      │
  -- ╰─────────────────────────────────────────────────────────╯
  {
    "jcdickinson/codeium.nvim",
    cond = EcoVim.plugins.ai.codeium.enabled,
    event = "InsertEnter",
    cmd = "Codeium",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "hrsh7th/nvim-cmp",
    },
    config = true,
  },
  {
    "zbirenbaum/copilot.lua",
    cond = EcoVim.plugins.ai.copilot.enabled,
    lazy = false,
    config = function()
      require("plugins.copilot")
    end,
  },
  {
    "CopilotC-Nvim/CopilotChat.nvim",
    event = "VeryLazy",
    opts = {
      show_help = "no",
      prompts = {
        Explain = "Explain how it works.",
        Review = "Review the following code and provide concise suggestions.",
        Tests = "Briefly explain how the selected code works, then generate unit tests.",
        Refactor = "Refactor the code to improve clarity and readability.",
      },
    },
    build = function()
      vim.defer_fn(function()
        vim.cmd("UpdateRemotePlugins")
        vim.notify("CopilotChat - Updated remote plugins. Please restart Neovim.")
      end, 3000)
    end,
    keys = {
      { "<leader>ccb", ":CopilotChatBuffer<cr>",      desc = "CopilotChat - Buffer" },
      { "<leader>cce", "<cmd>CopilotChatExplain<cr>", desc = "CopilotChat - Explain code" },
      { "<leader>cct", "<cmd>CopilotChatTests<cr>",   desc = "CopilotChat - Generate tests" },
      {
        "<leader>ccT",
        "<cmd>CopilotChatVsplitToggle<cr>",
        desc = "CopilotChat - Toggle Vsplit", -- Toggle vertical split
      },
      {
        "<leader>ccv",
        ":CopilotChatVisual",
        mode = "x",
        desc = "CopilotChat - Open in vertical split",
      },
      {
        "<leader>ccc",
        ":CopilotChatInPlace<cr>",
        mode = { "n", "x" },
        desc = "CopilotChat - Run in-place code",
      },
      {
        "<leader>ccf",
        "<cmd>CopilotChatFixDiagnostic<cr>", -- Get a fix for the diagnostic message under the cursor.
        desc = "CopilotChat - Fix diagnostic",
      },
    }
  },

  -- ╭─────────────────────────────────────────────────────────╮
  -- │ Git                                                     │
  -- ╰─────────────────────────────────────────────────────────╯
  {
    "lewis6991/gitsigns.nvim",
    event = "BufRead",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      require("plugins.git.signs")
    end,
    keys = {
      { "<Leader>ghd", desc = "diff hunk" },
      { "<Leader>ghp", desc = "preview" },
      { "<Leader>ghR", desc = "reset buffer" },
      { "<Leader>ghr", desc = "reset hunk" },
      { "<Leader>ghs", desc = "stage hunk" },
      { "<Leader>ghS", desc = "stage buffer" },
      { "<Leader>ght", desc = "toggle deleted" },
      { "<Leader>ghu", desc = "undo stage" },
    }
  },
  {
    "sindrets/diffview.nvim",
    lazy = true,
    enabled = true,
    event = "BufRead",
    config = function()
      require("plugins.git.diffview")
    end,
    keys = {
      { "<Leader>gd", "<cmd>lua require('plugins.git.diffview').toggle_file_history()<CR>", desc = "diff file" },
      { "<Leader>gS", "<cmd>lua require('plugins.git.diffview').toggle_status()<CR>",       desc = "status" }
    },
  },
  {
    "akinsho/git-conflict.nvim",
    lazy = false,
    config = function()
      require("plugins.git.conflict")
    end,
    keys = {
      { "<Leader>gcb", '<cmd>GitConflictChooseBoth<CR>',   desc = 'choose both' },
      { "<Leader>gcn", '<cmd>GitConflictNextConflict<CR>', desc = 'move to next conflict' },
      { "<Leader>gcc", '<cmd>GitConflictChooseOurs<CR>',   desc = 'choose current' },
      { "<Leader>gcp", '<cmd>GitConflictPrevConflict<CR>', desc = 'move to prev conflict' },
      { "<Leader>gci", '<cmd>GitConflictChooseTheirs<CR>', desc = 'choose incoming' },
    }
  },
  {
    "ThePrimeagen/git-worktree.nvim",
    lazy = false,
    config = function()
      require("plugins.git.worktree")
    end,
    keys = {
      { "<Leader>gww", desc = "worktrees" },
      { "<Leader>gwc", desc = "create worktree" }
    }
  },
  {
    "kdheepak/lazygit.nvim",
    cmd = {
      "LazyGit",
      "LazyGitCurrentFile",
      "LazyGitFilterCurrentFile",
      "LazyGitFilter",
    },
    keys = {
      { "<Leader>gg", "<cmd>LazyGit<CR>", desc = "lazygit" },
    },
    config = function()
      vim.g.lazygit_floating_window_scaling_factor = 0.9
    end,
  },
  {
    "pwntester/octo.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-telescope/telescope.nvim",
      "nvim-tree/nvim-web-devicons",
    },
    cmd = {
      "Octo",
    },
    config = function()
      require('plugins.git.octo')
    end
  },

  -- ╭─────────────────────────────────────────────────────────╮
  -- │ Testing                                                 │
  -- ╰─────────────────────────────────────────────────────────╯
  {
    "rcarriga/neotest",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
      "antoinemadec/FixCursorHold.nvim",
      "haydenmeade/neotest-jest",
    },
    config = function()
      require("plugins.neotest")
    end,
  },
  {
    "andythigpen/nvim-coverage",
    dependencies = "nvim-lua/plenary.nvim",
    cmd = {
      "Coverage",
      "CoverageSummary",
      "CoverageLoad",
      "CoverageShow",
      "CoverageHide",
      "CoverageToggle",
      "CoverageClear",
    },
    config = function()
      require("coverage").setup()
    end,
  },

  -- ╭─────────────────────────────────────────────────────────╮
  -- │ DAP                                                     │
  -- ╰─────────────────────────────────────────────────────────╯
  {
    "mfussenegger/nvim-dap",
    config = function()
      require("plugins.dap")
    end,
    keys = {
      "<Leader>da",
      "<Leader>db",
      "<Leader>dc",
      "<Leader>dd",
      "<Leader>dh",
      "<Leader>di",
      "<Leader>do",
      "<Leader>dO",
      "<Leader>dt",
    },
    dependencies = {
      "theHamsta/nvim-dap-virtual-text",
      "rcarriga/nvim-dap-ui",
      "mxsdev/nvim-dap-vscode-js",
    },
  },
  {
    "LiadOz/nvim-dap-repl-highlights",
    config = true,
    dependencies = {
      "mfussenegger/nvim-dap",
      "nvim-treesitter/nvim-treesitter",
    },
    build = function()
      if not require("nvim-treesitter.parsers").has_parser("dap_repl") then
        vim.cmd(":TSInstall dap_repl")
      end
    end,
  },

  -- ╭─────────────────────────────────────────────────────────╮
  -- │ Format & Lint                                           │
  -- ╰─────────────────────────────────────────────────────────╯
}
