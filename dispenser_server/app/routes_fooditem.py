from app import app, db
from app.models import Food_Item
from flask import abort, jsonify
from flask import request


@app.route('/api/food_item/create', methods=['POST'])
def create_food_item():
    name = request.form.get('name')
    quantity = request.form.get('quantity')
    category = request.form.get('category')
    if name is None or quantity is None or category is None:
        abort(400)  # missing arguments

    food_item = Food_Item( name = name, quantity = quantity, category = category)
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
    category = request.form.get('category')
    if name is None or quantity is None or category is None:
        abort(400)  # missing arguments

    food_item = Food_Item.query.get(food_item_id)
    if food_item is None:
        abort(404)

    food_item.name = name
    food_item.quantity = quantity
    food_item.category = category
    db.session.commit()
    return {'success': True}, 200

@app.route('/api/food_item/delete/<int:food_item_id>', methods=['DELETE'])
def delete_food_item(food_item_id):

    food_item = Food_Item.query.get(food_item_id)
    if food_item is None:
        abort(404)
    db.session.delete(food_item)
    db.session.commit()
    return {"success" : True}, 204