package org.geoserver.monitoring.monitors.hb;

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

    public void add(RequestStats reqStats) {
        entityManager.persist(reqStats);
    }

    public List<RequestStats> getPagedRequests(int start, int pageSize) {
        Query selectQuery = entityManager.createQuery("from RequestStats rs order by rs.startTime desc");
        selectQuery.setMaxResults(pageSize);
        selectQuery.setFirstResult(0);
        return selectQuery.getResultList();
    }

    @PersistenceContext
    public void setEntityManager(EntityManager entityManager) {
        this.entityManager = entityManager;
    }

}
