vim.lsp.config("*", {
	root_markers = { ".git" },
})

vim.diagnostic.config({
	virtual_text = true,
	severity_sort = true,
	float = {
		style = "minimal",
		border = "rounded",
		source = "if_many",
		header = "",
		prefix = "",
	},
	signs = {
		text = {
			[vim.diagnostic.severity.ERROR] = "✘",
			[vim.diagnostic.severity.WARN] = "▲",
			[vim.diagnostic.severity.HINT] = "⚑",
			[vim.diagnostic.severity.INFO] = "»",
		},
	},
})
-- put early in lsp.lua
local orig = vim.lsp.util.open_floating_preview
---@diagnostic disable-next-line: duplicate-set-field
function vim.lsp.util.open_floating_preview(contents, syntax, opts, ...)
	opts = opts or {}
	opts.border = opts.border or "rounded"
	opts.max_width = opts.max_width or 80
	opts.max_height = opts.max_height or 24
	opts.wrap = opts.wrap ~= false
	return orig(contents, syntax, opts, ...)
end

-- 4) Per-buffer behavior on LSP attach (keymaps, auto-format, completion)
-- See :help LspAttach for the recommended pattern
vim.api.nvim_create_autocmd("LspAttach", {
	group = vim.api.nvim_create_augroup("my.lsp", {}),
	callback = function(args)
		local client = assert(vim.lsp.get_client_by_id(args.data.client_id))
		local buf = args.buf
		local map = function(mode, lhs, rhs)
			vim.keymap.set(mode, lhs, rhs, { buffer = buf })
		end

		-- Keymaps (use builtin LSP buffer functions)
		map("n", "K", vim.lsp.buf.hover)
		map("n", "gd", vim.lsp.buf.definition)
		map("n", "gD", vim.lsp.buf.declaration)
		map("n", "gi", vim.lsp.buf.implementation)
		map("n", "go", vim.lsp.buf.type_definition)
		map("n", "gr", vim.lsp.buf.references)
		map("n", "gs", vim.lsp.buf.signature_help)
		map("n", "gl", vim.diagnostic.open_float)
		map("n", "<F2>", vim.lsp.buf.rename)
		map({ "n", "x" }, "<F3>", function()
			vim.lsp.buf.format({ async = true })
		end)
		map("n", "<F4>", vim.lsp.buf.code_action)
		local conform_ft = {
			javascript = true,
			javascriptreact = true,
			typescript = true,
			typescriptreact = true,
			json = true,
			jsonc = true,
			cs = true,
		}

		local excluded_filetypes = { php = true }

		if
			not conform_ft[vim.bo[buf].filetype]
			and not excluded_filetypes[vim.bo[buf].filetype]
			and client:supports_method("textDocument/formatting")
			and not client:supports_method("textDocument/willSaveWaitUntil")
		then
			vim.api.nvim_create_autocmd("BufWritePre", {
				group = vim.api.nvim_create_augroup("my.lsp.format", { clear = false }),
				buffer = buf,
				callback = function()
					vim.lsp.buf.format({ bufnr = buf, id = client.id, timeout_ms = 2000 })
				end,
			})
		end
	end,
})

-- 5) Define the Lua language server config (no mason/lspconfig)
-- See :help lsp-new-config and :help vim.lsp.config()
local caps = require("cmp_nvim_lsp").default_capabilities()
vim.lsp.config["luals"] = {
	cmd = { "lua-language-server" },
	filetypes = { "lua" },
	root_markers = { { ".luarc.json", ".luarc.jsonc" }, ".git" },
	capabilities = caps,
	settings = {
		Lua = {
			runtime = { version = "LuaJIT" },
			diagnostics = { globals = { "vim" } },
			workspace = {
				checkThirdParty = false,
				library = vim.api.nvim_get_runtime_file("", true),
			},
			telemetry = { enable = false },
		},
	},
}

vim.lsp.config["cssls"] = {
	cmd = { "vscode-css-language-server", "--stdio" },
	filetypes = { "css", "scss", "less" },
	root_markers = { "package.json", ".git" },
	capabilities = caps,
	settings = {
		css = { validate = true },
		scss = { validate = true },
		less = { validate = true },
	},
}

vim.lsp.config["phpls"] = {
	cmd = { "intelephense", "--stdio" },
	filetypes = { "php" },
	root_markers = { "composer.json", ".git" },
	capabilities = caps,
	settings = {
		intelephense = {
			files = {
				maxSize = 5000000, -- default 5MB
			},
		},
	},
}

-- Rust --
vim.lsp.config["rust-analyzer"] = {
	capabilities = caps,
	cmd = { "rust-analyzer" },
	filetypes = { "rust" },
	root_markers = { "Cargo.toml", ".git" },
	single_file_support = true,
	settings = {
		["rust-analyzer"] = {
			diagnostics = {
				enable = true,
			},
		},
	},
	before_init = function(init_params, config)
		-- See https://github.com/rust-lang/rust-analyzer/blob/eb5da56d839ae0a9e9f50774fa3eb78eb0964550/docs/dev/lsp-extensions.md?plain=1#L26
		if config.settings and config.settings["rust-analyzer"] then
			init_params.initializationOptions = config.settings["rust-analyzer"]
		end
	end,
}

-- Nix LSP (nil)
vim.lsp.config["nil_ls"] = {
	cmd = { "nil" },
	filetypes = { "nix" },
	root_markers = { "flake.nix", "default.nix", ".git" },
	capabilities = caps,
	settings = {
		["nil"] = {
			formatting = {
				command = { "nixpkgs-fmt" }, -- or "alejandra" if you prefer
			},
		},
	},
}

