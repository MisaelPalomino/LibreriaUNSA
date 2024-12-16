-- Clientes tipo individual
CALL RegistrarCliente('jose.gomez@gmail.com', 'pass1234', 'individual', 'Lima', 'Miraflores', 'Av. Larco', '455', 987654321, 'Jose', 'Gomez', 'Perez', 'Peruana', NULL, NULL, NULL);
CALL RegistrarCliente('ana.lopez@yahoo.com', 'securePass1', 'individual', 'Cusco', 'Wanchaq', 'Av. Cultura', '123', 912345678, 'Ana', 'Lopez', 'Vargas', 'Peruana', NULL, NULL, NULL);
CALL RegistrarCliente('carlos.ruiz@hotmail.com', 'carlos2023', 'individual', 'Arequipa', 'Cayma', 'Calle Los Arces', '567', 956789012, 'Carlos', 'Ruiz', 'Diaz', 'Peruana', NULL, NULL, NULL);
CALL RegistrarCliente('maria.paredes@gmail.com', 'maria#2024', 'individual', 'Lima', 'San Isidro', 'Calle Las Begonias', '789', 934567890, 'Maria', 'Paredes', 'Castillo', 'Peruana', NULL, NULL, NULL);
CALL RegistrarCliente('julio.fernandez@outlook.com', 'julio_pass', 'individual', 'Piura', 'Castilla', 'Av. Grau', '342', 978123456, 'Julio', 'Fernandez', 'Soto', 'Peruana', NULL, NULL, NULL);
CALL RegistrarCliente('luz.ramos@gmail.com', 'luz2023', 'individual', 'Junin', 'Huancayo', 'Jr. Tarapacá', '145', 987654123, 'Luz', 'Ramos', 'Rojas', 'Peruana', NULL, NULL, NULL);
CALL RegistrarCliente('arturo.silva@live.com', 'arturo456', 'individual', 'Trujillo', 'La Esperanza', 'Av. Mansiche', '908', 965432189, 'Arturo', 'Silva', 'Cruz', 'Peruana', NULL, NULL, NULL);
CALL RegistrarCliente('diana.romero@gmail.com', 'diana2023', 'individual', 'Puno', 'Juliaca', 'Calle Real', '321', 945678123, 'Diana', 'Romero', 'Torres', 'Peruana', NULL, NULL, NULL);
CALL RegistrarCliente('manuel.espinoza@gmail.com', 'manuel_pass', 'individual', 'Tacna', 'Alto de la Alianza', 'Av. Leguía', '451', 956712345, 'Manuel', 'Espinoza', 'Lopez', 'Peruana', NULL, NULL, NULL);
CALL RegistrarCliente('elena.vargas@yahoo.com', 'elena@123', 'individual', 'Ica', 'Chincha Alta', 'Jr. Ayacucho', '789', 978456321, 'Elena', 'Vargas', 'Quispe', 'Peruana', NULL, NULL, NULL);
CALL RegistrarCliente('oscar.martinez@gmail.com', 'oscar789', 'individual', 'Lima', 'Barranco', 'Calle 28 de Julio', '623', 987321654, 'Oscar', 'Martinez', 'Ramirez', 'Peruana', NULL, NULL, NULL);
CALL RegistrarCliente('veronica.mendoza@gmail.com', 'veronica2023', 'individual', 'Arequipa', 'Cerro Colorado', 'Av. Aviación', '567', 934567213, 'Veronica', 'Mendoza', 'Salas', 'Peruana', NULL, NULL, NULL);
CALL RegistrarCliente('henry.vilca@gmail.com', 'henry!pass', 'individual', 'Cusco', 'San Sebastian', 'Jr. Cusibamba', '456', 965432789, 'Henry', 'Vilca', 'Abarca', 'Peruana', NULL, NULL, NULL);
CALL RegistrarCliente('claudia.sanchez@hotmail.com', 'claudia@45', 'individual', 'Lambayeque', 'Chiclayo', 'Av. Bolognesi', '888', 945678912, 'Claudia', 'Sanchez', 'Tello', 'Peruana', NULL, NULL, NULL);
CALL RegistrarCliente('pedro.castillo@gmail.com', 'pedro2023', 'individual', 'Loreto', 'Iquitos', 'Av. La Marina', '765', 987654098, 'Pedro', 'Castillo', 'Rosales', 'Peruana', NULL, NULL, NULL);

