# Rails Tabler Starter

<div align="center">
<p><strong>A high-velocity Rails boilerplate to get from idea to implementation in hours.</strong></p>

<br />

<img src="./app/assets/images/saas-example.gif" alt="Rails Tabler Preview" width="800px" style="border-radius: 8px; box-shadow: 0 4px 6px rgba(0,0,0,0.1);" />

<br />
<br />

**[Live Demo](https://rails-tabler.tarunvelli.site)** • **[Tweak Settings](https://rails-tabler.tarunvelli.site/setup/edit)**

</div>

---

## 🎯 Goals

This starter is designed for Rails developers who want a clean slate without the "magic" bloat.

* **No DSL:** No complex Domain Specific Languages to learn. It's just Vanilla Rails.
* **Simplicity > Efficiency:** Prioritizing readable, maintainable code over micro-optimization.
* **Lean Frontend:** High-quality UI components via [Tabler](https://tabler.io/) (Bootstrap 5) without the headache of complex JS frameworks.

---

## 🚀 Feature Highlights

### 🛠️ Architecture & Core

* **Authentication:** [Devise](https://github.com/heartcombo/devise) + [OmniAuth](https://github.com/heartcombo/devise/wiki/OmniAuth%3A-Overview) for social logins.
* **Authorization:** [Pundit](https://github.com/varvet/pundit) for policy-based access control.
* **Background Jobs:** Modern queuing via [solid_queue](https://github.com/rails/solid_queue/).
* **Multi-Tenancy:** Built-in `Space` model for teams/organizations. Toggle between a Public SaaS or a Private Internal Tool with one setting.

### 🛡️ Role Management

* Standard roles across all spaces.
* Custom role creation per-space with fine-grained permissions.

### 💎 UI & Developer Experience

* **Beautiful UI:** Full integration with Tabler's dashboard layouts.
* **Auto-Documentation:** [Annotate](https://github.com/ctran/annotate_models) for schema/route visibility.
* **Security First:** [Brakeman](https://github.com/presidentbeef/brakeman) vulnerability scanning included.

---

## 📊 Database Schema (ERD)

<div align="center">
<img src="./app/assets/images/template-erb.png" alt="ERD Diagram" width="600px" />
</div>

---

## ⚡ Quick Start

### 1. Install Prerequisites

Ensure you have `sqlite3` and `ruby 3.3+` (we recommend [mise](https://mise.jdx.dev/)).

```bash
brew install sqlite3

```

### 2. Setup Application

```bash
git clone https://github.com/tarunvelli/rails-tabler-starter.git
cd rails-tabler-starter
mise install  # Or your preferred ruby manager
bin/setup
bin/dev

```

### 3. Grant Admin Privileges

```ruby
# bundle exec rails c
User.first.update(admin: true)

```

---

## ⚙️ AppSettings

Fine-tune your application behavior at `/setup/edit`.

| Setting | Description | Options |
| --- | --- | --- |
| `interface_layout` | Change the primary nav style | `VERTICAL`, `HORIZONTAL`, `OVERLAP`, `CONDENSED` |
| `interface_mode` | Theme preference | `LIGHT`, `DARK`, `SYSTEM` |
| `interface_theme` | Color theme of app | `DEFAULT`, `COOL` |
| `login_layout` | Layout of login screens | `DEFAULT`, `ILLUSTRATION`, `COVER` |
| `multi_tenant_mode` | Toggle SaaS vs Internal Tool | `true` (Public Signups), `false` (Invite Only) |
| `show_landing_page` | Root path behavior | `true` (Landing Page), `false` (Redirect to Login) |

---

## 🚢 Deployment

The demo is running on **Hetzner** using [Kamal](https://kamal-deploy.org/).

* **Fly.io:** [Deployment Guide](https://fly.io/docs/rails/getting-started/)
* **Heroku:** [Deployment Guide](https://devcenter.heroku.com/articles/getting-started-with-rails7)

---

## 🤝 Contribution

Contributions make the open-source community a better place. Whether it's a bug fix or a new component, PRs are welcome.

1. Fork the Project
2. Create your Feature Branch (`git checkout -b feature/AmazingFeature`)
3. Commit your Changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to the Branch (`git push origin feature/AmazingFeature`)
5. Open a Pull Request
