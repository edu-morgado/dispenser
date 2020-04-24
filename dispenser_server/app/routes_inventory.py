from app import app, db
from app.models import Inventory
from flask import abort, jsonify
from flask import request



@app.route('/api/inventory/create', methods=['POST'])
def create_inventory():
    name = request.form.get('name')
    ttype = request.form.get('ttype')
    if id is None or name is None or ttype is None :
        abort(400)  # missing arguments

    inventory = Inventory(name = name, ttype = ttype)
    db.session.add(inventory)
    db.session.flush()
    db.session.commit()
    return {'success': True, 'id' : inventory.id }, 201


@app.route('/api/inventory/read', methods=['POST'])
def read_all_inventories_id():
    home_id = request.form.get('homeId')
    inventories = Inventory.query.filter_by(home_id=home_id)
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
    if name is None or ttype is None:
        abort(400)  # missing arguments

    inventory = Inventory.query.get(inventory_id)
    if inventory is None:
        abort(404)


    inventory.ttype = ttype
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