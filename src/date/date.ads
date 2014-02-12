package Date is

   --  data types
   --  http://beru.univ-brest.fr/~singhoff/DOC/LANG/ADA/BOOK/10.html
   --  http://en.wikipedia.org/wiki/Integer_%28computer_science%29
   type Byte is mod 256;

   subtype Short is Short_Integer'Base;
   subtype Long is Long_Long_Integer'Base range -(2**63) .. +(2**63 - 1);

   type Date_Type is
      record
         Date : Long;
      end record;

end Date;
