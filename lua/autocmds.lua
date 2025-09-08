local autocmd = vim.api.nvim_create_autocmd

-- dont list quickfix buffers
autocmd("FileType", {
  pattern = "qf",
  callback = function()
    vim.opt_local.buflisted = false
  end,
})

-- user event that loads after UIEnter + only if file buf is there
vim.api.nvim_create_autocmd({ "UIEnter", "BufReadPost", "BufNewFile" }, {
  group = vim.api.nvim_create_augroup("NvFilePost", { clear = true }),
  callback = function(args)
    local file = vim.api.nvim_buf_get_name(args.buf)
    local buftype = vim.api.nvim_buf_get_option(args.buf, "buftype")

    if not vim.g.ui_entered and args.event == "UIEnter" then
      vim.g.ui_entered = true
    end

    if file ~= "" and buftype ~= "nofile" and vim.g.ui_entered then
      vim.api.nvim_exec_autocmds("User", { pattern = "FilePost", modeline = false })
      vim.api.nvim_del_augroup_by_name "NvFilePost"

      vim.schedule(function()
        vim.api.nvim_exec_autocmds("FileType", {})

        if vim.g.editorconfig then
          require("editorconfig").config(args.buf)
        end
      end)
    end
  end,
})

-- Convert pdf to text when opened in neovim
-- Define a function to handle loading PDF text into the buffer
local function load_pdf_text_into_buffer(pdf_path)
  -- Use `pdftotext` to get the text content from the PDF
  local handle = io.popen("pdftotext " .. pdf_path .. " -") -- `-` outputs to stdout
  if handle then
    local pdf_text = handle:read "*a"
    handle:close()

    -- Clear the current buffer and insert the PDF text
    vim.api.nvim_buf_set_lines(0, 0, -1, false, vim.split(pdf_text, "\n"))
  else
    print "Error: Could not open PDF with pdftotext."
  end
end

-- Create an autocommand group to manage the PDF loading commands
vim.api.nvim_create_augroup("PDFtoText", { clear = true })

-- Add an autocommand for opening PDF files
vim.api.nvim_create_autocmd("BufReadPost", {
  group = "PDFtoText",
  pattern = "*.pdf",
  callback = function()
    local pdf_path = vim.fn.expand "%:p" -- Get the full path of the PDF file
    load_pdf_text_into_buffer(pdf_path)
  end,
})



-- Disable inline virtual text and enable virtual lines
vim.diagnostic.config({
  virtual_text = false,
  virtual_lines = true,
})

vim.cmd [[colorscheme tokyonight-moon]]
vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
vim.api.nvim_set_hl(0, "SignColumn", { bg = "none" })
vim.api.nvim_set_hl(0, "ActiveWindow", { bg = "none" })
vim.api.nvim_set_hl(0, "InactiveWindow", { bg = "none" })
vim.api.nvim_set_hl(0, "NormalNC", { bg = "none" })
vim.api.nvim_set_hl(0, "WinSeparator", { bg = "none", fg = "none" })
