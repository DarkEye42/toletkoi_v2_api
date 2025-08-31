// Fetch and display the dynamic landing message
fetch('/api/v1/landing')
  .then(r => r.json())
  .then(data => {
    document.getElementById('landing-message').textContent = data.message || 'Welcome to ToletKoi!';
  })
  .catch(() => {
    document.getElementById('landing-message').textContent = 'Welcome to ToletKoi!';
  });

// Newsletter AJAX submit
document.getElementById('newsletter-form').addEventListener('submit', function(e) {
  e.preventDefault();
  const email = this.querySelector('input[name="email"]').value;
  fetch('/api/v1/newsletter', {
    method: 'POST',
    headers: { 'Content-Type': 'application/json' },
    body: JSON.stringify({ email })
  })
  .then(r => r.json())
  .then(data => {
    this.querySelector('.sent-message').style.display = 'block';
    this.querySelector('.error-message').style.display = 'none';
  })
  .catch(() => {
    this.querySelector('.error-message').textContent = 'Failed to subscribe.';
    this.querySelector('.error-message').style.display = 'block';
  });
});

// Contact AJAX submit
document.getElementById('contact-form').addEventListener('submit', function(e) {
  e.preventDefault();
  const form = this;
  const data = {
    name: form.querySelector('input[name="name"]').value,
    email: form.querySelector('input[name="email"]').value,
    subject: form.querySelector('input[name="subject"]').value,
    message: form.querySelector('textarea[name="message"]').value
  };
  fetch('/api/v1/contact', {
    method: 'POST',
    headers: { 'Content-Type': 'application/json' },
    body: JSON.stringify(data)
  })
  .then(r => r.json())
  .then(data => {
    form.querySelector('.sent-message').style.display = 'block';
    form.querySelector('.error-message').style.display = 'none';
  })
  .catch(() => {
    form.querySelector('.error-message').textContent = 'Failed to send message.';
    form.querySelector('.error-message').style.display = 'block';
  });
});
