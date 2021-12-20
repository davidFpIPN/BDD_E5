const express = require('express');
const app = express();
const http = require('http');
const server = http.createServer(app);

const path = require('path');
const exphbs = require('express-handlebars');
const consultas = require('./helpers/consultas');

app.set('views', path.join(__dirname, 'views'));
app.engine('.hbs', exphbs({
    defaultLayout: 'main',
    layoutsDir: path.join(app.get('views'), 'layouts'),
    partialsDir: path.join(app.get('views'), 'partials'),
    extname: '.hbs',
}));
app.set('view engine', 'hbs');

/* RUTAS */

let messages='';

app.get("/", (req, res)=>{
    res.render('index');
})

app.get("/mvt", async(req, res) => {
    const data = await consultas.getMayorVentas();
    //console.log(data);
    res.render('cons1',{ data })
})

app.get("/mvap", async(req, res) => {
    const data = await consultas.getMayorVentasAp();
    res.render('cons2',{ data })
})

app.get("/bpr", async(req, res) => {
    const data = await consultas.getBonosPR();
    res.render('cons3',{ data })
})

app.get("/totT", async(req, res) => {
    const data = await consultas.getTotalXTarjeta();
    res.render('cons4',{ data })
})

app.get("/cpt", async(req, res) => {
    const data = await consultas.getConsumidoresPT();
    res.render('cons5',{ data })
})

app.get("/act", (req, res) => {
    res.render('cons689',{ messages })
    messages='';
})

app.get("/ant", async(req, res) => {
    await consultas.actNomTi();
    messages='Se actualizó el nombre de la tienda Tire Company';
    res.redirect('/act');
})

app.get("/abmv", async(req, res) => {
    await consultas.actBMV();
    messages='Se actualizó el bono a los encargados que más ventas tienen este año';
    res.redirect('/act');
})

app.get("/absv", async(req, res) => {
    await consultas.actBMenV();
    messages='Se actualizó el bono a los encargados que no tuvieron ventas el año pasado';
    res.redirect('/act');
})

app.get("/upe", async(req, res) => {
    const page = parseInt(req.query.page);
    const newPage = (page * 100) - 100;
    const data = await consultas.getUsersPromo(newPage);
    res.render('cons7',{ data })
})

app.get("/tpe", async(req, res) => {
    const data = await consultas.getTiendasEnc();
    res.render('cons10',{ data })
})


app.get("/ner", async(req, res) => {
    const data = await consultas.getNomEnc();
    res.render('cons11',{ data })
})

app.get("/dela", (req, res) => {
    res.render('cons12', {messages});
    messages='';
})

app.get("/ednc", async(req, res) => {
    const acc = req.query.ncuenta;
    const data = await consultas.deleteAccount(acc);
    console.log(data);
    messages=`Se eliminó al cliente con número de cuenta ${acc}`;
    res.redirect('/dela');
})
//

server.listen(3030, () => {
    console.log("Server started on port 3030");
});