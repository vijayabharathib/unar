# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
visits=Visit.create([
    {url: '/home',ip:'192.192.192.192',device:'mobile'},
    {url: '/priv',ip:'192.192.192.193',device:'deskto'},
    {url: '/home',ip:'192.192.192.194',device:'tablet'},
    {url: '/priv',ip:'192.192.192.192',device:'deskto'},
    {url: '/home',ip:'192.192.192.193',device:'tablet'},
    {url: '/abou',ip:'192.192.192.192',device:'mobile'},
    {url: '/abou',ip:'192.192.192.194',device:'tablet'},
    {url: '/abou',ip:'192.192.192.194',device:'tablet'},

])