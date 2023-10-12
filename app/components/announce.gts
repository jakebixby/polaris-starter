import { modifier } from 'ember-modifier';

import type { TOC } from '@ember/component/template-only';

type Named = { callback: Function };
interface FadeInSignature {
  Element: HTMLElement;
  Args: {
    Named: Named;
  }
}

const fadeIn = modifier<FadeInSignature> ((element, _, named) => {
  let animation = element.animate([
    { opacity: 0},
    { transform: "translateX(-100px)" },
    { opacity: 1},
    { transform: "translateX(1px)" },
  ], {
    duration: 100,
  });
  let timeout = setTimeout(() => {
    named.callback();
  }, 1000);

  return () => {
    animation.cancel();
    clearTimeout(timeout);
  };
});

interface AnnounceSignature {
  announcement: string;
  show: boolean;
  hide: Function;
}

export const Announce: TOC<AnnounceSignature> = <template>
  {{#if @show}}
    <div {{fadeIn callback=@hide}}>
      <h1>{{@announcement}}</h1>
    </div>
  {{/if}}
</template>
