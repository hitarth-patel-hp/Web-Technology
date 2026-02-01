let quotes = [];
let autoTimer = null;

function q(selector) { return document.querySelector(selector); }

function loadQuotes() {
  return fetch('quotes.json').then(r => r.json()).then(data => {
    quotes = data;
    populateCategories();
  });
}

function populateCategories() {
  const cats = ['all', ...new Set(quotes.map(q => q.category))];
  const sel = q('#category');
  sel.innerHTML = cats.map(c => `<option value="${c}">${c}</option>`).join('');
}

function randomFrom(arr){ return arr[Math.floor(Math.random()*arr.length)]; }

function loadQuote() {
  const cat = q('#category').value;
  let pool = quotes;
  if (cat !== 'all') pool = quotes.filter(x => x.category === cat);
  if (!pool.length) { q('#quote').innerText = 'No quotes for this category.'; q('#author').innerText=''; return; }
  const pick = randomFrom(pool);
  q('#quote').innerText = pick.text;
  q('#author').innerText = pick.author ? `— ${pick.author}` : '';
}

function saveFavorite(){
  const text = q('#quote').innerText;
  const author = q('#author').innerText;
  if (!text) return;
  const favs = JSON.parse(localStorage.getItem('favs')||'[]');
  favs.push({text,author});
  localStorage.setItem('favs', JSON.stringify(favs));
  renderFavorites();
}

function renderFavorites(){
  const list = q('#favorites');
  const favs = JSON.parse(localStorage.getItem('favs')||'[]');
  if (!favs.length) { list.innerHTML = '<li>No favorites yet.</li>'; return; }
  list.innerHTML = favs.map((f,i)=>`<li><span class="ftext">${f.text}</span><span class="fauthor">${f.author}</span> <button data-i="${i}" class="remove">Remove</button></li>`).join('');
  list.querySelectorAll('.remove').forEach(btn=>btn.addEventListener('click', e=>{
    const i = +e.target.dataset.i; favs.splice(i,1); localStorage.setItem('favs', JSON.stringify(favs)); renderFavorites();
  }));
}

function shareQuote(){
  const text = q('#quote').innerText;
  const author = q('#author').innerText;
  if (!text) return;
  const toCopy = `${text} ${author}`;
  navigator.clipboard?.writeText(toCopy).then(()=> alert('Copied to clipboard')); 
}

function startAuto(){
  if (autoTimer) clearInterval(autoTimer);
  autoTimer = setInterval(loadQuote, 5000);
}

function stopAuto(){ if (autoTimer) { clearInterval(autoTimer); autoTimer = null; } }

document.addEventListener('DOMContentLoaded', ()=>{
  loadQuotes().then(()=>{
    q('#load').addEventListener('click', loadQuote);
    q('#fav').addEventListener('click', saveFavorite);
    q('#share').addEventListener('click', shareQuote);
    q('#autoplay').addEventListener('change', e=> e.target.checked ? startAuto() : stopAuto());
    renderFavorites();
  });
});
