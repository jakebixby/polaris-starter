import '@glint/environment-ember-loose';
import '@glint/environment-ember-loose/native-integration';

import type { HelperLike } from '@glint/template';
import type List from 'polaris-starter/components/list';
import type Reminders from 'polaris-starter/components/reminders';
import type Announce from 'polaris-starter/components/announce';
// import type { ComponentLike, HelperLike, ModifierLike } from "@glint/template";
import type Welcome from 'polaris-starter/components/welcome';
declare module '@glint/environment-ember-loose/registry' {
  export default interface Registry {
    // Examples
    // state: HelperLike<{ Args: {}, Return: State }>;
    // attachShadow: ModifierLike<{ Args: { Positional: [State['update']]}}>;
    Welcome: typeof Welcome;
    Reminders: typeof Reminders;
    List: typeof List;

    // eslint-disable-next-line @typescript-eslint/no-explicit-any
    'page-title': HelperLike<{ Args: { Positional: any[] }; Return: string }>;
  }
}
