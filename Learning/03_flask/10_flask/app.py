# Create Simple Flask Application
from flask import Flask, render_template, request, redirect, url_for

app = Flask(__name__) # works as a entry point.

@app.route('/')
def home():
    return '<h2>Hello World!</h2>'

@app.route('/welcome')
def welcome():
    return 'Welcome to flask Tutorial'

@app.route('/index')
def index():
    return render_template('index.html')
    # render_template() redirects to index.html whenever we visits '/index'
    # it returns a HTML page from a 'templates' folder. So its necessary for us to create all the HTML templates in 'templates' foldere
    # The naming convention for folder should be exactly same as mention: 'templates'

@app.route('/passed/<int:score>/<name>')
def passed(score, name):
    return f"{name} passed with average score of {score}"

@app.route('/failed/<int:score>')
def failed(score, name):
    return f"{name} failed with average score of {score}"

@app.route('/calculate', methods=['POST','GET'])
def calculate():
    if request.method == 'GET':
        return render_template('calculate.html')
    else:
        maths = float(request.form['maths'])
        physics = float(request.form['physics'])
        chemistry = float(request.form['chemistry'])
        english = float(request.form['English'])

        avg = (maths + physics + chemistry + english)/4

        # Redirectiing result to another html page
        # we use render_template() to redirect to another html page
        # return render_template('result.html', result=avg) 

        # Redirecting to same html page
        return render_template('result.html', result=avg) # we can also print result to same page
    
        # Redirect to above methods
        # we use redirect(url_for) to redirect request to same python file.
        res = ''
        if avg >= 50:
            res = 'passed'
        else:
            res = 'failed'
        
        # return redirect(url_for(res, score=avg, name='rohit'))


if __name__ == '__main__':
    # 'debug=True' will help in debug, but never use this in production
    # It will debug and detect the new changes in real time. without rerunning application.
    app.run(debug=True) 