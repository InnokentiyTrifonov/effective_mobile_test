part of 'recive_all_tickets_bloc.dart';

sealed class ReceiveAllTicketsState extends Equatable {
  const ReceiveAllTicketsState();
}

final class ReceiveAllTicketsInitial extends ReceiveAllTicketsState {
  @override
  List<Object> get props => [];
}

final class TicketsReceivedFailed extends ReceiveAllTicketsState {
  final String message;

  const TicketsReceivedFailed({required this.message});
  @override
  List<Object?> get props => [message];
}

final class TicketsReceivedSuccesful extends ReceiveAllTicketsState {
  final List<Ticket> tickets;

  const TicketsReceivedSuccesful({required this.tickets});
  @override
  List<Object?> get props => [tickets];
}
