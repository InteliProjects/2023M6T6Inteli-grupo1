from flask import Flask, request, jsonify
import modelo
import asyncio
from flask_cors import CORS, cross_origin
app = Flask(__name__)
cors = CORS(app)

@app.route('/melhorfornecedor', methods=["POST"])
@cross_origin()
def melhorFornecedor():
    cie = request.json.get('cie')
    response = asyncio.run(modelo.encontrar_melhor_fornecedor(cie))
    return response, 200

if __name__ == '__main__':
    app.run(debug=True)
