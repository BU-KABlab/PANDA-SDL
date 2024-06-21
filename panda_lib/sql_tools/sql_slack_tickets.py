from dataclasses import dataclass

from panda_lib.sql_tools.sql_utilities import execute_sql_command, execute_sql_command_no_return


# region Slack Tickets
@dataclass
class SlackTicket:
    msg_id: str
    channel_id: str
    msg_txt: str
    valid_cmd: int
    timestamp: str
    addressed_timestamp: str

def insert_slack_ticket(ticket: SlackTicket) -> None:
    """
    Insert a slack ticket into the slack_tickets table.

    Args:
        ticket (SlackTicket): The slack ticket to insert.
    """
    execute_sql_command_no_return(
        """
        INSERT INTO slack_tickets (
            msg_id,
            channel_id,
            msg_text,
            valid_cmd,
            timestamp,
            addressed_timestamp
            )
        VALUES (?, ?, ?, ?, ?, ?)
        """,
        (
            ticket.msg_id,
            ticket.channel_id,
            ticket.msg_text,
            ticket.valid_cmd,
            ticket.timestamp,
            ticket.addressed_timestamp,
        ),
    )

def select_slack_ticket(msg_id: str) -> SlackTicket:
    """
    Select a slack ticket from the slack_tickets table.

    Args:
        msg_id (str): The message ID of the slack ticket.

    Returns:
        SlackTicket: The slack ticket.
    """
    result = execute_sql_command(
        """
        SELECT
            msg_id,
            channel_id,
            msg_text,
            valid_cmd,
            timestamp,
            addressed_timestamp
        FROM slack_tickets
        WHERE msg_id = ?
        """,
        (msg_id,),
    )
    if result == []:
        return None
    return SlackTicket(*result[0])


# endregion