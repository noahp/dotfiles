#!/usr/bin/env node

const fs = require('node:fs');
const { execSync } = require('node:child_process');

const CLAUDE_DUMB_ZONE = 59;

function getGitBranch() {
  try {
    return execSync('git branch --show-current 2>/dev/null', { encoding: 'utf-8' }).trim();
  } catch {
    return '';
  }
}

function ansi(text, bgColor, color = 'rgb(255, 255, 255)') {
  const RESET = '\x1b[0m';
  const bgColorValues = bgColor.match(/\d+/g);
  const bgColorAnsi = `\x1b[48;2;${bgColorValues.join(';')}m`;
  const colorValues = color.match(/\d+/g);
  const colorAnsi = `\x1b[38;2;${colorValues.join(';')}m`;
  return `${RESET}${bgColorAnsi}${colorAnsi}${text}${RESET}`;
}

function formatSections(sections) {

  const LEFT_ROUND = '\ue0b6';
  const RIGHT_ARROW = '\ue0b0';
  const RIGHT_ROUND = '\ue0b4';

  const coloredSections = sections.map((section, index) => {
    const { text, bgColor, color } = section;
    const coloredSection = ansi(` ${text} `, bgColor, color);

    // First section does not need a leading right arrow
    if (index === 0) {
      return coloredSection;
    }

    const prevBgColor = sections[index - 1].bgColor;
    const prefix = `${ansi(RIGHT_ARROW, bgColor, prevBgColor)}`;
    return prefix + coloredSection;
  });

  return [
    `${ansi(LEFT_ROUND, 'rgb(0,0,0)', sections.at(0).bgColor)}`,
    ...coloredSections,
    `${ansi(RIGHT_ROUND, 'rgb(0,0,0)', sections.at(-1).bgColor)}`,
  ].join('');
}

try {
  const sections = [];

  // Read data from Claude Code stdin
  const input = JSON.parse(fs.readFileSync(0, 'utf-8'));

  const cwd = input.workspace.current_dir;
  const dirName = cwd.split('/').at(-1);
  sections.push({ text: dirName, bgColor: "rgb(52, 86, 164)" });

  const branch = getGitBranch();
  if (branch) {
    sections.push({ text: branch, bgColor: "rgb(70, 107, 62)" });
  }

  const model = input.model.display_name;
  sections.push({ text: model, bgColor: "rgb(68, 68, 68)" });

  // Context window usage
  const contextWindow = input.context_window;

  if (contextWindow?.current_usage && contextWindow?.context_window_size) {
    const usage = contextWindow.current_usage;
    const currentTokens = (usage.input_tokens || 0) +
                          (usage.output_tokens || 0) +
                          (usage.cache_creation_input_tokens || 0) +
                          (usage.cache_read_input_tokens || 0);
    const contextSize = contextWindow.context_window_size;
    const percent = Math.round((currentTokens / contextSize) * 100);
    const isDumbZone = percent > CLAUDE_DUMB_ZONE;
    const bgColor = isDumbZone ? "rgb(226, 0, 0)" : "rgb(217, 119, 87)";
    const color = isDumbZone ? "rgb(255, 255, 255)" : "rgb(0, 0, 0)";
    sections.push({ text: `${percent}%`, bgColor, color });
  }

  // Rate limit usage
  const rateLimits = input.rate_limits;
  if (rateLimits?.five_hour && rateLimits?.seven_day) {
    const fiveH = Math.round(rateLimits.five_hour.used_percentage);
    const sevenD = Math.round(rateLimits.seven_day.used_percentage);
    const maxPct = Math.max(fiveH, sevenD);
    const bgColor = maxPct > 75 ? "rgb(226, 0, 0)" : maxPct > 50 ? "rgb(217, 119, 87)" : "rgb(68, 68, 68)";
    const color = maxPct > 50 ? "rgb(0, 0, 0)" : "rgb(255, 255, 255)";
    sections.push({ text: `5h:${fiveH}% 7d:${sevenD}%`, bgColor, color });
  }

  console.log(formatSections(sections));
} catch (error) {
  console.error('Error:', error.message);
  process.exit(1);
}
