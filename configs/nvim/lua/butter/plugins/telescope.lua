return {
    "nvim-telescope/telescope.nvim",
    branch = "0.1.x",
    dependencies = {
        "nvim-lua/plenary.nvim",
        { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
        "nvim-tree/nvim-web-devicons",
    },
    config = function()
        local telescope = require("telescope")
        local actions = require("telescope.actions")

        telescope.setup({
            defaults = {
                file_ignore_patterns = { "node_modules", ".git", "coverage" },
                path_display = { "truncate " },
                mappings = {
                    i = {
                        ["<C-k>"] = actions.move_selection_previous, -- move to prev result
                        ["<C-j>"] = actions.move_selection_next, -- move to next result
                        ["<C-q>"] = actions.send_selected_to_qflist + actions.open_qflist,
                        ["<C-d>"] = actions.delete_buffer,
                    },
                    n = {
                        ["<C-d>"] = actions.delete_buffer,
                    },
                },
            },
        })

        telescope.load_extension("fzf")

        -- set keymaps
        local keymap = vim.keymap -- for conciseness

        -- misc
        keymap.set("n", "<leader>fh", "<cmd>Telescope help_tags<cr>", { desc = "Fuzzy find help" })

        -- files
        keymap.set("n", "<leader>ff", "<cmd>Telescope find_files<cr>", { desc = "Fuzzy find files in cwd" })
        keymap.set("n", "<leader>fo", "<cmd>Telescope oldfiles<cr>", { desc = "Fuzzy find recent files" })
        keymap.set("n", "<leader><space>", "<cmd>Telescope buffers<cr>", { desc = "Fuzzy find open buffers" })

        -- text
        keymap.set("n", "<leader>fs", "<cmd>Telescope live_grep hidden=true<cr>", { desc = "Find string in cwd" })
        keymap.set("n", "<leader>fc", "<cmd>Telescope grep_string<cr>", { desc = "Find string under cursor in cwd" })

        -- lsp
        keymap.set("n", "<leader>fd", "<cmd>Telescope diagnostics<cr>", { desc = "Fuzzy find diagnostics" })
        keymap.set(
            "n",
            "<leader>fp",
            "<cmd>Telescope lsp_document_symbols<cr>",
            { desc = "Fuzzy find document symbols" }
        )
        keymap.set(
            "n",
            "<leader>fP",
            "<cmd>Telescope lsp_dynamic_workspace_symbols<cr>",
            { desc = "Fuzzy find workspace symbols" }
        )
    end,
}
