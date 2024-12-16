from flask import Flask, render_template, request, flash, redirect, url_for, session
from flask_sqlalchemy import SQLAlchemy
from sqlalchemy import text
from werkzeug.security import check_password_hash

app = Flask(__name__)
app.config['SQLALCHEMY_DATABASE_URI'] = 'mysql+pymysql://root:Elhuequito1<=3@localhost:3306/libreria'
app.secret_key = 'Elhuequito1<=3'
db = SQLAlchemy(app)


@app.route('/')
def index():  # put application's code here
    categorias = db.session.execute(text('CALL ObtenerCategorias()'))
    res_dict = categorias.mappings().all()
    return render_template('index.html', categorias=res_dict)


@app.route('/categoria/<string:categoria_nombre>', defaults={'pagina': 1})
@app.route('/categoria/<string:categoria_nombre>/<int:pagina>')
def categoria_libros(categoria_nombre, pagina):
    num_libros_pagina = 20
    num_libros = db.session.execute(text('CALL ContarCategoria(:categoria)'),
                                    {'categoria': categoria_nombre}).scalar()
    data = db.session.execute(
        text('CALL ObtenerLibrosConPaginacion(:categoria, :limite, :pagina)'),
        {'categoria': categoria_nombre, 'limite': num_libros_pagina, 'pagina': pagina}
    )

    res_dict = data.mappings().all()
    return render_template('libros_grilla.html', libros=res_dict, num_libros_pagina=num_libros_pagina,
                           num_libros=num_libros, categoria_nombre=categoria_nombre, pagina=pagina)


@app.route('/libro/<string:isbn>')
def detalle_libro(isbn):
    data = db.session.execute(
        text('CALL ObtenerLibroPorISBN(:isbn)'), {'isbn': isbn})

    res_dict = data.mappings().all()
    if len(res_dict) == 0:
        return "Libro no encontrado"

    return render_template('libro.html', libro=res_dict[0])


@app.route('/registro', methods=['GET', 'POST'])
def registro():
    if request.method == 'POST':

        email = request.form['email']
        password = request.form['password']
        tipo_cliente = request.form['tipo_cliente']

        nombres = apellido1 = apellido2 = nacionalidad = None
        nombre_colegio = niveles_educativos = tipo_colegio = None
        departamento = request.form.get('departamento')
        ciudad = request.form.get('ciudad')
        calle = request.form.get('calle')
        numero = request.form.get('numero')
        telefono = request.form.get('telefono')

        if tipo_cliente == 'individual':
            nombres = request.form.get('nombres')
            apellido1 = request.form.get('apellido1')
            apellido2 = request.form.get('apellido2')
            nacionalidad = request.form.get('nacionalidad')

        elif tipo_cliente == 'colegio':
            nombre_colegio = request.form.get('nombre_colegio')
            niveles_educativos = request.form.get('niveles_educativos')
            tipo_colegio = request.form.get('tipo_colegio')

        try:
            db.session.execute(text('''CALL RegistrarCliente(
                :email, :password, :tipo_cliente, :departamento, :ciudad, :calle, :numero, :telefono,
                :nombres, :apellido1, :apellido2, :nacionalidad, :nombre_colegio, :niveles_educativos, :tipo_colegio
            )'''), {
                'email': email,
                'password': password,
                'tipo_cliente': tipo_cliente,
                'departamento': departamento,
                'ciudad': ciudad,
                'calle': calle,
                'numero': numero,
                'telefono': telefono,
                'nombres': nombres,
                'apellido1': apellido1,
                'apellido2': apellido2,
                'nacionalidad': nacionalidad,
                'nombre_colegio': nombre_colegio,
                'niveles_educativos': niveles_educativos,
                'tipo_colegio': tipo_colegio
            })
            db.session.commit()
            flash('Registro exitoso. Ahora puedes iniciar sesión.', 'success')
            return redirect(url_for('login'))
        except Exception as e:
            db.session.rollback()
            flash(f'Error en el registro: {str(e)}', 'danger')

    return render_template('registro.html')


@app.route('/login', methods=['GET', 'POST'])
def login():
    if request.method == 'POST':
        email = request.form['email']
        password = request.form['password']

        try:
            result = db.session.execute(
                text('CALL LoginCliente(:email, :password)'), {'email': email, 'password': password})
            cliente = result.mappings().first()

            if cliente and check_password_hash(cliente['password'], password):
                flash('Inicio de sesión exitoso.', 'success')
                return redirect(url_for('index'))
            else:
                print('Credenciales invalidas')
                flash('Credenciales inválidas. Inténtalo nuevamente.', 'danger')
        except Exception as e:
            flash(f'Error en el inicio de sesión: {str(e)}', 'danger')

    return render_template('login.html')


# Ruta para el login
@app.route('/login_empleado', methods=['GET', 'POST'])
def login_empleado():
    if request.method == 'GET':
        return render_template('login_empleado.html')
    if request.method == 'POST':
        id = request.form['id']
        password = request.form['password']

    data = db.session.execute(
        text('CALL ObtenerCredencialesEmpleado(:id)'), {'id': id})
    empleado = data.mappings().first()
    # res_dict = data.mappings().all()

    # Verificar credenciales

    if empleado and empleado['password'] == password:
        # Determinar el rol
        data = db.session.execute(
            text('CALL ObtenerTipoEmpleado(:id)'), {'id': id})
        tipo = data.mappings().first()

        if tipo:
            session['id'] = empleado['id']
            session['role'] = tipo['ROL']
            return redirect(url_for('dashboard_empleado'))
            # # Redirigir según el rol
            # if tipo['ROL'] == 'vendedor':
            #     return "Vendedor"
            #     # return redirect(url_for('vendedor_dashboard'))
            # elif tipo['ROL'] == 'supervisor':
            #     return "Supervisor"
            #     # return redirect(url_for('supervisor_dashboard'))
            # elif tipo['ROL'] == 'gerente':
            #     return "Gerente"
            # return redirect(url_for('gerente_dashboard'))
    else:
        print("Credenciales inválidas")
        return render_template('login_empleado.html')


@app.route('/dashboard_empleado')
@app.route('/dashboard_empleado')
def dashboard_empleado():
    if session['role'] in ['vendedor', 'supervisor', 'gerente']:
        data = db.session.execute(text('CALL ObtenerEmpleado(:id)'), {'id': session['id']})
        datos_generales = data.mappings().first()

        if session['role'] == 'gerente':
            data = db.session.execute(text('CALL ObtenerSupervisoresDisponibles()'))
            supervisores_disponibles = data.mappings().all()

            data = db.session.execute(text('CALL ObtenerSucursalesPorGerente(:id)'), {'id': session['id']})
            datos_sucursales = data.mappings().all()

            data = db.session.execute(text('CALL ObtenerSupervisoresPorSucursal(:id)'), {'id': session['id']})
            supervisores = data.mappings().all()  

            datos_especificos = {
                'sucursales': datos_sucursales,
                'supervisores': supervisores,
                'supervisores_disponibles': supervisores_disponibles  
            }

        
        return render_template('dashboard_empleado.html', 
                               datos_generales=datos_generales,
                               datos_especificos=datos_especificos)
@app.route('/asignar_supervisor', methods=['POST'])
def asignar_supervisor():
    supervisor_id = request.form['supervisor_id']
    sucursal_id = request.form['sucursal_id']
    if supervisor_id and sucursal_id:
        pass
    else:
        flash("Error: Debes seleccionar un supervisor y sucursal", "danger")
        return redirect(url_for('dashboard_empleado'))


if __name__ == '__main__':
    app.run(debug=True)
    app.run()
