public with sharing class InlineVfPageProfessorController {
    public string Ids{get; set;}
    public boolean flag{get;set;}
    public InlineVfPageProfessorController(ApexPages.StandardController controller) {
        Ids = controller.getId();
        }
        public List<Student__c> getAllStudents() {
        List<Course__c> CourseList = [Select Name, Professor_del__c 
                    FROM Course__c
                    WHERE Professor_del__c =: Ids 
                    AND Professor_del__c != NULL];
        List<Id> CourseListIdList= new List<Id>();
        for(Course__c course : CourseList) {
            CourseListIdList.add(course.Id);
        }        
        List<Student_Professor__c> JunctionObj = [SELECT Id, Name, Select_Student__c
                                                                FROM Student_Professor__c
                                                                WHERE Course_select__c IN: CourseListIdList];                                                                
        System.debug('-------------' + JunctionObj);        
        List<Id> studentsId = new List<Id>();
        for(Student_Professor__c junction : JunctionObj) {
            studentsId.add(junction.Select_Student__c);
        }        
        List<Student__c> Students = [SELECT Id, Name, Number_of_Courses__c
                                                FROM Student__c
                                                WHERE Id IN: studentsId];                                              
        System.debug('\\\\\\' + Students);       
        
        if (Course__c.Professor_del__c != NULL){
            flag = true;
        }
        else{
            flag = false;
        }
    return Students; 
    }

}