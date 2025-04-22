repeat wait() until game:IsLoaded()

    if ZZ_LOADED then
        return
    end
    pcall(function() getgenv().ZZ_LOADED = true end)

    if not _G.Authorize or _G.Authorize == "" then
        loadstring(game:HttpGet("https://raw.githubusercontent.com/Zeldazsy/Zenzo/refs/heads/free" .. game.GameId))()
        return
    end

    loadstring(game:HttpGet("https://raw.githubusercontent.com/Zeldazsy/Zenzo/refs/heads/paid" .. game.GameId .. "-wl"))()
