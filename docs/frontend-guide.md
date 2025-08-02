# 🎨 Frontend Development Guide - 前端开发指南

现代前端开发的完整技术指南和最佳实践。

## 🛠️ Technology Stack - 技术栈

### Core Frameworks - 核心框架

#### Vue 3 Ecosystem - Vue 3 生态系统
```javascript
// Composition API 示例
<script setup lang="ts">
import { ref, computed, onMounted } from 'vue'

const count = ref(0)
const doubleCount = computed(() => count.value * 2)

onMounted(() => {
  console.log('Component mounted')
})
</script>

<template>
  <div>
    <p>Count: {{ count }}</p>
    <p>Double: {{ doubleCount }}</p>
    <button @click="count++">Increment</button>
  </div>
</template>
```

**核心特性:**
- **Composition API** - 更好的逻辑复用和类型推导
- **`<script setup>`** - 简化的组件语法
- **Reactivity Transform** - 响应式语法糖
- **Teleport** - 组件传送门
- **Suspense** - 异步组件支持

#### React 18+ Ecosystem - React 18+ 生态系统
```typescript
// React Hooks 示例
import React, { useState, useEffect, useMemo } from 'react'

const Counter: React.FC = () => {
  const [count, setCount] = useState(0)
  
  const doubleCount = useMemo(() => count * 2, [count])
  
  useEffect(() => {
    console.log('Component mounted')
  }, [])
  
  return (
    <div>
      <p>Count: {count}</p>
      <p>Double: {doubleCount}</p>
      <button onClick={() => setCount(c => c + 1)}>
        Increment
      </button>
    </div>
  )
}
```

**核心特性:**
- **Concurrent Features** - 并发渲染
- **Automatic Batching** - 自动批处理
- **Suspense for Data Fetching** - 数据获取的Suspense
- **Server Components** - 服务器组件
- **React 18 Hooks** - 新的Hook API

### Build Tools - 构建工具

#### Vite - 现代构建工具
```typescript
// vite.config.ts
import { defineConfig } from 'vite'
import vue from '@vitejs/plugin-vue'
import { resolve } from 'path'

export default defineConfig({
  plugins: [vue()],
  resolve: {
    alias: {
      '@': resolve(__dirname, 'src'),
      '@components': resolve(__dirname, 'src/components'),
      '@utils': resolve(__dirname, 'src/utils')
    }
  },
  build: {
    rollupOptions: {
      output: {
        manualChunks: {
          vendor: ['vue', 'vue-router'],
          ui: ['element-plus']
        }
      }
    }
  },
  server: {
    port: 3000,
    proxy: {
      '/api': {
        target: 'http://localhost:8080',
        changeOrigin: true
      }
    }
  }
})
```

**优势:**
- **极快的冷启动** - 基于ESM的开发服务器
- **热模块替换** - 毫秒级的HMR
- **优化的构建** - 基于Rollup的生产构建
- **插件生态** - 丰富的插件系统

### UI Libraries - UI组件库

#### Element Plus (Vue)
```vue
<template>
  <el-form :model="form" :rules="rules" ref="formRef">
    <el-form-item label="用户名" prop="username">
      <el-input v-model="form.username" />
    </el-form-item>
    <el-form-item label="密码" prop="password">
      <el-input v-model="form.password" type="password" />
    </el-form-item>
    <el-form-item>
      <el-button type="primary" @click="submitForm">提交</el-button>
    </el-form-item>
  </el-form>
</template>

<script setup lang="ts">
import { reactive, ref } from 'vue'
import type { FormInstance, FormRules } from 'element-plus'

const formRef = ref<FormInstance>()
const form = reactive({
  username: '',
  password: ''
})

const rules: FormRules = {
  username: [
    { required: true, message: '请输入用户名', trigger: 'blur' }
  ],
  password: [
    { required: true, message: '请输入密码', trigger: 'blur' },
    { min: 6, message: '密码长度至少6位', trigger: 'blur' }
  ]
}

const submitForm = async () => {
  if (!formRef.value) return
  
  await formRef.value.validate((valid) => {
    if (valid) {
      console.log('表单验证通过', form)
    }
  })
}
</script>
```

#### Ant Design (React)
```typescript
import React from 'react'
import { Form, Input, Button, message } from 'antd'

interface FormValues {
  username: string
  password: string
}

const LoginForm: React.FC = () => {
  const [form] = Form.useForm()
  
  const onFinish = (values: FormValues) => {
    console.log('表单提交:', values)
    message.success('登录成功')
  }
  
  return (
    <Form
      form={form}
      layout="vertical"
      onFinish={onFinish}
    >
      <Form.Item
        label="用户名"
        name="username"
        rules={[{ required: true, message: '请输入用户名' }]}
      >
        <Input />
      </Form.Item>
      
      <Form.Item
        label="密码"
        name="password"
        rules={[
          { required: true, message: '请输入密码' },
          { min: 6, message: '密码长度至少6位' }
        ]}
      >
        <Input.Password />
      </Form.Item>
      
      <Form.Item>
        <Button type="primary" htmlType="submit">
          提交
        </Button>
      </Form.Item>
    </Form>
  )
}
```

