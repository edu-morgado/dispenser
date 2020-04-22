from config import Config
from flask import Flask
from flask_sqlalchemy import SQLAlchemy
from flask_migrate import Migrate


import sqlite3
import datetime


app = Flask(__name__)
app.config.from_object(Config)
db = SQLAlchemy(app)
migrate = Migrate(app, db)




from app import routes, models

from app.models import *





if(len(Home.query.all()) == 0 ):
    print("populating database now")
    home1 = Home(name="home1dengue")
    home2 = Home(name="home2dengue")
    inventory1 = Inventory(name = "inventory1  ", ttype =1 , home = home1)
    inventory2 = Inventory(name = "inventory2  ", ttype =2 , home = home1)
    inventory3 = Inventory(name = "inventory3  ", ttype =0 , home = home1)
    inventory4 = Inventory(name = "inventory4  ", ttype =2 , home = home2)
    inventory5 = Inventory(name = "inventory5  ", ttype =1 , home = home2)
    inventory6 = Inventory(name = "inventory6  ", ttype =1 , home = home2)
    wishlist1 = Wish_List(name = "wishlist1  ", home = home1)
    wishlist2 = Wish_List(name = "wishlist2  ", home = home1)
    wishlist3 = Wish_List(name = "wishlist3  ", home = home2)
    wishlist4 = Wish_List(name = "wishlist4  ", home = home2)
    food = Food_Item(name = "food item1  ", quantity = 4, category = "Carne  ", inventory = inventory1)
    food = Food_Item(name = "food item2  ", quantity = 2, category = "Peixe ", inventory = inventory1)
    food = Food_Item(name = "food item3  ", quantity = 1, category = "Espada ", inventory = inventory2)
    food = Food_Item(name = "food item4  ", quantity = 4, category = "DEngue ",  inventory = inventory3)
    food = Food_Item(name = "food item5  ", quantity = 3, category = "cereais ", inventory = inventory3)
    food = Food_Item(name = "food item6  ", quantity = 12, category = "papelhigineico ", inventory = inventory3)
    food = Food_Item(name = "food item7  ", quantity = 45, category = "dengue ", wishlist = wishlist1)
    food = Food_Item(name = "food item8  ", quantity = 1, category = " congelado " ,wishlist = wishlist1)
    food = Food_Item(name = "food item9  ", quantity = 3, category = " nao congelado ", inventory = inventory4)
    food = Food_Item(name = "food item10 ", quantity = 5, category = "vegetais  ", inventory = inventory4)
    food = Food_Item(name = "food item11 ", quantity = 3, category = " fruta ", inventory = inventory5)
    food = Food_Item(name = "food item12 ", quantity = 1, category = " nao fruta ",  inventory = inventory5)
    food = Food_Item(name = "food item13 ", quantity = 8, category = " bebida  ",  inventory = inventory5)
    food = Food_Item(name = "food item14 ", quantity = 5, category = "jolzz  ",  inventory = inventory6)
    food = Food_Item(name = "food item15 ", quantity = 3, category = "frios ", wishlist = wishlist3)
    food = Food_Item(name = "food item16 ", quantity = 55, category = "quentes  ", wishlist = wishlist3)
    food = Food_Item(name = "food item17 ", quantity = 3, category = " dengues ", wishlist = wishlist4)
    db.session.add(home1)
    db.session.add(home2)
    db.session.commit()


