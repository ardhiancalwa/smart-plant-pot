from app import db
from sqlalchemy.exc import SQLAlchemyError
from flask import current_app

class BaseRepository:
    def __init__(self, model):
        self.model = model

    def get_all(self):
        return self.model.query.all()

    def get_by_id(self, id):
        return self.model.query.get(id)

    def save(self, obj):
        try:
            db.session.add(obj)
            db.session.commit()
            return obj
        except SQLAlchemyError as e:
            db.session.rollback()
            current_app.logger.error(f"Database save error: {str(e)}")
            raise e

    def update(self, obj):
        try:
            db.session.commit()
            return obj
        except SQLAlchemyError as e:
            db.session.rollback()
            current_app.logger.error(f"Database update error: {str(e)}")
            raise e

    def delete(self, obj):
        try:
            db.session.delete(obj)
            db.session.commit()
        except SQLAlchemyError as e:
            db.session.rollback()
            current_app.logger.error(f"Database delete error: {str(e)}")
            raise e

    def get_paginated(self, query=None, page=1, per_page=10):
        if query is None:
            query = self.model.query
        return query.paginate(page=page, per_page=per_page, error_out=False)
