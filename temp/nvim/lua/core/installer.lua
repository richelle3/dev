-- ~/.config/nvim/lua/core/installer.lua
local M = {}

local function detect_platform()
    local handle = io.popen("uname -o 2>/dev/null")
    local os_name = handle:read("*l") or ""
    handle:close()

    local is_arch = os.execute("command -v pacman > /dev/null 2>&1") == 0
    local is_termux = os_name:lower():match("android") and os.execute("command -v pkg > /dev/null 2>&1") == 0

    if is_termux then
        return "termux", "pkg install -y "
    elseif is_arch then
        return "arch", "pacman -S --noconfirm "
    else
        return nil, nil
    end
end

local function is_installed(binary)
    return os.execute("command -v " .. binary .. " > /dev/null 2>&1") == 0
end

local function install(pkg)
    local platform, install_cmd = detect_platform()
    if not platform then
        print("❌ Система не поддерживается. Установите '" .. pkg .. "' вручную.")
        return
    end

    print("🚀 Устанавливаю " .. pkg .. " через " .. platform .. "...")
    local result = os.execute(install_cmd .. pkg)
    if result == 0 then
        print("✅ Установлен: " .. pkg)
    else
        print("❌ Ошибка установки: " .. pkg)
    end
end

M.install_dependencies = function(deps)
    if type(deps) ~= "table" then
        print("⚠️ Ожидался список зависимостей.")
        return
    end

    for _, dep in ipairs(deps) do
        if not is_installed(dep.binary) then
            install(dep.package)
        else
            print("✅ " .. dep.binary)
        end
    end
end

return M

