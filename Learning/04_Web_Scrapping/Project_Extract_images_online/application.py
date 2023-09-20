from flask import Flask, render_template, request
from bs4 import BeautifulSoup
import requests
import pymongo
import os
import base64

def connect():
    try: 
        client = pymongo.MongoClient("mongodb+srv://Demo:Demo@cluster01.n7r3noi.mongodb.net/?retryWrites=true&w=majority")
        db = client.test
        print(db)
        print("Connection Established Successfully")
        db = client['Store_Image']
        return db
    except:
        print("Error while connecting to mongoDB")

def inset_into_mongoDB(db, table_name, data):
    try:
        coll = db[table_name]
        coll.insert_many(data)
        print('Table name: ', table_name)
        print('Data insertion completed.')
    except:
        print("Error While inserting data into MongoDB")


def fetch_result(keyword):
    # save_dir = "image/"
    # if not os.path.exists(save_dir):
    #     os.makedirs(save_dir)

    url = f"https://www.google.com/search?q={keyword}&tbm=isch&ved=2ahUKEwiAsJebhbiAAxVE3DgGHcNrBZYQ2-cCegQIABAA&oq=elon+m&gs_lcp=CgNpbWcQARgAMgoIABCKBRCxAxBDMggIABCABBCxAzIKCAAQigUQsQMQQzIKCAAQigUQsQMQQzIICAAQgAQQsQMyCAgAEIAEELEDMggIABCABBCxAzIICAAQgAQQsQMyCAgAEIAEELEDMggIABCABBCxAzoECCMQJzoECAAQAzoLCAAQgAQQsQMQgwE6BQgAEIAEOggIABCxAxCDAToHCAAQigUQQ1DhCli3FWCYIWgAcAB4AIAB1wGIAZAKkgEFMC42LjGYAQCgAQGqAQtnd3Mtd2l6LWltZ8ABAQ&sclient=img&ei=bC_HZIDKMMS44-EPw9eVsAk&bih=739&biw=1536&rlz=1C1YTUH_enIN1061IN1061"
    
    # Get all content from html
    response = requests.get(url)

    # Parse image
    parse = BeautifulSoup(response.content, 'html.parser')

    # Filter on 'img' tags
    image_tags = parse.find_all('img')
    del image_tags[0]

    # List to insert into mongodb
    images_ls = []

    # Get all the filed where link in 'src'tag
    for i in image_tags:
        image_url = i['src']

        #Extract Byte image
        byte_image = requests.get(image_url).content

        # with open(os.path.join(save_dir, f"{keyword}_{image_tags.index(i)}.jpg"), "wb") as f:
        #     f.write(byte_image)

        # Store all the images
        file_name = f"{keyword}_{image_tags.index(i)}"
        dict = {
            'Img_name': file_name,
            'Image': byte_image
        }

        images_ls.append(dict)
    
    return images_ls

def get_DB_data(db, keyword):
    try:
        coll = db[keyword]
        records = coll.find()
        data_dict = []
        for i in records:
            dict = {
                'Img_name': i['Img_name'],
                'Image': i['Image']
            }

            data_dict.append(dict)

        return data_dict

    except:
        print("Error While fetching data into MongoDB")


def delete_table(db, table_name):
    try:
        coll = db[table_name]
        coll.drop

application = Flask(__name__)

# In this updated code, we defined a custom b64encode filter function that uses the 
# base64.b64encode() function to encode the binary data as base64 and decode it to a 
# UTF-8 string. We then added this custom filter to the Jinja2 environment in your Flask application, 
# making it available to be used in the templates.
# =================================================
# Define the custom b64encode filter
def b64encode(data):
    return base64.b64encode(data).decode('utf-8')

# Add the custom filter to the Jinja2 environment
application.jinja_env.filters['b64encode'] = b64encode

@application.route('/', methods=['POST','GET'])
def search():
    if request.method == 'GET':
        return render_template('search.html')
    else:
        keyword = request.form['search']

        # Get data from browser
        images_ls = fetch_result(keyword)

        # Connect to N=mongoDB
        db = connect()

        # Insert data into mongoDB
        inset_into_mongoDB(db, keyword, data = images_ls)

        # Get data from mongoDB
        print("Get records form MongoDB")
        data = get_DB_data(db, keyword)

        return render_template('result.html', data = data)        

if __name__ == '__main__':
    application.run(debug=True)

        