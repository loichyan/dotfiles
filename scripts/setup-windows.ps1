# Install packages for development
winget install -i 7zip.7zip
winget install -i Microsoft.VisualStudioCode
winget install -i gsudo
winget install -i Microsoft.PowerShell

# Install packages for media
winget install -i Daum.PotPlayer
winget install -i Netease.CloudMusic

# Install other packages
winget install -i voidtools.Everything.Lite
winget install -i Tencent.WeChat
winget install -i Tencent.QQ

# Set Nerd Fonts fallback
Set-ItemProperty -Path "HKCU:\EUDC\$(Get-ItemPropertyValue -Path HKLM:\SYSTEM\CurrentControlSet\Control\Nls\CodePage -Name OEMCP)" -Name SystemDefaultEUDCFont -Value SymbolsNerdFont-Regular.ttf
