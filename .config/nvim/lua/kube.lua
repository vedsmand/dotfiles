  --TODO
  --add command for switching context
local api = vim.api
local buf, win
local position = 0
local init_path = vim.fn.expand('%:h:p') 

local function center(str)
  local width = api.nvim_win_get_width(0)
  local shift = math.floor(width / 2) - math.floor(string.len(str) / 2)
  return string.rep(' ', shift) .. str
end

local function open_window()
  buf = api.nvim_create_buf(false, true)
  local border_buf = api.nvim_create_buf(false, true)

  api.nvim_buf_set_option(buf, 'bufhidden', 'wipe')
  api.nvim_buf_set_option(buf, 'buftype', 'nofile')
  api.nvim_buf_set_option(buf, 'filetype', 'text')

  local width = api.nvim_get_option("columns")
  local height = api.nvim_get_option("lines")

  local win_height = math.ceil(height * 0.8 - 4)
  local win_width = math.ceil(width * 0.8)
  local row = math.ceil((height - win_height) / 2 - 1)
  local col = math.ceil((width - win_width) / 2)

  local border_opts = {
    style = "minimal",
    relative = "editor",
    width = win_width + 2,
    height = win_height + 2,
    row = row - 1,
    col = col - 1
  }

  local opts = {
    style = "minimal",
    relative = "editor",
    width = win_width,
    height = win_height,
    row = row,
    col = col
  }

  local border_lines = { '╔' .. string.rep('═', win_width) .. '╗' }
  local middle_line = '║' .. string.rep(' ', win_width) .. '║'
  for i=1, win_height do
    table.insert(border_lines, middle_line)
  end
  table.insert(border_lines, '╚' .. string.rep('═', win_width) .. '╝')
  api.nvim_buf_set_lines(border_buf, 0, -1, false, border_lines)

  local border_win = api.nvim_open_win(border_buf, true, border_opts)
  win = api.nvim_open_win(buf, true, opts)
  api.nvim_command('au BufWipeout <buffer> exe "silent bwipeout! "'..border_buf)

end

local function update_view(direction)
  api.nvim_buf_set_option(buf, 'modifiable', true)
  position = position + direction
  if position < 0 then position = 0 end

  local ks_command = string.format("kubectl apply --server-side=true --dry-run=server --validate=strict -k %s", init_path)
  local result = vim.fn.systemlist(ks_command)

  if #result == 0 then table.insert(result, '') end -- add  an empty line to preserve layout if there is no results
  for k,v in pairs(result) do
    result[k] = '  '..result[k]
  end

  local kube_context = vim.fn.systemlist('kubectl config current-context')
  if #kube_context == 0 then table.insert(kube_context, '--kubernetes context is not set--') end

  api.nvim_buf_set_lines(buf, 0, -1, false, {center(string.format('  %s', ks_command))})
  api.nvim_buf_add_highlight(buf, -1, 'GruvboxFg2', 0, 0, -1)

  api.nvim_buf_set_lines(buf, 1, 2, false, {center(string.format(' ﴱ %s', kube_context[1]))})
  api.nvim_buf_add_highlight(buf, -1, 'GruvboxYellow', 1, 0, -1)

  api.nvim_buf_set_lines(buf, 2, 3, false, { center(string.format('  %s', init_path)), '', ''})
  api.nvim_buf_add_highlight(buf, -1, 'GruvboxBlue', 2, 0, -1)

  api.nvim_buf_set_lines(buf, 3, 4, false, {center("")}) -- add empty line seperator
  api.nvim_buf_set_lines(buf, 5, -1, false, result)

  api.nvim_buf_set_option(buf, 'modifiable', true)
end

local function close_window()
  api.nvim_win_close(win, true)
end


local function move_cursor()
  local new_pos = math.max(4, api.nvim_win_get_cursor(win)[1] - 1)
  api.nvim_win_set_cursor(win, {new_pos, 0})
end

local function set_mappings()
  local mappings = {
    q = 'close_window()',
    k = 'move_cursor()'
  }

  for k,v in pairs(mappings) do
    api.nvim_buf_set_keymap(buf, 'n', k, ':lua require"kube".'..v..'<cr>', {
        nowait = true, noremap = true, silent = true
      })
  end
  local other_chars = {
    'a', 'b', 'c', 'd', 'e', 'f', 'g', 'h', 'i', 'l', 'n', 'o', 'p', 'r', 's', 't', 'u', 'v', 'w', 'x', 'y', 'z'
  }
  for k,v in ipairs(other_chars) do
    api.nvim_buf_set_keymap(buf, 'n', v, '', { nowait = true, noremap = true, silent = true })
    api.nvim_buf_set_keymap(buf, 'n', v:upper(), '', { nowait = true, noremap = true, silent = true })
    api.nvim_buf_set_keymap(buf, 'n',  '<c-'..v..'>', '', { nowait = true, noremap = true, silent = true })
  end
end

local function kube()
  position = 0
  open_window()
  set_mappings()
  update_view(0)
  api.nvim_win_set_cursor(win, {4, 0})
end

return {
  kube = kube,
  move_cursor = move_cursor,
  close_window = close_window
}