-- Clientes tipo colegio
CALL RegistrarCliente('colegio.losandes@gmail.com', 'andes2023', 'colegio', 'Cusco', 'Cusco', 'Jr. Andahuaylas', '156', 951234567, NULL, NULL, NULL, NULL, 'Colegio Los Andes', 3, 'Privado');
CALL RegistrarCliente('colegio.trilce@gmail.com', 'trilce456', 'colegio', 'Lima', 'Santiago de Surco', 'Av. Primavera', '789', 987123654, NULL, NULL, NULL, NULL, 'Colegio Trilce', 4, 'Privado');
CALL RegistrarCliente('colegio.sanjose@gmail.com', 'sanjose!2023', 'colegio', 'Arequipa', 'Yanahuara', 'Av. Ejercito', '432', 965432187, NULL, NULL, NULL, NULL, 'Colegio San Jose', 5, 'Parroquial');
CALL RegistrarCliente('colegio.peruano@gmail.com', 'peruano123', 'colegio', 'Piura', 'Catacaos', 'Av. Piura', '123', 978564321, NULL, NULL, NULL, NULL, 'Colegio Peruano', 2, 'Nacional');
CALL RegistrarCliente('colegio.moderno@gmail.com', 'moderno2023', 'colegio', 'Lambayeque', 'Ferreñafe', 'Jr. El Olivo', '345', 945678900, NULL, NULL, NULL, NULL, 'Colegio Moderno', 3, 'Privado');
CALL RegistrarCliente('colegio.alemania@gmail.com', 'alemania!45', 'colegio', 'Cusco', 'San Jeronimo', 'Jr. Alemania', '567', 987654310, NULL, NULL, NULL, NULL, 'Colegio Alemania', 4, 'Privado');
CALL RegistrarCliente('colegio.cesarvallejo@gmail.com', 'cesar2023', 'colegio', 'La Libertad', 'Trujillo', 'Av. Mansiche', '678', 951234789, NULL, NULL, NULL, NULL, 'Colegio Cesar Vallejo', 5, 'Nacional');
CALL RegistrarCliente('colegio.inmaculada@gmail.com', 'inmaculada456', 'colegio', 'Junin', 'Huancayo', 'Jr. San Carlos', '234', 978456123, NULL, NULL, NULL, NULL, 'Colegio Inmaculada', 3, 'Parroquial');
CALL RegistrarCliente('colegio.elite@gmail.com', 'elite1234', 'colegio', 'Puno', 'Juliaca', 'Av. Elite', '567', 987654312, NULL, NULL, NULL, NULL, 'Colegio Elite', 4, 'Privado');
CALL RegistrarCliente('colegio.americas@gmail.com', 'americas2024', 'colegio', 'Loreto', 'Iquitos', 'Av. Amazonas', '789', 965432198, NULL, NULL, NULL, NULL, 'Colegio Las Americas', 3, 'Nacional');

-- Sucursales
CALL RegistrarSucursal('Sucursal Lima Centro', 'Lima', 'Lima', 'Av. Abancay', '123', NULL);
CALL RegistrarSucursal('Sucursal Arequipa Norte', 'Arequipa', 'Arequipa', 'Av. Ejercito', '456', NULL);
CALL RegistrarSucursal('Sucursal Cusco Imperial', 'Cusco', 'Cusco', 'Av. Tullumayo', '789', NULL);
CALL RegistrarSucursal('Sucursal Trujillo Sur', 'La Libertad', 'Trujillo', 'Av. Larco', '321', NULL);
CALL RegistrarSucursal('Sucursal Piura Este', 'Piura', 'Piura', 'Av. Grau', '654', NULL);

