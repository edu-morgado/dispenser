from app import app, db
from app.models import Inventory
from flask import abort, jsonify
from flask import request



@app.route('/api/inventory/create', methods=['POST'])
def create_inventory():
    id = request.form.get('id')
    name = request.form.get('name')
    ttype = request.form.get('ttype')
    foods_json = request.form.get('foods_json')
    if id is None or name is None or ttype is None or foods_json is None:
        abort(400)  # missing arguments

    inventory = Inventory(id = id,name = name, ttype = ttype, foods_json = foods_json)
    db.session.add(inventory)
    db.session.commit()
    return {'success': True}, 201


@app.route('/api/inventory/read')
def read_all_inventories():
    inventories = Inventory.query.all()
    return jsonify([inventory.to_json() for inventory in inventories]), 200

@app.route('/api/inventory/read/<int:inventory_id>', methods=['GET'])
def read_inventory(inventory_id):
    inventory = Inventory.query.get(inventory_id)
    if inventory is None:
        abort(404)
    else:
        return jsonify(inventory.to_json()), 200

@app.route('/api/inventory/update/<int:inventory_id>', methods=['POST'])
def update_inventory(inventory_id):

    name = request.form.get('name')
    ttype = request.form.get('ttype')
    foods_json = request.form.get('foods_json')
    if name is None or ttype is None or foods_json is None:
        abort(400)  # missing arguments

    inventory = Inventory.query.get(inventory_id)
    if inventory is None:
        abort(404)


    inventory.ttype = ttype
    inventory.foods_json = foods_json
    db.session.commit()
    return {'success': True}, 200

@app.route('/api/inventory/delete/<int:inventory_id>', methods=['DELETE'])
def delete_inventory(inventory_id):

    inventory = Inventory.query.get(inventory_id)
    if inventory is None:
        abort(404)
    db.session.delete(inventory)
    db.session.commit()
    return {"success" : True}, 204