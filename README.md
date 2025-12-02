# Jarkom-Modul-5-2025-K44

No | Nama | NRP
-- | -- | --
1 | Ahmad Yazid Arifuddin | 5027241040
2 | Tiara Fatimah Azzahra   |   5027241090


![assets/topologi.png](assets/topologi.png)

# MISI & SOAL

## Misi 1: Memetakan Medan Perang

1.1. Identifikasi Perangkat
- **Narya:** Berfungsi sebagai DNS Server.
- **Vilya:** Berfungsi sebagai DHCP Server.
- **Web Servers:** Palantir dan IronHills.
- **Client (Pasukan):**
  - **Khamul:** 5 host (Target/Burnice).
  - **Cirdan:** 20 host (Lycaon).
  - **Isildur:** 30 host (Policeboo).
  - **Durin:** 50 host (Caesar).
  - **Gilgalad:** 100 host (Ellen).
  - **Elendil:** 200 host (Jane).

---

1.2. Setelah membagi alamat IP menggunakan VLSM (Prefix IP sesuai kelompok), **gambarkan pohon subnet** yang menunjukkan hierarki pembagian IP di jaringan Aliansi. **Lingkari subnet yang akan dilewati.**

---

1.3. **Buat konfigurasi rute** untuk menghubungkan semua subnet dengan benar. Pastikan semua perangkat dapat saling terhubung.

---

1.4. Konfigurasi Service  
_(Dikerjakan setelah Misi 2 No. 1)_

- **Vilya** sebagai DHCP Server untuk:  
  Khamul, Durin, Gilgalad, Elendil, Cirdan, Isildur.
- **AnduinBanks, Rivendell, Minastir** sebagai DHCP Relay.
- **Narya** sebagai DNS Server.
- **Palantir & IronHills** sebagai Web Server (Apache/Nginx).
- Buat `index.html` berisi:  **"Welcome to {hostname}"**

---

## Misi 2: Menemukan Jejak Kegelapan (Security Rules)
Agar jaringan aman, terapkan aturan firewall berikut.
 
2.1. Agar jaringan Aliansi dapat terhubung ke luar (Valinor/Internet), konfigurasi routing menggunakan **iptables**.  
   **Syarat: Tidak boleh menggunakan target MASQUERADE.**

---

2.2. **Proteksi Vilya (DHCP):**  
   - Tidak ada perangkat lain yang boleh melakukan **ping ke Vilya**.  
   - Tetapi **Vilya bebas mengakses/ping** semua perangkat lain.

---

2.3. **Agar lokasi pasukan tidak bocor:**  
   - **Hanya Vilya** yang dapat mengakses **Narya (DNS)**.  
   - Gunakan **nc (netcat)** untuk memastikan akses port 53.  
   - *Hapus aturan ini setelah pengujian* agar internet lancar untuk install paket.

---

2.4. **IronHills terdeteksi aktivitas mencurigakan.**  
   - Hanya boleh diakses pada **Akhir Pekan (Sabtu & Minggu)**.  
   - Akses hanya untuk faksi:
     - Kurcaci & Pengkhianat → **Durin & Khamul**
     - Manusia → **Elendil & Isildur**
   - Karena hari ini **Rabu**, semua harus **tertolak**.  
   - Gunakan **curl** untuk bukti blokir waktu.

2.5. **Akses Palantir dibatasi berdasarkan ras:**
   - **Faksi Elf (Gilgalad & Cirdan):** 07.00 – 15.00  
   - **Faksi Manusia (Elendil & Isildur):** 17.00 – 23.00  
   - Gunakan **curl** untuk uji akses sesuai jam.

2.6. **Uji keamanan Palantir oleh Elendil (Manusia).**  
   Lakukan port scan dengan:
