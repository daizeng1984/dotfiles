$PWD = Get-Location
cd "$env:TEMP"
git clone https://github.com/sahibjotsaggu/San-Francisco-Pro-Fonts.git
cd "San-Francisco-Pro-Fonts"

echo "Copy from https://blog.simontimms.com/2021/06/11/installing-fonts/"

$fonts = (New-Object -ComObject Shell.Application).Namespace(0x14)

foreach ($file in gci *.?tf)

{
    $fileName = $file.Name
    if (-not(Test-Path -Path "C:\Windows\fonts\$fileName" )) {
        echo $fileName
        dir $file | %{ $fonts.CopyHere($_.fullname) }
    }
}

cp *.?tf c:\windows\fonts\

cd $PWD
