# --
# Copyright (C) 2021 mo-azfar, https://github.com/mo-azfar/OTRS-ZnunyLTS-Enforce-Closing-of-Escalated-Tickets
# --
# This software comes with ABSOLUTELY NO WARRANTY. For details, see
# the enclosed file COPYING for license information (GPL). If you
# did not receive this file, see https://www.gnu.org/licenses/gpl-3.0.txt.
# --

package Kernel::Output::HTML::Notification::AgentEscalationCheckRedirect;

use strict;
use warnings;

use Kernel::Language qw(Translatable);

our @ObjectDependencies = (
    'Kernel::System::Ticket',
    'Kernel::Output::HTML::Layout',
);

sub new {
    my ( $Type, %Param ) = @_;
   
    # allocate new hash for object
    my $Self = {%Param};
    bless( $Self, $Type );

    return $Self;
}

sub Run {
    my ( $Self, %Param ) = @_;

    my $TicketObject = $Kernel::OM->Get('Kernel::System::Ticket');
    my $LayoutObject = $Kernel::OM->Get('Kernel::Output::HTML::Layout');
        
    my @TicketIDs = $TicketObject->TicketSearch(
        Result => 'ARRAY',
        # ticket escalation time of more than 1 minutes ago (optional)
        TicketEscalationTimeOlderMinutes => -1,
        OwnerIDs => [$Self->{UserID}],
        UserID => $Self->{UserID},
    );
   
        
    my $Output = '';
    my $Text;
    
    if (scalar @TicketIDs)
    {
        if ( $LayoutObject->{Action} eq 'AgentTicketZoom' ) 
        {
            if ( not grep( /^$Self->{TicketID}$/, @TicketIDs ) ) 
            {
                 $Text = '
<script>
window.location.search = "Action=AgentTicketEscalationView";
</script>';
                
                $Output= $LayoutObject->Notify(
                    Data     => $Text."There are escalated ticket. Update or resolved them first!",
                    Link     => $LayoutObject->{Baselink} . 'Action=AgentTicketEscalationView',
                    Priority => 'Warning',
                );

            }        
            
        }
        else
        {
            $Text = '
<script>
if (!window.location.search.match(/^[?]Action=(AgentTicketEscalationView|Admin.*|AgentFAQ.*|AgentITSM.*|AgentStatistics.*|AgentTicketZoom)/)) {
    window.location.search = "Action=AgentTicketEscalationView";
}
</script>';

            $Output= $LayoutObject->Notify(
                Data     => $Text."There are escalated ticket. Update or resolved them first!",
                Link     => $LayoutObject->{Baselink} . 'Action=AgentTicketEscalationView',
                Priority => 'Warning',
            );
                
        }
        
    }

    return $Output;
}

1;