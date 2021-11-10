const express = require('express');
const app = express();
const http = require('http').Server(app);
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

app.get("/msold", async(req,res) => {
    const data = await consultas.getMoreSold();    
    res.render('index',{ data });
})

app.get("/fsold", async(req,res) => {
    const data = await consultas.getFewerSold();    
    res.render('index',{ data });
})

app.get("/sbt", async(req,res) => {
    const data = await consultas.getSalesByTerritory();    
    //res.render('salesByTerritory',{ data });
    console.log(data);
})

app.get("/ism", async(req,res) => {
    const data = await consultas.getIncreaseSoldManager();    
    res.render('increaseSoldManager',{ data });
    //console.log(data);
})

app.get("/iss", async(req,res) => {
    const data = await consultas.getIncreaseSoldManager();    
    res.render('increaseSoldManager',{ data });
    //console.log(data);
})

const server = http.listen(3030, () => {
    console.log("Server started on port 3030");
});