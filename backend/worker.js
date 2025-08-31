const { emailQueue } = require('./middleware/queue');
const nodemailer = require('nodemailer');
const axios = require('axios');
const env = require('./config/envConfig');

const transporter = nodemailer.createTransport({
  host: env.EMAIL_HOST,
  port: env.EMAIL_PORT,
  auth: {
    user: env.EMAIL_USER,
    pass: env.EMAIL_PASS
  }
});

emailQueue.process(async (job, done) => {
  const { to, subject, html } = job.data;
  try {
    await transporter.sendMail({ from: env.EMAIL_FROM, to, subject, html });
    done();
  } catch (err) {
    // Fallback to PHP mailer endpoint
    try {
      await axios.post('http://localhost:3000/php_mailer/send_mail.php', { to, subject, html });
      done();
    } catch (e) {
      done(new Error('Both nodemailer and PHP mailer failed'));
    }
  }
});

console.log('Worker started for email queue');
