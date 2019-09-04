User.destroy_all
FlashCard.destroy_all
10.times do
    user_name = Faker::Internet.unique.user_name
    email = Faker::Internet.email
   user = User.create(user_name: user_name, email: email, password: "123")
    10.times do 
        english = "dog" #use faker to randomly generate a value
        translation = "perro"
        part_of_speech = "noun"
        fc = FlashCard.create(english: english, translation: translation, part_of_speech: part_of_speech)
        fc.user = user
        user.flash_cards << fc
    end

end