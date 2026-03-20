FROM nodered/node-red:latest

# Instala módulos extra en el directorio de Node-RED sin sobreescribir su package.json
RUN npm install --unsafe-perm --no-update-notifier --no-fund \
    --prefix /usr/src/node-red \
    node-red-dashboard@2.30.0 \
    node-red-node-ui-table
