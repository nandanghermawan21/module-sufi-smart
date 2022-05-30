class NewsModel {
  int? newsid;
  String? imagepath;
  String? title;
  String? newsContent;

  NewsModel({
    this.imagepath,
    this.newsid,
    this.title,
    this.newsContent,
  });

  factory NewsModel.fromJson(Map<String, dynamic> json) {
    return NewsModel(
      newsid: json['newsid'] as int,
      imagepath: json['imagepath'] as String,
      title: json['title'] as String,
      newsContent: json['newsContent'] as String,
    );
  }

  Map<String, dynamic> toJson() => {
        'newsid': newsid,
        'imagepath': imagepath,
        'title': title,
        'newsContent': newsContent,
      };
  
     

  static List<NewsModel> dummy() {
    return [
      NewsModel(
        newsid: 1,
        imagepath:
            "https://i.postimg.cc/yYFgwndV/Screen-Shot-2022-02-02-at-15-28-50.png",
        title: "Dengan Bayar Suzuki Finence Di Indomaret Bisa Tebus Murah Jayo",
        newsContent:
            '"Setiap konsumen yang melakukan transaksi pembayaran tagihan / angsuran / kode booking (all payment point) di Indomaret, maka konsumen bisa tebus murah 1 BTL JAYO MINUMAN JAHE ORGINAL GINGER 150ML HANYA SEHARGA Rp 4.000,- (Diskon Rp 2.600, harga normal Rp 6.600)"\n'
            'PERIODE : 1 - 28 Februari 2022\n'
            '\n'
            'Syarat & Ketentuan :   \n'
            '*Ambil produk Jayo Original Ginger 150ml dan bayar bersamaan dengan pembayaran tagihan (harus dalam 1 struk yang sama).\n'
            '*Promo berlaku di Indomaret yang menjual produk tebus murah.\n'
            '*Promosi berlaku untuk semua layanan Payment Point di Indomare',
      ),
      NewsModel(
          newsid: 2,
          imagepath:
              "https://i.postimg.cc/RVSDf75Y/Screen-Shot-2022-02-02-at-15-20-59.png",
          title: "Literasi Bersama Ignity (Ignis Comunity)",
          newsContent:
              'Peserta hadir secara daring pada webinar Literasi bersama Ignity (Ignis Community) yang diadakan pada Jum’at, 17 Desember 2021. Tema yang diusung kali ini adalah “Mengenal Lebih Jauh Perusahaan Pembiayaan”. Peserta Ignity yang hadir berasal dari seluruh Indonesia dan mereka sangat antusias untuk mengikuti acara ini. Pada sesi diskusi peserta webinar mengajukan pertanyaan seputar asuransi, program diskon, trade in, dan dokumen pengajuan kredit pembiayaan.\n'
              '\n'
              'Abah Odie selaku Ketua Umum Pengurus Nasional Ignity menyampaikan bahwa event ini sangat bermanfaat sekali untuk menambah wawasan peserta khususnya dalam bidang pembiayaan. Penyerahan suvenir dari Suzuki Finance Indonesia diserahkan langsung oleh Presiden Direktur Mr. Seiji Itayama di kantor pusat Suzuki Finance Indonesia pada Jum’at, 24 Desember 2021'),
      NewsModel(
        newsid: 3,
        imagepath:
            "https://i.postimg.cc/43bh8Lj9/Screen-Shot-2022-02-02-at-15-24-51.png",
        title: "CSR Berbagi Kasih Natal",
        newsContent:
            'Pada Kamis, 23 Desember 2021 dalam rangka kegiatan CSR berbagi kasih Natal kami mengunjungi Panti Asuhan Griya Asih, Cempaka Putih. Pada kunjungan kali ini yang dihadiri oleh Presiden Direktur Suzuki Finance Indonesia Mr. Seiji Itayama dan Head of Corporate Legal & Compliance Ibu Yuflindawati kami memberikan bantuan berupa dana kemanusiaan, Covid kit (masker, hand sanitizer, disinfektan), kebutuhan pokok sehari-hari, dan peralatan sekolah. Harapan kami bantuan yang kami berikan dapat memberikan keceriaan dan menambah suka cita Natal adik-adik Panti Asuhan Griya Asih',
      ),
    ];
  }
}
