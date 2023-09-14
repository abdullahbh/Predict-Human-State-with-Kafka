from glob import glob
from urllib import response
from flask import Flask, request, jsonify
from matplotlib.font_manager import json_load
import json

response = ''
app = Flask(__name__)


@app.route('/detect', methods=['POST','GET'])
def displayacc():
    global response

    if(request.method == 'POST'):
        request_data = request.data
        request_data = json.loads(request_data.decode('utf-8'))
        ax = request_data['A_X']
        ay = request_data['A_Y']
        az = request_data['A_Z']
        gx = request_data['G_X']
        gy = request_data['G_Y']
        gz = request_data['G_Z']
        print(ax)
        response = f'this is {ax}'
        return ax
    else:
        return jsonify({'name': response})



if __name__ == "__main__":
    app.run()
