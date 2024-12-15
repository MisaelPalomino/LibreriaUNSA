from flask import Flask, render_template
from flask_sqlalchemy import SQLAlchemy
from sqlalchemy import text

app = Flask(__name__)
app.config['SQLALCHEMY_DATABASE_URI'] = 'mysql+pymysql://root:Elhuequito1<=3@localhost:3306/libreria'
db = SQLAlchemy(app)


@app.route('/')
def index():  # put application's code here
    categorias = db.session.execute(text('SELECT * FROM categoria'))

    res_dict = categorias.mappings().all()

    # print(res_dict)

    return render_template('index.html', categorias=res_dict)


#
@app.route('/categoria/<string:categoria_nombre>', defaults={'pagina': 1})
@app.route('/categoria/<string:categoria_nombre>/<int:pagina>')
def categoria_libros(categoria_nombre, pagina):
    data = db.session.execute(
        text('CALL ObtenerLibrosConPaginacion(:categoria, :pagina)'),
        {'categoria': categoria_nombre, 'pagina': pagina}
    )

    res_dict = data.mappings().all()
    print(res_dict)

    # while data.returns_rows:
    #     result = data.fetchall()
    #     print(result)
    #     data.nextset()

    # result = data.fetchall()  # Obtiene todos los resultados
    # libros = [dict(row) for row in result]  # Convierte cada fila en un diccionario
    #
    # print(libros)
    return render_template('libros_grilla.html', libros=res_dict)


@app.route('/libro/<string:isbn>')
def detalle_libro(isbn):
    data = db.session.execute(
        text('CALL ObtenerLibroPorISBN(:isbn)'), {'isbn': isbn})

    res_dict = data.mappings().all()
    if len(res_dict) == 0:
        return "Libro no encontrado"

    # print(res_dict)

    return render_template('libro.html', libro=res_dict[0])


if __name__ == '__main__':
    app.run()
