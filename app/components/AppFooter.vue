<script setup lang="ts">
const links = [
  { label: 'Услуги', to: '#services' },
  { label: 'Как мы работаем', to: '#process' },
  { label: 'О компании', to: '#about' },
  { label: 'Контакты', to: '#contacts' },
  { label: 'falx-b2b.ru', to: 'https://falx-b2b.ru', target: '_blank' }
]
</script>

<template>
  <UFooter
    :ui="{
      container: 'border-t border-default lg:py-8',
      right: 'gap-x-0 flex-wrap'
    }"
  >
    <template #left>
      <div class="flex flex-col gap-1 text-sm text-dimmed">
        <p>
          © {{ new Date().getFullYear() }} ООО «ФЕЛ ИКС»
        </p>
        <p class="text-xs">
          Саратов, 3-й Дегтярный проезд, 3д 21 стр 3 • Пн–вс: 09:00 — 20:00
        </p>
      </div>
    </template>

    <template #right>
      <UButton
        v-for="link in links"
        :key="link.label"
        :label="link.label"
        :to="link.to"
        :target="link.target"
        color="neutral"
        variant="link"
        class="font-light"
        size="sm"
      />
      <UButton
        label="8 926 371-42-00"
        icon="i-lucide-phone"
        to="tel:+79263714200"
        color="neutral"
        variant="link"
        class="font-mono text-xs font-light tracking-tight"
        size="sm"
      />
    </template>
  </UFooter>
</template>
