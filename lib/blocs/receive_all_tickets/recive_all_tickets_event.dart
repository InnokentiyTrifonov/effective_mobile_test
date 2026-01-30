part of 'recive_all_tickets_bloc.dart';

sealed class ReceiveAllTicketsEvent extends Equatable {
  const ReceiveAllTicketsEvent();
}

final class ReceiveTickets extends ReceiveAllTicketsEvent {
  @override
  List<Object?> get props => [];
}
