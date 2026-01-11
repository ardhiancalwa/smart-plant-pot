from flask import Blueprint, request
from app.utils.response import success_response, error_response
from app.services.pot_service import PotService

pot_bp = Blueprint('pot', __name__)
pot_service = PotService()

@pot_bp.route('/<pot_id>/readings', methods=['POST'])
def add_reading(pot_id):
    """
    Add a new sensor reading for a pot.
    ---
    tags:
      - Readings
    parameters:
      - name: pot_id
        in: path
        type: integer
        required: true
      - name: body
        in: body
        required: true
        schema:
          type: object
          properties:
            moisture:
              type: number
            temperature:
              type: number
            light_level:
              type: number
    responses:
      200:
        description: Reading added
      404:
        description: Pot not found
    """
    data = request.get_json()
    reading, error = pot_service.add_reading(pot_id, data)
    
    if error:
        return error_response(error, 404)
        
    return success_response(reading.to_dict(), "Reading added successfully")

@pot_bp.route('/<pot_id>/status', methods=['GET'])
def get_status(pot_id):
    """
    Get pot status and latest reading.
    ---
    tags:
      - Status
    parameters:
      - name: pot_id
        in: path
        type: integer
        required: true
    responses:
      200:
        description: Pot status
      404:
        description: Pot not found
    """
    data, error = pot_service.get_pot_status(pot_id)
    if error:
        return error_response(error, 404)
        
    return success_response(data)

@pot_bp.route('/<pot_id>/control', methods=['POST'])
def control_pot(pot_id):
    """
    Trigger an action (e.g., pump).
    ---
    tags:
      - Control
    parameters:
      - name: pot_id
        in: path
        type: integer
        required: true
      - name: body
        in: body
        required: true
        schema:
          type: object
          properties:
            action:
              type: string
              example: WATER
    responses:
      200:
        description: Action queued
      404:
        description: Pot not found
    """
    data = request.get_json()
    action_type = data.get('action')
    
    action, error = pot_service.create_action(pot_id, action_type)
    if error:
        return error_response(error, 404)
    
    return success_response(action.to_dict(), "Action queued")

@pot_bp.route('/<pot_id>/history', methods=['GET'])
def get_history(pot_id):
    """
    Get paginated sensor readings.
    ---
    tags:
      - History
    parameters:
      - name: pot_id
        in: path
        type: integer
        required: true
      - name: page
        in: query
        type: integer
        default: 1
      - name: per_page
        in: query
        type: integer
        default: 20
    responses:
      200:
        description: History list
    """
    page = request.args.get('page', 1, type=int)
    per_page = request.args.get('per_page', 20, type=int)
    
    pagination = pot_service.get_readings_history(pot_id, page, per_page)
    
    data = [r.to_dict() for r in pagination.items]
    meta = {
        'page': page,
        'per_page': per_page,
        'total': pagination.total,
        'pages': pagination.pages
    }
    
    return success_response({'readings': data, 'meta': meta})

@pot_bp.route('/<pot_id>/predictions', methods=['GET'])
def get_predictions(pot_id):
    """
    Get AI analysis history.
    ---
    tags:
      - AI
    """
    page = request.args.get('page', 1, type=int)
    per_page = request.args.get('per_page', 20, type=int)
    
    pagination = pot_service.get_predictions_history(pot_id, page, per_page)
    
    data = [p.to_dict() for p in pagination.items]
    return success_response(data)

@pot_bp.route('/<pot_id>/settings', methods=['POST'])
def update_settings(pot_id):
    """
    Update pot settings.
    ---
    tags:
      - Settings
    """
    data = request.get_json()
    settings, error = pot_service.update_settings(pot_id, data)
    
    if error:
        return error_response(error, 404)

    return success_response(settings.to_dict(), "Settings updated")

@pot_bp.route('/<pot_id>/diagnose', methods=['POST'])
def diagnose_plant(pot_id):
    """
    Mock AI disease prediction.
    ---
    tags:
      - AI
    """
    pred = pot_service.diagnose_pot(pot_id)
    return success_response(pred.to_dict())
