# 🚦 Four-way Traffic Light in VHDL 🚦
▶ : https://youtu.be/cb8xoPKAAy8
Four-way Traffic Light in VHDL Four Lane Junction Traffic Light Controller merupakan alat controller yang dapat membuat pengguna jalan tetap aman dalam berkendara di jalan. Karena di dalam controller ini terdapat controller secara otomatis dan manual sehingga Pihak kepolisian yang terdekat dapat mengatur lalu lintas yang ada. 
Lampu lalu lintas yang menangani arus lalu lintas di persimpangan empat arah. Lampu lalu lintas ini dapat bekerja otomatis dan manual. Kerja manual ini dikontrol oleh pos polisi terdekat untuk keadaan-keadaan khusus seperti konvoi militer atau keadaan darurat . ini sangat membantu pihak berwajib dalam penanganan kasus kasus darurat di lalu lintas. Di controller ini dibuat control dalam seven segment yang menunjukkan angka countdown dalam lampu merah menuju kuning kemudian terakhir hijau. 

IMPLEMENTASI

Four Lane Junction Traffic Light Controller merupakan alat controller yang dapat membuat pengguna jalan tetap aman dalam berkendara di jalan. Karena di dalam controller ini terdapat controller secara otomatis dan manual sehingga Pihak kepolisian yang terdekat dapat mengatur lalu lintas yang ada.
Lampu lalu lintas yang menangani arus lalu lintas di persimpangan empat arah. Lampu lalu lintas ini dapat bekerja otomatis dan manual. Kerja manual ini dikontrol oleh pos polisi terdekat untuk keadaan-keadaan khusus seperti konvoi militer atau keadaan darurat . ini sangat membantu pihak berwajib dalam penanganan kasus kasus darurat di lalu lintas. Di controller ini dibuat kontrol dan seven segment yang menunjukkan angka countdown dalam lampu merah menuju kuning kemudian terakhir hijau. dan juga di dalam controller ini diterapkan logic diagram dari sistem, kemudian menerapkan State Table untuk tiap kondisi persimpangan jalan, komponen Counter untuk menentukan interval tiap state, dan 7-Segment Display untuk menampilkan Counter. Selain itu, kelompok kami telah melakukan simulasi terhadap kode VHDL, menghasilkan skematik dari proyek, dan membuat RTL Viewer untuk menampilkan bentuk hardware dari kode VHDL. 
Dalam kode ini digunakan input clear, clock, dan mode dalam bentuk std_logic,  serta condition dalam bentuk integer. Sedangkan outputnya adalah green, yellow, dan red dalam bentuk std_logic_vector. Kode ini terdiri dari 8 state atau kondisi. Dengan state S0 sebagai state pertama dan S8 sebagai state terakhir. Pada masing-masing state dilakukan modifikasi pada output dan juga sinyal nextState.
Rangkaian ini juga terbagi dalam dua bagian besar yaitu proses seq dan proses comb. Pada proses seq dilakukan penentuan mode lampu lalu lintas, yaitu otomatis atau manual. Sedangkan pada proses comb dilakukan penentuan nyala lampu berdasarkan arah mata angin dan arah jarum jam.


Program ini memiliki fitur
- Lampu lalu lintas otomatis
- Kontrol lampu lalu lintas manual
- LED penunjuk waktu lampu merah yang tersisa 

TODO's
- [x] Membuat main program 	:page_facing_up:
- [x] Membuat testbench program 	:memo:
- [x] Mengimplementasikan semua modul :pushpin:
- [x] Membuat laporan dan README.md 	:clipboard:
- [x] Membuat presentasi :bar_chart:
