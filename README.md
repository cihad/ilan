## İlan ([Demo](http://fastilan.herokuapp.com/))

İlan, gazete sayfalarında görmeye alışmış olduğumuz kutu ilan yapısını webe aktarmak fikrinden doğmuş bir [Ruby on Rails](http://www.rubyonrails.org) uygulamasıdır.

Uygulamayı tasarlarken basit olmasını dikkate aldım. Gereksiz özellikler eklemekten kaçındım. Kullanıcıyı ilan eklemek için üye olma gibi gereksiz süreçlerden olabildiğince uzak tutmaya çalıştım. 

### Özellikleri

- Ruby on Rails 4.0.1,
- Postgresql veritabanı,
- Üyelik gerektirmeden ilan ekleyebilme,
- İlan formunda daha önce ilan ekleyenin email adresinin gözükmesi,
- Hangi şehirden **ilan ekle** butonuna tıklanırsa ilan ekleme formunda o ilin gözükmesi,
- Mobil uyumlu,
- Turbolinks ve [NProgress.js](https://github.com/rstacruz/nprogress) ile daha iyi kullanıcı deneyimi,
- [Bootstrap 3](http://getbootstrap.com/),
- Site kontrol sayfası için **Basic HTTP Authentication**,
- Kategori ekleme, silme,
- Kategorilere simge olarak [bootstrap ikonları](http://getbootstrap.com/components/#glyphicons) verebilme,
- Şehir ekleme, silme

gibi özelliklere sahip.

### Kurulum

1. Gerekli postgresql veritabanı, Ruby 2.0 ve üzeri ile gerekli diğer kurulumları tamamlayın 

2. `bundle` ile gerekli gem paketlerini kurun,

3. `config/application.example.yml` dosyasını `application.yml` olarak değiştirin. Bilgileri kendinize göre düzenleyin,

4. `rake db:migrate` ile veritabanı yapısını oluşturun,

5. `rails s` ile uygulamayı başlatın,


**Not:** `/control` ile uygulamanın kontrol sayfasına erişebilirsiniz. `config/application.yml` dosyasındaki verileri giriş için kullanacaksınız.

### Testleri çalıştırma

Uygulama başlangıç dizininden `rake spec` veya `rspec .` ile testleri çalıştırabilirsiniz.