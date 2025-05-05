# TypeScript Project Starter (newTsp)

## Overview
newTsp is a Bash-based tool for quickly initializing TypeScript projects with standardized configurations. It supports creating:

- Node.js backend projects
- Frontend projects
- Combined full-stack projects
- TypeZero template projects

The tool automates project setup including:
- Directory structure creation
- TypeScript configuration
- Dependency installation
- Testing framework setup
- Basic starter files

## Getting Started
No installation required - just run the scripts directly from the project directory. Ensure you have:
- Bash
- Node.js and npm
- Git (for TypeZero projects)

## Usage

### Main Script
* `src/newTsp.sh`: The main entry point for creating projects. Run with `-h` to see all options:
```bash
newTsp -h
```

Common usage patterns:
```bash
# Basic project with interactive type selection
newTsp my-project

# Node.js backend project
newTsp my-backend --node

# Frontend project
newTsp my-frontend --frontend

# Combined project
newTsp my-combo --node --frontend

# TypeZero template project
newTsp my-typezero --typezero
```

### Key Features

#### Node.js Backend Setup
Creates a Node.js project with:
- TypeScript configuration
- Jest testing
- Basic backend structure
- Common development dependencies

#### Frontend Setup
Creates a frontend project with:
- TypeScript configuration
- Parcel bundler
- Basic HTML/CSS/TS structure
- Testing setup with Puppeteer

#### Combined Setup
Creates both backend and frontend in one project with:
- Separate configurations
- Concurrent test scripts
- Shared dependencies

#### TypeZero Setup
Clones and customizes the TypeZero template:
- Removes Git history
- Updates package name
- Maintains all TypeZero features

## Examples

1. Create a Node.js backend project:
```bash
newTsp my-api --node
```

2. Create a frontend project and start development:
```bash
newTsp my-app --frontend
cd my-app
npm run dev:frontend
```

3. Create a full-stack project:
```bash
newTsp fullstack-app --node --frontend
```

## Notes

- All projects use ES Modules (`"type": "module"`) by default
- Frontend projects include Parcel for bundling
- Node.js projects include tsup for building
- Combined projects use concurrently to manage multiple processes
- The `--typezero` flag takes precedence over other flags

For detailed help on any command, use the `-h` or `--help` flag:
```bash
newTsp --help
```

## Project Structure
Key files and directories:

* `src/newTsp.sh`: Main project creation script
* `src/util/standard/`: Standard setup scripts
* `src/util/zero/`: TypeZero-specific setup
* `tests/`: Test scripts for validation

Implementation details are in the individual script files, but users typically only need to interact with the main `newTsp.sh` script.