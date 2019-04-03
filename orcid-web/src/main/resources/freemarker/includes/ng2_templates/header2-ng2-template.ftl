<script type="text/ng-template" id="header2-ng2-template">

<div class="header2">
    <#if oauthError??>            
    <ng-container *ngIf="isOauth"> 
        <div class="row top-header">
            <div class="col-md-6 col-md-offset-3 centered logo topBuffer">
                <a href="https://orcid.org" alt="ORCID logo">
                    <img src="${staticCdn}/img/orcid-logo-208-64.png" width="208px" height="64px" alt="ORCID logo">
                </a>
            </div>       
        </div>
    </ng-container>
    </#if>

    <div  *ngIf="!isOauth"> 

        <div class="container">
            <div class="logo-search-bar">
                <div class="logo"> 
                    <a href="{{aboutUri}}"><img *ngIf="assetsPath != null" src="{{assetsPath + '/img/orcid-logo.png'}}" alt="ORCID logo" /></a>
                    <div class="slogan"><@orcid.msg 'public-layout.logo.tagline'/></div>
                </div>
                <div class="search">
                <a href="{{getBaseUri()}}/orcid-search/search" class="settings-button"><@orcid.msg 'public-layout.search.advanced'/></a>
                <div class="form-group ">
                <div class="input-group">
                <div class="input-group-addon">
                    <div class="search-dropdown" [ngClass]="{'open': searchDropdownOpen}" >
                        <div class="search-dropbtn" (click)="clickDropdown()"> {{headerSearch.searchOption === 'website'? '<@orcid.msg 'public-layout.search.choice.website'/>':'<@orcid.msg 'public-layout.search.choice.registry'/>'}} <span class="glyphicon glyphicon-chevron-down"></span> </div>
                        <ul class="dropdown-content">
                            <div (click)="clickDropdown('registry')"> <@orcid.msg 'public-layout.search.choice.registry'/> </div>
                            <div (click)="clickDropdown('website')"> <@orcid.msg 'public-layout.search.choice.website'/> </div>
                        </ul>
                    </div>  
                </div>
                <input class="form-control" id="email" name="email" type="text" placeholder="<@orcid.msg 'public-layout.search'/>"/>
                <div class="input-group-addon">
                        <span class="glyphicon glyphicon-search" (click)="searchSubmit()"></span> 
                </div>
                </div>
                </div>
                         <#--  
                        <div class="conditions" >
                            <p>                         
                                <@orcid.msg 'public-layout.search.terms1'/><a
                                    href="{{aboutUri}}/legal"><@orcid.msg
                                    'public-layout.search.terms2'/></a><@orcid.msg
                                'public-layout.search.terms3'/>
                            </p>
                        </div>  
                        -->
                </div>
            </div>
        </div>

        <div class="menu-bar">
                <!--  Desktop / Tablet menu -->             
                <ul class="menu container" resize>
                    <!-- FOR RESEARCHERS -->
                    <li class="first expanded active-trail">
                        <a href="{{aboutUri}}/about/what-is-orcid/mission" (click)="handleMobileMenuOption($event)" title=""><@orcid.msg 'public-layout.for_researchers'/></a>
                        <ul class="menu lang-fixes" *ngIf="!userInfo['REAL_USER_ORCID']">
                            <!-- Mobile view Only -->
                            <li class="leaf hidden-md hidden-lg hidden-sm visible-xs"><a href="{{getBaseUri()}}" title=""><@orcid.msg 'public-layout.for_researchers'/></a></li>
                    
                            <!-- Menu -->
                            <li class="leaf last"><a ${(nav=="signin")?then('class="active" ', '')} href="{{getBaseUri()}}/signin"><@orcid.msg 'public-layout.sign_in'/></a></li>                                   
                            <li class="leaf last"><a ${(nav=="register")?then('class="active" ', '')} href="{{getBaseUri()}}/register"><@orcid.msg 'public-layout.register'/></a></li>                                                                                                                          
                            <li class="leaf last"><a href="{{getBaseUri()}}/content/initiative"><@orcid.msg 'manage_delegators.learn_more.link.text' /></a></li>
                        </ul>
                        <ul class="menu lang-fixes" *ngIf="userInfo['REAL_USER_ORCID']">
                            <li>
                                <a ${(nav=="record")?then('class="active" ', '')}href="{{getBaseUri()}}/my-orcid">
                                    <div *ngIf="userInfo['IN_DELEGATION_MODE'] == 'true'">
                                        <@orcid.msg 'public-layout.my_orcid'/>
                                    </div>
                                    <div *ngIf="userInfo['IN_DELEGATION_MODE'] == 'false'">
                                        <@orcid.msg 'public-layout.my_orcid_record'/>
                                    </div>
                                </a>
                            </li>
                            <li>
                                {{retrieveUnreadCount()}}
                                <a ${(nav=="notifications")?then('class="active" ', '')} href="{{getBaseUri()}}/inbox">${springMacroRequestContext.getMessage("workspace.notifications")} <span *ngIf="getUnreadCount > 0">({{getUnreadCount}})</span></a>
                            </li>
                            <li>
                                <a ${(nav=="settings")?then('class="active" ', '')} href="{{getBaseUri()}}/account" id="accountSettingMenuLink"><@orcid.msg 'public-layout.account_setting'/></a>
                            </li>
                            
                            <!-- Developer tools -->
                            <li *ngIf="(userInfo['IN_DELEGATION_MODE'] == 'false' || userInfo['DELEGATED_BY_ADMIN'] == 'true') && userInfo['MEMBER_MENU']=='true'"><a ${(nav=="developer-tools")?then('class="active" ', '')}href="{{getBaseUri()}}/group/developer-tools">${springMacroRequestContext.getMessage("workspace.developer_tools")}</a></li>
                            <li *ngIf="(userInfo['IN_DELEGATION_MODE'] == 'false' || userInfo['DELEGATED_BY_ADMIN'] == 'true') && userInfo['MEMBER_MENU']!='true'"><a ${(nav=="developer-tools")?then('class="active" ', '')}href="{{getBaseUri()}}/developer-tools">${springMacroRequestContext.getMessage("workspace.developer_tools")}</a></li>
                            
                            <!-- Admin menu -->
                            <li *ngIf="userInfo['ADMIN_MENU']"><a ${(nav=="members")?then('class="active" ', '')}href="{{getBaseUri()}}/manage-members"><@orcid.msg 'admin.members.workspace_link' /></a></li>
                            <li *ngIf="userInfo['ADMIN_MENU']"><a ${(nav=="admin")?then('class="active" ', '')}href="{{getBaseUri()}}/admin-actions"><@orcid.msg 'admin.workspace_link' /></a></li>
                                
                            <!-- Self service menu -->
                            <li *ngIf="userInfo['SELF_SERVICE_MENU']"><a ${(nav=="self-service")?then('class="active" ', '')}href="{{getBaseUri()}}/self-service"><@orcid.msg 'workspace.self_service' /></a></li>
                                    
                            <li class="leaf last"><a href="{{getBaseUri()}}/content/initiative"><@orcid.msg 'manage_delegators.learn_more.link.text' /></a></li>
                        </ul>
                    </li>

                    <!-- DRUPAL WEBSITE MENUS -->
                    <!-- FOR ORGANIZATIONS -->
                    <li class="expanded">
                        <a href="{{aboutUri}}/organizations" (click)="handleMobileMenuOption($event)"><@orcid.msg 'public-layout.for_organizations'/></a>
                        <ul class="menu lang-fixes">
                            <!-- Mobile view Only -->
                            <li class="first leaf hidden-md hidden-lg hidden-sm visible-xs">
                                <a href="{{aboutUri}}/organizations"><@orcid.msg 'public-layout.for_organizations'/></a>
                            </li>

                            <li class="first leaf">
                                <a href="{{aboutUri}}/organizations/funders" class="russian-fix" (click)="handleMobileMenuOption($event); toggleSecondaryMenu('funders')"><@orcid.msg 'public-layout.funders'/><span class="more"></span></a> <!-- Updated according Drupal website structure -->
                            </li>
                            <li class="leaf">
                                <a href="{{aboutUri}}/organizations/institutions" (click)="handleMobileMenuOption($event); toggleSecondaryMenu('institutions')"><@orcid.msg 'public-layout.research_organizations'/><span class="more" ></span></a> <!-- Updated according Drupal website structure -->
                            </li>
                            <li class="leaf">
                                <a href="{{aboutUri}}/organizations/publishers" (click)="handleMobileMenuOption($event); toggleSecondaryMenu('publishers')"> <@orcid.msg 'public-layout.publishers'/><span class="more"></span></a> <!-- Updated according Drupal website structure -->
                            </li>
                            <li class="leaf">
                                <a href="{{aboutUri}}/organizations/associations" (click)="handleMobileMenuOption($event); toggleSecondaryMenu('associations')"><@orcid.msg 'public-layout.associations'/><span class="more"></span></a> <!-- Updated according Drupal website structure -->
                            </li>
                            <li class="last leaf">
                                <a href="{{aboutUri}}/organizations/integrators" (click)="handleMobileMenuOption($event); toggleSecondaryMenu('integrators')"><@orcid.msg 'public-layout.integrators'/><span class="more"></span></a> <!-- Updated according Drupal website structure -->
                            </li>
                        </ul>
                    </li>
                    <!-- ABOUT -->
                    <li class="expanded"><a href="{{aboutUri}}/about" (click)="handleMobileMenuOption($event)"><@orcid.msg
                            'public-layout.about'/></a>

                        <ul class="menu lang-fixes">
                            <!-- Mobile view Only -->
                            <li><a href="{{aboutUri}}/about"
                                class="first leaf hidden-md hidden-lg hidden-sm visible-xs"><@orcid.msg
                                    'public-layout.about'/></a></li>
                            <!-- What is ORCID? -->
                            <li class="first expanded">
                                <a href="{{aboutUri}}/about/what-is-orcid" (click)="handleMobileMenuOption($event); toggleSecondaryMenu('whatIsOrcid')"><@orcid.msg 'public-layout.what_is_orcid'/><span class="more"></span></a>
                       
                            </li>
                            <!-- The ORCID Team -->
                            <li class="leaf"><a href="{{aboutUri}}/about/team" title=""><@orcid.msg
                                    'public-layout.the_orcid_team'/></a></li>
                            <!-- The ORCID Comunity -->
                            <li class="expanded">
                                <a href="{{aboutUri}}/about/community" (click)="handleMobileMenuOption($event); toggleSecondaryMenu('community')"><@orcid.msg 'public-layout.the_orcid_community'/><span class="more"></span></a>
                             
                            </li>
                            <!-- Membership -->
                            <li class="expanded">
                                <a href="{{aboutUri}}/about/membership" (click)="handleMobileMenuOption($event); toggleSecondaryMenu('membership')"><@orcid.msg 'public-layout.membership'/><span class="more"></span></a>
        
                            </li>
                            <!-- News -->
                            <li class="leaf">
                                <a href="{{aboutUri}}/about/news/news" (click)="handleMobileMenuOption($event); toggleSecondaryMenu('news')"><@orcid.msg 'public-layout.news'/><span class="more"></span></a>
                            </li>
                            <!-- Events -->
                            <li class="last expanded">
                                <a href="{{aboutUri}}/about/events" title=""><@orcid.msg 'public-layout.events'/></a>
                            </li>
                        </ul>
                    </li>
                    <!-- HELP -->
                    <li class="expanded">
                        <a href="{{aboutUri}}/help" (click)="handleMobileMenuOption($event)"><@orcid.msg 'public-layout.help'/></a>
                        <ul class="menu lang-fixes">
                            <!-- Mobile view Only -->
                            <li class="first leaf hidden-md hidden-lg hidden-sm visible-xs">
                                <a href="{{aboutUri}}/help"><@orcid.msg 'public-layout.help'/></a>
                            </li>
                            <li class="first leaf">
                                <a href="{{aboutUri}}/faq-page" title=""><@orcid.msg 'public-layout.faq'/></a>
                            </li>
                            <li class="leaf">
                                <a href="{{aboutUri}}/help/contact-us" title=""><@orcid.msg 'public-layout.contact_us'/></a>
                            </li>
                            <li class="leaf">
                                <a href="https://support.orcid.org/hc/en-us/community/topics" title=""><@orcid.msg 'public-layout.give_feedback'/></a>
                            </li>
                            <li class="last leaf">
                                <a href="<@orcid.msg 'common.kb_uri_help_center_home'/>" title=""><@orcid.msg 'public-layout.knowledge_base'/></a>
                            </li>
                        </ul>
                    </li>
                    
                    <!-- SIGN IN/OUT -->
                    <li class="last leaf">                    
                        <a *ngIf="!userInfo['REAL_USER_ORCID']" href="{{getBaseUri()}}/signin"><@orcid.msg 'public-layout.sign_in'/></a>                    
                        <a *ngIf="userInfo['REAL_USER_ORCID']" href="{{getBaseUri()}}/signout"><@orcid.msg 'public-layout.sign_out'/></a>
                    </li>                    

                </ul>  
            <div class="header-secondary-bar-row">
            </div>
        </div>

    </div>   
</div> 
</script>