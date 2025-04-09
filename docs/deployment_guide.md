Okay, let's break down the setup process into detailed steps. This guide assumes you are working on a Linux server environment (like Ubuntu 20.04/22.04 or Debian 10/11) with root or `sudo` access.

**Phase 1: Install Necessary Software (Apache, MySQL, PHP)**

This phase installs the core components of your technology stack.

1.  **Update Package Lists:** Ensure your system's package manager has the latest list of available software.
    ```bash
    sudo apt update
    sudo apt upgrade -y
    ```

2.  **Install Apache2 Web Server:**
    ```bash
    sudo apt install apache2 -y
    ```
    *   *Verification:* You can check if Apache is running: `sudo systemctl status apache2` (Press `q` to exit). You should see "active (running)".
    *   *Firewall Check:* If you have `ufw` (Uncomplicated Firewall) enabled, allow web traffic:
        ```bash
        sudo ufw allow 'Apache Full' # Allows both HTTP (80) and HTTPS (443)
        sudo ufw enable # If not already enabled
        sudo ufw status # Check the status
        ```

3.  **Install MySQL Server:** PrestaShop uses MySQL to store data.
    ```bash
    sudo apt install mysql-server -y
    ```
    *   *Verification:* Check the service status: `sudo systemctl status mysql`.

4.  **Install PHP and Required Extensions:** PrestaShop requires specific PHP extensions. We'll install PHP 8.1 (check PrestaShop documentation for the recommended version for the specific PrestaShop release you intend to use, it might differ).
    ```bash
    sudo apt install php8.1 libapache2-mod-php8.1 php8.1-mysql php8.1-gd php8.1-intl php8.1-mbstring php8.1-xml php8.1-zip php8.1-curl php8.1-bcmath php8.1-soap php8.1-opcache -y
    ```
    *   *Explanation of Extensions:*
        *   `libapache2-mod-php8.1`: Integrates PHP with Apache.
        *   `php8.1-mysql`: For database communication.
        *   `php8.1-gd`: For image processing (resizing, watermarks).
        *   `php8.1-intl`: For internationalization features.
        *   `php8.1-mbstring`: For multi-byte string handling (character encoding).
        *   `php8.1-xml`: For reading/writing XML data.
        *   `php8.1-zip`: For handling zip archives (module installations).
        *   `php8.1-curl`: For making external requests (payment gateways, APIs).
        *   `php8.1-bcmath`: For arbitrary precision mathematics (important for calculations).
        *   `php8.1-soap`: For web services integrations.
        *   `php8.1-opcache`: Improves PHP performance by caching precompiled script bytecode.
    *   *Verification:* `php -v`

5.  **Restart Apache:** To ensure Apache loads the new PHP module.
    ```bash
    sudo systemctl restart apache2
    ```

**Phase 2: Initialize Environment Setup & Preparation**

Configure the installed software for your application.

1.  **Secure MySQL Installation:** Run the security script provided by MySQL.
    ```bash
    sudo mysql_secure_installation
    ```
    *   Follow the prompts:
        *   `VALIDATE PASSWORD component?`: Choose `N` (No) unless you have specific requirements and understand its implications.
        *   `New password for root user`: Set a strong password for the MySQL root user.
        *   `Remove anonymous users?`: `Y` (Yes).
        *   `Disallow root login remotely?`: `Y` (Yes) - Recommended for security.
        *   `Remove test database and access to it?`: `Y` (Yes).
        *   `Reload privilege tables now?`: `Y` (Yes).

2.  **Create MySQL Database and User for PrestaShop:**
    *   Log in to MySQL as root:
        ```bash
        sudo mysql -u root -p
        ```
        (Enter the root password you set in the previous step).
    *   Run the following SQL commands:
        ```sql
        -- Create the database (use utf8mb4 for full character support)
        CREATE DATABASE thescent_db CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

        -- Create a dedicated user for the application
        CREATE USER 'thescent_user'@'localhost' IDENTIFIED BY 'Put_A_Very_Strong_Password_Here!';

        -- Grant all privileges on the new database to the new user
        GRANT ALL PRIVILEGES ON thescent_db.* TO 'thescent_user'@'localhost';

        -- Apply the changes
        FLUSH PRIVILEGES;

        -- Exit MySQL
        EXIT;
        ```
        **Important:** Replace `Put_A_Very_Strong_Password_Here!` with a unique, strong password. Remember these database credentials (database name, username, password) as you'll need them during PrestaShop installation.

