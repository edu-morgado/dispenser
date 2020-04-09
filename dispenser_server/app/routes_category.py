from app import app, db
from app.models import Category
from flask import abort, jsonify
from flask import request


@app.route('/api/category/create', methods=['POST'])
def create_category():
    id = request.form.get('id')
    name = request.form.get('name')
    foods_json = request.form.get('foods_json')
    if id is None or name is None or foods_json is None:
        abort(400)  # missing arguments

    category = Category(id = id, name = name, foods_json = foods_json)
    db.session.add(category)
    db.session.commit()
    return {'success': True}, 201


@app.route('/api/category/read')
def read_all_categories():
    categories = Category.query.all()
    return jsonify([category.to_json() for category in categories]), 200

@app.route('/api/category/read/<int:category_id>', methods=['GET'])
def read_category(category_id):
    category = Category.query.get(category_id)
    if category is None:
        abort(404)
    else:
        return jsonify(category.to_json()), 200

@app.route('/api/category/update/<int:category_id>', methods=['POST'])
def update_category(category_id):

    name = request.form.get('name')
    foods_json = request.form.get('foods_json')
    if name is None or foods_json is None:
        abort(400)  # missing arguments

    category = Category.query.get(category_id)
    if category is None:
        abort(404)

    category.name = name
    category.foods_json = foods_json
    db.session.commit()
    return {'success': True}, 200


@app.route('/api/category/delete/<int:category_id>', methods=['DELETE'])
def delete_category(category_id):

    category = Category.query.get(category_id)
    if category is None:
        abort(404)
    db.session.delete(category)
    db.session.commit()
    return {"success" : True}, 204