module.exports = {
    preset: 'ts-jest',
    testEnvironment: 'node',
    moduleFileExtensions: ['ts', 'js'],
    testMatch: ['**/*.test.ts'],
    transform: {
        '^.+\\.ts$': 'ts-jest',
    },
    clearMocks: true,
    collectCoverage: false,
    coverageDirectory: 'coverage',
    coverageProvider: 'v8',
};