3.  **Configure PHP Settings (Optional but Recommended):** Adjust `php.ini` for typical web application needs. PrestaShop might require higher limits than the defaults.
    *   Find the PHP configuration file used by Apache: `/etc/php/8.1/apache2/php.ini` (the path might vary slightly based on your PHP version).
    *   Edit the file: `sudo nano /etc/php/8.1/apache2/php.ini`
    *   Find and adjust these settings (use Ctrl+W in nano to search):
        ```ini
        memory_limit = 256M  ; Or higher (512M) if needed for complex operations/modules
        upload_max_filesize = 64M ; Max size for file uploads (e.g., product images)
        post_max_size = 64M    ; Must be >= upload_max_filesize
        max_execution_time = 120  ; Increase if needed for long import/export processes
        ; Optional but good for performance:
        opcache.enable=1
        opcache.memory_consumption=128
        opcache.interned_strings_buffer=8
        opcache.max_accelerated_files=10000
        opcache.revalidate_freq=2
        opcache.fast_shutdown=1
        ```
    *   Save the file (Ctrl+X, then Y, then Enter).
    *   Restart Apache again to apply PHP changes:
        ```bash
        sudo systemctl restart apache2
        ```

4.  **Configure Apache Virtual Host:** Create a dedicated configuration for your site.
    *   Create a new configuration file:
        ```bash
        sudo nano /etc/apache2/sites-available/thescent.conf
        ```
    *   Paste the following configuration, adjusting `ServerName`, `ServerAlias`, and `DocumentRoot`:
        ```apache
        <VirtualHost *:80>
            ServerAdmin webmaster@localhost
            ServerName yourdomain.com       # Replace with your actual domain or a test domain (e.g., thescent.local)
            ServerAlias www.yourdomain.com  # Optional: www version

            DocumentRoot /var/www/thescent

            <Directory /var/www/thescent>
                Options Indexes FollowSymLinks
                AllowOverride All  # Crucial for PrestaShop's .htaccess/routing
                Require all granted
            </Directory>

            ErrorLog ${APACHE_LOG_DIR}/thescent_error.log
            CustomLog ${APACHE_LOG_DIR}/thescent_access.log combined
        </VirtualHost>
        ```
        **Note:** If using a test domain like `thescent.local`, you'll need to edit your local machine's `hosts` file to point this domain to your server's IP address for testing.
    *   Save the file (Ctrl+X, Y, Enter).
    *   Enable the new site configuration and disable the default one:
        ```bash
        sudo a2ensite thescent.conf
        sudo a2dissite 000-default.conf
        ```
    *   Enable necessary Apache modules:
        ```bash
        sudo a2enmod rewrite ssl headers expires # expires is good for caching
        ```
    *   Test the Apache configuration:
        ```bash
        sudo apache2ctl configtest
        ```        You should see "Syntax OK". If not, review your `.conf` file for typos.
    *   Restart Apache one last time:
        ```bash
        sudo systemctl restart apache2
        ```

5.  **(Strongly Recommended) Setup SSL/HTTPS:** Use Let's Encrypt for a free SSL certificate. This requires a real domain name pointing to your server's IP address.
    ```bash
    sudo apt install certbot python3-certbot-apache -y
    sudo certbot --apache -d yourdomain.com -d www.yourdomain.com # Follow prompts
    ```
    Certbot will automatically obtain the certificate and modify your Apache config (`thescent.conf`) to handle HTTPS redirection.

**Phase 3: Create File/Folder Structure for Deployment**

Prepare the directory where your application code will reside.

1.  **Create the Document Root Directory:** This directory was specified in your Apache `thescent.conf` file.
    ```bash
    sudo mkdir -p /var/www/thescent
    ```

