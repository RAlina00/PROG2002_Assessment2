var mysql = require('mysql2');

module.exports = {
  getConnection: () => {
    return mysql.createConnection({
      host: 'localhost',
      user: 'root',
      password: '123456',
      database: 'crowdfunding_db'
    })
  }
}
