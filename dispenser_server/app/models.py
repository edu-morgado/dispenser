from app import app, db
from datetime import datetime
from sqlalchemy.dialects.postgresql import UUID
from sqlalchemy.ext.declarative import declarative_base
from uuid import uuid4



Base = declarative_base()

class Home(db.Model, Base):
    schema = 'public'
    __tablename__='home'
    id = db.Column(db.Integer, autoincrement = True, primary_key = True, nullable = False)
    name = db.Column(db.String(128), nullable = False)
    date_created = db.Column(db.DateTime, default = datetime.now(), nullable = False)
    date_last_update = db.Column(db.DateTime, default = datetime.now(), nullable = False)
    inventories = db.relationship("Inventory", backref = 'home', cascade = 'all, delete-orphan')
    wishlists = db.relationship("Wish_List", backref = 'home', cascade = 'all, delete-orphan')
    notes = db.relationship("Note", backref = 'home', cascade = 'all, delete-orphan')

    def __repr__(self):
        return '<Home {}: {}> created at {} ; last edited at {}'.format(self.id, self.name , self.date_created, self.date_last_update)
    
    def to_json(self):
        return { 'id' : self.id,
                'name': self.name,
                'date_created':self.date_created,
                'date_last_update':self.date_last_update}

class Inventory(db.Model, Base):
    schema = 'public'
    __tablename__ = 'inventory'
    id = db.Column(db.Integer, autoincrement = True, primary_key = True, nullable = False)
    name = db.Column(db.String(128), nullable=False)
    ttype = db.Column(db.Integer, nullable=False)
    date_created = db.Column(db.DateTime, default = datetime.now(), nullable = False)
    date_last_update = db.Column(db.DateTime,  default = datetime.now(), nullable = False)
    home_id = db.Column(db.Integer, db.ForeignKey('home.id'))
    food_items = db.relationship("Food_Item", backref = 'inventory', cascade = 'all')

    def __repr__(self):
        return '<Inventory {}: {} with ttype {}> created at {} ; last edited at {}'.format(self.id, self.name , self.ttype, self.date_created. date_last_update)
    
    def to_json(self):
        return { 'id' : self.id,
                'name' : self.name,
                'ttype' : self.ttype,
                'date_created' : self.date_created.isoformat(),
                'date_last_update': self.date_last_update.isoformat()}

class Wish_List(db.Model, Base):
    schema = 'public'
    __tablename__ = 'wish_list'
    id = db.Column(db.Integer, autoincrement=True, primary_key=True, nullable=False)
    name = db.Column(db.String(128), nullable=False)
    date_created = db.Column(db.DateTime, default = datetime.now(), nullable = False)
    date_last_update = db.Column(db.DateTime, default = datetime.now(), nullable = False)
    home_id = db.Column(db.Integer, db.ForeignKey('home.id'))
    food_items = db.relationship("Food_Item", backref = 'wish_list', cascade = 'all')

    def __repr__(self):
        return '<Inventory {}: {} > created at {} ; last edited at {}'.format(self.id, self.name, self.date_created. date_last_update)
    
    def to_json(self):
        return { 'id' : self.id,
            'name' : self.name,
            'date_created' : self.date_created.isoformat(),
            'date_last_update': self.date_last_update.isoformat()}

class Food_Item(db.Model, Base):
    schema = 'public'
    __tablename__ = 'food_item'
    id = db.Column(db.Integer,autoincrement=True, primary_key=True, nullable=False)
    name = db.Column(db.String(128), nullable=False)
    quantity = db.Column(db.Integer, nullable=False)
    category = db.Column(db.String(128), nullable = False)
    date_created = db.Column(db.DateTime, default = datetime.now(), nullable = False)
    date_last_update = db.Column(db.DateTime, default = datetime.now(), nullable = False)
    inventory_id = db.Column(db.Integer, db.ForeignKey('inventory.id'))
    wish_list_id = db.Column(db.Integer, db.ForeignKey('wish_list.id'))
    def __repr__(self):
        return '<Food_item {}: {}> quantity: {}; category: {}; date_created: {}; date_last_update: {}'.format(self.id, self.name, self.quantity, self,category, self.date_created, self.date_last_update)


    def to_json(self):
        return {'id': self.id,
                'name': self.name,
                'quantity': self.quantity,
                'category': self.category,
                'date_created' : self.date_created.isoformat(),
                'date_last_update': self.date_last_update.isoformat()}

class Note(db.Model, Base):
    schema = 'public'
    __tablename__ = 'note'
    id = db.Column(db.Integer,autoincrement=True, primary_key=True, nullable = False)
    title = db.Column(db.String(128), nullable = False)
    content = db.Column(db.String(2048), nullable = False)
    color = db.Column(db.String(64), nullable = False)
    date_created = db.Column(db.DateTime,default = datetime.now(), nullable = False)
    date_last_update = db.Column(db.DateTime,default = datetime.now(), nullable = False)
    house_id = db.Column(db.Integer, db.ForeignKey('home.id'))

    def __repr__(self):
        return '<Note {}:{} >; content: {}; color: {}; date_created: {}; date_last_update: {}'.format(self.id, self.title, self.content, self,color, self.date_created, self.date_last_update)

    def to_json(self):
        return {'id': self.id,
                'title': self.title,
                'content': self.content,
                'color': self.color,
                'date_created' : self.date_created.isoformat(),
                'date_last_update': self.date_last_update.isoformat()}