2.  **Download and Extract PrestaShop:**
    *   Go to the official PrestaShop website ([https://www.prestashop.com/](https://www.prestashop.com/)) and download the latest stable version zip file. Get the download URL.
    *   Download it to a temporary location on your server:
        ```bash
        cd /tmp
        wget <PASTE_PRESTASHOP_DOWNLOAD_URL_HERE>
        ```
        (Replace `<PASTE_PRESTASHOP_DOWNLOAD_URL_HERE>` with the actual link).
    *   Install `unzip` if you don't have it: `sudo apt install unzip -y`
    *   Unzip the downloaded file directly into your document root:
        ```bash
        sudo unzip prestashop_*.zip -d /var/www/thescent/
        ```
        *(Check the contents after unzipping. Sometimes PrestaShop might unzip into a subfolder like `prestashop/` or include extra files like `index.php` and `Install_PrestaShop.html` alongside the main files. Ensure the core PrestaShop directories like `admin`, `app`, `classes`, `config`, `controllers`, etc., are directly inside `/var/www/thescent`, not in a subfolder. If they are in a subfolder, move them up: `sudo mv /var/www/thescent/prestashop/* /var/www/thescent/` and then remove the empty subfolder `sudo rmdir /var/www/thescent/prestashop/`)*

3.  **Set Permissions:** This is critical for PrestaShop to function correctly (write configuration files, upload images, install modules, etc.). The web server user (`www-data` on Debian/Ubuntu) needs ownership and appropriate permissions.
    ```bash
    sudo chown -R www-data:www-data /var/www/thescent/
    sudo find /var/www/thescent/ -type d -exec chmod 755 {} \; # Directories: rwx r-x r-x
    sudo find /var/www/thescent/ -type f -exec chmod 644 {} \; # Files: rw- r-- r--
    ```
    *Note: PrestaShop's installer might suggest slightly different permissions (e.g., 775/664) during installation if needed for specific directories. It's generally safe to start with 755/644 and adjust if the installer flags specific permission issues.*

4.  **Cleanup (Optional):** Remove the downloaded zip file.
    ```bash
    rm /tmp/prestashop_*.zip
    ```

**At this point, your server is configured, and the PrestaShop files are in place. You should be able to access `http://yourdomain.com` (or https if you set up SSL) in your browser and see the PrestaShop Installation Assistant.** Proceed with the PrestaShop web installation, providing the database details (name: `thescent_db`, user: `thescent_user`, password: the one you set) when prompted.

---

**Phase 4: Conceptual Database Schema**

**Disclaimer:** PrestaShop automatically generates its database schema during the installation process. This schema is extensive and includes many tables for configuration, logging, modules, overrides, etc. The following is a **simplified, conceptual overview** of the *key entities* and their likely relationships to help you understand the core data structure. The actual table names (often prefixed with `ps_` or a custom prefix set during install) and column names might differ slightly.

**Key Entities & Important Attributes (Conceptual):**

1.  **Customers (`ps_customer`)**
    *   `id_customer` (PK): Unique customer ID
    *   `firstname`, `lastname`: Customer name
    *   `email` (Unique): Login email
    *   `passwd`: Hashed password
    *   `id_default_group`: Customer group (e.g., default customer, B2B)
    *   `newsletter`: Boolean (subscribed?)
    *   `active`: Boolean (account enabled?)
    *   `date_add`, `date_upd`: Timestamps

2.  **Addresses (`ps_address`)**
    *   `id_address` (PK): Unique address ID
    *   `id_customer` (FK -> ps_customer): Link to the customer
    *   `alias`: Address nickname (e.g., Home, Work)
    *   `firstname`, `lastname`: Recipient name at this address
    *   `address1`, `address2`: Street address lines
    *   `postcode`, `city`
    *   `id_country` (FK -> ps_country)
    *   `id_state` (FK -> ps_state, optional)
    *   `phone`, `phone_mobile`
    *   `active`, `deleted`
    *   `date_add`, `date_upd`

3.  **Categories (`ps_category`, `ps_category_lang`)**
    *   `ps_category`:
        *   `id_category` (PK)
        *   `id_parent`: For subcategories
        *   `active`
        *   `position`: Display order
        *   `date_add`, `date_upd`
    *   `ps_category_lang`: (Links category to language-specific details)
        *   `id_category` (FK)
        *   `id_lang` (FK)
        *   `name`: Category name in specific language
        *   `description`: Category description
        *   `link_rewrite`: URL-friendly slug
        *   `meta_title`, `meta_description`, `meta_keywords`: SEO data

4.  **Products (`ps_product`, `ps_product_lang`, `ps_product_shop`)**
    *   `ps_product`:
        *   `id_product` (PK)
        *   `id_category_default` (FK -> ps_category): Main category
        *   `reference`, `ean13`, `upc`: Product codes
        *   `price`: Base price (tax excl.)
        *   `id_tax_rules_group` (FK): Tax settings
        *   `quantity`: Stock level (for products without combinations)
        *   `active`
        *   `weight`, `width`, `height`, `depth`: Dimensions for shipping
        *   `date_add`, `date_upd`
    *   `ps_product_lang`:
        *   `id_product` (FK)
        *   `id_lang` (FK)
        *   `name`, `description`, `description_short`
        *   `link_rewrite`, `meta_title`, `meta_description`, `meta_keywords`
    *   `ps_product_shop`: Links product to specific shops (if multistore enabled) and sets shop-specific price, activity status etc.

5.  **Attributes & Combinations (`ps_attribute`, `ps_attribute_lang`, `ps_attribute_group`, `ps_attribute_group_lang`, `ps_product_attribute`, `ps_product_attribute_combination`)**
    *   *Groups:* Define types of variations (e.g., Size, Scent) (`ps_attribute_group`, `ps_attribute_group_lang`).
    *   *Attributes:* Define specific values within groups (e.g., 10ml, 30ml, Lavender, Citrus) (`ps_attribute`, `ps_attribute_lang`).
    *   *Product Attributes:* Create the actual product variations (Combinations) linking a product to specific attribute values (`ps_product_attribute`). This table holds combination-specific details like `price` impact, `weight` impact, `reference`, `ean13`, `quantity`.
    *   `ps_product_attribute_combination`: Links a `ps_product_attribute` (a specific combination) to one or more `ps_attribute` values.

6.  **Images (`ps_image`, `ps_image_lang`, `ps_image_shop`)**
    *   Links products (`id_product`) to image files, handles positioning (cover image), and potentially language-specific captions.

7.  **Orders (`ps_orders`)**
    *   `id_order` (PK)
    *   `id_customer` (FK)
    *   `id_cart` (FK)
    *   `id_currency` (FK)
    *   `id_lang` (FK)
    *   `id_address_delivery`, `id_address_invoice` (FK -> ps_address)
    *   `current_state` (FK -> ps_order_state): Order status (e.g., Awaiting payment, Processing, Shipped)
    *   `payment`: Payment method name (e.g., PayPal, Stripe)
    *   `module`: Payment module used
    *   `total_discounts`, `total_paid`, `total_paid_tax_incl`, `total_paid_tax_excl`, `total_products`, `total_shipping`: Financial details
    *   `invoice_number`, `delivery_number`
    *   `invoice_date`, `delivery_date`, `date_add`, `date_upd`

8.  **Order Details (`ps_order_detail`)**
    *   `id_order_detail` (PK)
    *   `id_order` (FK)
    *   `id_product` (FK, may be null if product deleted)
    *   `id_product_attribute` (FK, for combinations)
    *   `product_name`, `product_reference`, `product_ean13`
    *   `product_quantity`: Quantity of this specific item in the order
    *   `product_price`: Unit price (tax excl.)
    *   `reduction_percent`, `reduction_amount`
    *   `total_price_tax_incl`, `total_price_tax_excl`: Line item total
    *   `unit_price_tax_incl`, `unit_price_tax_excl`: Unit price

9.  **Shopping Cart (`ps_cart`, `ps_cart_product`)**
    *   `ps_cart`: Represents a customer's shopping session. Links to `id_customer`, `id_address_delivery`, `id_address_invoice`, `id_lang`, `id_currency`.
    *   `ps_cart_product`: Links items (`id_product`, `id_product_attribute`) and their `quantity` to a specific `id_cart`.

10. **Carriers/Shipping (`ps_carrier`, `ps_carrier_lang`, `ps_carrier_zone`, `ps_delivery`)**
    *   Defines shipping methods (`ps_carrier`), their names/descriptions (`ps_carrier_lang`), associates them with geographical zones (`ps_carrier_zone`), and links them to actual shipping cost calculation ranges/rules (`ps_delivery`).

11. **CMS (`ps_cms`, `ps_cms_lang`, `ps_cms_category`, `ps_cms_category_lang`)**
    *   Manages static content pages (like About Us, T&Cs) and their categorization.

This conceptual schema covers the main data points. The real PrestaShop database will have many more tables related to specific features, configuration, modules, logging, performance, etc. However, understanding these core entities provides a good foundation.
