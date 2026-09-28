FROM registry.redhat.io/rhbk/keycloak-rhel9:26.4 AS builder

ENV KC_FIPS_MODE=strict
ENV KC_HEALTH_ENABLED=true
ENV KC_METRICS_ENABLED=true

RUN /opt/keycloak/bin/kc.sh build --features=fips

FROM registry.redhat.io/rhbk/keycloak-rhel9:26.4

COPY --from=builder /opt/keycloak/ /opt/keycloak/

ENV KC_FIPS_MODE=strict

ENTRYPOINT ["/opt/keycloak/bin/kc.sh"]
