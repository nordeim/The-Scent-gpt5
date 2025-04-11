# The Scent - Design Specification Document

## Current Theme Structure

### 1. Design System

#### 1.1 Typography
- **Primary Font (Headings)**: `'Cormorant Garamond', serif`
- **Body Font**: `'Montserrat', sans-serif`
- **Accent Font**: `'Raleway', sans-serif`

#### 1.2 Color Palette
```css
--color-primary: #1A4D5A;    /* Deep Teal */
--color-secondary: #A0C1B1;  /* Soft Mint Green */
--color-accent: #D4A76A;     /* Muted Gold/Ochre */
--color-background: #F8F5F2; /* Warm Off-White */
--color-text: #333333;       /* Dark Gray */
--color-text-light: #FFFFFF; /* White */
--color-border: #e0e0e0;     /* Light Gray */
```

#### 1.3 Spacing System
- Base unit: `1rem` (16px)
- Spacing scale:
  - XS: `calc(var(--spacing-unit) * 0.5)` - 8px
  - SM: `var(--spacing-unit)` - 16px
  - MD: `calc(var(--spacing-unit) * 1.5)` - 24px
  - LG: `calc(var(--spacing-unit) * 2)` - 32px
  - XL: `calc(var(--spacing-unit) * 3)` - 48px
  - XXL: `calc(var(--spacing-unit) * 4)` - 64px

### 2. Component Library

#### 2.1 Buttons
```css
.btn {
  padding: calc(var(--spacing-unit) * 0.8) calc(var(--spacing-unit) * 2);
  border-radius: 50px;
  font-family: var(--font-accent);
  text-transform: uppercase;
  letter-spacing: 0.5px;
}
```

Variants:
- Primary: Deep teal background
- Secondary: Transparent with teal border
- Accent: Muted gold background

#### 2.2 Form Elements
- Input fields: 44px height, 4px border radius
- Focus states: Accent color border
- Error states: Red (#e74c3c) indicators
- Helper text: 14px, light gray

#### 2.3 Cards
Product Cards:
- White background
- 8px border radius
- Soft shadow: `0 4px 15px rgba(0,0,0,0.05)`
- Hover transform: `translateY(-5px)`
- Image area: 250px height
- Content padding: 24px

#### 2.4 Animation Specifications
```css
/* Base Transitions */
--transition-speed: 0.3s;

/* Animations */
@keyframes fadeInUp {
  from { opacity: 0; transform: translateY(20px); }
  to { opacity: 1; transform: translateY(0); }
}

@keyframes slideIn {
  from { transform: translateX(-100%); }
  to { transform: translateX(0); }
}

@keyframes shimmer {
  0% { background-position: -1000px 0; }
  100% { background-position: 1000px 0; }
}
```

### 3. Layout Specifications

#### 3.1 Grid System
- Container max-width: 1200px
- Grid columns: Auto-fit, minmax(280px, 1fr)
- Gap: 32px (2rem)
- Responsive breakpoints:
  - Mobile: < 576px
  - Tablet: < 768px
  - Desktop: < 992px
  - Large Desktop: < 1200px

#### 3.2 Header
- Sticky behavior on scroll
- Height: 80px (desktop), 64px (mobile)
- Transparent to white background transition
- Mobile menu: Full-width overlay

#### 3.3 Footer
- 4-column grid layout
- Dark background (#2f3d41)
- Bottom bar: Darker shade (#222b2e)

### 4. Page-Specific Layouts

#### 4.1 Homepage
1. Hero Section
   - Full-height (100vh)
   - Video/Image background
   - Centered content
   - Overlay: rgba(0,0,0,0.4)

2. About Section
   - Two-column layout
   - Image with shadow
   - Text alignment: Left

3. Products Grid
   - 4 columns on desktop
   - 2 columns on tablet
   - 1 column on mobile

4. Scent Finder
   - 5-column grid
   - Card-based layout
   - Icon-driven design

5. Testimonials
   - 3-column grid
   - Card layout
   - Quote-style design

6. Newsletter
   - Full-width
   - Deep teal background
   - Centered content

#### 4.2 Product Pages
- Left-right layout
- Product gallery: 60% width
- Product info: 40% width
- Sticky add-to-cart on mobile

#### 4.3 Cart/Checkout
- Single-column layout on mobile
- Two-column layout on desktop
- Order summary: Sticky on desktop

### 5. Animation & Interaction States

#### 5.1 Hover States
- Links: Color transition
- Buttons: Background color + transform
- Cards: Shadow + transform
- Images: Opacity

#### 5.2 Loading States
- Skeleton screens
- Button loading spinners
- Image lazy loading

#### 5.3 Form Feedback
- Input focus states
- Validation feedback
- Success/error messages

### 6. Responsive Design Rules

#### 6.1 Typography Scale
```css
h1 { font-size: clamp(2.5rem, 5vw, 4rem); }
h2 { font-size: clamp(1.8rem, 4vw, 2.8rem); }
h3 { font-size: clamp(1.3rem, 3vw, 1.8rem); }
```

#### 6.2 Layout Adjustments
- Stack columns on mobile
- Reduce padding/margins
- Adjust grid columns
- Hide/show mobile navigation

### 7. Future Enhancements

#### 7.1 Planned Components
- Quick view modal
- Advanced search overlay
- Filter sidebar
- Size guide modal
- Product comparison tool

#### 7.2 Performance Optimizations
- Image lazy loading
- CSS/JS minification
- Critical CSS implementation
- Progressive image loading

### 8. Accessibility Guidelines

#### 8.1 Color Contrast
- Maintain WCAG 2.1 AA standard
- Text on images: Ensure readability
- Focus states: Clear visibility

#### 8.2 Interactive Elements
- Minimum touch target: 44px
- Focus order: Logical flow
- Skip links: Implement for navigation
- ARIA labels: Use where needed

### 9. Browser Support
- Modern browsers (last 2 versions)
- IE11: Graceful degradation
- Mobile browsers: Full support
- Progressive enhancement approach

### 10. Asset Guidelines

#### 10.1 Images
- Product images: 1200x1200px, squared
- Hero images: 1920x1080px minimum
- Thumbnails: 300x300px
- Format: WebP with JPEG fallback

#### 10.2 Icons
- Font Awesome for UI icons
- Custom SVGs for logo/branding
- Touch targets: Minimum 44x44px
