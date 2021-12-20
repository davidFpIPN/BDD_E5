const rest = new (require('rest-mssql-nodejs'))({
    user: 'DavidPruebas',
    password: 'DavidPruebas',
    server: 'DESKTOP-A8FTTBG',
    database: 'America' 
});

const getMayorVentas = async()=>{
    const procedureName = 'territorio_mayormoney';
    const execProc = await rest.executeStoredProcedure(procedureName);
    //console.log(execProc);
    return execProc.data[0];
}

const getMayorVentasAp = async()=>{
    const procedureName = 'territorio_mayor_aniopast';
    const execProc = await rest.executeStoredProcedure(procedureName);
    return execProc.data[0];
}

const getTotalXTarjeta = async()=>{
    const procedureName = 'PersonasXTarjeta';
    const execProc = await rest.executeStoredProcedure(procedureName);
    return execProc.data[0];
}

const getConsumidoresPT = async()=>{
    const procedureName = 'customer_territory';
    const execProc = await rest.executeStoredProcedure(procedureName);
    return execProc.data[0];
}


const getBonosPR = async()=>{
    const procedureName = 'regional_bonos';
    const execProc = await rest.executeStoredProcedure(procedureName);
    return execProc.data[0];
}


const getTiendasEnc = async()=>{
    const procedureName = 'TiendasXEncargado';
    const execProc = await rest.executeStoredProcedure(procedureName, null, {
        id_tienda: 275
    });
    return execProc.data[0];
}

const getNomEnc = async()=>{
    const procedureName = 'name_encargados';
    const execProc = await rest.executeStoredProcedure(procedureName);
    return execProc.data[0];
}

const getUsersPromo = async(offset)=>{
    const procedureName = 'usuarios_promocion';
    const execProc = await rest.executeStoredProcedure(procedureName, null, {
        offs: offset
    });
    return execProc.data[0];
}

const actNomTi = async()=>{
    const procedureName = 'cambiar_nombre';
    const execProc = await rest.executeStoredProcedure(procedureName);
    //return execProc.data[0];
    /*console.log(execProc.data[0]);
    console.log(execProc.data[1]);*/
}

const actBMV = async()=>{
    const procedureName = 'Bonos_MasVentas';
    const execProc = await rest.executeStoredProcedure(procedureName);
    //return execProc.data[0];
    /*console.log(execProc.data[0]);
    console.log(execProc.data[1]);*/
}

const actBMenV = async()=>{
    const procedureName = 'Bonos_MenosVentas';
    const execProc = await rest.executeStoredProcedure(procedureName);
    //return execProc.data[0];
    /*console.log(execProc.data[0]);
    console.log(execProc.data[1]);*/
}

const deleteAccount = async(account )=>{
    const procedureName = 'EliminarCliente';
    const execProc = await rest.executeStoredProcedure(procedureName, null, {
        NumeroCuenta: account
    });
}
// ---------------------------------


module.exports = {
    "getMayorVentas": getMayorVentas,
    "getMayorVentasAp":getMayorVentasAp,
    "getTotalXTarjeta":getTotalXTarjeta,
    "getConsumidoresPT":getConsumidoresPT,
    "getTiendasEnc":getTiendasEnc,
    "getNomEnc":getNomEnc,
    "getUsersPromo":getUsersPromo,
    "getBonosPR":getBonosPR,
    "actNomTi":actNomTi,
    "actBMV":actBMV,
    "actBMenV":actBMenV,
    "deleteAccount":deleteAccount,    
}