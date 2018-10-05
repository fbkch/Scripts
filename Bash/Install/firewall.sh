#!/bin/sh
### BEGIN INIT INFO
# Provides: firewall
# Required-Start: mountkernfs $local_fs
# Required-Stop: $local_fs
# Default-Start: 2 3 4 5
# Default-Stop: 0 1 6
# Short-Description: Set up iptables rules
### END INIT INFO

FW_start() {
echo "[Démarrage du pare-feu]"

### EFFACE TOUT LES PARAMETRES
iptables -F
iptables -t filter -F
iptables -t nat -F
iptables -t mangle -F
echo "Vidages [OK]"

### REGLES DE FILTRAGE
# Autoriser le Loopback
iptables -A INPUT -i lo -j ACCEPT
iptables -A OUTPUT -o lo -j ACCEPT

# Ne pas casser les connexions déjà établies
iptables -t filter -A INPUT -m state --state RELATED,ESTABLISHED -j ACCEPT
iptables -t filter -A OUTPUT -m state --state RELATED,ESTABLISHED -j ACCEPT

# PING (ICMP)
iptables -t filter -A INPUT -p icmp -j ACCEPT
iptables -t filter -A OUTPUT -p icmp -j ACCEPT

# SSH
#iptables -t filter -A INPUT -p tcp --dport 22 -j ACCEPT
iptables -t filter -A OUTPUT -p tcp --dport 22 -j ACCEPT

# Serveur web (HTTP)
#iptables -t filter -A INPUT -p tcp --dport 80 -j ACCEPT
iptables -t filter -A OUTPUT -p tcp --dport 80 -j ACCEPT

# Serveur web (HTTPS)
#iptables -t filter -A INPUT -p tcp --dport 443 -j ACCEPT
iptables -t filter -A OUTPUT -p tcp --dport 443 -j ACCEPT

# Serveur FTP
#iptables -t filter -A INPUT -p tcp --dport 20:21 -j ACCEPT
#iptables -t filter -A INPUT -m state --state ESTABLISHED,RELATED -j ACCEPT
iptables -t filter -A OUTPUT -p tcp --dport 20:21 -j ACCEPT


# Serveur MAIL SMTP:25
#iptables -t filter -A INPUT -p tcp --dport 25 -j ACCEPT
iptables -t filter -A OUTPUT -p tcp --dport 25 -j ACCEPT

# Serveur MAIL POP3:110
#iptables -t filter -A INPUT -p tcp --dport 110 -j ACCEPT
iptables -t filter -A OUTPUT -p tcp --dport 110 -j ACCEPT

# Serveur MAIL IMAP:143
#iptables -t filter -A INPUT -p tcp --dport 143 -j ACCEPT
iptables -t filter -A OUTPUT -p tcp --dport 143 -j ACCEPT

# Serveur MAIL POP3S:995
#iptables -t filter -A INPUT -p tcp --dport 995 -j ACCEPT
iptables -t filter -A OUTPUT -p tcp --dport 995 -j ACCEPT


# DNS In/Out
#iptables -t filter -A INPUT -p tcp --dport 53 -j ACCEPT
#iptables -t filter -A INPUT -p udp --dport 53 -j ACCEPT
iptables -t filter -A OUTPUT -p tcp --dport 53 -j ACCEPT
iptables -t filter -A OUTPUT -p udp --dport 53 -j ACCEPT

# NTP
iptables -t filter -A OUTPUT -p udp --dport 123 -j ACCEPT

#MySQL
iptables -t filter -A OUTPUT -p tcp --dport 3306 -j ACCEPT

#ThunderBird
iptables -t filter -A OUTPUT -p tcp --dport 993 -j ACCEPT
iptables -t filter -A OUTPUT -p tcp --dport 587 -j ACCEPT

#SMB
iptables -t filter -A OUTPUT -p tcp --dport 445 -j ACCEPT

#IRC Chat
iptables -t filter -A OUTPUT -p tcp --dport 6667 -j ACCEPT

#port 4242
iptables -t filter -A OUTPUT -p tcp --dport 4242 -j ACCEPT

# Rejeter tout le reste
iptables -A INPUT -j DROP
echo "Filtrages [OK]"


### POLITIQUES
# Trafic entrants bloqués
iptables -P INPUT DROP

# Trafic forwardés bloqués
iptables -P FORWARD DROP

# Trafic sortants bloqués
iptables -P OUTPUT DROP

echo "Politiques [OK]"
}


FW_stop() {
echo "[Arret du pare-feu]"

# Supprime tous les filtres
iptables -F
iptables -t filter -F
iptables -t nat -F
iptables -t mangle -F

# Attribut une politiques "ACCEPT" aux tables
iptables -P INPUT ACCEPT
iptables -P FORWARD ACCEPT
iptables -P OUTPUT ACCEPT

iptables -t filter -P INPUT ACCEPT
iptables -t filter -P FORWARD ACCEPT
iptables -t filter -P OUTPUT ACCEPT

iptables -t nat -P PREROUTING ACCEPT
iptables -t nat -P POSTROUTING ACCEPT
iptables -t nat -P OUTPUT ACCEPT

iptables -t mangle -P PREROUTING ACCEPT
iptables -t mangle -P INPUT ACCEPT
iptables -t mangle -P FORWARD ACCEPT
iptables -t mangle -P OUTPUT ACCEPT
iptables -t mangle -P POSTROUTING ACCEPT
}


FW_restart() {
FW_stop;
sleep 2;
FW_start;
}


case "$1" in
'start')
FW_start
;;

'stop')
FW_stop
;;

'restart')
FW_restart
;;

'status')
iptables -L
iptables -t nat -L
iptables -t mangle -L
;;

*)
echo "Usage: firewall {start|stop|restart|status}"
;;
esac
