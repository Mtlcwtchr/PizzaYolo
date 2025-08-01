﻿param($installPath, $toolsPath, $package, $project)

$analyzersDir = Join-Path (Split-Path -Path $toolsPath -Parent) "analyzers"
if (-Not (Test-Path $analyzersDir))
{
    return
}

$analyzersPaths = Join-Path ( $analyzersDir ) * -Resolve

foreach($analyzersPath in $analyzersPaths)
{
    # Install the language agnostic analyzers.
    if (Test-Path $analyzersPath)
    {
        foreach ($analyzerFilePath in Get-ChildItem $analyzersPath -Filter *.dll)
        {
            if($project.Object.AnalyzerReferences)
            {
                $project.Object.AnalyzerReferences.Add($analyzerFilePath.FullName)
            }
        }
    }
}

# $project.Type gives the language name like (C# or VB.NET)
$languageFolder = ""
if($project.Type -eq "C#")
{
    $languageFolder = "cs"
}
if($project.Type -eq "VB.NET")
{
    $languageFolder = "vb"
}
if($languageFolder -eq "")
{
    return
}

foreach($analyzersPath in $analyzersPaths)
{
    # Install language specific analyzers.
    $languageAnalyzersPath = join-path $analyzersPath $languageFolder
    if (Test-Path $languageAnalyzersPath)
    {
        foreach ($analyzerFilePath in Get-ChildItem $languageAnalyzersPath -Filter *.dll)
        {
            if($project.Object.AnalyzerReferences)
            {
                $project.Object.AnalyzerReferences.Add($analyzerFilePath.FullName)
            }
        }
    }
}
# SIG # Begin signature block
# MIIpMgYJKoZIhvcNAQcCoIIpIzCCKR8CAQExDzANBglghkgBZQMEAgEFADB5Bgor
# BgEEAYI3AgEEoGswaTA0BgorBgEEAYI3AgEeMCYCAwEAAAQQH8w7YFlLCE63JNLG
# KX7zUQIBAAIBAAIBAAIBAAIBADAxMA0GCWCGSAFlAwQCAQUABCCh1voBODYpfCet
# zwmmor0XvG3ngI9/l8E/7NCzPBjyWaCCDeUwggZjMIIES6ADAgECAhMzAAAEQBT8
# C+g+8SRfAAAAAARAMA0GCSqGSIb3DQEBDAUAMH4xCzAJBgNVBAYTAlVTMRMwEQYD
# VQQIEwpXYXNoaW5ndG9uMRAwDgYDVQQHEwdSZWRtb25kMR4wHAYDVQQKExVNaWNy
# b3NvZnQgQ29ycG9yYXRpb24xKDAmBgNVBAMTH01pY3Jvc29mdCBDb2RlIFNpZ25p
# bmcgUENBIDIwMTEwHhcNMjQxMTE5MTk1MTAwWhcNMjUxMTEyMTk1MTAwWjBjMQsw
# CQYDVQQGEwJVUzETMBEGA1UECBMKV2FzaGluZ3RvbjEQMA4GA1UEBxMHUmVkbW9u
# ZDEeMBwGA1UEChMVTWljcm9zb2Z0IENvcnBvcmF0aW9uMQ0wCwYDVQQDEwQuTkVU
# MIIBojANBgkqhkiG9w0BAQEFAAOCAY8AMIIBigKCAYEAwp5dioSFpA9DhkKd9OXW
# VboA9VIKhu8EWRl+qwi+1rSn9FJrDkZ4/lUdCOOz6ozu7C5zpsIx+en67iSssgOx
# cfM1iCDTmAehCqEzsTnv8WJ7FKgFJnPgEcizCrfMGymRbvteQjcyCNWgz8r9ZYOs
# Le//5OMJFjWVA1dEpeksgAyUicnRYndWgTtYDI9giy756T+y6xM/EXad34L8wwDu
# yE4eQWKmTTbZe5Hu5JyfPx7Rgo1Hnio7F+gb/dWtCJTlXWvPQm86ND7Ef3NWfLjS
# KD7Qd+V8MZV23BvjA/D8i6QaKMnUncZuWcsqrxun9zNXb7DlvowaK3nwb/VGLMSz
# DzY+26vhvNfMkIjCUV7rwtrprDl1DazSJNOZYcJfJGhHbKKvKp7fMmrWCCvaXqG+
# 1VamD9C4Vci/b1vzs+fOzhb5SzplZ6MC3L53OcMuCpisqZc/uyYpHfwb7h9IDMae
# qfkVAxvVg8H3+4gztjHJ0RxqO/fEzWGpB3V3WmeCcmCjAgMBAAGjggFzMIIBbzAf
# BgNVHSUEGDAWBgorBgEEAYI3TAgBBggrBgEFBQcDAzAdBgNVHQ4EFgQUj1B9RRfD
# LVcRVwidWUipFGcV2/0wRQYDVR0RBD4wPKQ6MDgxHjAcBgNVBAsTFU1pY3Jvc29m
# dCBDb3Jwb3JhdGlvbjEWMBQGA1UEBRMNNDY0MjIzKzUwMzM4MjAfBgNVHSMEGDAW
# gBRIbmTlUAXTgqoXNzcitW2oynUClTBUBgNVHR8ETTBLMEmgR6BFhkNodHRwOi8v
# d3d3Lm1pY3Jvc29mdC5jb20vcGtpb3BzL2NybC9NaWNDb2RTaWdQQ0EyMDExXzIw
# MTEtMDctMDguY3JsMGEGCCsGAQUFBwEBBFUwUzBRBggrBgEFBQcwAoZFaHR0cDov
# L3d3dy5taWNyb3NvZnQuY29tL3BraW9wcy9jZXJ0cy9NaWNDb2RTaWdQQ0EyMDEx
# XzIwMTEtMDctMDguY3J0MAwGA1UdEwEB/wQCMAAwDQYJKoZIhvcNAQEMBQADggIB
# AJ2WeQqPlxGNTsy9yIduH3+jiBbaLIOPP80imeyasAjU7059y77VR+ddGU0LfRz6
# CDdwQ/A3o22QvkCqpOQRY91/bcCPm1NeP+Ssr0S1hcimFzYVBLgWWq7Kpe6WTW8C
# 5Ds7YbIC1th/WbKOAafAfK3rpfoUCyNqUO/lqGEC38EKUwXasDo49Qy+xVE8kWfh
# NyaBUE3wsvh/PEBn1RIr9fP+DwVPV/v4p5n463qr/9bJtnJXaCk+npWTbEpL059N
# 44uJP1B8f6jmstqtxqdipnmdVWULd3zf6VYakAr68Fw6aQmj9tinxhhEpm+gMtgU
# 2LmXdsP+LzhLmPQd1rc4g1BpasoXlYfdsAmxxV44JkFiY0KuHtKC7/R9ZgWSFMm6
# 3+4RTy4cZP33HgyhboIC/xUbOFPir6AA9dLNdGMWkrGWumaU+A09+6DUsP3qL/lb
# 4UXlsyK99BMstxLh6eoifTYceVDDxn6qqCPGKcexkZdU2eHluAkh7tFGISzc6xZm
# 2SuIwKPnlgxrEwJLynCMXhsHUv2uuDLhJy0wQO6hcJbbN11jYcCZdJOEQQ22bpCi
# lCJWknmOrf6Eeldnsr/dRWBs7iLFVeeR6nevDbF2GymPD9qhj1PxrywKhiXVrr9f
# pseZOv3myCwGMQqpjGmV1FpGYodIIzMS6jIsh0Fku3LeMIIHejCCBWKgAwIBAgIK
# YQ6Q0gAAAAAAAzANBgkqhkiG9w0BAQsFADCBiDELMAkGA1UEBhMCVVMxEzARBgNV
# BAgTCldhc2hpbmd0b24xEDAOBgNVBAcTB1JlZG1vbmQxHjAcBgNVBAoTFU1pY3Jv
# c29mdCBDb3Jwb3JhdGlvbjEyMDAGA1UEAxMpTWljcm9zb2Z0IFJvb3QgQ2VydGlm
# aWNhdGUgQXV0aG9yaXR5IDIwMTEwHhcNMTEwNzA4MjA1OTA5WhcNMjYwNzA4MjEw
# OTA5WjB+MQswCQYDVQQGEwJVUzETMBEGA1UECBMKV2FzaGluZ3RvbjEQMA4GA1UE
# BxMHUmVkbW9uZDEeMBwGA1UEChMVTWljcm9zb2Z0IENvcnBvcmF0aW9uMSgwJgYD
# VQQDEx9NaWNyb3NvZnQgQ29kZSBTaWduaW5nIFBDQSAyMDExMIICIjANBgkqhkiG
# 9w0BAQEFAAOCAg8AMIICCgKCAgEAq/D6chAcLq3YbqqCEE00uvK2WCGfQhsqa+la
# UKq4BjgaBEm6f8MMHt03a8YS2AvwOMKZBrDIOdUBFDFC04kNeWSHfpRgJGyvnkmc
# 6Whe0t+bU7IKLMOv2akrrnoJr9eWWcpgGgXpZnboMlImEi/nqwhQz7NEt13YxC4D
# dato88tt8zpcoRb0RrrgOGSsbmQ1eKagYw8t00CT+OPeBw3VXHmlSSnnDb6gE3e+
# lD3v++MrWhAfTVYoonpy4BI6t0le2O3tQ5GD2Xuye4Yb2T6xjF3oiU+EGvKhL1nk
# kDstrjNYxbc+/jLTswM9sbKvkjh+0p2ALPVOVpEhNSXDOW5kf1O6nA+tGSOEy/S6
# A4aN91/w0FK/jJSHvMAhdCVfGCi2zCcoOCWYOUo2z3yxkq4cI6epZuxhH2rhKEmd
# X4jiJV3TIUs+UsS1Vz8kA/DRelsv1SPjcF0PUUZ3s/gA4bysAoJf28AVs70b1FVL
# 5zmhD+kjSbwYuER8ReTBw3J64HLnJN+/RpnF78IcV9uDjexNSTCnq47f7Fufr/zd
# sGbiwZeBe+3W7UvnSSmnEyimp31ngOaKYnhfsi+E11ecXL93KCjx7W3DKI8sj0A3
# T8HhhUSJxAlMxdSlQy90lfdu+HggWCwTXWCVmj5PM4TasIgX3p5O9JawvEagbJjS
# 4NaIjAsCAwEAAaOCAe0wggHpMBAGCSsGAQQBgjcVAQQDAgEAMB0GA1UdDgQWBBRI
# bmTlUAXTgqoXNzcitW2oynUClTAZBgkrBgEEAYI3FAIEDB4KAFMAdQBiAEMAQTAL
# BgNVHQ8EBAMCAYYwDwYDVR0TAQH/BAUwAwEB/zAfBgNVHSMEGDAWgBRyLToCMZBD
# uRQFTuHqp8cx0SOJNDBaBgNVHR8EUzBRME+gTaBLhklodHRwOi8vY3JsLm1pY3Jv
# c29mdC5jb20vcGtpL2NybC9wcm9kdWN0cy9NaWNSb29DZXJBdXQyMDExXzIwMTFf
# MDNfMjIuY3JsMF4GCCsGAQUFBwEBBFIwUDBOBggrBgEFBQcwAoZCaHR0cDovL3d3
# dy5taWNyb3NvZnQuY29tL3BraS9jZXJ0cy9NaWNSb29DZXJBdXQyMDExXzIwMTFf
# MDNfMjIuY3J0MIGfBgNVHSAEgZcwgZQwgZEGCSsGAQQBgjcuAzCBgzA/BggrBgEF
# BQcCARYzaHR0cDovL3d3dy5taWNyb3NvZnQuY29tL3BraW9wcy9kb2NzL3ByaW1h
# cnljcHMuaHRtMEAGCCsGAQUFBwICMDQeMiAdAEwAZQBnAGEAbABfAHAAbwBsAGkA
# YwB5AF8AcwB0AGEAdABlAG0AZQBuAHQALiAdMA0GCSqGSIb3DQEBCwUAA4ICAQBn
# 8oalmOBUeRou09h0ZyKbC5YR4WOSmUKWfdJ5DJDBZV8uLD74w3LRbYP+vj/oCso7
# v0epo/Np22O/IjWll11lhJB9i0ZQVdgMknzSGksc8zxCi1LQsP1r4z4HLimb5j0b
# pdS1HXeUOeLpZMlEPXh6I/MTfaaQdION9MsmAkYqwooQu6SpBQyb7Wj6aC6VoCo/
# KmtYSWMfCWluWpiW5IP0wI/zRive/DvQvTXvbiWu5a8n7dDd8w6vmSiXmE0OPQvy
# CInWH8MyGOLwxS3OW560STkKxgrCxq2u5bLZ2xWIUUVYODJxJxp/sfQn+N4sOiBp
# mLJZiWhub6e3dMNABQamASooPoI/E01mC8CzTfXhj38cbxV9Rad25UAqZaPDXVJi
# hsMdYzaXht/a8/jyFqGaJ+HNpZfQ7l1jQeNbB5yHPgZ3BtEGsXUfFL5hYbXw3MYb
# BL7fQccOKO7eZS/sl/ahXJbYANahRr1Z85elCUtIEJmAH9AAKcWxm6U/RXceNcbS
# oqKfenoi+kiVH6v7RyOA9Z74v2u3S5fi63V4GuzqN5l5GEv/1rMjaHXmr/r8i+sL
# gOppO6/8MO0ETI7f33VtY5E90Z1WTk+/gFcioXgRMiF670EKsT/7qMykXcGhiJtX
# cVZOSEXAQsmbdlsKgEhr/Xmfwb1tbWrJUnMTDXpQzTGCGqMwghqfAgEBMIGVMH4x
# CzAJBgNVBAYTAlVTMRMwEQYDVQQIEwpXYXNoaW5ndG9uMRAwDgYDVQQHEwdSZWRt
# b25kMR4wHAYDVQQKExVNaWNyb3NvZnQgQ29ycG9yYXRpb24xKDAmBgNVBAMTH01p
# Y3Jvc29mdCBDb2RlIFNpZ25pbmcgUENBIDIwMTECEzMAAARAFPwL6D7xJF8AAAAA
# BEAwDQYJYIZIAWUDBAIBBQCgga4wGQYJKoZIhvcNAQkDMQwGCisGAQQBgjcCAQQw
# HAYKKwYBBAGCNwIBCzEOMAwGCisGAQQBgjcCARUwLwYJKoZIhvcNAQkEMSIEILHG
# 5OyijfDOM5bxiJFmyVasy7d752HLA4qfvHm7QzF9MEIGCisGAQQBgjcCAQwxNDAy
# oBSAEgBNAGkAYwByAG8AcwBvAGYAdKEagBhodHRwOi8vd3d3Lm1pY3Jvc29mdC5j
# b20wDQYJKoZIhvcNAQEBBQAEggGAsa3G9rhyU6zEtGKeaBGc3zbK8Hi1tuDxXktQ
# a6YJnk+oSciNb5hbk3LSnvjsDTK7v0J5gabvzMRLKd2KImdjANHXfVqxwNwAml1Q
# W0a0N3r15Zzy10ouOataQsxl6DyhEIPAZcj/pmNAphYxlxc8fDcEMa9wJchou+dy
# gLiJ5gT2BCcxZgzrlMM0y2bwOyoMHPx7Dyyv7JCrdq0OGh3WZLJJwo7oVnNDUWh1
# FIkjZ7pI/UQdDjHRNp7biS71xg0dDj232tTwmxfAY/rGakcwI0wgoQXYxh9xfYsj
# Lpdwhavh05kEM5GUGHAFNRrTdcbHhpdXTXMD3eAHPKLnpwP9YOSKwSTnY1L0gNeq
# CbzT0SXMm2wneIgSr1LpuIiWTcN4m3lqkED5sKfIJiOY4gzVbcfITSNepqzDs8AW
# lT27DJnRVVTJSPnI8ILtiYAbp8ayC+eAhjhMZJHh30yFuBmy46NG39Hf3Q39xCrI
# BfP9296eREd2DegDYp6nJ9RP5W8xoYIXrTCCF6kGCisGAQQBgjcDAwExgheZMIIX
# lQYJKoZIhvcNAQcCoIIXhjCCF4ICAQMxDzANBglghkgBZQMEAgEFADCCAVoGCyqG
# SIb3DQEJEAEEoIIBSQSCAUUwggFBAgEBBgorBgEEAYRZCgMBMDEwDQYJYIZIAWUD
# BAIBBQAEIJxACsVfpIqL16YKwxBHdM42oHHqYt5OnxHqjGW4n4u+AgZoE/+jKOwY
# EzIwMjUwNTEzMDYwNTU0LjM1MVowBIACAfSggdmkgdYwgdMxCzAJBgNVBAYTAlVT
# MRMwEQYDVQQIEwpXYXNoaW5ndG9uMRAwDgYDVQQHEwdSZWRtb25kMR4wHAYDVQQK
# ExVNaWNyb3NvZnQgQ29ycG9yYXRpb24xLTArBgNVBAsTJE1pY3Jvc29mdCBJcmVs
# YW5kIE9wZXJhdGlvbnMgTGltaXRlZDEnMCUGA1UECxMeblNoaWVsZCBUU1MgRVNO
# OjMyMUEtMDVFMC1EOTQ3MSUwIwYDVQQDExxNaWNyb3NvZnQgVGltZS1TdGFtcCBT
# ZXJ2aWNloIIR+zCCBygwggUQoAMCAQICEzMAAAH4o6EmDAxASP4AAQAAAfgwDQYJ
# KoZIhvcNAQELBQAwfDELMAkGA1UEBhMCVVMxEzARBgNVBAgTCldhc2hpbmd0b24x
# EDAOBgNVBAcTB1JlZG1vbmQxHjAcBgNVBAoTFU1pY3Jvc29mdCBDb3Jwb3JhdGlv
# bjEmMCQGA1UEAxMdTWljcm9zb2Z0IFRpbWUtU3RhbXAgUENBIDIwMTAwHhcNMjQw
# NzI1MTgzMTA4WhcNMjUxMDIyMTgzMTA4WjCB0zELMAkGA1UEBhMCVVMxEzARBgNV
# BAgTCldhc2hpbmd0b24xEDAOBgNVBAcTB1JlZG1vbmQxHjAcBgNVBAoTFU1pY3Jv
# c29mdCBDb3Jwb3JhdGlvbjEtMCsGA1UECxMkTWljcm9zb2Z0IElyZWxhbmQgT3Bl
# cmF0aW9ucyBMaW1pdGVkMScwJQYDVQQLEx5uU2hpZWxkIFRTUyBFU046MzIxQS0w
# NUUwLUQ5NDcxJTAjBgNVBAMTHE1pY3Jvc29mdCBUaW1lLVN0YW1wIFNlcnZpY2Uw
# ggIiMA0GCSqGSIb3DQEBAQUAA4ICDwAwggIKAoICAQDFHbeldicPYG44N15ezYK7
# 9PmQoj5sDDxxu03nQKb8UCuNfIvhFOox7qVpD8Kp4xPGByS9mvUmtbQyLgXXmvH9
# W94aEoGahvjkOY5xXnHLHuH1OTn00CXk80wBYoAhZ/bvRJYABbFBulUiGE9YKdVX
# ei1W9qERp3ykyahJetPlns2TVGcHvQDZur0eTzAh4Le8G7ERfYTxfnQiAAezJpH2
# ugWrcSvNQQeVLxidKrfe6Lm4FysU5wU4Jkgu5UVVOASpKtfhSJfR62qLuNS0rKmA
# h+VplxXlwjlcj94LFjzAM2YGmuFgw2VjF2ZD1otENxMpa111amcm3KXl7eAe5iiP
# zG4NDRdk3LsRJHAkgrTf6tNmp9pjIzhdIrWzRpr6Y7r2+j82YnhH9/X4q5wE8njJ
# R1uolYzfEy8HAtjJy+KAj9YriSA+iDRQE1zNpDANVelxT5Mxw69Y/wcFaZYlAiZN
# kicAWK9epRoFujfAB881uxCm800a7/XamDQXw78J1F+A8d86EhZDQPwAsJj4uyLB
# vNx6NutWXg31+fbA6DawNrxF82gPrXgjSkWPL+WrU2wGj1XgZkGKTNftmNYJGB3U
# UIFcal+kOKQeNDTlg6QBqR1YNPZsZJpRkkZVi16kik9MCzWB3+9SiBx2IvnWjuyG
# 4ciUHpBJSJDbhdiFFttAIQIDAQABo4IBSTCCAUUwHQYDVR0OBBYEFL3OxnPPntCV
# Pmeu3+iK0u/U5Du2MB8GA1UdIwQYMBaAFJ+nFV0AXmJdg/Tl0mWnG1M1GelyMF8G
# A1UdHwRYMFYwVKBSoFCGTmh0dHA6Ly93d3cubWljcm9zb2Z0LmNvbS9wa2lvcHMv
# Y3JsL01pY3Jvc29mdCUyMFRpbWUtU3RhbXAlMjBQQ0ElMjAyMDEwKDEpLmNybDBs
# BggrBgEFBQcBAQRgMF4wXAYIKwYBBQUHMAKGUGh0dHA6Ly93d3cubWljcm9zb2Z0
# LmNvbS9wa2lvcHMvY2VydHMvTWljcm9zb2Z0JTIwVGltZS1TdGFtcCUyMFBDQSUy
# MDIwMTAoMSkuY3J0MAwGA1UdEwEB/wQCMAAwFgYDVR0lAQH/BAwwCgYIKwYBBQUH
# AwgwDgYDVR0PAQH/BAQDAgeAMA0GCSqGSIb3DQEBCwUAA4ICAQBh+TwbPOkRWcaX
# vLqhejK0JvjYfHpM4DT52RoEjfp+0MT20u5tRr/ExscHmtw2JGEUdn3dF590+lzj
# 4UXQMCXmU/zEoA77b3dFY8oMU4UjGC1ljTy3wP1xJCmAZTPLDeURNl5s0sQDXsD8
# JOkDYX26HyPzgrKB4RuP5uJ1YOIR9rKgfYDn/nLAknEi4vMVUdpy9bFIIqgX2GVK
# tlIbl9dZLedqZ/i23r3RRPoAbJYsVZ7z3lygU/Gb+bRQgyOOn1VEUfudvc2DZDiA
# 9L0TllMxnqcCWZSJwOPQ1cCzbBC5CudidtEAn8NBbfmoujsNrD0Cwi2qMWFsxwbr
# yANziPvgvYph7/aCgEcvDNKflQN+1LUdkjRlGyqY0cjRNm+9RZf1qObpJ8sFMS2h
# OjqAs5fRQP/2uuEaN2SILDhLBTmiwKWCqCI0wrmd2TaDEWUNccLIunmoHoGg+lzz
# ZGE7TILOg/2C/vO/YShwBYSyoTn7Raa7m5quZ+9zOIt9TVJjbjQ5lbyV3ixLx+fJ
# uf+MMyYUCFrNXXMfRARFYSx8tKnCQ5doiZY0UnmWZyd/VVObpyZ9qxJxi0SWmOpn
# 0aigKaTVcUCk5E+z887jchwWY9HBqC3TSJBLD6sF4gfTQpCr4UlP/rZIHvSD2D9H
# xNLqTpv/C3ZRaGqtb5DyXDpfOB7H9jCCB3EwggVZoAMCAQICEzMAAAAVxedrngKb
# SZkAAAAAABUwDQYJKoZIhvcNAQELBQAwgYgxCzAJBgNVBAYTAlVTMRMwEQYDVQQI
# EwpXYXNoaW5ndG9uMRAwDgYDVQQHEwdSZWRtb25kMR4wHAYDVQQKExVNaWNyb3Nv
# ZnQgQ29ycG9yYXRpb24xMjAwBgNVBAMTKU1pY3Jvc29mdCBSb290IENlcnRpZmlj
# YXRlIEF1dGhvcml0eSAyMDEwMB4XDTIxMDkzMDE4MjIyNVoXDTMwMDkzMDE4MzIy
# NVowfDELMAkGA1UEBhMCVVMxEzARBgNVBAgTCldhc2hpbmd0b24xEDAOBgNVBAcT
# B1JlZG1vbmQxHjAcBgNVBAoTFU1pY3Jvc29mdCBDb3Jwb3JhdGlvbjEmMCQGA1UE
# AxMdTWljcm9zb2Z0IFRpbWUtU3RhbXAgUENBIDIwMTAwggIiMA0GCSqGSIb3DQEB
# AQUAA4ICDwAwggIKAoICAQDk4aZM57RyIQt5osvXJHm9DtWC0/3unAcH0qlsTnXI
# yjVX9gF/bErg4r25PhdgM/9cT8dm95VTcVrifkpa/rg2Z4VGIwy1jRPPdzLAEBjo
# YH1qUoNEt6aORmsHFPPFdvWGUNzBRMhxXFExN6AKOG6N7dcP2CZTfDlhAnrEqv1y
# aa8dq6z2Nr41JmTamDu6GnszrYBbfowQHJ1S/rboYiXcag/PXfT+jlPP1uyFVk3v
# 3byNpOORj7I5LFGc6XBpDco2LXCOMcg1KL3jtIckw+DJj361VI/c+gVVmG1oO5pG
# ve2krnopN6zL64NF50ZuyjLVwIYwXE8s4mKyzbnijYjklqwBSru+cakXW2dg3viS
# kR4dPf0gz3N9QZpGdc3EXzTdEonW/aUgfX782Z5F37ZyL9t9X4C626p+Nuw2TPYr
# bqgSUei/BQOj0XOmTTd0lBw0gg/wEPK3Rxjtp+iZfD9M269ewvPV2HM9Q07BMzlM
# jgK8QmguEOqEUUbi0b1qGFphAXPKZ6Je1yh2AuIzGHLXpyDwwvoSCtdjbwzJNmSL
# W6CmgyFdXzB0kZSU2LlQ+QuJYfM2BjUYhEfb3BvR/bLUHMVr9lxSUV0S2yW6r1AF
# emzFER1y7435UsSFF5PAPBXbGjfHCBUYP3irRbb1Hode2o+eFnJpxq57t7c+auIu
# rQIDAQABo4IB3TCCAdkwEgYJKwYBBAGCNxUBBAUCAwEAATAjBgkrBgEEAYI3FQIE
# FgQUKqdS/mTEmr6CkTxGNSnPEP8vBO4wHQYDVR0OBBYEFJ+nFV0AXmJdg/Tl0mWn
# G1M1GelyMFwGA1UdIARVMFMwUQYMKwYBBAGCN0yDfQEBMEEwPwYIKwYBBQUHAgEW
# M2h0dHA6Ly93d3cubWljcm9zb2Z0LmNvbS9wa2lvcHMvRG9jcy9SZXBvc2l0b3J5
# Lmh0bTATBgNVHSUEDDAKBggrBgEFBQcDCDAZBgkrBgEEAYI3FAIEDB4KAFMAdQBi
# AEMAQTALBgNVHQ8EBAMCAYYwDwYDVR0TAQH/BAUwAwEB/zAfBgNVHSMEGDAWgBTV
# 9lbLj+iiXGJo0T2UkFvXzpoYxDBWBgNVHR8ETzBNMEugSaBHhkVodHRwOi8vY3Js
# Lm1pY3Jvc29mdC5jb20vcGtpL2NybC9wcm9kdWN0cy9NaWNSb29DZXJBdXRfMjAx
# MC0wNi0yMy5jcmwwWgYIKwYBBQUHAQEETjBMMEoGCCsGAQUFBzAChj5odHRwOi8v
# d3d3Lm1pY3Jvc29mdC5jb20vcGtpL2NlcnRzL01pY1Jvb0NlckF1dF8yMDEwLTA2
# LTIzLmNydDANBgkqhkiG9w0BAQsFAAOCAgEAnVV9/Cqt4SwfZwExJFvhnnJL/Klv
# 6lwUtj5OR2R4sQaTlz0xM7U518JxNj/aZGx80HU5bbsPMeTCj/ts0aGUGCLu6WZn
# OlNN3Zi6th542DYunKmCVgADsAW+iehp4LoJ7nvfam++Kctu2D9IdQHZGN5tggz1
# bSNU5HhTdSRXud2f8449xvNo32X2pFaq95W2KFUn0CS9QKC/GbYSEhFdPSfgQJY4
# rPf5KYnDvBewVIVCs/wMnosZiefwC2qBwoEZQhlSdYo2wh3DYXMuLGt7bj8sCXgU
# 6ZGyqVvfSaN0DLzskYDSPeZKPmY7T7uG+jIa2Zb0j/aRAfbOxnT99kxybxCrdTDF
# NLB62FD+CljdQDzHVG2dY3RILLFORy3BFARxv2T5JL5zbcqOCb2zAVdJVGTZc9d/
# HltEAY5aGZFrDZ+kKNxnGSgkujhLmm77IVRrakURR6nxt67I6IleT53S0Ex2tVdU
# CbFpAUR+fKFhbHP+CrvsQWY9af3LwUFJfn6Tvsv4O+S3Fb+0zj6lMVGEvL8CwYKi
# excdFYmNcP7ntdAoGokLjzbaukz5m/8K6TT4JDVnK+ANuOaMmdbhIurwJ0I9JZTm
# dHRbatGePu1+oDEzfbzL6Xu/OHBE0ZDxyKs6ijoIYn/ZcGNTTY3ugm2lBRDBcQZq
# ELQdVTNYs6FwZvKhggNWMIICPgIBATCCAQGhgdmkgdYwgdMxCzAJBgNVBAYTAlVT
# MRMwEQYDVQQIEwpXYXNoaW5ndG9uMRAwDgYDVQQHEwdSZWRtb25kMR4wHAYDVQQK
# ExVNaWNyb3NvZnQgQ29ycG9yYXRpb24xLTArBgNVBAsTJE1pY3Jvc29mdCBJcmVs
# YW5kIE9wZXJhdGlvbnMgTGltaXRlZDEnMCUGA1UECxMeblNoaWVsZCBUU1MgRVNO
# OjMyMUEtMDVFMC1EOTQ3MSUwIwYDVQQDExxNaWNyb3NvZnQgVGltZS1TdGFtcCBT
# ZXJ2aWNloiMKAQEwBwYFKw4DAhoDFQC2RC395tZJDkOcb5opHM8QsIUT0aCBgzCB
# gKR+MHwxCzAJBgNVBAYTAlVTMRMwEQYDVQQIEwpXYXNoaW5ndG9uMRAwDgYDVQQH
# EwdSZWRtb25kMR4wHAYDVQQKExVNaWNyb3NvZnQgQ29ycG9yYXRpb24xJjAkBgNV
# BAMTHU1pY3Jvc29mdCBUaW1lLVN0YW1wIFBDQSAyMDEwMA0GCSqGSIb3DQEBCwUA
# AgUA68z9+zAiGA8yMDI1MDUxMjIzMDg0M1oYDzIwMjUwNTEzMjMwODQzWjB0MDoG
# CisGAQQBhFkKBAExLDAqMAoCBQDrzP37AgEAMAcCAQACAicMMAcCAQACAhLxMAoC
# BQDrzk97AgEAMDYGCisGAQQBhFkKBAIxKDAmMAwGCisGAQQBhFkKAwKgCjAIAgEA
# AgMHoSChCjAIAgEAAgMBhqAwDQYJKoZIhvcNAQELBQADggEBAFSFBwGALLd6EA9P
# gW/M6cyEMnHjzDf7WfpdRR6l7yP2fgPXRHuK8OkPggFWrIfv3sZqElW96m87MmYJ
# mhtEIQAY2XTLVZx8mqWwZwabEtPehUqk8d7KRh9v/3ysWNceoQ92U4VfiI06yZsA
# +LU7Rcc+K4CGTRMo2rDGGuGSVMyNSInAxayfAMWWaKFiPvwMf7KorQLSTI6pqq00
# heui1T7VH2mdEpJ/855KSmhs5f046mgtDw01NwO9yomC25n0BQP9pFMrz3BymQpE
# xswBA+wuqA6O2mBmNB9bp9eSpLaxDCuABssmDk9rn8vUYK/f2/wWNzomjNr8qZPR
# LNQukgAxggQNMIIECQIBATCBkzB8MQswCQYDVQQGEwJVUzETMBEGA1UECBMKV2Fz
# aGluZ3RvbjEQMA4GA1UEBxMHUmVkbW9uZDEeMBwGA1UEChMVTWljcm9zb2Z0IENv
# cnBvcmF0aW9uMSYwJAYDVQQDEx1NaWNyb3NvZnQgVGltZS1TdGFtcCBQQ0EgMjAx
# MAITMwAAAfijoSYMDEBI/gABAAAB+DANBglghkgBZQMEAgEFAKCCAUowGgYJKoZI
# hvcNAQkDMQ0GCyqGSIb3DQEJEAEEMC8GCSqGSIb3DQEJBDEiBCCGiZffp3s6easm
# fKouhJAxMNIwwN/xRcCq7zzfn3DZlTCB+gYLKoZIhvcNAQkQAi8xgeowgecwgeQw
# gb0EIO/MM/JfDVSQBQVi3xtHhR2Mz3RC/nGdVqIoPcjRnPdaMIGYMIGApH4wfDEL
# MAkGA1UEBhMCVVMxEzARBgNVBAgTCldhc2hpbmd0b24xEDAOBgNVBAcTB1JlZG1v
# bmQxHjAcBgNVBAoTFU1pY3Jvc29mdCBDb3Jwb3JhdGlvbjEmMCQGA1UEAxMdTWlj
# cm9zb2Z0IFRpbWUtU3RhbXAgUENBIDIwMTACEzMAAAH4o6EmDAxASP4AAQAAAfgw
# IgQgak5boUQ6cV/wgaDM+E+gODzYpUDHTqSvZt7Ef89ww30wDQYJKoZIhvcNAQEL
# BQAEggIAR4QJOw3mGmV6oEXXPpYbbHb7F6sCa5SKk6frNTATdRbFjsJ7A+nkK8sT
# l74ATHB81prdOI5GnahGxY25zBg6T3six0QIjQ4rbqcr0kg1/A0deQwFBHLTiYp0
# ny/BVrA83xFYIcYZGwUPkY459xFJkZWBZOA4YKM37V2ivMEDBuxZF1hQGbtmzJNv
# crUlGPF4njpCFml0YlVzvF3SLClRpkJjVI/kuzpvH225Y2rZeGivf/Qh/1ozjkBI
# QAX9vdedDBUQNXonAE/dr//3vp8JKdoTOpnrlTIU4IMufVgcJq5QCvlX8WNyMGR9
# pr9HdbVPezm9bFSPqdg7W+sFGR2LCllrh5qG7eWZKc44LtaN9qH9bbrDK1GNy7n9
# aX858ieRg21wbtUvzZIvSik9Hmae4KPHDFW8WbQtUt/T5cCtsdQ2XRcglTbirq7P
# NQTDAxEdzHTK5/7WvjaN5rVQPMQFyQzDZ1sfw6ClZ+/EcgL5OACUBmti1r409WPK
# KVuQ/BuqPwC2ZJHx5VuXX8rAQ06Q+e2dDWkoDIcOGmw9Ugk0+tcB7gCYtLQ14buC
# URP8/hsVTRUJ3U9frGe9nxtTublLZKMvSxfQs2Ad/SKQ+W5QnJDrxeVVmVBlwDlt
# 7O+3BP93CGWxLJ0QPQxDzzvsjI1IhEStibb3GSsPVmMZcHwXpxc=
# SIG # End signature block
