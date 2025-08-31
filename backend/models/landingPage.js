const fs = require('fs');
const path = require('path');

const filePath = path.join(__dirname, '../public/landing_message.json');

const LandingPage = {
  getMessage() {
    if (!fs.existsSync(filePath)) return 'Welcome to ToletKoi!';
    try {
      const data = fs.readFileSync(filePath, 'utf8');
      const obj = JSON.parse(data);
      return obj.message || 'Welcome to ToletKoi!';
    } catch {
      return 'Welcome to ToletKoi!';
    }
  },
  setMessage(message) {
    fs.writeFileSync(filePath, JSON.stringify({ message }, null, 2), 'utf8');
  }
};

module.exports = LandingPage;
