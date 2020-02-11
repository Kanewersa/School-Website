# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

path = Rails.root.join("app/assets/images/image_not_available.png")
tab = MainTab.new
tab.title = "O Szkole"
tab.body = "Tekst zakładki"
tab.slug = "o-szkole"
tab.image.attach(io: File.open(path), filename: "image_not_available.png", content_type: "application/image")
tab.save

tab = MainTab.new
tab.body = "Tekst zakładki"
tab.title = "Organizacja"
tab.slug = "organizacja"
tab.image.attach(io: File.open(path), filename: "image_not_available.png", content_type: "application/image")
tab.save

tab = MainTab.new
tab.body = "Tekst zakładki"
tab.title = "Dla uczniów"
tab.slug = "dla-uczniow"
tab.image.attach(io: File.open(path), filename: "image_not_available.png", content_type: "application/image")
tab.save

tab = MainTab.new
tab.body = "Tekst zakładki"
tab.title = "Dla rodziców"
tab.slug = "dla-rodzicow"
tab.image.attach(io: File.open(path), filename: "image_not_available.png", content_type: "application/image")
tab.save

tab = MainTab.new
tab.body = "Tekst zakładki"
tab.title = "Kontakt"
tab.slug = "kontakt"
tab.image.attach(io: File.open(path), filename: "image_not_available.png", content_type: "application/image")
tab.save

#
#MainTab.create(id: 1, title: "O Szkole",
#               slug: "o-szkole",
#               body: "Tekst zakładki",
#               image: Rails.root.join("app/assets/images/image_not_available.png").open)
#MainTab.create(id: 2,
#               title: "Organizacja",
#               slug: "organizacja",
#               body: "Tekst zakładki",
#               image: Rails.root.join("app/assets/images/image_not_available.png").open)
#MainTab.create(id: 4,
#               title: "Dla uczniów",
#               slug: "dla-uczniów",
#               body: "Tekst zakładki",
#               image: Rails.root.join("app/assets/images/image_not_available.png").open)
#MainTab.create(id: 5,
#               title: "Dla rodziców",
#               slug: "dla-rodziców",
#               body: "Tekst zakładki",
#               image: Rails.root.join("app/assets/images/image_not_available.png").open)
#MainTab.create(id: 6,
#               title: "Kontakt",
#               slug: "kontakt",
#               body: "Tekst zakładki",
#               image: Rails.root.join("app/assets/images/image_not_available.png").open)

Category.create(id: 1, title: "Ogólnoszkolne", slug: "ogolnoszkolne")
Category.create(id: 2, title: "Oddział przedszkolny", slug: "oddzial-przedszkolny")
Category.create(id: 3, title: "Klasy I-III", slug: "klasy-i-iii")
Category.create(id: 4, title: "Klasy IV-VIII", slug: "klasy-iv-viii")
Category.create(id: 5, title: "Świetlica", slug: "swietlica")

SubTab.create(title: "Plan lekcji",
              main_tab: MainTab.where(:title => "Organizacja").take,
              slug: "plan-lekcji",
              sort: 1,
              status: 1,
              body: "Tekst zakładki")

SubTab.create(title: "Zajęcia pozalekcyjne",
              main_tab: MainTab.where(:title => "Dla uczniów").take,
              slug: "zajecia-pozalekcyjne",
              sort: 1,
              status: 1,
              body: "Tekst zakładki")

Token.create(role: "admin", value: "value", name: "Administrator")