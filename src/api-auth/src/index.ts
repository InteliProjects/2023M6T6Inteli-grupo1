import express from 'express';

import schoolRouter from './router/school.router';
import seducRouter from './router/seduc.router';
import dotenv from 'dotenv';
import adminRouter from './router/admin.router';
const app = express();

dotenv.config({ path: `${__dirname}/../.env` });

const port = process.env.PORT;

app.use(express.json());

app.use((req, res, next) => {
    console.log(`[${req.method}] ${req.url} - ${new Date().toISOString()}`);
    next();
});

app.use('/school', schoolRouter);
app.use('/seduc', seducRouter);
app.use('/admin', adminRouter);

if (process.env.NODE_ENV !== 'test') {
    app.listen(port, () => {
        console.log(`Listening ${port} PORT`);
    });
}

export default app;
