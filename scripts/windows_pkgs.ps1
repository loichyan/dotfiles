# Install Scoop package manager.
Invoke-Expression (New-Object net.webclient).downloadstring('https://get.scoop.sh')

# Install packages for development.
scoop install 7zip gsudo git gcc make python neovim nodejs yarn
winget install -i Microsoft.PowerShell
winget install -i Microsoft.VisualStudioCode

# Install packages for media.
winget install -i Daum.PotPlayer
winget install -i Netease.CloudMusic
winget install -i ByteDance.JianyingPro

# Install other packages.
winget install -i voidtools.Everything.Lite
winget install -i Tencent.WeChat
winget install -i Tencent.QQ
