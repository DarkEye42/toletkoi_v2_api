const db = require('../config/db');
exports.create = async (req,res)=>{
  const data = req.body;
  const [r] = await db.query('INSERT INTO products (owner_id,title,slug,description,category,price,stock) VALUES (?,?,?,?,?,?,?)',
    [data.owner_id,data.title,data.slug,data.description,data.category,data.price||0,data.stock||0]);
  res.json({ok:true,id:r.insertId});
};
exports.getBySlug = async (req,res)=>{
  const slug = req.params.slug;
  const [rows] = await db.query('SELECT p.*, u.username as owner FROM products p LEFT JOIN users u ON u.id=p.owner_id WHERE p.slug=? LIMIT 1',[slug]);
  if(!rows.length) return res.status(404).json({error:'Not found'});
  const product = rows[0];
  const [photos] = await db.query('SELECT path FROM product_photos WHERE product_id=? ORDER BY sort_order',[product.id]);
  product.photos = photos.map(p=>p.path);
  res.json(product);
};
exports.trackView = async (req,res)=>{
  const id = req.params.id;
  const ip = req.ip;
  await db.query('INSERT INTO product_views (product_id, ip) VALUES (?,?)',[id,ip]);
  res.json({ok:true});
};
