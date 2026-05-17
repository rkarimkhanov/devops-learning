from flask import Flask
import redis
import os

app = Flask(__name__)

### connect to redis 
### this is hard coded version
#client = redis.Redis(host='redis', port=6379)


redis_host = os.environ.get('REDIS_HOST', 'redis')
redis_port = os.environ.get('REDIS_PORT', 6379)

client = redis.Redis(host=redis_host, port=int(redis_port))

@app.route('/')
def home():
    return 'Welcome to Flask App!'

@app.route('/count')
def count():
    visits = client.incr('visits')
    return f'Visit count: {visits}'

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5000)