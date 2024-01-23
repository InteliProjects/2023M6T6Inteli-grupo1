import App from './infra/App';
const app = new App(`${__dirname}/../.env`);

(async () => {
    await app.config();
    app.listen();
})();
