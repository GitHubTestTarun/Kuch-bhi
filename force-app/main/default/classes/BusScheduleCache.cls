public class BusScheduleCache {
    
    private Cache.OrgPartition part;
    String partitionName = 'local.BusSchedule';
    public BusScheduleCache() {
        Cache.OrgPartition orgPart = Cache.Org.getPartition(partitionName);
        part = orgPart;
    }
    
    public void putSchedule(String busLine, Time[] schedule) {
        part.put(busLine, schedule);
    }
    
    public Time[] getSchedule(String busLine) {
        Time[] schedule = new List<Time>();
        Time t2;
        // Get a cached value and Cast return value to a specific data type
        if(part.get(busLine)!=null) {
		 	t2 = (Time)part.get(busLine);
            schedule.add(t2);
        }
        else {
            Time t3 = Time.newInstance(8,0,0,0);
            schedule.add(t3);
            Time t4 = Time.newInstance(17,0,0,0);
            schedule.add(t4);
        }     
        return schedule;
    } 
}