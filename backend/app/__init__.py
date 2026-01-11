from flask import Flask
from flask_sqlalchemy import SQLAlchemy
from flask_migrate import Migrate
from flasgger import Swagger
from config import config
from app.utils.response import error_response

# Initialize extensions
db = SQLAlchemy()
migrate = Migrate()
swagger = Swagger()

def create_app(config_name='default'):
    app = Flask(__name__)
    app.config.from_object(config[config_name])

    # Initialize extensions with app
    db.init_app(app)
    migrate.init_app(app, db)
    swagger.init_app(app)

    # Register Blueprints
    from app.routes import register_routes
    register_routes(app)

    # Error Handlers
    @app.errorhandler(404)
    def not_found_error(error):
        return error_response("Resource not found", 404)

    @app.errorhandler(500)
    def internal_error(error):
        db.session.rollback()
        return error_response("Internal server error", 500)

    @app.errorhandler(400)
    def bad_request_error(error):
        return error_response("Bad request", 400)
        
    @app.errorhandler(Exception)
    def handle_exception(e):
        # Pass through HTTP errors
        if hasattr(e, 'code'):
            return error_response(str(e), e.code)
        # Handle non-HTTP exceptions
        return error_response(str(e), 500)

    return app
