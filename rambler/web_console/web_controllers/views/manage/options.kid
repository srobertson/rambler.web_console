<html py:layout="template('layout')" xmlns:py="http://purl.org/kid/ns#">
  <script py:def="page_specific_header()" language="javascript" type="text/javascript"><!--
  $(function () {
    var oTable = $('#options').dataTable( {
      "bProcessing": true,
        "sAjaxSource": "/manage/options",
        "fnServerData": function ( sSource, aoData, fnCallback ) {
          console.log(aoData)
          $.ajax( {
            "dataType": 'json', 
            "type": "GET", 
            "url": sSource,
            "success": function(data){
              fnCallback({'aaData': data, 'aoColumns': [{sTitle: 'foo'}]});
              $('td', oTable.fnGetNodes()).editable( '/manage/options', {
                  "callback": function( sValue, y ) {
                    var aPos = oTable.fnGetPosition( this );
                    oTable.fnUpdate( sValue, aPos[0], aPos[1] );
                  },
                  "submitdata": function ( value, settings ) {
                    // got to be an easier way to get this from the data tabel
                    var key = oTable.fnGetData()[oTable.fnGetPosition( this )[0]][0];
                    return {
                      id: key
                    };
                  },
                  "height": "14px"
                } );
              
            }
        } );
      }
      
    } );
    
   
  }); 
  //-->
  </script>
  
      
      <table class="display grid_8 prefix_4" py:match="item.tag == 'content'" cellpadding="0" cellspacing="0" border="0"  id="options">
         <thead>
           <tr>
             <th width="20%">Option</th>
             <th width="25%">Value</th>
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
             <th>Value</th>
           </tr>
         </tfoot>
       </table>


</html>
