import os
SQLALCHEMY_DATABASE_URI = os.environ.get('SQLALCHEMY_DATABASE_URI')
SECRET_KEY = os.environ.get('SUPERSET_SECRET_KEY', 'change-me')
SUPERSET_LOAD_EXAMPLES = os.environ.get('SUPERSET_LOAD_EXAMPLES', 'no').lower() in ('1','true','yes')
