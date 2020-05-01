from app import app, db
from app.models import Home
from flask import abort, jsonify
from flask import request




@app.route('/api/home/create', methods=['POST'])
def create_home():
    name = request.form.get('name')
    if  name is None:
        abort(400)  # missing arguments

    home = Home(name = name)
    db.session.add(home)
    db.session.commit()
    return {'success': True, "id" : home.id}, 201


@app.route('/api/home/read')
def read_all_homes():
    homes = Home.query.with_for_update(read=True).all()
    return jsonify([home.to_json() for home in homes]), 200

@app.route('/api/home/read/<int:home_id>', methods=['GET'])
def read_home(home_id):
    home = Home.query.with_for_update(read=True).get(home_id)
    if home is None:
        abort(404)
    else:
        return jsonify(home.to_json()), 200

@app.route('/api/home/update/<int:home_id>', methods=['POST'])
def update_home(home_id):

    name = request.form.get('name')
    if name is None:
        abort(400)  # missing arguments

    home = Home.query.with_for_update().get(home_id)
    if home is None:
        abort(404)

    home.name = name
    db.session.commit()
    return {'success': True}, 200

@app.route('/api/home/delete/<int:home_id>', methods=['DELETE'])
def delete_home(home_id):

    home = Home.query.with_for_update().get(home_id)
    if home is None:
        abort(404)
    db.session.delete(home)
    db.session.commit()
    return {"success" : True}, 204