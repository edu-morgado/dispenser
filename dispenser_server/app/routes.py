from app import app, db
from app.models import *
from flask import make_response, abort, jsonify



@app.errorhandler(400)
def forbidden(error):
    return make_response(jsonify({'error': 'Forbidden'}), 400)


@app.errorhandler(401)
def method_not_allowed(error):
    return make_response(jsonify({'error': 'Unauthorized'}), 401)


@app.errorhandler(403)
def method_not_allowed(error):
    return make_response(jsonify({'error': 'Forbidden'}), 403)


@app.errorhandler(404)
def not_found(error):
    return make_response(jsonify({'error': 'Not found'}), 404)


@app.errorhandler(405)
def method_not_allowed(error):
    return make_response(jsonify({'error': 'Method not allowed'}), 405)
