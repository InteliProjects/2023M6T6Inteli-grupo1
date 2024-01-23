import { NextFunction, Request, Response } from 'express';
import ApiError from '../infra/ApiError/ApiError';
import { isAxiosError } from 'axios';

export default function errorHandlerMiddleware(error: any, req: Request, res: Response, next: NextFunction) {
    let message = error?.message || error;
    let code = 500;
    let showError = true;

    if (error instanceof ApiError) {
        code = error.code;
        message = error.message;
        showError = error.showError;
    }

    if (isAxiosError(error)) {
        showError = false;
        if (error.response?.status) {
            code = error.response.status;
        }

        if (error.response?.data) {
            message = error.response?.data?.message || error.response?.data;
        }
    }

    if (String(message).includes('ER_DUP_ENTRY')) {
        message = 'Some of the information has already exists on database';
    }

    if (showError) {
        console.log(`ERROR [${new Date().toISOString()}] ${code} -`, message, error?.stack);
    }
    res.status(code).json({
        code,
        message,
    });
}