#### Tailwind CSS - 原子化CSS
```html
<!-- 响应式卡片组件 -->
<div class="max-w-sm mx-auto bg-white rounded-xl shadow-lg overflow-hidden md:max-w-2xl">
  <div class="md:flex">
    <div class="md:shrink-0">
      <img class="h-48 w-full object-cover md:h-full md:w-48" 
           src="/img/building.jpg" alt="Building">
    </div>
    <div class="p-8">
      <div class="uppercase tracking-wide text-sm text-indigo-500 font-semibold">
        Company retreat
      </div>
      <a href="#" class="block mt-1 text-lg leading-tight font-medium text-black hover:underline">
        Incredible accommodation for your team
      </a>
      <p class="mt-2 text-slate-500">
        Looking to take your team away on a retreat to enjoy awesome food and take in some sunshine? We have a list of places to do just that.
      </p>
    </div>
  </div>
</div>
```

### State Management - 状态管理

#### Pinia (Vue)
```typescript
// stores/user.ts
import { defineStore } from 'pinia'
import { ref, computed } from 'vue'

export const useUserStore = defineStore('user', () => {
  // State
  const user = ref<User | null>(null)
  const token = ref<string>('')
  
  // Getters
  const isLoggedIn = computed(() => !!token.value)
  const userName = computed(() => user.value?.name || '')
  
  // Actions
  async function login(credentials: LoginCredentials) {
    try {
      const response = await authAPI.login(credentials)
      user.value = response.user
      token.value = response.token
      localStorage.setItem('token', token.value)
    } catch (error) {
      throw new Error('登录失败')
    }
  }
  
  function logout() {
    user.value = null
    token.value = ''
    localStorage.removeItem('token')
  }
  
  return {
    user,
    token,
    isLoggedIn,
    userName,
    login,
    logout
  }
})
```

#### Zustand (React)
```typescript
import { create } from 'zustand'
import { persist } from 'zustand/middleware'

interface UserState {
  user: User | null
  token: string
  isLoggedIn: boolean
  login: (credentials: LoginCredentials) => Promise<void>
  logout: () => void
}

export const useUserStore = create<UserState>()(
  persist(
    (set, get) => ({
      user: null,
      token: '',
      isLoggedIn: false,
      
      login: async (credentials) => {
        try {
          const response = await authAPI.login(credentials)
          set({
            user: response.user,
            token: response.token,
            isLoggedIn: true
          })
        } catch (error) {
          throw new Error('登录失败')
        }
      },
      
      logout: () => {
        set({
          user: null,
          token: '',
          isLoggedIn: false
        })
      }
    }),
    {
      name: 'user-storage',
      partialize: (state) => ({ 
        token: state.token,
        user: state.user 
      })
    }
  )
)
```

## 🏗️ Architecture Patterns - 架构模式

### Component Architecture - 组件架构

#### Atomic Design - 原子设计
```
atoms/          # 原子组件 (Button, Input, Icon)
├── Button.vue
├── Input.vue
└── Icon.vue

molecules/      # 分子组件 (SearchBox, FormField)
├── SearchBox.vue
└── FormField.vue

organisms/      # 有机体组件 (Header, ProductList)
├── Header.vue
└── ProductList.vue

templates/      # 模板 (PageLayout, FormLayout)
├── PageLayout.vue
└── FormLayout.vue

pages/          # 页面 (HomePage, ProductPage)
├── HomePage.vue
└── ProductPage.vue
```

#### Feature-Based Structure - 功能导向结构
```
src/
├── features/
│   ├── auth/
│   │   ├── components/
│   │   ├── stores/
│   │   ├── services/
│   │   └── types/
│   ├── products/
│   │   ├── components/
│   │   ├── stores/
│   │   ├── services/
│   │   └── types/
│   └── orders/
├── shared/
│   ├── components/
│   ├── utils/
│   ├── types/
│   └── constants/
└── app/
    ├── router/
    ├── store/
    └── main.ts
```

### Performance Optimization - 性能优化

