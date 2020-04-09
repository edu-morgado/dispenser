from app import app, db
from app.models import Food_Item
from flask import abort, jsonify
from flask import request
from flask import g
from datetime import datetime




@app.route('/food_item/create', methods=['POST'])
def create_food_item():
    id = request.form.get('id')
    name = request.form.get('name')
    quantity = request.form.get('quantity')
    if id is None or name is None or quantity is None:
        abort(400)  # missing arguments

    food_item = Food_Item(id = id, name = name, quantity = quantity)
    db.session.add(food_item)
    db.session.commit()
    return {'success': True}, 201



@app.route('/api/food_item/read')
def read_all_food_items():
    food_items = Food_Item.query.all()
    return jsonify([food_item.to_json() for food_item in food_items]), 200

@app.route('/api/food_item/read/<int:food_item_id>', methods=['GET'])
def read_food_item(food_item_id):
    food_item = Food_Item.query.get(food_item_id)
    if food_item is None:
        abort(404)
    else:
        return jsonify(food_item.to_json()), 200


@app.route('/api/food_item/update/<int:food_item_id>', methods=['POST'])
def update_food_item(food_item_id):

    name = request.form.get('name')
    quantity = request.form.get('quantity')
    if id is None or name is None or quantity is None:
        abort(400)  # missing arguments

    food_item = Food_Item.query.get(food_item_id)
    if food_item is None:
        abort(404)

    food_item.name = name
    food_item.quantity = quantity
    db.session.commit()
    return {'success': True}, 200
