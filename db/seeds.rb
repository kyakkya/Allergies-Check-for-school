# coding: utf-8

User.create!(name: "Sample User",
             email: "sample@email.com",
             password: "password",
             password_confirmation: "password",
             admin: true)
             
User.create!(name: "管理職",
             email: "kanri@email.com",
             password: "password",
             password_confirmation: "password",
             admin: true)
             
User.create!(name: "高橋",
             email: "shunin1@email.com",
             password: "password",
             password_confirmation: "password",
             superior: true) 
             
User.create!(name: "山田",
             email: "shunin2@email.com",
             password: "password",
             password_confirmation: "password",
             superior: true)              


