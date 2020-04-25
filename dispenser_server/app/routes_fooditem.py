from app import app, db
from app.models import Food_Item
from flask import abort, jsonify
from flask import request


@app.route('/api/food_item/create', methods=['POST'])
def create_food_item():
    
    name = request.form.get('name')
    quantity = request.form.get('quantity')
    category = request.form.get('category')
    inventory_id = request.form.get("inventory_id")
    wish_list_id = request.form.get("wish_list_id")

    if name is None or quantity is None or category is None:
        abort(400)  # missing arguments
    if inventory_id is None and wish_list_id is None:
        abort(400)
    if inventory_id is not None and wish_list_id is not None:
        abort(400) 
    if inventory_id is None:
        food_item = Food_Item( name = name, quantity = quantity, category = category, wish_list_id = wish_list_id)
    if wish_list_id is None:
        food_item = Food_Item( name = name, quantity = quantity, category = category, inventory_id = inventory_id)
    db.session.add(food_item)
    db.session.flush()
    db.session.commit()
    return {'success': True, "id" : food_item.id}, 201

@app.route('/api/food_item/read_from_inventory', methods=['POST'])
def read_all_food_items_from_inventory():
    inventory_id = request.form.get('inventory_id')
    food_items = Food_Item.query.filter_by(inventory_id=inventory_id)
    return jsonify([food_item.to_json() for food_item in food_items]), 200

@app.route('/api/food_item/read_from_wishlist', methods=['POST'])
def read_all_food_items_from_wishlist():
    wishlist_id = request.form.get('wishlist_id')
    food_items = Food_Item.query.filter_by(wish_list_id=wishlist_id)
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