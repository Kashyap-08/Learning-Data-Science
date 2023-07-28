from flask import Flask, render_template, request, redirect, url_for

app = Flask(__name__)

@app.route('/')
def home():
    return "<h2> Hello! It's my first Flask WebPage</h2>"

@app.route('/welcome')
def welcome():
    # render_template() redirects to Welcome.html whenever we visits '/index' in browser.
    # it returns a HTML page from a 'templates' folder. So its necessary for us to create all the HTML templates in 'templates' foldere
    # The naming convention for folder should be exactly same as mention: 'templates'
    return render_template('welcome.html')



@app.route('/form', methods = ['GET', 'POST'])
def form():
    if request.method == 'GET':
        return render_template('form.html')
    else:
        maths = float(request.form['maths'])
        physics = float(request.form['physics'])
        chemistry = float(request.form['chemistry'])
        english = float(request.form['English'])

        avg = (maths + physics + chemistry + english)/4

        # Redirectiing result to another html page
        # we use render_template() to redirect to another html page

        return render_template('result.html', name='rohit', result=avg) 
    
    
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