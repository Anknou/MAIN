@echo off

@RD /S /Q "%temp%\ALIK_V"

netsh advfirewall set allprofiles state on
netsh advfirewall firewall delete rule name="ALIK - Anti-Spying"

MKDIR %temp%\ALIK_V
MKDIR %temp%\ALIK_V\hosts
MKDIR %temp%\ALIK_V\firewall



echo # ALIK - Anti (Spying; Adware; Malware) [%date%]>>"%temp%\ALIK_V\hosts\winspyblock_hosts.txt"
echo.>>"%temp%\ALIK_V\hosts\winspyblock_hosts.txt"
echo # CCleanerSpyBlocker>>"%temp%\ALIK_V\hosts\winspyblock_hosts.txt"
echo 0.0.0.0 www.ccleaner.com>>"%temp%\ALIK_V\hosts\winspyblock_hosts.txt"
echo 0.0.0.0 license.piriform.com>>"%temp%\ALIK_V\hosts\winspyblock_hosts.txt"
echo 0.0.0.0 shepherd.ff.avast.com>>"%temp%\ALIK_V\hosts\winspyblock_hosts.txt"
echo 0.0.0.0 shepherd.ff.avast.concc.avast.com>>"%temp%\ALIK_V\hosts\winspyblock_hosts.txt"
echo 0.0.0.0 ncc.avast.com.edgesuite.net>>"%temp%\ALIK_V\hosts\winspyblock_hosts.txt"
echo 0.0.0.0 ip-info.ff.avast.com>>"%temp%\ALIK_V\hosts\winspyblock_hosts.txt"
echo.>>"%temp%\ALIK_V\hosts\winspyblock_hosts.txt"
echo # WindowsSpyBlocker by crazy-max>>"%temp%\ALIK_V\hosts\winspyblock_hosts.txt"
bitsadmin /transfer /download https://raw.githubusercontent.com/crazy-max/WindowsSpyBlocker/master/data/hosts/spy.txt "%temp%\ALIK_V\hosts\crazy-max_hosts.txt"
more +6 "%temp%\ALIK_V\hosts\crazy-max_hosts.txt" >> "%temp%\ALIK_V\hosts\winspyblock_hosts.txt"
echo.>>"%temp%\ALIK_V\hosts\winspyblock_hosts.txt"


bitsadmin /transfer /download https://raw.githubusercontent.com/StevenBlack/hosts/master/hosts "%temp%\ALIK_V\hosts\StevenBlack(adware + malware).txt"
type "%temp%\ALIK_V\hosts\StevenBlack(adware + malware).txt" | >"%temp%\ALIK_V\hosts\StevenBlack(adware + malware)_edited.txt" findstr /i /v /l /c:"0.0.0.0 s.click.aliexpress.com"



bitsadmin /transfer /download https://raw.githubusercontent.com/crazy-max/WindowsSpyBlocker/master/data/firewall/spy.txt "%temp%\ALIK_V\firewall\crazy-max_firewall.txt"


set "sym_fw=,"
 <"%temp%\ALIK_V\firewall\crazy-max_firewall.txt">"%temp%\ALIK_V\firewall\spy_firewall_2.txt" (
for /f "delims=" %%i in ('more +5') do (
 for /f "delims=" %%j in ("%sym_fw%") do (
  echo.%%j%%i
  )
 )
)

 <"%temp%\ALIK_V\firewall\spy_firewall_2.txt">"%temp%\ALIK_V\firewall\spy_firewall_3.txt" (
for /f %%a in ('more') do @<nul set/p="%%a" )


set "sym_fw2=netsh advfirewall firewall add rule name="ALIK - Anti-Spying" action=block dir=OUT remoteip="
 <"%temp%\ALIK_V\firewall\spy_firewall_3.txt">"%temp%\ALIK_V\firewall\spy_firewall_final.bat" (
for /f "delims=" %%i in ('more') do (
 for /f "delims=" %%j in ("%sym_fw2%") do (
  echo.%%j%%i
  )
 )
)

copy /b "%temp%\ALIK_V\hosts\winspyblock_hosts.txt" + "%temp%\ALIK_V\hosts\StevenBlack(adware + malware)_edited.txt" "%systemroot%\System32\drivers\etc\hosts"

call "%temp%\ALIK_V\firewall\spy_firewall_final.bat"


@RD /S /Q "%temp%\ALIK_V"

exit/b
