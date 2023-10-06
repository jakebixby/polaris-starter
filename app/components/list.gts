import Component from '@glimmer/component';
import { service } from '@ember/service';


import { Reminder } from 'polaris-starter/components/reminders';
import type State from 'polaris-starter/services/state';
import { LinkTo } from '@ember/routing';

export default class List extends Component {
  @service('state') declare state: State;

  get reminders() {
    return [...this.state.values()];
  }

  <template>
    {{#each this.reminders as |reminder|}}
      <Reminder @data={{reminder}} />
    {{/each}}
    <LinkTo @route="application">Add Reminders</LinkTo>
  </template>
}
