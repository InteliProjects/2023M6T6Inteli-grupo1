import mysql, { FieldInfo } from 'mysql';

export default class MysqlConnection {
    private mysqlPool: mysql.Pool;

    constructor(host: string, user: string, password: string, database: string, port = 3306) {
        this.mysqlPool = mysql.createPool({
            host,
            user,
            password,
            database,
            port,
        });
    }

    async connect() {
        return await new Promise((resolve, reject) => {
            this.mysqlPool.getConnection((error) => {
                if (error) {
                    reject(error);
                } else {
                    console.log(`Conected to database`);
                    resolve(this);
                }
            });
        });
    }

    async close() {
        return await new Promise((resolve, reject) => {
            this.mysqlPool.end((error) => {
                if (error) {
                    reject(error);
                } else {
                    console.log(`Disconnected to database`);
                    resolve(this);
                }
            });
        });
    }

    doQuery = async <R = any>(query: string): Promise<{ results: R; fields: FieldInfo[] | undefined }> => {
        return new Promise((resolve, reject) => {
            this.mysqlPool.query(query, (error, results, fields) => {
                console.log(`Query: `, query);
                if (error) reject(error);
                resolve({ results, fields });
            });
        });
    };

    doSelect = async <R = any>(query: string) => {
        const result = await this.doQuery<R[]>(query);
        return result.results;
    };

    doSelectOne = async <R = any>(query: string) => {
        const result = await this.doQuery<R[]>(query);
        return result.results[0] as R | null;
    };

    doCreate = async (query: string): Promise<number | string> => {
        const result = await this.doQuery(query);
        return result.results.insertId;
    };

    doUpdate = async (query: string): Promise<number> => {
        const result = await this.doQuery(query);
        return result.results.affectedRows;
    };

    doDelete = async (query: string): Promise<number> => {
        const result = await this.doQuery(query);
        return result.results.affectedRows;
    };
}
