import Component from '@glimmer/component';
import { LinkTo } from '@ember/routing';
import { service } from '@ember/service';

import { Reminder } from 'polaris-starter/components/reminders';

import type State from 'polaris-starter/services/state';

export default class List extends Component {
  <template>
    {{#each this.reminders as |reminder|}}
      <Reminder @data={{reminder}} />
    {{/each}}
    <LinkTo @route="application">Add Reminders</LinkTo>
  </template>

  @service('state') declare state: State;

  get reminders() {
    return [...this.state.values()];
  }

}
