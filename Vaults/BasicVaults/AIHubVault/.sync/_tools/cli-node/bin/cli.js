#!/usr/bin/env node

import { Command } from 'commander';
import { readFileSync } from 'node:fs';
import { fileURLToPath } from 'node:url';
import { dirname, join } from 'node:path';

const __filename = fileURLToPath(import.meta.url);
const __dirname = dirname(__filename);
const pkg = JSON.parse(readFileSync(join(__dirname, '..', 'package.json'), 'utf8'));

const program = new Command();

program
  .name('aimv')
  .description('AIMindVaults cross-platform CLI tools')
  .version(pkg.version);

// Phase 2: index commands will be registered here
// program.command('index').description('Vault index operations');

// Phase 3: review commands
// program.command('review').description('Post-edit review');

// Phase 4: sync commands
// program.command('sync').description('Workspace sync');

program.parse();
