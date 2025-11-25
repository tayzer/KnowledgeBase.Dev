### What Should Be in Mappers

1. **Direct Property Mapping:** Copying values from one object to another where the mapping is direct and consistent regardless of the application's state.
    
2. **Basic Transformations:** Simple data transformations, such as formatting strings, converting data types, or defaulting values when null.
    
3. **Stateless Operations:** Operations that do not depend on external state or conditions beyond the data in the objects being mapped.
    

### What Should Not Be in Mappers

1. **Business Logic:** Any logic that involves business rules, decisions, or calculations based on application state or user context.
    
2. **External Dependencies:** Dependencies on external services, context objects like HTTP requests, user sessions, or other components that represent the application's runtime state.
    
3. **Conditional Logic Based on Application State:** Decisions based on the current state of the application, user permissions, or other dynamic contexts.
    
4. **Side Effects:** Operations that cause changes outside the scope of the mapping, like database access, file I/O, network calls, etc.