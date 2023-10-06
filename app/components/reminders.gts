import Component from '@glimmer/component';
import { tracked } from '@glimmer/tracking';
import { fn } from '@ember/helper';
import { on } from '@ember/modifier';
import { LinkTo } from '@ember/routing';
import { service } from '@ember/service';

import { resource } from 'ember-resource';
import { Announce } from 'polaris-starter/components/announce';

import type { TOC } from '@ember/component/template-only';
import type State from 'polaris-starter/services/state';

interface ReminderData {
   title?: string;
   dueDate?: string;
   description: string;
}
interface ReminderComponent {
  data: ReminderData;
}

type PropertyKey = 'title' | 'description' | 'dueDate';
type EventInterface = {
  target: {
    value: string;
  }
};

export const Reminder: TOC<ReminderComponent> = <template>
  <div>
    {{@data.title}} | {{@data.description}} | {{@data.dueDate}}
  </div>
</template>

export default class Reminders extends Component {
  @service('state') declare state: State;

  @tracked added: boolean = false;
  @tracked title: string = "";
  @tracked description: string = "";
  @tracked dueDate: string = this.getDate();

  addReminder = (data: ReminderData): void  => {
    if (data.title) {
      this.state.setState(data, data);
      this.title = "";
      this.description = "";
      this.dueDate = this.getDate();
      this.added = true;
    }
  };

  onInput = (property: string, event: EventInterface | Event): void => {
    this[property as PropertyKey] = (event as EventInterface).target.value;
  }

  hide = () => {
    this.added = false;
  }

  getDate() {
    const date = new Date().toISOString();

    return date.substring(0, date.indexOf('T'));
  }

  get data(): ReminderData {
    const { title, description, dueDate } = this;

    return { title, description, dueDate };
  }

  get reminders(): Array<ReminderData> {
    return this.state.values() as [ReminderData];
  }

  <template>
    <form>
      <input value={{this.title}} {{on "input" (fn this.onInput "title")}}/>
      <textarea value={{this.description}} {{on "input" (fn this.onInput "description")}}//>
      <input type="date" value={{this.dueDate}} {{on "input" (fn this.onInput "dueDate")}}//>
      <button type="button" class="button" {{on "click" (fn this.addReminder this.data)}}>Add Reminder</button>
    </form>
    <Announce @announcement="Reminder added!" @show={{this.added}} @hide={{this.hide}}/>
    <LinkTo @route="list">Reminders</LinkTo>
  </template>
}
