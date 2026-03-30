from flask import Flask, render_template, jsonify

app = Flask(__name__)

products = [
    {"id": 1, "name": "Wireless Headphones", "price": "₹1,999", "category": "Electronics"},
    {"id": 2, "name": "Running Shoes",        "price": "₹2,499", "category": "Footwear"},
    {"id": 3, "name": "Coffee Mug",           "price": "₹299",   "category": "Kitchen"},
    {"id": 4, "name": "Laptop Stand",         "price": "₹899",   "category": "Electronics"},
    {"id": 5, "name": "Yoga Mat",             "price": "₹599",   "category": "Fitness"},
]

@app.route("/")
def index():
    return render_template("index.html", products=products)

@app.route("/api/products")
def api_products():
    return jsonify(products)

@app.route("/health")
def health():
    return jsonify({"status": "ok", "app": "ShopEasy"})

if __name__ == "__main__":
    app.run(host="0.0.0.0", port=5000)