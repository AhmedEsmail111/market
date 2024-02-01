abstract class AddressesStates {}

class InitialAddressesState extends AddressesStates {}

class AddAddressLoadingState extends AddressesStates {}

class AddAddressSuccessState extends AddressesStates {}

class AddAddressFailureState extends AddressesStates {}

class UpdateAddressLoadingState extends AddressesStates {}

class UpdateAddressSuccessState extends AddressesStates {}

class UpdateAddressFailureState extends AddressesStates {}

class GetAddressesLoadingState extends AddressesStates {}

class GetAddressesSuccessState extends AddressesStates {}

class GetAddressesFailureState extends AddressesStates {}

class ChangeChosenAddressId extends AddressesStates {}
