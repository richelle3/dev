local M = {}

-- Определение системы
local function detect_system()
  -- Попробуем определить через /etc/os-release
  local ok, os_release = pcall(vim.fn.readfile, "/etc/os-release")
  if ok then
    for _, line in ipairs(os_release) do
      line = line:lower()
      if line:match("arch linux arm") or line:match("archlinux arm") or line:match("id=archarm") then
        return "archlinuxarm"
      elseif line:match("arch") then
        return "arch"
      elseif line:match("debian") then
        return "debian"
      elseif line:match("ubuntu") then
        return "ubuntu"
      end
    end
  end

  -- Дополнительная проверка на Termux
  if vim.fn.has("unix") == 1 and vim.fn.executable("termux-info") == 1 then
    return "termux"
  end

  return "unknown"
end

local dependencies = {
  { binary = "git", package = "git" },
  { binary = "curl", package = "curl" },
  { binary = "zip", package = "zip" },
  { binary = "unzip", package = "unzip" },
  { binary = "file", package = "file" },
  { binary = "fzf", package = "fzf" },
  { binary = "node", package = "nodejs" },
  { binary = "python", package = "python" },
  { binary = "rg", package = "ripgrep" },
  { binary = "fd", package = "fd" },
  { binary = "cowsay", package = "cowsay" },
}

-- Проверка зависимостей
local function check_dependencies()
  local missing = {}
  for _, dep in ipairs(dependencies) do
    if vim.fn.executable(dep.binary) == 0 then
      table.insert(missing, dep)
    end
  end

  if #missing > 0 then
    vim.notify("[ !! ] Отсутствуют зависимости:", vim.log.levels.WARN)
    for _, dep in ipairs(missing) do
      vim.notify(string.format(">> %s (пакет: %s)", dep.binary, dep.package))
    end
  end

  return missing
end

M.install = function(opts)
  opts = opts or {}

  if opts.dependencies then
    local missing = check_dependencies()
    local system = detect_system()

    if system == "archlinuxarm" then
      for _, dep in ipairs(missing) do
        vim.fn.system({ "pacman", "-S", "--noconfirm", dep.package })
        vim.notify("[ Ok ] Установлен: " .. dep.package, vim.log.levels.INFO)
      end
    elseif system == "termux" then
      for _, dep in ipairs(missing) do
        vim.fn.system({ "apt", "install", "-y", dep.package })
        vim.notify("[ Ok ] Установлен: " .. dep.package, vim.log.levels.INFO)
      end
    else
      vim.notify("[ modul core ] Автоустановка поддерживается только на ArchLinux ARM.\nОбнаружена система: " .. system .. ".\n[ tip ] Установи зависимости вручную.")
    end
  end
end

return M

