const express = require('express');
const mongoose = require('mongoose');
const bodyParser = require('body-parser');

const app = express();

const { keyValueRouter } = require('./routes/store');
const { healthRouter } = require('./routes/health');

app.use(bodyParser.json());

app.use('/health', healthRouter);
app.use('/store', keyValueRouter);



mongoose
  .connect(
    `mongodb://mongodb/${process.env.KEY_VALUE_DB}`,
    {
      auth: {
        username: process.env.KEY_VALUE_USER,
        password: process.env.KEY_VALUE_PASSWORD,
      },
      connectTimeoutMS: 500,
    }
  )
  .then(() => {
    app.listen(process.env.PORT, () => {
      console.log(`Listening on port ${process.env.PORT}`);
    });
    console.log('Connected to DB');
  })
  .catch((err) => {
    console.error('Something went wrong!');
    console.error(err);
  });