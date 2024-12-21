from flask import Flask, request, jsonify

app = Flask(__name__)

# Mock database
users = [
    {
        "userIdentifier": "9618285561",
        "otp": "9999",
        "name": "Veer",
        "userType": "ADMIN",
        "userAccess": ["READ", "WRITE", "APPROVE"]
    },
    {
        "userIdentifier": "9945126598",
        "otp": "1234",
        "name": "John",
        "userType": "VENDOR",
        "userAccess": ["READ"],
        "businessName": "John's Supplies",
        "gstNumber": "GSTIN1234567890",
        "addressInfo": {
            "address1": "123 Vendor Lane",
            "city": "Metropolis",
            "state": "NY",
            "pincode": "10101"
        }
    }
]

# Middleware for validating headers
def validate_headers(required_headers):
    # Normalize headers to lowercase for validation
    incoming_headers = {k.lower(): v for k, v in request.headers.items()}
    for header in required_headers:
        print(f"Checking header: {header}, Found: {incoming_headers.get(header.lower())}")
        if header.lower() not in incoming_headers:
            return False, f"Missing header: {header}"
    return True, None


# Endpoints
@app.route('/milestone-api/services/v1/login', methods=['POST'])
def login():
    required_headers = [ 'businessIdentifier']
    is_valid, error = validate_headers(required_headers)
    if not is_valid:
        return jsonify({"error": error}), 400

    data = request.json
    user = next((u for u in users if u["userIdentifier"] == data["userIdentifier"] and u["otp"] == data["otp"]), None)
    if user:
        return jsonify(user), 200
    else:
        return jsonify({"error": "Invalid credentials"}), 401

@app.route('/milestone-api/services/v1/user/<string:userIdentifier>', methods=['GET'])
def get_user(userIdentifier):
    required_headers = ['businessIdentifier']
    is_valid, error = validate_headers(required_headers)
    if not is_valid:
        return jsonify({"error": error}), 400

    user = next((u for u in users if u["userIdentifier"] == userIdentifier), None)
    if user:
        return jsonify(user), 200
    else:
        return jsonify({"error": "User not found"}), 404

@app.route('/milestone-api/services/v1/user', methods=['POST'])
def create_user():
    required_headers = [ 'businessIdentifier']
    is_valid, error = validate_headers(required_headers)
    if not is_valid:
        return jsonify({"error": error}), 400

    data = request.json
    if not data:
        return jsonify({"error": "Invalid request body"}), 400

    new_user = {
        "userIdentifier": data["userIdentifier"],
        "otp": data["otp"],
        "name": data["name"],
        "userType": data["userType"],
        "userAccess": data.get("userAccess", ["READ"]),
    }

    if data["userType"] == "VENDOR":
        vendor_details = {
            "businessName": data["businessName"],
            "gstNumber": data["gstNumber"],
            "addressInfo": data["addressInfo"]
        }
        new_user.update(vendor_details)

    users.append(new_user)
    return jsonify({"message": "User created successfully", "user": new_user}), 201

if __name__ == '__main__':
    app.run(debug=True, port=5000, host='0.0.0.0')
