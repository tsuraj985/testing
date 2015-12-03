public with sharing class ListOfStudentsinClass{
    public string coursesString{get;set;}
    public List<Course__c> CourseName{get; set;}
    public boolean flag{get;set;}
    List<Course__c> CourseList = new List<Course__c>();
        public ListOfStudentsinClass(ApexPages.StandardController ST){
            string coursesString=ST.getId();
            CourseList = [
            SELECT Name, Professor_del__c, Select_University__c
            FROM Course__c
            WHERE Select_University__c =: coursesString
            AND Professor_del__c =: NULL];
            system.debug('>>>>>>' +CourseList);
            if ( NULL != Course__c.Professor_del__c){
                flag=true;
            }
            else{
            flag=false;
            }
        }
        public List<Course__c> getCourses() {
            return CourseList;
        }
}