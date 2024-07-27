> [!IMPORTANT]
> "Blog post is coming ASAP"

# Microsoft Defender for Identity NPCAP Config Checker

I created a small program to test the "Entities exposing credentials in clear text" Secure Score Recommended Action for Microsoft Defender for Identity. For more information, please check the official documentation from Microsoft:

https://learn.microsoft.com/en-us/defender-for-identity/health-alerts#sensor-has-issues-with-packet-capturing-component

## ⚙️ Features

- Creates an LDAP connection to a Domain Controller using a simple Bind
- Using arguments for the server, username, and password to make it simple for anyone to use
- Triggers "Exposed Entities" for the "Stop clear text credentials exposure" recommended action in secure score

## 🛠️ Usage

Enter a Domain Controller as the ldapserver, the Distinguished Name of a user account, and the corresponding password. Here is an example:
````
SimpleLDAPBind.exe /ldapServer:"DC01" /userDN:"CN=thalpius,CN=Users,DC=yoshis,DC=island" /password:"SimpleLDAPBind01!"
````

> **_NOTE:_** Use the "Attribute Editor" in "Active Directory Users and Computers" on the object to find the Distinguished Name for a user account.

## 📄 Blog

To find out more about configuring NPCAP for Microsoft Defender for Identity, check out my blog post:

https://thalpius.com/

## 📺 Screenshots
Here is an example of a passed config for NPCAP:

![Alt text](/Screenshots/MicrosoftDefenderForIdentityNPCAPConfigChecker01.png?raw=true "Microsoft Defender for Identity NPCAP Config Checker Pass")

Here is an example of a failed config for NPCAP:

![Alt text](/Screenshots/MicrosoftDefenderForIdentityNPCAPConfigChecker02.png?raw=true "Microsoft Defender for Identity NPCAP Config Checker Fail")
