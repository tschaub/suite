package org.geoserver.monitoring.monitors.hb;

import java.util.Date;
import java.util.List;

import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.persistence.Query;

import org.geoserver.monitoring.monitors.RequestMonitorDAO;
import org.geoserver.monitoring.monitors.RequestStats;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

@Repository
@Transactional
public class RequestMonitorDAOImpl implements RequestMonitorDAO {

    protected EntityManager entityManager;

    @PersistenceContext
    public void setEntityManager(EntityManager entityManager) {
        this.entityManager = entityManager;
    }

    public void add(RequestStats reqStats) {
        entityManager.persist(reqStats);
    }

    public List<RequestStats> getPagedRequests(Date from, Date to, int start, int pageSize) {
        Query selectQuery = getRequestsByInterval(from, to, false);
        selectQuery.setMaxResults(pageSize);
        selectQuery.setFirstResult(0);
        return selectQuery.getResultList();
    }

    public long getRequestsCount(Date from, Date to) {
        Query selectQuery = getRequestsByInterval(from, to, true);
        return (Long) selectQuery.getSingleResult();
    }

    /**
     * Builds a query for requests in a certain time interval. Boy, how much I miss the Hibernate
     * Criteria API...
     * 
     * @param from The from date, or null
     * @param to The to date, or null
     * @param count True if the query should just return a count of the results, false otherwise
     * @return
     */
    Query getRequestsByInterval(Date from, Date to, boolean count) {
        StringBuffer sb = new StringBuffer();
        if (count)
            sb.append("select count(*) ");
        sb.append("from RequestStats rs ");
        if (from != null || to != null) {
            sb.append("where ");
        }
        if (from != null) {
            sb.append("rs.startTime >= ? ");
            if (to != null)
                sb.append("and ");
        }
        if (to != null) {
            sb.append("rs.startTime <= ? ");
        }
        if(!count)
            sb.append("order by rs.startTime desc");

        Query query = entityManager.createQuery(sb.toString());
        if (from != null) {
            query.setParameter(1, from);
        }
        if (to != null) {
            query.setParameter(2, to);
        }

        return query;
    }

}
