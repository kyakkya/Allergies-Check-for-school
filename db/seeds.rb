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
             
User.create!(name: "代表",
             email: "dai@n.n",
             password: "are",
             password_confirmation: "are",
             superior: true) 
             


