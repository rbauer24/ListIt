/*
 * Controller where we get the data on songs
*/


(function() {
    'use strict';
    var myApp = angular.module("songs");
    myApp.controller('dataControl', function($scope, $http, $window) {
        
        
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
        
        
        // data on songs
        $http.get("getsongs.php")
            .then(function(response) {
                $scope.songs = response.data;    
            });
        
        // function to save a song        
        $scope.saveSong = function(songDetails) {
            var songs = angular.copy(songDetails);
            
            $http.post("savesong.php", songs)
                .then(function(response) {
                    if (response.status == 200) {
                        if(response.data.status == 'error') {
                            alert ('error: ' + response.data.message);
                        } else{
                            // successful
                            $window.location.href = "index.html";
                        }
                        
                    } else {
                        alert ('unexpected error');
                    }
                }
                );
            };        

        // function to update a song        
        $scope.updateSong = function(songDetails, id) {
            var songs = angular.copy(songDetails);
            
            songs.id = id;

            $http.post("updatesong.php", songs)
                .then(function(response) {
                    if (response.status == 200) {
                        if(response.data.status == 'error') {
                            alert ('error: ' + response.data.message);
                        } else{
                            // successful
                            $window.location.href = "index.html";
                        }
                        
                    } else {
                        alert ('unexpected error');
                    }
                }
                );
            };        
        
        /*
         * Function to edit a particular song
         * on -- boolean to say whether we want to edit the song or not
         * item -- the song that we want to apply this to
         */ 
        
        $scope.setEditMode = function(on, item) {
            if(on) {
                // put in edit mode
                item.year_released  = parseInt(item.year_released);
                $scope.editSong = angular.copy(item);
                item.editMode = true;
                
            } else {
                // no editing
                item.editMode = false;
            }
        };
        
        // Returns the edit mode for the current song
        $scope.getEditMode =function(item) {
            return item.editMode;
        };
        
        
        // function to delete a song
        $scope.deleteSong = function(name, id) {
            if(confirm("Are you sure that you want to delete " + name + "?")){
                
                $http.post("deletesong.php", {"id" : id})
                    .then(function(response) {
                        if (response.status == 200) {
                            if(response.data.status == 'error') {
                                alert ('error: ' + response.data.message);
                            } else{
                                // successful
                                $window.location.href = "index.html";
                            }
                            
                        } else {
                            alert ('unexpected error');
                        }
                    }
                    );
                }
            }; 
        
        
        // these are variables used for search bar
        $scope.query = {};
        $scope.queryBy = '$';
        
        // variable that tells us which menu item should be highlighted
        $scope.menuHighlight = 0;
    });
} )();