<?php
if (!defined('_PS_VERSION_')) {
    exit;
}

class Ts_Testimonials extends Module
{
    public function __construct()
    {
        $this->name = 'ts_testimonials';
        $this->tab = 'front_office_features';
        $this->version = '1.0.0';
        $this->author = 'The Scent';
        $this->need_instance = 0;

        parent::__construct();

        $this->displayName = $this->l('The Scent Testimonials');
        $this->description = $this->l('Display customer testimonials');
    }

    public function install()
    {
        return parent::install() &&
            $this->registerHook('displayHome') &&
            $this->registerHook('displayTestimonials');
    }

    public function hookDisplayTestimonials($params)
    {
        $testimonials = [
            [
                'text' => "The Lavender Essential Oil transformed my bedtime routine—its calming aroma truly helps me unwind.",
                'author' => "Sarah L., Los Angeles",
                'rating' => 5
            ],
            // ...add more testimonials...
        ];

        $this->context->smarty->assign([
            'testimonials' => $testimonials
        ]);

        return $this->display(__FILE__, 'views/templates/hook/testimonials.tpl');
    }
}
