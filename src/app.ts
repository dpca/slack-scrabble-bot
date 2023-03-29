import * as dotenv from 'dotenv';

dotenv.config();

import _ from 'lodash';
import { RTMClient } from '@slack/rtm-api';

const slackToken = process.env.SLACK_TOKEN;
const slackChannels = process.env.SLACK_CHANNELS.split(',');

const rtm = new RTMClient(slackToken);

function sendResponse(channel, message) {
  console.log(`Response: ${message}`);
  rtm.sendMessage(message, channel);
}

function scanForMatches(message) {
  const matches = [...message.matchAll(/:scrabble_([a-z]|blank*):/g)];
  return matches.map((match) => match[1]);
}

const pointValues = {
  a: 1,
  b: 3,
  c: 3,
  d: 2,
  e: 1,
  f: 4,
  g: 2,
  h: 4,
  i: 1,
  j: 8,
  k: 5,
  l: 1,
  m: 3,
  n: 1,
  o: 1,
  p: 3,
  q: 10,
  r: 1,
  s: 1,
  t: 1,
  u: 1,
  v: 1,
  w: 4,
  x: 8,
  y: 4,
  z: 10,
};

function calculatePoints(letter) {
  return pointValues[letter] || 0;
}

rtm.on('message', ({ user, channel, text }) => {
  if (text === undefined) {
    return;
  }

  // Only respond in the specified channel
  if (slackChannels.includes(channel)) {
    console.log(`Received: ${channel} <@${user}> ${text}`);
    const matches = scanForMatches(text);
    if (matches.length > 0) {
      const points = matches.reduce((sum, letter) => sum + calculatePoints(letter), 0);
      if (points === 1) {
        sendResponse(`WOOHOO! YOU SCORED ${points} POINT!`, channel)
      } else if (points > 1) {
        sendResponse(`WOOHOO! YOU SCORED ${points} POINTS!`, channel)
      }
    }
  }
});

(async () => {
  const { self, team } = await rtm.start();
  console.log(`Connected to ${(team as any).name} as ${(self as any).name}`);
})();
