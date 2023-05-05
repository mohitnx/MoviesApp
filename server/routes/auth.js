const express = require("express");
const bcryptjs = require("bcryptjs");
const jwt = require("jsonwebtoken");
const User = require("../models/user");
const authRouter = express.Router(); 




//signup route
authRouter.post("/api/signup",async(req, res)=>{
    try{
        const{name, email, password} = req.body;
const existingUser = await User.findOne({email});
if(existingUser)
{
    //wihtout expicictly defining status, we send 200 on error which is status OK
    // when a usr is trying to enter exisint email to create new account
    //that would be bad request which is 400
    return res.status(400).json({msg: "User with the same email already exisits"});
}

const hashedPassword = await bcryptjs.hash(password, 8);

let user = new User({
    name, 
    email,
    password: hashedPassword,
});

user = await user.save(); 
res.json(user);
    }catch(e){
        //server error
res.status(500).json({error: e.message});
    }
});




//sigin route

authRouter.post("/api/signin", async(req, res)=> {
    try{

        const {email, password} = req.body;
        const user = await User.findOne ({email});
        if (!user)
        {
            return res.status(400).json({msg: "User with this email doesnt exist!"});

        }
        //if email exists then match the password of that emall with the password from client side

        const isMatch = await bcryptjs.compare(password, user.password);
        if (!isMatch){
            return res.status(400).json({msg: "Incorrect password"});

        }
//if password also matches then generate a token for that user
//to generate token we need teh user's id which is genereated by mongodb automatially for each user
        const token = jwt.sign({id: user._id}, "passwordKey");
        //...user._doc will send back only the necessary data like emal , passowrd, etc
        //just passing user here will send a lot of other unncessary data as well...try sending user and see the output to confirm
        //or just believeee

        //so bascailly two things are sent here
        //in signup only user was sent
        //here token is sent and ... helps to add user._doc items to the token item
        //and both are sent together

        res.json({token, ...user._doc});
    } catch (e)
    {
        res.status(500).json({error: e.message});
    }
});


module.exports = authRouter;