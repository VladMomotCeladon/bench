'use strict';

module.exports = {
  /**
   * An asynchronous register function that runs before
   * your application is initialized.
   *
   * This gives you an opportunity to extend code.
   */
  register(/*{ strapi }*/) {},

  /**
   * An asynchronous bootstrap function that runs before
   * your application gets started.
   *
   * This gives you an opportunity to set up your data model,
   * run jobs, or perform some special logic.
   */
  async bootstrap({ strapi }) {
    // Set up public permissions for homepage-content
    try {
      const pluginStore = strapi.store({ type: 'plugin', name: 'users-permissions' });
      const settings = await pluginStore.get({ key: 'advanced' });
      
      if (!settings) {
        await pluginStore.set({
          key: 'advanced',
          value: {
            unique_email: true,
            allow_register: false,
            email_confirmation: false,
            email_confirmation_redirection: null,
            email_reset_password: null,
            email_blocked: null,
            email_enable_account: null,
          },
        });
      }

      // Set public role permissions
      const publicRole = await strapi
        .query('plugin::users-permissions.role')
        .findOne({ where: { type: 'public' } });

      if (publicRole) {
        const permissions = await strapi
          .query('plugin::users-permissions.permission')
          .findMany({
            where: {
              role: publicRole.id,
              action: 'api::homepage-content.homepage-content.find',
            },
          });

        if (permissions.length === 0) {
          await strapi
            .query('plugin::users-permissions.permission')
            .create({
              data: {
                role: publicRole.id,
                action: 'api::homepage-content.homepage-content.find',
                subject: null,
                properties: {},
                conditions: [],
              },
            });
          console.log('✅ Public permissions set for homepage-content');
        }
      }

      // Check if we have any homepage content, if not create initial data
      const existingContent = await strapi
        .query('api::homepage-content.homepage-content')
        .findMany();

      if (existingContent.length === 0) {
        await strapi
          .query('api::homepage-content.homepage-content')
          .create({
            data: {
              title: 'Hello World!',
              content: 'This is a static site generated with Next.js and powered by Strapi CMS. You can edit this content in Strapi and rebuild the site to see changes.',
              publishedAt: new Date(),
            },
          });
        console.log('✅ Initial homepage content created');
      }
    } catch (error) {
      console.error('Error during bootstrap:', error);
    }
  },
};
