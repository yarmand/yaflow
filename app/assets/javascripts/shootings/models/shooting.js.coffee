ShootingsApp.Shooting = DS.Model.extend
  collectionUrl: '/shootings',
  resourceUrl: '/shootings/%@',
  resourceName: 'shooting'

  yammer_url: DS.attr('string')
  yammer_page_id: DS.attr('string')
  title: DS.attr('string')
  inline_content: DS.attr('string')
  status: DS.attr('string')
  progression: DS.attr('string')

  validate: () ->
    if(this.get('yammer_url') == undefined || this.get('yammer_url') == '' )
      return 'Shooting require a yammer_url'
    if(this.get('yammer_page_id') == undefined || this.get('yammer_page_id') == '' )
      return 'Shooting require a yammer_page_id'
    if(this.get('status') == undefined || this.get('status') == '' )
      return 'Shooting require a status'


