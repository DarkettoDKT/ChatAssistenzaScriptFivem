Config = {
    popassistformat = "Il Player %s richiede supporto via chat \nscrivi <span class='text-success'>/dmaccassist %s</span> per accettare o <span class='text-danger'>/dmdecansist</span> per rifiutare", -- popup assist message format
    chatassistformat = " Il Player %s richiede supporto via chat \nscrivi ^2/dmaccassist %s^7 per accettare or ^1/dmaccassist^7 per rifiutare\n", -- chat assist message format

    warning_screentime = 7.5, -- warning display length (in seconds)
    backup_kick_method = false, -- set this to true if banned players don't get kicked when banned or they can re-connect after being banned.
    kick_without_steam = true, -- prevent a player from joining your server without a steam identifier.
    page_element_limit = 250,
    ip_ban = false -- set to true to use ip in bans

    Staff = {
        'founder', 
        'cofounder', 
        'superadmin',
        'admin',
        'mod', 
        'helper'
    }
}
