import os
import signal
from flask import Flask
from buzz import generator

app = Flask(__name__)

signal.signal(signal.SIGINT, lambda s, f: os._exit(0))

@app.route("/")
def generate_buzz():
    return """
    <html>
      <head>
        <title>Calculi Buzz Generator</title>
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <link href="https://fonts.googleapis.com/css?family=Lobster"
          rel="stylesheet">
        <style>
          body {
            padding: 0;
            background: url('http://www.calculi.com/wp-content/uploads/2017/01/integ-productHero.jpg') no-repeat;
            background-size: cover;
            background-color: #58576a;
            background-blend-mode: multiply;
          }
          .buzz {
            color: #fff;
            font-family: 'Lobster', cursive;
            font-size: 48px;
          }
          div.buzz {
            max-width: 50%;
            margin: 0 auto;
            text-align: center;
            position: relative;
            top: 40%;
          }
        </style>
      </head>
      <body>
        <div class="buzz">
          <p class="buzz">""" + generator.generate_buzz() + """</p>
        </div>
      </body>
    </html>
    """

if __name__ == "__main__":
    app.run(host='0.0.0.0', port=int(os.getenv('PORT', 5000)))
