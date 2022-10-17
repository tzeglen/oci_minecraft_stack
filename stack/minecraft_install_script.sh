#!/bin/sh
mkdir -p /u01/MinecraftServer
mkdir -p /u01/MinecraftServer/plugins
cd /u01/MinecraftServer
yum install jdk-18.aarch64 -y
# Spigot Minecraft Server 1.19.2
wget https://download.getbukkit.org/spigot/spigot-1.19.2.jar -O server.jar
# Mojang Minecraft Server 1.19.2
#wget https://piston-data.mojang.com/v1/objects/f69c284232d7c7580bd89a5a4931c3581eae1378/server.jar -O server.jar
# Essentials Plugin 2.19.7
wget https://github.com/EssentialsX/Essentials/releases/download/2.19.7/EssentialsX-2.19.7.jar -O plugins/EssentialsX-2.19.7.jar
# Accept Mojang license
java -Xmx1024M -Xms1024M -jar server.jar nogui
sed -i 's/eula=false/eula=true/g' eula.txt
# Open port on firewall
firewall-offline-cmd --zone=public --add-port=25565/tcp
firewall-offline-cmd --zone=public --add-port=25565/udp
systemctl restart firewalld
# Run the server
nohup java -Xmx4G -Xms1024M -jar server.jar nogui >>/tmp/MinecraftServer.log &
