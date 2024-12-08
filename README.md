# **Proyek Akhir PSD - RSA-Encryptor pada VHDL**

## **Latar Belakang**
Di era digital saat ini, keamanan informasi sangat penting. Banyak data pribadi dan sensitif yang dikirimkan melalui jaringan komunikasi, seperti pesan teks, email, dan berbagai jenis file. Oleh karena itu, perlindungan data ini menjadi kebutuhan yang mendesak.

Namun, masalah utama yang dihadapi adalah potensi serangan dari pihak yang tidak berwenang yang berusaha mencuri atau merusak data. Teknik yang sering digunakan oleh peretas adalah mencoba mendekripsi informasi yang dikirimkan atau disimpan. Untuk mengatasi masalah ini, diperlukan sistem enkripsi yang kuat dan efisien.

## **Cara Kerja**
Program ini dapat menghasilkan angka acak menggunakan fungsi **impure**, yang ditemukan dalam **PrimeGen.vhd**. Dalam program ini, dua angka acak 12 bit (4096 dalam desimal) akan dihasilkan dan kemudian diperiksa apakah angka tersebut adalah bilangan prima atau tidak. Jika kedua angka acak tersebut adalah bilangan prima, maka angka tersebut akan dimasukkan ke dalam variabel p dan q.

### **Control Unit**
Program VHDL ini adalah implementasi dari entitas dan arsitektur yang membentuk unit kontrol sederhana. Entitas **Finpro_tb** memiliki dua port, yaitu **clk** sebagai input clock, dan **prime1_receiver** dan **prime2_receiver** sebagai buffer untuk bilangan prima yang diterima. Terdapat juga output untuk **outCurr**, **outputEncrypt**, dan **outputDecrypt**.

Arsitektur **rtl** (register-transfer level) mendefinisikan komponen **DecryptorUnit** yang berfungsi untuk menerima pesan, mengenkripsi, dan mendekripsi data sesuai dengan kunci yang diterima. Proses ini akan dijalankan dengan menggunakan clock sebagai sinyal pengatur waktu, yang memastikan setiap proses enkripsi dan dekripsi berjalan sesuai urutan state yang telah ditentukan.

### **Key Generator**
Program VHDL ini mengimplementasikan entitas **KeyGenUnit** yang bertanggung jawab untuk menghasilkan kunci publik dan kunci privat berdasarkan bilangan prima **prime1_key** dan **prime2_key**. Komponen utama dalam program ini adalah proses yang diaktifkan pada setiap rising edge dari sinyal clock (**clk**). Dalam proses ini, terdapat komponen lain yang disebut **PrimeGen**. Komponen ini bertanggung jawab untuk menghasilkan dua bilangan prima yang akan digunakan sebagai **prime1_key** dan **prime2_key**.

Selanjutnya, dalam proses utama, dilakukan perhitungan untuk menentukan kunci enkripsi (**e**) dan kunci dekripsi (**d**) berdasarkan algoritma yang telah ditentukan. Hasil perhitungan ini kemudian disimpan dalam sinyal **encryption_key** dan **decryption_key**. Program ini juga menyediakan komentar yang menunjukkan tempat untuk menambahkan logika tambahan, seperti perhitungan kunci privat (**d**), yang mungkin diperlukan dalam implementasi kriptografi yang lebih kompleks. Secara singkat, tujuan dari program ini adalah untuk menghasilkan kunci publik dan privat yang digunakan dalam algoritma kriptografi, di mana kunci publik digunakan untuk enkripsi dan kunci privat digunakan untuk dekripsi.

### **Prime Generator**
Program **PrimeGen.vhd** ini dirancang untuk menghasilkan dua bilangan prima (**p** dan **q**) berdasarkan sinyal clock (**clk**). Program ini menggunakan metode **trial division** untuk memastikan bahwa angka yang dihasilkan adalah bilangan prima. Dalam implementasinya, program ini menggunakan proses yang diaktifkan pada setiap rising edge dari sinyal clock. Dalam proses ini, variabel seperti **seed1**, **seed2**, **rand_int1**, dan **rand_int2** diinisialisasi, yang diperlukan untuk menghasilkan angka acak.

