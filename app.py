from flask import Flask, render_template, request, redirect
import json, os

app = Flask(__name__)
DB = "todos.json"

def load(): return json.load(open(DB)) if os.path.exists(DB) else []
def save(t): json.dump(t, open(DB, "w"))

@app.route("/")
def home():
    return render_template("index.html", todos=load())

@app.route("/add", methods=["POST"])
def add():
    t = load(); t.append({"id": len(t)+1, "text": request.form["text"], "done": False}); save(t); return redirect("/")

@app.route("/toggle/<int:id>")
def toggle(id):
    t = load(); next(x for x in t if x["id"]==id)["done"] ^= True; save(t); return redirect("/")

@app.route("/delete/<int:id>")
def delete(id):
    t = load(); save([x for x in t if x["id"]!=id]); return redirect("/")

if __name__ == "__main__":
    app.run(host="0.0.0.0", port=5000, debug=True)