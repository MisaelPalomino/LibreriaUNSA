from flask import Flask, render_template
from flask_sqlalchemy import SQLAlchemy
from sqlalchemy import text

app = Flask(__name__)
app.config['SQLALCHEMY_DATABASE_URI'] = 'mysql+pymysql://root:Elhuequito1<=3@localhost:3306/libreria'
db = SQLAlchemy(app)


@app.route('/')
def hello_world():  # put application's code here
    # data = db.session.execute(text('SELECT * FROM autor'))
    data = db.session.execute(text('CALL ObtenerLibrosConPaginacion("Fiction",2)'))

    res_dict = data.mappings().all()

    print(res_dict)

    # return render_template('index.html', data=res_dict)
    return render_template('index.html')


if __name__ == '__main__':
    app.run()
