<!DOCTYPE html>
<html lang="en" data-layout-decorate="~{layouts/default-list-layout}">
  <head>

    <title data-th-text="|${r"#{"}label_show_entity(${r"#{"}${entityLabel}${r"}"})${r"}"}|">Show ${entityName} - Spring Roo application</title>

  </head>

  <#if userManagedComponents?has_content && userManagedComponents["body"]??>
    ${userManagedComponents["body"]}
  <#else>
  <body id="body">

    <header role="banner">
      <!-- Content replaced by layout of the page displayed -->
    </header>

    <!--CONTAINER-->
    <div class="container bg-container">
      <!-- CONTENT -->
      <!--
        Only the inner content of the following tag "section" is included
        within the template, in the section "content"
      -->
      <section data-layout-fragment="content" data-th-object="${modelAttribute}">
        <div class="container-fluid content">

          <!-- CONTENT -->
          <h1 data-th-text="${r"#{"}label_show_entity(${r"#{"}${entityLabel}})}">Show ${entityName}</h1>

            <div id="mainEntityFieldSet">
              <h2 data-th-text="${r"#{"}label_data_entity(${r"#{"}${entityLabel}})}">${entityName} data</h2>
              <ul class="list-unstyled" id="containerFields">
              <#list fields as field>
                <#if field.userManaged>
                  ${field.codeManaged}
                <#else>
                  <li id="${field.fieldId}" data-z="${field.z}">
            	      <strong data-th-text="${r"#{"}${field.label}}">${field.fieldName}</strong>
                    <span data-th-text="*{{${field.fieldName}}}">${field.fieldName}Value</span>
         	        </li>
                </#if>
              </#list>
              </ul>
            </div>

            <#if compositeRelationFields?has_content>
              <#list compositeRelationFields?keys as referencedField>
                <div id="${referencedField}FieldSet">
                  <#list compositeRelationFields[referencedField] as field>
                  <#if field?index == 0>
                  <h2 data-th-text="${r"#{"}label_data_entity(${r"#{"}${field.legendLabel}})}">${field.entityName} data</h2>
                  <ul class="list-unstyled" id="containerFields">
                  </#if>
                    <#if field.userManaged>
                      ${field.codeManaged}
                    <#else>
                      <li id="${field.fieldId}" data-z="${field.z}">
                        <strong data-th-text="${r"#{"}${field.label}}">${field.fieldName}</strong>
                        <span data-th-text="*{{${field.fieldName}}}">${field.fieldName}Value</span>
                      </li>
                    </#if>
                 </#list>
                 </ul>
                </div>
              </#list>
            </#if>

          <!-- details -->
          <#if details?size != 0>
            <hr>
            <ul class="nav nav-tabs">
            <#assign firstDetail=true>
            <#list details as field>
              <#if firstDetail == true>
                <li class="active"><a id="${field.fieldNameCapitalized}Tab" data-toggle="tab" href="#detail-${field.fieldNameCapitalized}">${field.fieldNameCapitalized}</a></li>
                <#assign firstDetail=false>
              <#else>
                  <li><a id="${field.fieldNameCapitalized}Tab" data-toggle="tab" href="#detail-${field.fieldNameCapitalized}">${field.fieldNameCapitalized}</a></li>
              </#if>
            </#list>
            </ul>

            <div class="tab-content">
              <#assign firstDetail=true>
              <#list details as field>
                  <#if firstDetail == true>
                      <div id="detail-${field.fieldNameCapitalized}" class="tab-pane active">
                      <#assign firstDetail=false>
                  <#else>
                      <div id="detail-${field.fieldNameCapitalized}" class="tab-pane">
                  </#if>
                      <!-- TABLE -->
                      <div class="table-responsive">
                        <table id="${field.fieldNameCapitalized}Table" style="width: 99.7%"
                               class="table table-striped table-hover table-bordered"
                               data-row-id="${field.configuration.identifierField}"
                               data-select="single"
                               data-z="${field.z}"
                               data-order="[[ 0, &quot;asc&quot; ]]">
                          <caption data-th-text="${r"#{"}label_list_of_entity(${r"#{"}${field.configuration.referencedFieldLabel}${r"}"})${r"}"}">${field.fieldNameCapitalized} List</caption>
                          <thead>
                            <tr>
                              <#list field.configuration.referenceFieldFields as referencedFieldField>
                              <th data-th-text="${r"#{"}${referencedFieldField.label}${r"}"}">${referencedFieldField.fieldName}</th>
                              </#list>
                              <th data-th-text="${r"#{"}label_tools${r"}"}">Tools</th>
                            </tr>
                          </thead>
                          <tbody data-th-remove="all">
                            <tr>
                              <#list field.configuration.referenceFieldFields as referencedFieldField>
                              <td>${referencedFieldField.fieldName}</td>
                              </#list>
                              <td data-th-text="${r"#{"}label_tools${r"}"}">Tools</td>
                            </tr>
                          </tbody>
                        </table>
                      </div>
                      <!-- /TABLE -->
                  </div>
                </#list>
            </div>
          </#if>

          <div class="clearfix">
            <div class="pull-left">
              <a id="${entityName}_list" href="list.html" class="btn btn-default"
                 data-th-title="${r"#{"}label_goBack}"
  	             data-th-href="${"${"}@linkBuilder.of('${mvcCollectionControllerName}').to('list')}">
  	             <span class="glyphicon glyphicon-chevron-left" aria-hidden="true"></span>
  	             <span data-th-text="${r"#{"}label_back}">Back</span>
  	          </a>
            </div>
            <div class="pull-right">
      	       <a id="${entityName}_edit" href="edit.html" class="btn btn-primary"
      	           data-th-title="${r"#{"}label_goEdit}"
      	           data-th-href="${"${"}@linkBuilder.of('${mvcItemControllerName}').to('editForm').with('${modelAttributeName}', ${modelAttributeName}.${identifierField})}"
      	           data-th-text="${r"#{"}label_edit}">Edit</a>
            </div>
          </div>

        </div>
        <!-- /CONTENT-->

        <!-- MODAL -->
        <#if details?size != 0>
        <div
          data-layout-include="fragments/modal :: modal(id='delete${entityName}', title=${r"#{"}label_delete}")">

          <script type="text/javascript">
              function openDeleteModal(){
                jQuery('#staticModal').modal();
              }
            </script>

          <div class="modal fade" id="staticModal" tabindex="-1" role="dialog"
            aria-labelledby="staticModalLabel">
            <div class="modal-dialog" role="document">
              <div class="modal-content">
                <div class="modal-header">
                  <button type="button" class="close" data-dismiss="modal"
                    aria-label="${r"#{"}label_close}">
                    <span aria-hidden="true">&times;</span>
                  </button>
                  <h2 class="modal-title" id="staticModalLabel" data-th-text="${r"#{"}label_delete}">Delete</h2>
                </div>
                <div class="modal-body" id="staticModalBody">
                  <p data-th-text="${r"#{"}label_message}">Message</p>
                </div>
              </div>
            </div>
          </div>
        </div>
        </#if>
      </section>
      <!-- /CONTENT -->
  </div>
  <!-- /CONTAINER -->

  <footer class="container">
    <!-- Content replaced by layout of the page displayed -->
  </footer>

  <!-- JavaScript
  ================================================== -->
  <!-- Placed at the end of the document so that the pages load faster -->
  <!-- JavaScript loaded by layout of the page displayed -->
  <!--
       Only the inner content of the following tag "javascript" is included
       within the template, in the div "javascript"
      -->
  <div data-layout-fragment="javascript">
  </div>

  </body>
  </#if>

</html>
