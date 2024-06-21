

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


