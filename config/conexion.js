let mysql = require("mysql");

let conexion=mysql.createConnection({
    host:"localhost",
    database:"aramedic",
    user:"root",
    password:""
});

conexion.connect(function(error){
    if (error) {
        throw error;
    } else {
        console.log("TRIKA conexion exitosa")
    }
});

module.exports=conexion;

