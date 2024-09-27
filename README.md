
# Alambic : Catalyzing Innovation Alchemy

**Description:** "Alambic" is a collection of powerful Node-RED nodes designed to accelerate innovation projects.

With a focus on seamless integration, it enables the development of AI and IoT solutions by providing a suite of modules to connect with [Azure ChatGPT](https://learn.microsoft.com/fr-fr/azure/ai-services/openai/concepts/models), [AirTable](https://airtable.com/invite/r/21WM5R4L), and others Azure services. Like an alchemist's distillery, Alambic refines and channels complex workflows into streamlined processes, making it easier to transform ideas into real-world applications.

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
5. [Configuration](#configuration)
6. [Usage](#usage)
7. [Virtual Machine](#virtual-machine)
8. [License](#license)

## Introduction
"Alambic" is an advanced framework built on Node-RED 4.0, specifically designed to accelerate the development of AI and IoT projects. Leveraging the latest features of Node-RED, it externalizes project configurations into environment variables, allowing for more elegant and modular usage within Subflows.

![image](https://github.com/user-attachments/assets/2a167183-a3e1-4949-8026-29b8e5bc2510)

The framework is structured around two core components:

1. [Azure ChatGPT](https://learn.microsoft.com/fr-fr/azure/ai-services/openai/concepts/models) Integration: This module enables seamless integration with the Azure OpenAI services, making it possible to design applications that interact directly with the Language Learning Model (LLM) or via a customizable WebChat interface.

2. WebSocket Communication Protocol: A robust WebSocket-based protocol designed to simplify the creation of web interfaces and facilitate communication with ESP-32 modules. This allows for quick prototyping and development of interactive solutions, extending the framework’s capabilities to a wide range of connected devices.

## Features

Web Interface
- Customizable Web Chat with Custom Message protocol
- Handle Markdown content (Code, Images, ...)
- Handle Asynchronous Communication, Display LLM progress
- Handle LLM Request or Streaming (with partial JSON parsing)
- Alternate Text2Speech answers with Avatars (lipsync, gesture) support
- Cookie Authentication

LLM
- Support to all [Azure ChatGPT](https://learn.microsoft.com/fr-fr/azure/ai-services/openai/concepts/models) Models
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
- [AirTable](https://airtable.com/invite/r/21WM5R4L): Custom Node on top of AirTable API

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
- Test: Deploy on [Flow Fuse](https://flowfuse.com/)

## Architecture

![image](https://github.com/user-attachments/assets/4065df63-7a70-4002-8ce6-f563dcfcced2)

The Alambic framework is centered around a Node-RED application running on NodeJS. It can be deployed on any cloud provider or using [Flow Fuse](https://flowfuse.com/). Node-RED acts as an orchestrator, exposing web endpoints for web pages, webhooks, and integrations with platforms like Slack or Teams, while interacting with databases and APIs. For practical reasons, all my projects are hosted on Microsoft Azure, leveraging its full range of services.

As a [Microsoft MVP in AI (France)](https://mvp.microsoft.com/publicprofile/5002705) and a member of the Microsoft for Startups Founders Hub, I can facilitate your commercial projects on Azure, both technically and through connections within Microsoft. For any support or collaboration inquiries, [feel free to get in touch](https://moonshots.fr/contact).

## Installation

Installing Alambic is straightforward. Simply copy and paste the Node-RED JSON configuration representing the nodes into your Node-RED instance. When upgrading to a new version, make sure to check the "replace" option for all nodes to ensure the changes are applied correctly.

![image](https://github.com/user-attachments/assets/7c960a3a-c771-44e6-aa5e-e3575e992058)

Note: Some nodes' behavior may change across releases. While I strive to maintain backward compatibility as much as possible, it may not always be guaranteed. Make sure to review the changelog before upgrading.

For detailed instructions on installing the Virtual Machine on Azure, please refer to the end of the [documentation](#virtual-machine).


## Configuration
Each node has its own configuration, which can be customized using Flow or Global environment variables. This allows you to centralize and securely store credentials. The documentation for each node’s fields is still a work in progress.

![image](https://github.com/user-attachments/assets/d6198535-94b5-4d9f-92bc-de669277736f)

I follow a convention where nodes with multiple outputs have the first output dedicated to errors and exit conditions, while the last output is reserved for standard flow continuation. This helps design flows that move rightward and downward without crossing lines. For improved clarity, you can also use link nodes.

By design, each node or group of nodes stores its payload data in a dedicated object, such as `msg.llm` or `msg.airtable`, since `msg.payload` is frequently overridden by other nodes. Most configuration fields can also accept a string that references values within the flow, for example, `msg.cfg.my.data`.

### Usage

This framework is versatile and can be applied to various types of projects. The following example illustrates its use in a WebChat setup:

- The `ws:manager` node handles and routes all incoming WebSocket messages to the appropriate bots, establishing a session mechanism to track user interactions.
- The `web:chat` node creates a customizable webpage with all necessary components to connect to the server.
- The `llm:chat` node wraps the llm:openai node, managing the chat flow and allowing you to declare tools or trigger specific behaviors based on incoming data.
- Finally, the `ws:chat node` sends messages back to the web interface to display chat bubbles or execute any JavaScript commands that modify the page layout dynamically.

![image](https://github.com/user-attachments/assets/eaf768ea-2201-490b-8ac1-66f7371b3d53)

This architecture allows for flexible, real-time interaction between the front-end and back-end components, making it easy to build advanced conversational interfaces.


## Virtual Machine

Below are some guidelines for setting up multiple Node-RED instances on a Virtual Machine, configured behind a reverse proxy and connected to a GIT repository. This is just one of many ways to deploy a NodeJS server, so feel free to adapt it according to your needs. 

The documentation will use `nodered.encausse.net` in the samples. The [Node-RED configuration](https://github.com/JpEncausse/nodered.encausse.net/blob/main/node-red-conf/settings.js) flatten all the directory for a better management.

### Install NGINX

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

### Install CERTBOT
Certbot will create a certificate for your Node-RED. It is very important to protect websocket communication and very tricky with ESP-32 that will use RootCA Certificate.

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

### Install NodeJS

I'm using NVM to sandbox Node version and PM2 to supervise Node Instances.

#### NVM (Node Virtual Manager)

- [Install NVM](https://github.com/nvm-sh/nvm) with wget
- `nvm install node`
- `sudo apt-get install -y build-essential`

#### Install NCU for update
npm install -g npm-check-updates

#### Install PM2

- Install PM2 `npm install -g pm2`
- Run your start script
- Follow [instruction for startup and save](https://pm2.keymetrics.io/docs/usage/startup/)

### Install NodeRED

Go to this repository and `npm install`

#### node-red-conf/settings.js

Update the secret then set a password :

- The login will be : admin
- Create a password in command line:
`node -e "console.log(require('bcryptjs').hashSync(process.argv[1], 8));" your-password-here`

#### Start Node-RED

```
chmod +x ./node-red.sh
./node-red.sh
pm2 list
pm2 logs
```


### Github
Here is a [documentation to handle multiple private repositories](https://docs.github.com/fr/authentication/connecting-to-github-with-ssh/managing-deploy-keys#using-multiple-repositories-on-one-server).

#### Create a Deploy Key

1. In Github > Project > Settings > Deploy Key create a SSH Key for the VM.

2. Copy private key your.private.key.pem to `~/.ssh/`

3. Change rights `chmod 400 nodered.encausse.net.pem`

#### Update Config
Edit `~/.ssh/config` to declare all projects

```
Host github.com-nodered.encausse.net
Hostname github.com
IdentityFile ~/.ssh/nodered.encausse.net.pem
```

#### Git Clone and Push

Clone your repository to your VM using any method (zip, https, ...)
```
git clone git@github.com-nodered.encausse.net:JpEncausse/nodered.encausse.net.git
```

Then try to Git add/commit/push to test if it works.


## License
This project is licensed under the MIT License. See the [LICENSE](LICENSE) file for details.



