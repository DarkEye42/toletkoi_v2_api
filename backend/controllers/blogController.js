const db = require('../config/db');
exports.create = async (req,res)=>{
  const d = req.body;
  const [r] = await db.query('INSERT INTO blogs (title,slug,content,author_id) VALUES (?,?,?,?)',[d.title,d.slug,d.content,d.author_id||1]);
  res.json({ok:true,id:r.insertId});
};
exports.getBySlug = async (req,res)=>{
  const slug = req.params.slug;
  const [rows] = await db.query('SELECT b.*, u.username as author FROM blogs b LEFT JOIN users u ON u.id=b.author_id WHERE b.slug=? LIMIT 1',[slug]);
  if(!rows.length) return res.status(404).json({error:'Not found'});
  const blog = rows[0];
  res.json(blog);
};
exports.trackView = async (req,res)=>{
  const id = req.params.id;
  const ip = req.ip;
  await db.query('INSERT INTO blog_views (blog_id, ip) VALUES (?,?)',[id,ip]);
  res.json({ok:true});
};
