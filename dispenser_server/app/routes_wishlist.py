from app import app, db
from app.models import Wish_List
from flask import abort, jsonify
from flask import request


@app.route('/api/wishlist/create', methods=['POST'])
def create_category():
    id = request.form.get('id')
    name = request.form.get('name')
    foods_json = request.form.get('foods_json')
    if id is None or name is None or foods_json is None:
        abort(400)  # missing arguments

    wishlist = Wish_List(id = id, name = name, foods_json = foods_json)
    db.session.add(wishlist)
    db.session.commit()
    return {'success': True}, 201


@app.route('/api/wishlist/read')
def read_all_wishlists():
    wishlists = Wish_List.query.all()
    return jsonify([wishlist.to_json() for wishlist in categories]), 200

@app.route('/api/wishlist/read/<int:wishlist_id>', methods=['GET'])
def read_wishlist(wishlist_id):
    wishlist = Wish_List.query.get(wishlist_id)
    if wishlist is None:
        abort(404)
    else:
        return jsonify(wishlist.to_json()), 200

@app.route('/api/wishlist/update/<int:wishlist_id>', methods=['POST'])
def update_wishlist(wishlist_id):

    name = request.form.get('name')
    foods_json = request.form.get('foods_json')
    if name is None or foods_json is None:
        abort(400)  # missing arguments

    wishlist = Wish_List.query.get(wishlist_id)
    if wishlist is None:
        abort(404)

    wishlist.name = name
    wishlist.foods_json = foods_json
    db.session.commit()
    return {'success': True}, 200


@app.route('/api/wishlist/delete/<int:wishlist_id>', methods=['DELETE'])
def delete_wishlist(wishlist_id):

    wishlist = Wish_List.query.get(wishlist_id)
    if wishlist is None:
        abort(404)
    db.session.delete(wishlist)
    db.session.commit()
    return {"success" : True}, 204