const express = require('express');
const cors = require('cors');
const dbcon = require('./crowdfunding_db');

// Initialize Express app
const app = express();

// Connect to the database
const connection = dbcon.getConnection();

// Enable CORS for handling cross-origin requests
app.use(cors());

// Helper function to handle database query errors
function handleQueryError(err, res) {
  console.error("Database query error:", err);
  res.status(500).json({ message: 'Internal server error' });
}

// Retrieve all active fundraisers and their categories
app.get('/fundraisers', (req, res) => {
  const queryStr = 'SELECT * FROM fundraiser f INNER JOIN category c ON f.CATEGORY_ID = c.CATEGORY_ID WHERE active = 1';

  connection.query(queryStr, (err, records) => {
    if (err) {
      return handleQueryError(err, res);
    }
    res.status(200).json(records);
  });
});

// Retrieve all categories
app.get('/categories', (req, res) => {
  const queryStr = 'SELECT * FROM category';

  connection.query(queryStr, (err, records) => {
    if (err) {
      return handleQueryError(err, res);
    }
    res.status(200).json(records);
  });
});

// Search for active fundraisers based on optional filters (organizer, city, category)
app.get('/fundraisers/search', (req, res) => {
  const { organizer, city, category } = req.query;

  let queryStr = 'SELECT * FROM fundraiser f INNER JOIN category c ON f.CATEGORY_ID = c.CATEGORY_ID WHERE active = 1';
  const params = [];

  if (organizer) {
    queryStr += ' AND f.ORGANIZER LIKE ?';
    params.push(`%${organizer}%`);
  }

  if (city) {
    queryStr += ' AND f.CITY LIKE ?';
    params.push(`%${city}%`);
  }

  if (category) {
    queryStr += ' AND c.CATEGORY_ID = ?';
    params.push(category);
  }

  connection.query(queryStr, params, (err, records) => {
    if (err) {
      return handleQueryError(err, res);
    }
    res.status(200).json(records);
  });
});

// Retrieve a fundraiser by its ID
app.get('/fundraisers/:id', (req, res) => {
  const { id } = req.params;
  const queryStr = 'SELECT * FROM fundraiser f INNER JOIN category c ON f.CATEGORY_ID = c.CATEGORY_ID WHERE FUNDRAISER_ID = ?';

  connection.query(queryStr, [id], (err, records) => {
    if (err) {
      return handleQueryError(err, res);
    }
    if (records.length === 0) {
      return res.status(404).json({ message: 'Fundraiser not found' });
    }
    res.status(200).json(records[0]);
  });
});

// Start the server and listen on port 3000
app.listen(3000, () => {
  console.log('App is running on port 3000');
});
