import axios, { AxiosInstance, AxiosRequestConfig, isAxiosError } from 'axios';

export default class APIConnection {
    private axios: AxiosInstance;

    constructor(baseUrl: string) {
        this.axios = axios.create({
            baseURL: baseUrl,
        });
    }

    private async request<R = any>(config: AxiosRequestConfig): Promise<R> {
        try {
            const response = await this.axios.request<R>(config);
            console.log(
                `Request External API [${config.method}] - ${this.axios.getUri()}${config.url} with status ${response.status}`,
            );
            return response.data;
        } catch (error) {
            if (isAxiosError(error)) {
                console.log(
                    `Request External API [${config.method}] - ${this.axios.getUri()}${config.url} ERROR with status ${
                        error.response?.status
                    }`,
                );
            }
            throw error;
        }
    }

    protected get<R = any>(endpoint: string, config: AxiosRequestConfig) {
        return this.request<R>({
            url: endpoint,
            method: 'GET',
            ...config,
        });
    }

    protected post<R = any>(endpoint: string, config: AxiosRequestConfig) {
        return this.request<R>({
            url: endpoint,
            method: 'POST',
            ...config,
        });
    }

    protected path<R = any>(endpoint: string, config: AxiosRequestConfig) {
        return this.request<R>({
            url: endpoint,
            method: 'PATH',
            ...config,
        });
    }

    protected delete<R = any>(endpoint: string, config: AxiosRequestConfig) {
        return this.request<R>({
            url: endpoint,
            method: 'DELETE',
            ...config,
        });
    }
}
