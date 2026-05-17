from flask import Flask
import redis

app = Flask(__name__)

# connect to redis
client = redis.Redis(host='redis', port=6379)

@app.route('/')
def home():
    return 'Welcome to Flask App!'

@app.route('/count')
def count():
    visits = client.incr('visits')
    return f'Visit count: {visits}'

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5000)