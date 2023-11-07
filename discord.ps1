$message = Read-Host "message"
# Define the headers using a hashtable
$headers = @{
    "Content-Type" = "application/json"
    "Authorization" = "discord_token"
    "User-Agent" = "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/118.0.0.0 Safari/537.36"
}

# Create a web session
$session = New-Object Microsoft.PowerShell.Commands.WebRequestSession

# Define an array of cookies
$cookieData = @(
    @{ Name = '__dcfduid'; Value = 'a748c3366dd611ee8df622c48eb22492'; Domain = 'discord.com' },
    @{ Name = '__sdcfduid'; Value = 'a748c3366dd611ee8df622c48eb224921b2e2961c53ce71de12d91616d9acb92bb6f0c619c3c6622c6a5e245eaf0ff32'; Domain = 'discord.com' },
    @{ Name = '__cfruid'; Value = 'f74e2dde75b2ed8d42ea92c2c6a48a1c72ee6d8c-1697649529'; Domain = 'discord.com' },
    @{ Name = '_cfuvid'; Value = 'bj6FEc82UIdRWKJwxOgTI5U2B_rY5WEBdqMUo2KUEN0-1699250860658-0-604800000'; Domain = 'discord.com' }
)

# Create and add cookies to the session
foreach ($cookieInfo in $cookieData) {
    $cookie = New-Object System.Net.Cookie
    $cookie.Name = $cookieInfo.Name
    $cookie.Value = $cookieInfo.Value
    $cookie.Domain = $cookieInfo.Domain
    $session.Cookies.Add($cookie)
}

# Construct the JSON body with the message variable
$body = @{
    content = "$message *(this was sent from PowerShell)*"
} | ConvertTo-Json

# Make the API request
$response = Invoke-RestMethod -Uri 'https://discord.com/api/v9/channels/channel_ID/messages' -Method POST -Headers $headers -WebSession $session -ContentType 'application/json' -Body $body
Pause
