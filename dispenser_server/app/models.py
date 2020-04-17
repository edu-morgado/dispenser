from app import app, db
from datetime import datetime


class Home(db.model):
    __tablename__ = 'home'
    id = db.Column(db.Integer, autoincrement = True, primary_key = True, nullable = False)
    name = db.Column(db.String(128), nullable = False)
    date_created = db.Column(db.DateTime, nullable = False)
    date_last_update = db.Column(db.DateTime, nullable = False)

    def __repr__(self):
        return '<Home {}: {}> created at {} ; last edited at {}'.format(self.id, self.name , self.date_created, self.date_last_update)
    
    def to_json(self):
        return { 'id' : self.id,
                'name': self.name,
                'date_created':self.date_created,
                'date_last_updated':self.date_last_update}



class Inventory(db.Model):
    __tablename__ = 'inventory'
    id = db.Column(db.Integer, autoincrement = True, primary_key = True, nullable = False)
    name = db.Column(db.String(128), nullable=False)
    ttype = db.Column(db.Integer, nullable=False)
    date_created = db.Column(db.DateTime, nullable = False)
    date_last_update = db.Column(db.DateTime, nullable = False)

    def __repr__(self):
        return '<Inventory {}: {} with ttype {}> created at {} ; last edited at {}'.format(self.id, self.name , self.ttype, self.date_created. date_last_update)
    
    def to_json(self):
        return { 'id' : self.id,
                'name' : self.name,
                'ttype' : self.ttype,
                'date_created' : self.date_created.isoformat(),
                'date_last_updated': self.date_last_update.isoformat()}

class WishList(db.Model):
    __tablename__ = 'wishlist'
    id = db.Column(db.Integer, autoincrement=True, primary_key=True, nullable=False)
    name = db.Column(db.String(128), nullable=False)
    date_created = db.Column(db.DateTime, nullable = False)
    date_last_update = db.Column(db.DateTime, nullable = False)

    def __repr__(self):
        return '<Inventory {}: {} > created at {} ; last edited at {}'.format(self.id, self.name, self.date_created. date_last_update)
    
    def to_json(self):
        return { 'id' : self.id,
            'name' : self.name,
            'date_created' : self.date_created.isoformat(),
            'date_last_updated': self.date_last_update.isoformat()}


class Note(db.Model):
    __tablename__ = 'note'
    id = db.Column(db.Integer,autoincrement=True, primary_key=True, nullable = False)
    title = db.Column(db.String(128), nullable = False)
    content = db.Column(db.String(2048), nullable = False)
    color = db.Column(db.String(64), nullable = False)
    date_created = db.Column(db.DateTime, nullable = False)
    date_last_updated = db.Column(db.DateTime, nullable = False)

    def __repr__(self):
        return '<Note {}:{} >; content: {}; color: {}; date_created: {}; date_last_updated: {}'.format(self.id, self.title, self.content, self,color, self.date_created, self.date_last_updated)

    def to_json(self):
        return {'id': self.id,
                'title': self.title,
                'content': self.content,
                'color': self.color,
                'date_created' : self.date_created.isoformat(),
                'date_last_updated': self.date_last_update.isoformat()}

class Food_Item(db.Model):
    __tablename__ = 'food_item'
    id = db.Column(db.Integer,autoincrement=True, primary_key=True, nullable=False)
    name = db.Column(db.String(128), nullable=False)
    quantity = db.Column(db.Integer, nullable=False)
    category = db.Column(db.String(128), nullable = False)
    date_created = db.Column(db.DateTime, nullable = False)
    date_last_updated = db.Column(db.DateTime, nullable = False)

    def __repr__(self):
        return '<Food_item {}: {}> quantity: {}; category: {}; date_created: {}; date_last_updated: {}'.format(self.id, self.name, self.quantity, self,category, self.date_created, self.date_last_updated)


    def to_json(self):
        return {'id': self.id,
                'name': self.name,
                'quantity': self.quantity,
                'category': self.category,
                'date_created' : self.date_created.isoformat(),
                'date_last_updated': self.date_last_update.isoformat()}