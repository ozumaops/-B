# coding: utf-8

User.create!(name: "管理者",
    email: "sample@email.com",
    affiliation: "システム部",   
    password: "password",
    password_confirmation: "password",
    admin: true,
    superior: false)
    
User.create!(name: "上長A",
    email: "superior-a@email.com",
    affiliation: "統括部",    
    password: "password",
    password_confirmation: "password",
    admin: false,
    superior: true)
    
User.create!(name: "上長B",
    email: "superior-b@email.com",
    affiliation: "フリーランス部",
    password: "password",
    password_confirmation: "password",
    admin: false,
    superior: true)
    
   