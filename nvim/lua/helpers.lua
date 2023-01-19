function nnoremap(options)
  -- trigger key
  local key = options[1] or options.key
  -- command
  local command = options[2] or options.command
  -- noremap is true by default
  local noremap = true and options.noremap == nil or options.noremap
  -- silent is true by default
  local silent = true and options.silent == nil or options.silent
  -- expr is false by default
  local expr = true and options.expr

  vim.api.nvim_set_keymap("n", key, command, { noremap = noremap, silent = silent, expr = expr })
end

-- inoremap function
function inoremap(options)
  -- trigger key
  local key = options[1] or options.key
  -- command
  local command = options[2] or options.command
  -- noremap is true by default
  local noremap = true and options.noremap == nil or options.noremap
  -- silent is true by default
  local silent = true and options.silent == nil or options.silent
  -- expr is false by default
  local expr = true and options.expr

  vim.api.nvim_set_keymap("i", key, command, { noremap = noremap, silent = silent, expr = expr })
end

-- vnoremap function (visual mode)
function vnoremap(options)
  -- trigger key
  local key = options[1] or options.key
  -- command
  local command = options[2] or options.command
  -- noremap is true by default
  local noremap = true and options.noremap == nil or options.noremap
  -- silent is true by default
  local silent = true and options.silent == nil or options.silent
  -- expr is false by default
  local expr = true and options.expr

  vim.api.nvim_set_keymap("v", key, command, { noremap = noremap, silent = silent, expr = expr })
end
