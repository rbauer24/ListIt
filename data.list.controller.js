// this code is from JP's 'data.soccer.controller.js'
// data on lists in the end

(function () {
    'use strict';
    
    var myApp = angular.module("ListIt");
    myApp.controller("dataControl", function($scope, $http, $window) {
		
         // vote for list
        $scope.voteforlist = function(list) {
            var id = angular.copy(list);
            
             $http.post("votes.php", {"id":id}) // needs to send list_id for the list being voted on
                .then(function (response) {
                if (response.status == 200) {
                    if (response.data.status == 'error') {
                        alert ('error: ' + response.data.message);
                    } else {
                        //successful
                        $window.location.href ="index.html"; // doesn't need to reload page
                    }
                } else {
                    alert('unexpected error');
                }
            });
        };
        
        
        // function to update a item
        $scope.updateitem = function(value, itemid) {
			var newitemvalue = angular.copy(value);
            var dataupload = {"itemid":itemid, "data":newitemvalue};
					
            
			$http.post("updateitem.php", dataupload)
							.then(function(response) {
                                
					if (response.status == 200) {
                        if (response.data.status == 'error') {
                            alert ('error: ' + response.data.message);
                        } else {
                            //successful
                            $window.location.href ="editlist.html";		// reload page
                        }
                    } else {
                        alert('unexpected error');
					}
            });
      };
        
        
         /*
         * Function to edit a particular item
         * on -- boolean to say whether we want to edit item
         * item -- the item that we want to apply this to
         */
        $scope.seteditmode = function(on, item) {
            if (on) {
                // put it in edit mode
                
                $scope.edititem = [];
                $scope.edititem.value = [];
                
                // needs to change so that comes from database
                for(var i = 0; i < item.attributes.length; i++) {
                    $scope.edititem.value.push(item.attributes[i].value);
                }
                //$scope.edititem= angular.copy(item.attributes);
                item.editmode = true;
            } else {
                // no editing
                item.editmode = false;
            }
        };
        
        // returns the editMode for the current item (or song)
        $scope.geteditmode = function(item) {
            return item.editmode;
        };
        
        
       // function to delete a item
        $scope.deleteitem = function(id) {
            if (confirm("Are you sure you want to delete this item?")) {
                
                $http.post("deleteitem.php", {"id" : id})
                    .then(function (response) {
                    if (response.status == 200) {
                        if (response.data.status == 'error') {
                            alert ('error: ' + response.data.message);
                        } else {
                            //successful
                            $window.location.href ="editlist.html"; // send back to updated editlist page with item deleted
                        }
                    } else {
                        alert('unexpected error');
                    }
                });
            }
        };
        
        // is getting curent list id
        $scope.getcurrentlistid = function() {
           $http.post("getcurrentlistid.php")
                .then(function (response) {
                if (response.status == 200) {
                    if (response.data.status == 'error') {
                        alert ('error: ' + response.data.message);
                    } else {
                        //successful
                        // return your listid 
                        $scope.currentlistid = response.data.listid;
                    }
                } else {
                    alert('unexpected error');
                }
            });            
        };
        
       
       //sample from jp website
    $scope.account_id = "";
    var selectedArea = null;
    
    $scope.selectArea = function(newArea) {
        selectedArea = newArea;
    };
    
    /*
     * new Filter list based on selected list setting for editlist.html change
     */
    $scope.areaEdit = function(list) {
            // show only user's lists
            if (list.id == $scope.currentlistid) {
                return true;
            } else {
                return false;
            }
    };
    /*
     * Filter list based on selected list setting
     */
    $scope.areaFilter = function(list) {
        if (selectedArea === null) {
            // show all lists
            return true;
        } else {
            // show only user's lists
            if (list.account_id == $scope.account_id) {
                return true;
            } else {
                return false;
            }
        }
    };
    
    $scope.getAreaClass = function (area) {
      if ((selectedArea == area) || (area == 'all' && selectedArea === null)) {
        return "btn-primary";
      } else {
        return "";
      }
    };
       
        // get userlist
        $http.get("getUserLists.php")
            .then(function(response) {
                $scope.userlists = response.data;
            });
       
       //  go to edit user list page (editExistingList.html) 
        $scope.editExistingList = function(editlist) {
            var userlist = angular.copy(editlist);
            
             $http.post("setcurrentlistid.php", userlist)
                .then(function (response) {
                if (response.status == 200) {
                    if (response.data.status == 'error') {
                        alert ('error: ' + response.data.message);
                    } else {
                        //successful
                        $window.location.href ="editlist.html"; // sends to edit list page with new changes to show items in list this is to manage it like jp said
                    }
                } else {
                    alert('unexpected error');
                }
            });
        };
       
       
        // get template
        $http.get("getTemplate.php")
            .then(function(response) {
                $scope.templates = response.data;
            });
        
        
         // saves new item to list  
        $scope.newitem = function(saveitem) {
            var items = angular.copy(saveitem);
            
             $http.post("saveitem.php", items)
                .then(function (response) {
                if (response.status == 200) {
                    if (response.data.status == 'error') {
                        alert ('error: ' + response.data.message);
                    } else {
                        //successful
                        $window.location.href ="editlist.html"; // sends to edit list page
                    }
                } else {
                    alert('unexpected error');
                }
            });
        };
        
        
        
        // saves new list name and publish it 
        $scope.publishList = function(publishit) {
            var publishitems = angular.copy(publishit);
            
             $http.post("editlist.php", publishitems )
                .then(function (response) {
                if (response.status == 200) {
                    if (response.data.status == 'error') {
                        alert ('error: ' + response.data.message);
                    } else {
                        //successful
                        $window.location.href ="editlist.html"; // sends to edit list page
                    }
                } else {
                    alert('unexpected error');
                }
            });
        };
        
        
           // saves and add more 
        $scope.editList = function(listItem) {
            var itemsInL = angular.copy(listItem);
            
             $http.post("editlist.php", itemsInL)
                .then(function (response) {
                if (response.status == 200) {
                    if (response.data.status == 'error') {
                        alert ('error: ' + response.data.message);
                    } else {
                        //successful
                        $window.location.href ="editlist.html"; // sends to edit list page
                    }
                } else {
                    alert('unexpected error');
                }
            });
        };
        
        	
           // saves new list name
        $scope.newList = function(listname) {
            var name = angular.copy(listname);
            
             $http.post("createlist.php", name)
                .then(function (response) {
                if (response.status == 200) {
                    if (response.data.status == 'error') {
                        alert ('error: ' + response.data.message);
                    } else {
                        //successful
                        $window.location.href ="editlist.html"; // sends to edit list page
                    }
                } else {
                    alert('unexpected error');
                }
            });
        };
        
        
        
		/*
         * Account related functions
         * /
         */
        // saves new account
        $scope.newAccount = function(accountDetails) {
            var account = angular.copy(accountDetails);
            
            $http.post("newaccount.php", account)
                .then(function (response) {
                if (response.status == 200) {
                    if (response.data.status == 'error') {
                        alert ('error: ' + response.data.message);
                    } else {
                        //successful
                        $window.location.href ="index.html";
                    }
                } else {
                    alert('unexpected error');
                }
            });
        };
        
        // logs in
        $scope.login = function(credentialDetails) {
            var credentials = angular.copy(credentialDetails);
            
            $http.post("login.php", credentials)
                .then(function (response) {
                if (response.status == 200) {
                    if (response.data.status == 'error') {
                        alert ('error: ' + response.data.message);
                    } else {
                        //successful
                        $window.location.href ="index.html";
                    }
                } else {
                    alert('unexpected error');
                }
            });
        };        
        

        // logs out
        $scope.logout = function() {
            $http.post("logout.php")
                .then(function (response) {
                if (response.status == 200) {
                    if (response.data.status == 'error') {
                        alert ('error: ' + response);
                    } else {
                        //successful
                        $window.location.href ="index.html";
                    }
                } else {
                    alert('unexpected error');
                }
            });
        };
        
        // is logged in
        $scope.isloggedin = function() {
           $http.post("isloggedin.php")
                .then(function (response) {
                if (response.status == 200) {
                    if (response.data.status == 'error') {
                        alert ('error: ' + response.data.message);
                    } else {
                        //successful
                        // return whether logged in or not
                        $scope.isloggedin = response.data.loggedin;
                        $scope.account_id = response.data.account_id;
                    }
                } else {
                    alert('unexpected error');
                }
            });            
        };
        
        // get session variable
        $scope.getSessionVariable = function(attribute) {
           $http.post("getsessionvariable.php", attribute)
                .then(function (response) {
                if (response.status == 200) {
                    if (response.data.status == 'error') {
                        alert ('error: ' + response.data.message);
                    } else {
                        //successful
                        // return value of attribute
                        return response.data.value;
                    }
                } else {
                    alert('unexpected error');
                }
            });            
        };
        
        // set session variable
        $scope.setSessionVariable = function(attribute, value) {
           $http.post("setsessionvariable.php", {"attribute": attribute, "value":value})
                .then(function (response) {
                if (response.status == 200) {
                    if (response.data.status == 'error') {
                        alert ('error: ' + response.data.message);
                    } else {
                        //successful
                        return true;
                    }
                } else {
                    alert('unexpected error');
                }
            });            
        };
        
      
        // data on template attributes
                // set session variable
        $scope.getAttr = function() {
            $http.get("getAttr.php")
                .then(function(response) {
                    console.log(response);
                    $scope.attrs = response.data.value;
                });
                
        };

   
        // from JP Code
        // data on lists
        $http.get("getlists.php")
            .then(function(response) {
                $scope.data = response.data.value;
            });        
        
        // these are variables used for the search bar
        $scope.query = {};
        $scope.queryBy = "$";
      
      
        $scope.datatype = function(item) {
        return item.type;
      };
    });
} )();