#### Code Splitting - 代码分割
```typescript
// 路由级别的代码分割
const routes = [
  {
    path: '/',
    component: () => import('@/views/Home.vue')
  },
  {
    path: '/products',
    component: () => import('@/views/Products.vue')
  },
  {
    path: '/orders',
    component: () => import('@/views/Orders.vue')
  }
]

// 组件级别的懒加载
const LazyComponent = defineAsyncComponent(() => 
  import('@/components/HeavyComponent.vue')
)
```

#### Bundle Analysis - 包分析
```bash
# 分析包大小
npm run build -- --analyze

# Webpack Bundle Analyzer
npx webpack-bundle-analyzer dist/static/js/*.js

# Vite Bundle Analyzer
npx vite-bundle-analyzer
```

## 🧪 Testing Strategy - 测试策略

### Unit Testing - 单元测试
```typescript
// Vue Test Utils + Vitest
import { mount } from '@vue/test-utils'
import { describe, it, expect } from 'vitest'
import Counter from '@/components/Counter.vue'

describe('Counter', () => {
  it('increments count when button is clicked', async () => {
    const wrapper = mount(Counter)
    
    expect(wrapper.text()).toContain('Count: 0')
    
    await wrapper.find('button').trigger('click')
    
    expect(wrapper.text()).toContain('Count: 1')
  })
})

// React Testing Library + Jest
import { render, screen, fireEvent } from '@testing-library/react'
import Counter from '@/components/Counter'

describe('Counter', () => {
  it('increments count when button is clicked', () => {
    render(<Counter />)
    
    expect(screen.getByText('Count: 0')).toBeInTheDocument()
    
    fireEvent.click(screen.getByText('Increment'))
    
    expect(screen.getByText('Count: 1')).toBeInTheDocument()
  })
})
```

### E2E Testing - 端到端测试
```typescript
// Playwright
import { test, expect } from '@playwright/test'

test('user can login and view dashboard', async ({ page }) => {
  await page.goto('/login')
  
  await page.fill('[data-testid="username"]', 'testuser')
  await page.fill('[data-testid="password"]', 'password123')
  await page.click('[data-testid="login-button"]')
  
  await expect(page).toHaveURL('/dashboard')
  await expect(page.locator('h1')).toContainText('Dashboard')
})
```

## 📱 Responsive Design - 响应式设计

### Breakpoint Strategy - 断点策略
```css
/* Mobile First 方法 */
.container {
  padding: 1rem;
}

/* Tablet */
@media (min-width: 768px) {
  .container {
    padding: 2rem;
    max-width: 768px;
    margin: 0 auto;
  }
}

/* Desktop */
@media (min-width: 1024px) {
  .container {
    padding: 3rem;
    max-width: 1200px;
  }
}

/* Large Desktop */
@media (min-width: 1440px) {
  .container {
    max-width: 1400px;
  }
}
```

### CSS Grid & Flexbox - 网格和弹性布局
```css
/* CSS Grid 布局 */
.grid-layout {
  display: grid;
  grid-template-columns: repeat(auto-fit, minmax(300px, 1fr));
  gap: 2rem;
  padding: 2rem;
}

/* Flexbox 布局 */
.flex-layout {
  display: flex;
  flex-direction: column;
  gap: 1rem;
}

@media (min-width: 768px) {
  .flex-layout {
    flex-direction: row;
    align-items: center;
    justify-content: space-between;
  }
}
```

## 🔧 Development Tools - 开发工具

### ESLint Configuration - ESLint配置
```javascript
// .eslintrc.js
module.exports = {
  extends: [
    '@vue/typescript/recommended',
    '@vue/prettier',
    '@vue/prettier/@typescript-eslint'
  ],
  rules: {
    'no-console': process.env.NODE_ENV === 'production' ? 'warn' : 'off',
    'no-debugger': process.env.NODE_ENV === 'production' ? 'warn' : 'off',
    '@typescript-eslint/no-unused-vars': 'error',
    'vue/component-name-in-template-casing': ['error', 'PascalCase']
  }
}
```

### TypeScript Configuration - TypeScript配置
```json
{
  "compilerOptions": {
    "target": "ES2020",
    "module": "ESNext",
    "lib": ["ES2020", "DOM", "DOM.Iterable"],
    "moduleResolution": "node",
    "strict": true,
    "jsx": "preserve",
    "esModuleInterop": true,
    "skipLibCheck": true,
    "forceConsistentCasingInFileNames": true,
    "baseUrl": ".",
    "paths": {
      "@/*": ["src/*"],
      "@components/*": ["src/components/*"],
      "@utils/*": ["src/utils/*"]
    }
  },
  "include": [
    "src/**/*.ts",
    "src/**/*.tsx",
    "src/**/*.vue"
  ],
  "exclude": [
    "node_modules",
    "dist"
  ]
}
```
