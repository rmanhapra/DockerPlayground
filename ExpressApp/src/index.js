const express = require('express');
const bodyParser = require('body-parser');

const app = express();
const port = 3000;
const users = [];


app.use(bodyParser.json());
app.get('/',(req,res)=>{
    console.log("recieved request");
    res.send("Hello There!!!!!")
});

app.get('/users', (req,res)=>{
    return res.json({"users":users});
});

app.post('/users',(req,res)=>{
    const newUserId = req.body.userId;
    
    if(!newUserId){
        return res.status(400).send("Missing User Id");
    }

    if(users.includes(newUserId) > 1){
        return res.status(400).send("User Id already exisits");   
    }

    users.push(newUserId);
    return res.status(201).send("user registerd");
});

console.log(port);
app.listen(port,()=>{
    console.log(`I am listening on port ${port}`);
});

