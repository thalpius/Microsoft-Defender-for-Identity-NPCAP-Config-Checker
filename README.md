> [!IMPORTANT]
> "Blog post is coming soon!"

# Microsoft Defender for Identity NPCAP Config Checker

Microsoft Defender for Identity uses NPCAP to inspect packets for malicious intent. Sometimes, NPCAP is not configured correctly for Microsoft Defender for Identity or NPCAP is installed by another program with different settings resulting in health issues reported by Microsoft Defender for Identity. This script will check the NPCAP settings which Microsoft Defender for Identity expects.

For more information, please check the official documentation from Microsoft:

https://learn.microsoft.com/en-us/defender-for-identity/health-alerts#sensor-has-issues-with-packet-capturing-component

## ⚙️ Features

- Checks if the NPCAP service is running using the services names NPCAP or NPF
- Checks the registry settings for AdminOnly, LoopbackSupport and WinPcapCompatible
- Check if the property LoopbackAdapter exists and if it does, it fails

## 🛠️ Usage

Save the script to the Domain Controller and run the script to validate the NPCAP settings
````
& '.\MDI NPCAP Config Checker.ps1'
````

## 📄 Blog

To find out more about configuring NPCAP for Microsoft Defender for Identity, check out my blog post:

https://thalpius.com/

## 📺 Screenshots
Here is an example of a passed config for NPCAP:

![Alt text](/Screenshots/MicrosoftDefenderForIdentityNPCAPConfigChecker01.png?raw=true "Microsoft Defender for Identity NPCAP Config Checker Pass")

Here is an example of a failed config for NPCAP:

![Alt text](/Screenshots/MicrosoftDefenderForIdentityNPCAPConfigChecker02.png?raw=true "Microsoft Defender for Identity NPCAP Config Checker Fail")
