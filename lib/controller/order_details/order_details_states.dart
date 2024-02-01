abstract class OrderDetailsStates {}

class InitialOrderDetailsState extends OrderDetailsStates {}

class GetOrderDetailsLoadingState extends OrderDetailsStates {}

class GetOrderDetailsSuccessState extends OrderDetailsStates {}

class GetOrderDetailsFailureState extends OrderDetailsStates {}
