abstract class ComplaintStates {}

class InitialComplaintState extends ComplaintStates {}

class AddComplaintLoadingState extends ComplaintStates {}

class AddComplaintSuccessState extends ComplaintStates {}

class AddComplaintFailureState extends ComplaintStates {}

class ChangeComplaintState extends ComplaintStates {}
