
# Alambic : Catalyzing Innovation Alchemy

**Description:** "Alambic" is a collection of powerful Node-RED nodes designed to accelerate innovation projects.

With a focus on seamless integration, it enables the development of AI and IoT solutions by providing a suite of modules to connect with ChatGPT, AirTable, and others Azure services. Like an alchemist's distillery, Alambic refines and channels complex workflows into streamlined processes, making it easier to transform ideas into real-world applications.

Currently, Alambic is used in several of my side projects (looking for sponsors):

- SARAH, an intelligent home automation project.
- [Reflets](https://www.youtube.com/watch?v=2n-qs_Ye6PY), a SmartMirror project.
- [Au Tour De La Table](https://www.youtube.com/watch?v=dpHmAPXHFA8), a connected game project composed of multiple ESP32 modules and other SFX.
- [Overwatch](https://blog.encausse.net/2023/08/28/veille-3-0-avec-chatgpt-midjourney-et-neurovoice/), a business and technology intelligence project shared through my [website](https://encausse.net) and [newsletter](https://encausse.substack.com/).
- [Mediaverse](https://www.youtube.com/watch?v=8mfaiVYUaJM), combine Matterport virtual places with Avatars and Speech technologies. 
- And various ChatBots for multiple clients.

This framework has been continuously evolving over several years and is provided as-is to support the community. If you are looking to develop a commercial project and need assistance, [feel free to reach out for professional support](https://moonshots.fr/contact).

![Status](https://img.shields.io/badge/status-under%20construction-orange) ![Build Status](https://img.shields.io/badge/build-deliver%20as%20is-brightgreen) ![License](https://img.shields.io/badge/license-MIT-blue) ![Version](https://img.shields.io/badge/version-1.0.0-blue)

---

## Table of Contents
1. [Introduction](#introduction)
2. [Features](#features)
3. [Architecture](#architecture)
4. [Installation](#installation)
5. [Usage](#usage)
6. [Configuration](#configuration)
7. [Contributing](#contributing)
8. [License](#license)
9. [Contact](#contact)

## Introduction
"Alambic" is an advanced framework built on Node-RED 4.0, specifically designed to accelerate the development of AI and IoT projects. Leveraging the latest features of Node-RED, it externalizes project configurations into environment variables, allowing for more elegant and modular usage within Subflows.

The framework is structured around two core components:

1. Azure ChatGPT Integration: This module enables seamless integration with the Azure OpenAI services, making it possible to design applications that interact directly with the Language Learning Model (LLM) or via a customizable WebChat interface.

2. WebSocket Communication Protocol: A robust WebSocket-based protocol designed to simplify the creation of web interfaces and facilitate communication with ESP-32 modules. This allows for quick prototyping and development of interactive solutions, extending the framework’s capabilities to a wide range of connected devices.

![image](https://github.com/user-attachments/assets/2a167183-a3e1-4949-8026-29b8e5bc2510)


## Features

Web Interface
- Customizable Web Chat with Custom Message protocol
- Handle Markdown content (Code, Images, ...)
- Handle Asynchronous Communication, Display LLM progress
- Handle LLM Request or Streaming (with partial JSON parsing)
- Alternate Text2Speech answers with Avatars (lipsync, gesture) support
- Cookie Authentication

LLM
- Support to all Azure ChatGPT Models
- Automatic Chat History Management (and custom context, ...)
- Complex prompt with JSON output
- Tool Architecture (add any custom tool)
- Tool: Bing Search
- Tool: Scrapping mode: Raw, Clean Page, Main article.
- Tool: DALLE-3 Image Generation
- RAG: Simple, In-Memory Chunck, Index, Search and Embeddings
- Multi-Modal Architecture : Handle image
- Multi-Bot Architecture : Build Agentic Templates

Other
- AirTable: Custom Node on top of AirTable API

### Roadmap
- Doc: Write the documentation on all nodes !
- Add: Upload of Image from WebChat interface (remove URL hack)
- Add: support to Audio 
- Add: SSO Authentication
- Add: Store Chat conversation into Azure Logs (or something else) instead of AirTable
- Add: Thumb Up/Down rating the conversation + comment
- Add: Connector to AzureBotFramework
- UI: Display Previous Chat
- UI: Easier Upload of RAG documents.
- Tool: Improve Scraping of YouTube
- Demo: Custom/Refined History Management
- Demo: Store History into a Database
- Demo: Tool using Midjourney unnoficial API
- Demo: Azure AI Search API Call
- Demo: ESP-32 communication
- Rewrite the 3D Avatar component
- Rewrite the Matterport component
- Test: Deploy on FlowForge

## Architecture

## Installation
1. **Clone the repository:**
   ```bash
   git clone https://github.com/your-username/project-name.git
   cd project-name
   ```
2. **Install dependencies:**
   ```bash
   npm install
   ```
3. **Run the project:**
   ```bash
   npm start
   ```

## Usage
Provide examples of how to use your project. Include code snippets or screenshots when necessary.

```javascript
const example = require('project-name');
example.run();
```

## Configuration
Detail any configurations required, such as environment variables or file settings. Include default values if applicable.

## Contributing
1. Fork the repository.
2. Create a new branch (`git checkout -b feature-branch`).
3. Commit your changes (`git commit -m 'Add new feature'`).
4. Push to the branch (`git push origin feature-branch`).
5. Open a pull request.

## License
This project is licensed under the MIT License. See the [LICENSE](LICENSE) file for details.

## Contact
F




# INSTALL VM

# INSTALL VM

## Install NGINX

Install an HTTP Proxy in front of the VM to handle multiple Node-RED. 
Each port follow 1880, 1881, ... for each subdomain


```
sudo apt-get update
sudo apt-get install nginx
```

Create a dedicated configuration file
```
sudo nano /etc/nginx/sites-available/nodered.encausse.net
sudo ln -s /etc/nginx/sites-available/nodered.encausse.net /etc/nginx/sites-enabled/
sudo service nginx 
```

Use this sample config:
```
server {
    #only ports 80 and 443 are open
    listen 80;
    listen 443 ssl;

    #server name
    server_name nodered.encausse.net;

    #LetsEncrypt
    location '/.well-known/acme-challenge' {
        root /var/www/html;
    }

    # serve SSL certificates
    ssl_certificate /etc/nginx/ssl/certs/fullchain.pem;
    ssl_certificate_key /etc/nginx/ssl/certs/priv.key;
    ssl_protocols TLSv1 TLSv1.1 TLSv1.2;
    ssl_ciphers EECDH+AES128:RSA+AES128:EECDH+AES256:RSA+AES256:EECDH+3DES:RSA+3DES:!MD5;
    ssl_prefer_server_ciphers On;
    ssl_session_cache shared:SSL:128m;
    ssl_stapling on;
    ssl_stapling_verify on;

    resolver 8.8.8.8;

    location / {

        #redirect any request on http to https
        if ($scheme = http) {
      #      return 301 https://$server_name$request_uri;
        }

        #pass https requests to node-red
        proxy_pass http://localhost:1880;
        proxy_set_header Host $host;
        proxy_set_header X-Real-IP $remote_addr;
        proxy_http_version 1.1;

        #ensures node-red's websockets will work
        proxy_set_header Upgrade $http_upgrade;
        proxy_set_header Connection "upgrade";
    }

}
```

## Install CERTBOT
```
sudo apt update
sudo apt install snapd
sudo snap install core; sudo snap refresh core
sudo snap install --classic certbot
sudo ln -s /snap/bin/certbot /usr/bin/certbot
sudo certbot certonly --nginx
```
Follow instruction for the domain and get the certificate
```
/etc/letsencrypt/live/nodered.encausse.net/fullchain.pem
/etc/letsencrypt/live/nodered.encausse.net/privkey.pem
```
Then update the NGinx conf and restart

## Install NodeJS

### NVM (Node Virtual Manager)

- [Install NVM](https://github.com/nvm-sh/nvm) with wget
- `nvm install node`
- `sudo apt-get install -y build-essential`

### Install NCU for update
npm install -g npm-check-updates

### Install PM2

- Install PM2 `npm install -g pm2`
- Run your start script
- Follow [instruction for startup and save](https://pm2.keymetrics.io/docs/usage/startup/)

# Install NodeRED

Go to this repository and `npm install`

### node-red-conf/settings.js

Update the secret then set a password :

- The login will be : admin
- Create a password in command line:
`node -e "console.log(require('bcryptjs').hashSync(process.argv[1], 8));" your-password-here`

### Start Node-RED

```
chmod +x ./node-red.sh
./node-red.sh
pm2 list
pm2 logs
```


# GITHUB
Here is a documentation about handle to handle multiple private repository
Source : https://docs.github.com/fr/authentication/connecting-to-github-with-ssh/managing-deploy-keys#using-multiple-repositories-on-one-server


## Create a Deploy Key

1. In Github > Project > Settings > Deploy Key create a SSH Key for the VM.

2. Copy private key your.private.key.pem to `~/.ssh/`

3. Change rights `chmod 400 nodered.encausse.net.pem`

### Update Config
Edit `~/.ssh/config` to declare all projects

```
Host github.com-nodered.encausse.net
Hostname github.com
IdentityFile ~/.ssh/nodered.encausse.net.pem
```

## Git Clone and Push

Clone your repository to your VM using any method (zip, https, ...)
```
git clone git@github.com-nodered.encausse.net:JpEncausse/nodered.encausse.net.git
```

Then try to Git add/commit/push to test if it works.


