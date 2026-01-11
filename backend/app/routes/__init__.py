from .pot_routes import pot_bp

def register_routes(app):
    app.register_blueprint(pot_bp, url_prefix='/api/pot')
