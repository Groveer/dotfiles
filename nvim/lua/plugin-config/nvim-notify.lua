local status, project = pcall(require, "notify")
if not status then
  vim.notify("没有找到 nvim-notify")
  return
end

vim.notify = require("notify")
