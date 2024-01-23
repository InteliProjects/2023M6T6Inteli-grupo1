export default class ApiError extends Error {
    code: number;
    showError: boolean;

    constructor(message: any, code = 500, showError: boolean = true) {
        super(message);
        this.code = code;
        this.showError = showError;
    }
}
