from app import app, db
from datetime import datetime



class Food_Item(db.Model):
    __tablename__ = 'food_item'
    id = db.Column(db.Integer,autoincrement=True, primary_key=True, nullable=False)
    name = db.Column(db.String(128), nullable=False)
    quantity = db.Column(db.Integer, nullable=False)

    def __repr__(self):
        return '<FoodItem {}: {}> with quantity {}'.format(self.id, self.name , self.quantity)
    
    def to_json(self):
        return { 'id' : self.id,
                'name' : self.name,
                'quantity' : self.quantity}

class Inventory(db.Model):
    __tablename__ = 'inventory'
    id = db.Column(db.Integer,autoincrement=True, primary_key=True, nullable=False)
    ttype = db.Column(db.Integer, nullable=False)
    name = db.Column(db.String(128), nullable=False)
    foods_json = db.Column(db.String(10000), nullable=False)

    def __repr__(self):
        return '<Inventory {}: {}> following foods {}'.format(self.id, self.name , self.foods_json)
    
    def to_json(self):
        return { 'id' : self.id,
                'ttype' : self.ttype,
                'name' : self.name,
                'foods_json' : self.foods_json}


class Category(db.Model):
    __tablename__ = 'category'
    id = db.Column(db.Integer,autoincrement=True, primary_key=True, nullable=False)
    name = db.Column(db.String(128), nullable=False)
    foods_json = db.Column(db.String(10000), nullable=False)

    def __repr__(self):
        return '<Category {}: {}> following foods {}'.format(self.id, self.name , self.foods_json)
    
    def to_json(self):
        return { 'id' : self.id,
                'name' : self.name,
                'foods_json' : self.foods_json}

class Note(db.Model):
    __tablename__ = 'note'
    id = db.Column(db.Integer, primary_key=True)
    title = db.Column(db.String())
    text = db.Column(db.String())
    timestamp = db.Column(db.DateTime, default=datetime.utcnow)

    def __repr__(self):
        return 'Note {}; title: {}; text: {}; timestamp: {}'.format(self.id, self.title, self.text, self,timestamp)

    def to_json(self):
        return {'id': self.id,
                'title': self.title,
                'text': self.text,
                'timestamp': self.timestamp.isoformat()}