-- Gerentes (uno por sucursal registrada)
CALL RegistrarEmpleado('Luis', 'Perez', 'Lopez', 1, 'luis1234', 'gerente', NULL, NULL);
CALL RegistrarEmpleado('Maria', 'Torres', 'Castro', 2, 'maria2023', 'gerente', NULL, NULL);
CALL RegistrarEmpleado('Carlos', 'Sanchez', 'Diaz', 3, 'carlosPass', 'gerente', NULL, NULL);
CALL RegistrarEmpleado('Rosa', 'Ramos', 'Quispe', 4, 'rosa123', 'gerente', NULL, NULL);
CALL RegistrarEmpleado('Jorge', 'Vargas', 'Salas', 5, 'jorge@456', 'gerente', NULL, NULL);

-- Supervisores
CALL RegistrarEmpleado('Ana', 'Fernandez', 'Cruz', 1, 'anaSuper1', 'supervisor', NULL, NULL);
CALL RegistrarEmpleado('Oscar', 'Mendoza', 'Gomez', 2, 'oscarSuper2', 'supervisor', NULL, NULL);
CALL RegistrarEmpleado('Diana', 'Flores', 'Rojas', 3, 'dianaSuper3', 'supervisor', NULL, NULL);
CALL RegistrarEmpleado('Pedro', 'Garcia', 'Lopez', 4, 'pedroSuper4', 'supervisor', NULL, NULL);
CALL RegistrarEmpleado('Carmen', 'Rivera', 'Torres', 5, 'carmenSuper5', 'supervisor', NULL, NULL);

-- Vendedores
CALL RegistrarEmpleado('Jose', 'Cruz', 'Perez', 1, 'jose2023', 'vendedor', 5000, 6);
CALL RegistrarEmpleado('Lucia', 'Guzman', 'Castillo', 1, 'lucia123', 'vendedor', 6000, 6);
CALL RegistrarEmpleado('Miguel', 'Salas', 'Diaz', 2, 'miguel45', 'vendedor', 5500, 7);
CALL RegistrarEmpleado('Angela', 'Quispe', 'Lopez', 2, 'angelaPass', 'vendedor', 7000, 7);
CALL RegistrarEmpleado('Raul', 'Rojas', 'Sanchez', 3, 'raul@123', 'vendedor', 6500, 8);
CALL RegistrarEmpleado('Gloria', 'Lopez', 'Castro', 3, 'gloria@456', 'vendedor', 5500, 8);
CALL RegistrarEmpleado('Alberto', 'Diaz', 'Fernandez', 4, 'alberto2024', 'vendedor', 6000, 9);
CALL RegistrarEmpleado('Patricia', 'Torres', 'Gomez', 4, 'patricia123', 'vendedor', 7000, 9);
CALL RegistrarEmpleado('Victor', 'Vega', 'Cruz', 5, 'victor@789', 'vendedor', 6500, 10);
CALL RegistrarEmpleado('Cecilia', 'Morales', 'Salas', 5, 'cecilia2024', 'vendedor', 5000, 10);
CALL RegistrarEmpleado('Renzo', 'Garcia', 'Flores', 1, 'renzo2023', 'vendedor', 6000, 6);
CALL RegistrarEmpleado('Beatriz', 'Navarro', 'Lopez', 2, 'beatriz45', 'vendedor', 5500, 7);
CALL RegistrarEmpleado('Hugo', 'Campos', 'Torres', 3, 'hugo2024', 'vendedor', 7000, 8);
CALL RegistrarEmpleado('Sandra', 'Soto', 'Ramos', 4, 'sandraPass', 'vendedor', 5000, 9);
CALL RegistrarEmpleado('Marcos', 'Vasquez', 'Guzman', 5, 'marcos789', 'vendedor', 6000, 10);
