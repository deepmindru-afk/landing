<script setup lang="ts">
import { motion } from 'motion-v'
import type { VariantType } from 'motion-v'

const sections = ['services', 'process', 'about', 'contacts']
const activeSection = ref<string>()

const items = computed(() => [
  { label: 'Услуги', to: '#services', active: activeSection.value === 'services' },
  { label: 'Как мы работаем', to: '#process', active: activeSection.value === 'process' },
  { label: 'О компании', to: '#about', active: activeSection.value === 'about' },
  { label: 'Контакты', to: '#contacts', active: activeSection.value === 'contacts' }
])

const nuxtApp = useNuxtApp()

nuxtApp.hooks.hookOnce('page:loading:end', () => {
  const observer = new IntersectionObserver((entries) => {
    const visible = entries.find(e => e.isIntersecting)
    if (visible) {
      activeSection.value = visible.target.id
    } else if (entries.every(e => !e.isIntersecting)) {
      activeSection.value = undefined
    }
  }, { rootMargin: '-50% 0px -50% 0px' })

  document.querySelectorAll(sections.map(id => `#${id}`).join(', ')).forEach(el => observer.observe(el))
})

const variants: Record<string, VariantType | ((custom: unknown) => VariantType)> = {
  normal: {
    rotate: 0,
    y: 0,
    opacity: 1
  },
  close: (custom: unknown) => {
    const c = custom as number
    return {
      rotate: c === 1 ? 45 : c === 3 ? -45 : 0,
      y: c === 1 ? 6 : c === 3 ? -6 : 0,
      opacity: c === 2 ? 0 : 1,
      transition: {
        type: 'spring',
        stiffness: 260,
        damping: 20
      }
    }
  }
}
</script>

<template>
  <UHeader>
    <template #left>
      <NuxtLink
        to="/"
        class="focus-visible:outline-3 outline-primary/25 rounded-md p-1 -ms-1"
      >
        <AppLogo class="h-6 w-auto shrink-0" />
      </NuxtLink>
    </template>

    <UNavigationMenu
      :items="items"
      variant="link"
    />

    <template #right>
      <UButton
        label="8 926 371-42-00"
        icon="i-lucide-phone"
        trailing
        color="neutral"
        variant="ghost"
        class="hidden lg:flex font-mono text-xs tracking-tight"
        to="tel:+79263714200"
      />
      <UButton
        label="Обсудить задачу"
        color="neutral"
        class="hidden lg:flex"
        to="tel:+79263714200"
      />
    </template>

    <template #toggle="{ open, toggle, ui }">
      <UButton
        size="sm"
        variant="ghost"
        color="neutral"
        square
        :aria-label="open ? 'Close navigation' : 'Open navigation'"
        :aria-expanded="open"
        :class="ui.toggle({ toggleSide: 'right' })"
        @click="toggle"
      >
        <svg
          xmlns="http://www.w3.org/2000/svg"
          class="size-5"
          viewBox="0 0 24 24"
          fill="none"
          stroke="currentColor"
          stroke-width="2"
          stroke-linecap="round"
          stroke-linejoin="round"
        >
          <motion.line
            x1="4"
            y1="6"
            x2="20"
            y2="6"
            :variants="variants"
            :animate="open ? 'close' : 'normal'"
            :custom="1"
            tabindex="-1"
          />
          <motion.line
            x1="4"
            y1="12"
            x2="20"
            y2="12"
            :variants="variants"
            :animate="open ? 'close' : 'normal'"
            :custom="2"
            tabindex="-1"
          />
          <motion.line
            x1="4"
            y1="18"
            x2="20"
            y2="18"
            :variants="variants"
            :animate="open ? 'close' : 'normal'"
            :custom="3"
            tabindex="-1"
          />
        </svg>
      </UButton>
    </template>

    <template #body>
      <UNavigationMenu
        :items="items"
        orientation="vertical"
      />

      <div class="mt-4 flex flex-col gap-2">
        <UButton
          label="Обсудить задачу"
          block
          to="tel:+79263714200"
        />
        <UButton
          label="8 926 371-42-00"
          icon="i-lucide-phone"
          color="neutral"
          variant="soft"
          block
          class="font-mono tracking-tight"
          to="tel:+79263714200"
        />
      </div>
    </template>
  </UHeader>
</template>
