from app import db
from sqlalchemy.exc import SQLAlchemyError
from flask import current_app

class DatabaseManager:
    @staticmethod
    def save(obj):
        """
        Save a new object to the database with safe session management.
        """
        try:
            db.session.add(obj)
            db.session.commit()
            return obj
        except SQLAlchemyError as e:
            db.session.rollback()
            current_app.logger.error(f"Database save error: {str(e)}")
            raise e

    @staticmethod
    def update(obj):
        """
        Commit changes to an existing object.
        """
        try:
            db.session.commit()
            return obj
        except SQLAlchemyError as e:
            db.session.rollback()
            current_app.logger.error(f"Database update error: {str(e)}")
            raise e

    @staticmethod
    def delete(obj):
        """
        Delete an object from the database.
        """
        try:
            db.session.delete(obj)
            db.session.commit()
        except SQLAlchemyError as e:
            db.session.rollback()
            current_app.logger.error(f"Database delete error: {str(e)}")
            raise e

    @staticmethod
    def get_all(model):
        return model.query.all()

    @staticmethod
    def get_by_id(model, id):
        return model.query.get(id)

    @staticmethod
    def get_paginated(query, page=1, per_page=10):
        """
        Return paginated results.
        """
        return query.paginate(page=page, per_page=per_page, error_out=False)
