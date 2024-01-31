- @Value -- the immutable variant of @Data

#### @EqualsAndHansCode
`@EaualsAndHashCode` may cause errors by JPA.
- Error 1: wrong hash value with `GenerationType.IDENTITY`
  ```
  @Entity
  @EqualsAndHashCode
  public class TestEntity {

   @Id
   @GeneratedValue(strategy = GenerationType.IDENTITY)
   @Column(nullable = false)
   private Long id;
}
  ```