-- Svelte --
-- Svelte (core LSP API, not lspconfig)
local caps = require("cmp_nvim_lsp").default_capabilities()

vim.lsp.config["svelte"] = {
	cmd = { "svelteserver", "--stdio" }, -- Nix binary name
	filetypes = { "svelte" },
	-- Keep a sane root detection; you set a repo-wide default of '.git' above,
	-- but Svelte projects usually have one of these:
	root_markers = {
		"svelte.config.js",
		"svelte.config.cjs",
		"svelte.config.ts",
		"package.json",
		".git",
	},
	capabilities = caps,
	-- Optional: if your project vendors TS, help the LS find it
	-- init_options = {
	--   typescript = { tsdk = vim.fn.getcwd() .. '/node_modules/typescript/lib' }
	-- },
}

-- ts_ls
vim.lsp.config["ts_ls"] = {
	cmd = { "typescript-language-server", "--stdio" },
	filetypes = {
		"javascript",
		"javascriptreact",
		"javascript.jsx",
		"typescript",
		"typescriptreact",
		"typescript.tsx",
	},
	root_markers = { "package.json", "tsconfig.json", "jsconfig.json", ".git" },
	capabilities = caps,
	settings = {
		completions = {
			completeFunctionCalls = true,
		},
	},
	on_attach = function(client, bufnr)
		client.server_capabilities.documentFormattingProvider = false
		client.server_capabilities.documentRangeFormattingProvider = false
	end,
}

-- Biome lsp
vim.lsp.config["biome"] = {
	-- prefer local node binary; fallback to global "biome"
	cmd = function(dispatchers, _)
		local buf = vim.api.nvim_get_current_buf()
		local root = vim.fs.root(buf, { "package.json", "tsconfig.json", "jsconfig.json", ".git" }) or vim.loop.cwd()
		local local_biome = root and (root .. "/node_modules/.bin/biome") or nil
		local exe = (local_biome and vim.fn.executable(local_biome) == 1) and local_biome or "biome"
		return vim.lsp.rpc.start({ exe, "lsp-proxy" }, dispatchers)
	end,

	filetypes = {
		"javascript",
		"javascriptreact",
		"typescript",
		"typescriptreact",
		"json",
		"jsonc",
	},
	init_options = {
		typescript = { enabled = true },
	},

	-- keep root detection simple; biome can still find its config upward.
	root_markers = { "biome.json", "biome.jsonc" },

	capabilities = require("cmp_nvim_lsp").default_capabilities(),

	-- let conform do formatting; biome still provides diagnostics/completion
	on_attach = function(client, _)
		client.server_capabilities.documentformattingprovider = false
		client.server_capabilities.documentrangeformattingprovider = false
	end,
}

local function enable_semantic_tokens(client)
	local p = client.server_capabilities
	if p and p.semanticTokensProvider and not p.semanticTokensProvider.full then
		p.semanticTokensProvider.full = true
	end
end

vim.lsp.config["omnisharp"] = {
	cmd = { "omnisharp", "-lsp" }, -- LSP mode
	filetypes = { "cs", "vb" },
	root_markers = { "*.sln", "*.csproj", ".git" },
	capabilities = caps,
	init_options = {
		FormattingOptions = {
			-- Let your general formatter run; if you want OmniSharp to format, set to true
			EnableEditorConfigSupport = true,
			OrganizeImports = true,
		},
		RoslynExtensionsOptions = {
			EnableAnalyzersSupport = true,
			EnableDecompilationSupport = true,
			InlayHintsOptions = {
				EnableForParameters = true,
				ForLiteralParameters = true,
				ForIndexerParameters = true,
				ForOtherParameters = true,
				SuppressForParametersThatDifferOnlyBySuffix = false,
				SuppressForParametersThatMatchMethodIntent = false,
				SuppressForParametersThatMatchArgumentName = false,
			},
		},
		MarkdownOptions = {
			SupportGitHubStyle = true,
		},
		MsBuild = {
			-- Modern .NET (no Mono); helps on NixOS
			UseModernNet = true,
			-- Load projects faster; great for mono-repo or big trees
			LoadProjectsOnDemand = true,
		},
	},

	-- Minor fixups on attach
	on_attach = function(client, bufnr)
		enable_semantic_tokens(client)

		-- If you prefer a dedicated formatter (e.g., csharpier via conform/null-ls),
		-- keep server formatting off so it does not fight your formatter.
		client.server_capabilities.documentFormattingProvider = false
		client.server_capabilities.documentRangeFormattingProvider = false

		-- Optional: organize imports on save (safe + fast in C#)
		vim.api.nvim_create_autocmd("BufWritePre", {
			group = vim.api.nvim_create_augroup("csharp.organize_imports", { clear = false }),
			buffer = bufnr,
			callback = function()
				pcall(vim.lsp.buf.execute_command, {
					command = "omnisharp/runCodeAction",
					arguments = {
						{ Identifier = "usingdirective_sort", WantsTextChanges = true, ApplyChanges = true },
					},
				})
			end,
		})
	end,
}

vim.lsp.enable("luals")
vim.lsp.enable("cssls")
vim.lsp.enable("ts_ls")
vim.lsp.enable("phpls")
vim.lsp.enable("nil_ls")
vim.lsp.enable("rust-analyzer")
vim.lsp.enable("biome")
vim.lsp.enable("svelte")
vim.lsp.enable("omnisharp")
