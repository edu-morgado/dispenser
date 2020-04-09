import os
basedir = os.path.abspath(os.path.dirname(__file__))



class Config(object):
    DATABASE_URI=r'sqlite:///C:\Users\Eduardo\Documents\projects\dispenser\dispenser_server\dengue.db'
    SQLALCHEMY_DATABASE_URI = DATABASE_URI
    SQLALCHEMY_TRACK_MODIFICATIONS = False
