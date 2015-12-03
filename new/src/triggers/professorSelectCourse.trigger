trigger professorSelectCourse on Course__c (after insert, after update) {
    if (trigger.isAfter){
            set<Id> listIds = new set<Id>();
            List<Course__c> CoursesList = new List<Course__c>();
            for(Course__c Courses : trigger.new){
                CoursesList.add(Courses);
                listIds.add(Courses.Professor_del__c);
            }
            for(Course__c course : Trigger.new) {
                List<Course__c> courseList = [
                                            SELECT Name, Professor_del__c 
                                            FROM Course__c
                                            WHERE Professor_del__c IN: listIds AND Professor_del__c != NULL];
                if(courseList.size() <= 4){
                system.debug('>>>>>>>>>>>>>' + courseList);
            }
            else{   
                course.addError('A professor cannot take more than 4 Course at a time.');
            }
        }
        Map<Id, Course__c> CourseMap = new Map<Id, Course__c>();
        List<Course__c> fullCourseList = [SELECT Id, Name, Professor_del__c, Professor_Email__c FROM Course__c WHERE Id IN: Trigger.newMap.keySet()];
        for (Course__c course1 : fullCourseList) {
            if (Trigger.isInsert) {
                CourseMap.put(course1.Professor_del__c, course1);
            }
            if (Trigger.isUpdate && Trigger.oldMap.get(course1.Id).Professor_del__c != course1.Professor_del__c && course1.Professor_del__c != NULL) {
                CourseMap.put(course1.Professor_del__c, course1);
            }
       }
       List<Course__c> listToBeUpdated = new List<Course__c>();
       List<Professor__c> mainProfList = [
       SELECT Name, Email__c
       FROM Professor__c 
       WHERE Id IN: CourseMap.keySet()];
       for (Course__c course1 : CourseMap.values()) {
           for (Integer i = 0; i < mainProfList.size(); i++) {
                if (course1.Professor_del__c == mainProfList[i].Id) {
                    course1.Professor_Email__c = mainProfList[i].Email__c;
                    listToBeUpdated.add(course1);
                }
           }
       }
       System.debug('listToBeUpdated------------' + listToBeUpdated);
       update listToBeUpdated; 
    } 
}