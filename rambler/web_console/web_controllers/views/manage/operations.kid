<html py:layout="template('layout')" xmlns:py="http://purl.org/kid/ns#">
  <script py:def="page_specific_header()" language="javascript" type="text/javascript"><!--
  $(function () {
        var oTable = $('#options').dataTable( {
          "bProcessing": true,
            "sAjaxSource": "/manage/operations",
            "fnServerData": function ( sSource, aoData, fnCallback ) {
              $.ajax( {
                "dataType": 'json', 
                "type": "GET", 
                "url": sSource,
                "success": function(data){
                  aoData = $.map(data.queues, function(i,e){return [[i]]});
                  fnCallback({'aaData':aoData , 'aoColumns': [{sTitle: 'foo'}]});
                }
            } );
          }
        })
  }); 
  //-->
  </script>
  
  <div py:match="item.tag == 'content'">
     <table cellpadding="0" cellspacing="0" border="0" class="display" id="options">
       <thead>
         <tr>
           <th width="20%">Option</th>
         </tr>
       </thead>
       <tbody>
         <tr>
           <td colspan="2" class="dataTables_empty">Loading data from server</td>
         </tr>
       </tbody>
       <tfoot>
         <tr>
           <th>Option</th>
         </tr>
       </tfoot>
     </table>
  </div>

</html>