Program ini memiliki fungsi **rand_int_gen** yang menghasilkan bilangan acak dalam rentang yang ditentukan. Fungsi ini menggunakan nilai **seed** dan fungsi **uniform** dari paket **IEEE.math_real** untuk menghasilkan nilai acak antara 0 dan 1, yang kemudian dikonversi menjadi integer dalam rentang yang ditentukan.

Pada setiap siklus pemrosesan, program menghasilkan dua angka acak (**rand_int1** dan **rand_int2**). Selanjutnya, program menggunakan metode **trial division** untuk memeriksa apakah kedua angka tersebut adalah bilangan prima. Proses ini dilakukan dengan membagi setiap angka dengan angka-angka mulai dari 2 hingga akar kuadrat dari angka tersebut. Jika ditemukan pembagi yang membagi habis, maka angka tersebut bukan bilangan prima.

Proses ini diulang hingga kedua angka yang dihasilkan benar-benar merupakan bilangan prima. Setelah itu, kedua bilangan prima tersebut disalin ke output **p** dan **q**. Secara ringkas, tujuan dari program ini adalah untuk menghasilkan dua bilangan prima (**p** dan **q**) sebagai output berdasarkan sinyal clock, dengan memastikan bahwa angka tersebut benar-benar bilangan prima melalui metode percobaan dan kesalahan.

---

## **Fungsi `rand_int_gen` pada PrimeGen.vhd**
Pada bagian **PrimeGen.vhd**, fungsi **rand_int_gen** berfungsi untuk menghasilkan angka acak dalam rentang tertentu. Berikut adalah kode untuk menghasilkan angka acak:

```vhdl
impure function rand_int_gen(min: integer; max: integer) return integer is
    variable randomValue: real;
begin
    uniform(seed1, seed2, randomValue);
    return integer(round(randomValue * real(max - min + 1) + real(min) - 0.5));
end function;
```

- **Penjelasan**: 
  - Fungsi **rand_int_gen** menghasilkan angka acak dalam rentang yang ditentukan oleh `min` dan `max`.
  - Fungsi **uniform(seed1, seed2, randomValue)** dari paket **IEEE.math_real** digunakan untuk menghasilkan nilai acak antara 0 dan 1.
  - Kemudian nilai acak ini dikalikan dengan rentang yang diinginkan (dari `min` hingga `max`), dan hasilnya dibulatkan ke integer terdekat.

---

## **Cara Penggunaan**
Program kami bekerja untuk mengenkripsi dan mendekripsi pesan. Pada **Finpro_tb.vhd**, Anda akan diberikan sebuah pesan dalam bentuk string yang terdiri dari 10 huruf kapital, masing-masing dipisahkan oleh spasi. Pesan tersebut akan diproses oleh program utama **DecryptoUnit.vhd**.

## **State Diagram Program**
![state](https://i.imgur.com/9dyWpyA.jpeg)

## **Block Diagram Program**
![block](https://i.imgur.com/Zk5zaMJ.jpeg)

## **Pengujian**
Untuk menguji enkripsi dan dekripsi pesan ini, gunakan file **Finpro_tb.vhd** yang berfungsi sebagai testbench. Pada file **Finpro_tbr**, Anda akan diberikan pesan dalam bentuk string yang terdiri dari 10 huruf kapital, masing-masing dipisahkan oleh spasi. Pesan ini kemudian diproses oleh program utama **DecryptoUnit.vhd**.

## **Hasil Wave Simulasi**
### **Finpro_tb.vhd**
![testbench](https://i.imgur.com/4AcG2dD.jpeg)

### **DecryptorUnit.vhd**
![decryptor](https://i.imgur.com/VTHgce2.jpeg)

### **PrimeGen.vhd**
![prime](https://i.imgur.com/PhAihz9.jpeg)

### **KeyGenUnit.vhd**
![key generator](https://i.imgur.com/7IG3CYM.jpeg)
