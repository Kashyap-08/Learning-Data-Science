from connection import mongoDB
from flask import Flask, render_template, request
from bs4 import BeautifulSoup
import requests

def fetch_records(url):
    '''
    :param url: Flipkart product review url

    :return: data in the from of list containing sets
    '''

    # Get all the script from url
    response = requests.get(url) 

    # parse the html content   
    soup = BeautifulSoup(response.content, 'html.parser')

    # select perticular segemetn form the html
    review_block = soup.find_all('div', {'class':'_27M-vq'})

    review_data = []

    for block in review_block:
        rating_elem = block.find('div', {'class':'_3LWZlK _1BLPMq'}).text
        review_elem = block.find('p', {'class':'_2-N8zT'}).text

        add_on_review = block.find('div', {'class':"t-ZTKy"})
        description = add_on_review.find('div').find('div').text

        name_elem = block.find('p',{'class':"_2sc7ZR _2V5EHH"}).text

        location_elem = block.find('p', {'class': '_2mcZGG'}).text
        date_elem = block.find_all('p', {'class':'_2sc7ZR'})[1].text

        dict = {
            'name' : name_elem,
            'rating' : rating_elem,
            'review' : review_elem,
            'description': description,
            'location' : location_elem,
            'date' : date_elem
        }

        review_data.append(dict)

    return review_data



application = Flask(__name__)

@application.route('/', methods=['GET','POST'])
def search():
    if request.method == 'GET':
        # redirect to the html page if GET method found
        return render_template('search.html')
    
    else:
        # Get url from the html page
        url = request.form['search']

        # call fetch_records that will extract all info form the given url
        data = fetch_records(url)

        # get hte DB connection object
        db_conn = mongoDB.get_db_conn('flipkart_review')

        # insert data into table
        mongoDB.insert(db_conn, 'iphone14', data)

        # Once the data is stored in mongoDB. Get all the data from it
        DB_records = mongoDB.get_all(db_conn, 'iphone14')

        # give the data to the result.html page to print it out
        return render_template('search.html', results=DB_records)






if __name__ == '__main__':
    application.run(debug=True)
