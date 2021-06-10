package session;

import entity.PromoCode;
import jakarta.ejb.Stateless;
import jakarta.persistence.EntityManager;
import jakarta.persistence.PersistenceContext;

@Stateless
public class PromoCodeFacade extends AbstractFacade<PromoCode> {

    @PersistenceContext(unitName = "JPTVR19WebShopPU")
    private EntityManager entityManager;

    @Override
    protected EntityManager getEntityManager() {
        return entityManager;
    }

    public PromoCodeFacade() {
        super(PromoCode.class);
    }

    public PromoCode findPromoCodeName(String promoCodeName) {
        try {
            return (PromoCode) entityManager.createQuery("SELECT promoCode FROM PromoCode promoCode WHERE promoCode.promoCodeName=:promoCodeName")
                    .setParameter("promoCodeName", promoCodeName)
                    .getSingleResult();
        } catch (Exception e) {
            return null;
        }
    }
}
