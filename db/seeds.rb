User.create!(name:  "Addmin User",
             email: "addminuser@example.com",
             password:              "addmin",
             password_confirmation: "addmin",
             admin: true)


User.create!(name:  "Second User",
            email: "second@example",
            password:              "second",
            password_confirmation: "second",
            )
