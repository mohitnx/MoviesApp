const mongoose  = require("mongoose");

const userSchema = mongoose.Schema({
    name: {
    required: true,
    type: String,
    trim: true,
    },
    email: {
        required: true,
        type: String,
        trim: true,
        validate: {
            validator: (value) => {
                const re = /^(([^<>()[\]\\.,;:\s@"]+(\.[^<>()[\]\\.,;:\s@"]+)*)|.(".+"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/;
            return value.match(re);
            },
            //error msg
            message: "Enter a valid email",
        },
    },
    password: {
        required: true,
        type: String,
        trim: true,
    }
});


//changing teh schema to a model
//schmea: blueprint for defining the structure of mongodb document
//model:  a constuctor that represents a colleciton in teh mognnodb databse 
//In other words, a schema defines the structure of the data that will be stored in a MongoDB document,
// while a model is a higher-level abstraction that provides a way to interact with the data in the database.


//name of collction is User, and teh schema it user is userSchema
const User = mongoose.model("User", userSchema);

module.exports  = User;