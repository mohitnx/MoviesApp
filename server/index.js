const express = require("express");
const mongoose = require("mongoose");
const authRouter = require("./routes/auth");

const PORT = process.env.PORT || 3000;
const app = express();

app.use(express.json());
app.use(authRouter);
const DB = "mongodb+srv://mohitneupane157:4ZDxmkTSTVu4l4HD@cluster0.8aq9nzd.mongodb.net/?retryWrites=true&w=majority";
mongoose.connect(DB).then(
    ()=>{
        console.log("Databse connected");
    }
).catch((e) => {
console.log(e);
});

app.listen(PORT,"0.0.0.0", () =>{
     console.log('connected to the server');
});


//username:mohitneupane157
//pw:4ZDxmkTSTVu4l4HD