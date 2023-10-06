import Service from '@ember/service';

import { TrackedMap } from 'tracked-built-ins';

export default class State extends Service {
  private state = new TrackedMap([]);

  stateFor(key: unknown): unknown {
    return this.state.get(key);
  }
  setState(key: unknown, value: unknown) {
    this.state.set(key, value);
  }

  values(): Array<unknown> {
    return [...this.state.values()];
  }
}

declare module '@ember/service' {
  interface Registry {
    'state': State;
  }
}
