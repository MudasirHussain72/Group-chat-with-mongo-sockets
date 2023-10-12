const express = require("express");
const { createServer } = require("http");
const { Server } = require("socket.io");
const mongoose = require("mongoose");

const app = express();
const httpServer = createServer(app);
const io = new Server(httpServer);

// Connect to MongoDB
mongoose.connect("mongodb+srv://mudasir:mudasir@cluster0.gcsl9qx.mongodb.net/?retryWrites=true&w=majority", {
  useNewUrlParser: true,
  useUnifiedTopology: true,
});

const messageSchema = new mongoose.Schema({
  senderName: String,
  message: String,
  type: String,
  room: String,
  senderId: String,
  time:String 
});

const Message = mongoose.model("Message", messageSchema);

app.get("/", (req, res) => {
  res.send('Welcome to the group chat server!');
});

io.on("connection", (socket) => {
  console.log(`User connected: ${socket.id}`);

  socket.on("joinRoom", (room) => {
    socket.join(room);
    console.log(`${socket.id} joined room: ${room}`);
  });

  socket.on("sendMsg", (msg) => {
    console.log("Received message:", msg);

    // Save message to MongoDB
    const message = new Message({
      senderName: msg.senderName,
      message: msg.msg,
      room: msg.room,
      senderId:msg.senderId,
      time: msg.time,
      type: msg.type
    });

    message.save().then(() => {
      io.to(msg.room).emit("sendMsg", { ...msg, type: "otherMsg" });
    });
  });

  socket.on("disconnect", () => {
    console.log(`User disconnected: ${socket.id}`);
  });
});

const PORT = process.env.PORT || 3000;
httpServer.listen(PORT, () => {
  console.log(`Server is running on port ${PORT}`);
});
