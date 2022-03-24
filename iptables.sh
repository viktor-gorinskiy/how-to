#!/usr/bin/env bash
#iptables -F
iptables -A INPUT -p tcp --tcp-flags ALL NONE -j DROP
#блокирует нулевые пакеты

iptables -A INPUT -p tcp --tcp-flags ALL ALL -j DROP
#сброс пакетов XMAS

iptables -A INPUT -p tcp ! --syn -m state --state NEW -j DROP
#защита от syn-flood

iptables -A INPUT -i lo -j ACCEPT
iptables -A INPUT -p tcp -s 217.70.121.104/32 --dport 22 -j ACCEPT
iptables -A INPUT -p tcp -s 95.170.130.158/32 --dport 22 -j ACCEPT
iptables -A INPUT -p tcp --dport 80 -j ACCEPT
iptables -A INPUT -p tcp --dport 443 -j ACCEPT
-A INPUT -p tcp --dport 22 -j DROP
#
#
iptables -I DOCKER-USER -i ens3 -o  docker_freeipa -j DROP
#
#       Разрешим соединение для одного ip адреса, точнее сказать пакет может продолжить путь дальше по FORWARD.
#iptables -I DOCKER-USER -i ens3 -s 192.168.43.55 -j RETURN
#iptables -I DOCKER-USER -i ens3 -o docker_freeipa -m conntrack --ctstate RELATED,ESTABLISHED -j ACCEPT
iptables -I DOCKER-USER -m conntrack --ctstate RELATED,ESTABLISHED -j ACCEPT
##
##
##
iptables -I INPUT -m state --state ESTABLISHED,RELATED -j ACCEPT
iptables -P INPUT DROP
iptables -P FORWARD DROP
iptables -P OUTPUT ACCEPT
#

iptables --line-numbers -L -v -n
#iptables -L
