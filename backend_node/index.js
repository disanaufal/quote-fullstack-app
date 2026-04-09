const express = require('express');
const cors = require('cors');
const fs = require('fs/promises');

const app = express();
const PORT = 3000;

app.use(cors());
app.use(express.json());

//test route
app.get('/quotes', async (req, res) => {
    const data = await fs.readFile('./data/quotes.json', 'utf-8');
    const quotes = JSON.parse(data);

    res.json(quotes);
});

app.get('/quotes/random', async (req, res) => {
    const data = await fs.readFile('./data/quotes.json', 'utf-8');
    const quotes = JSON.parse(data);

    const randomIndex = Math.floor(Math.random() * quotes.length);
    const randomQuote = quotes[randomIndex];

    res.json(randomQuote);
});

//post route to add a new quote
app.post('/quotes', async (req, res) => {
    console.log("BODY:", req.body);
    const { content, author } = req.body;

    if (typeof content !== 'string' || 
        typeof author !== 'string' || 
        content.trim() === '' || 
        author.trim() === ''
    ) {
        return res.status(400).json({ error: 'Content and author are required' });
    }

    const data = await fs.readFile('./data/quotes.json', 'utf-8');
    const quotes = JSON.parse(data);

    const newId = quotes.length > 0 ? Math.max(...quotes.map(q => q.id)) + 1 : 1;

    const newQuote = {
        id: newId,
        content: content.trim(),
        author: author.trim(),
    };

    quotes.push(newQuote);

    await fs.writeFile('./data/quotes.json', JSON.stringify(quotes, null, 2));

    res.status(201).json(newQuote);
});

app.delete('/quotes/:id', async (req, res) => {
    console.log("PARAMS:", req.params);

    const id = parseInt(req.params.id);

    const data = await fs.readFile('./data/quotes.json', 'utf-8');
    let quotes = JSON.parse(data);

    const initialLength = quotes.length;

    quotes = quotes.filter(q => q.id !== id);

    if (quotes.length === initialLength) {
        return res.status(404).json({ error: 'Quote not found' });
    }

    await fs.writeFile('./data/quotes.json', JSON.stringify(quotes, null, 2));

    res.json({ message: 'Quote deleted successfully' });
});

app.listen(PORT, () => {
    console.log(`Server is running on http://localhost:${PORT}`);
});