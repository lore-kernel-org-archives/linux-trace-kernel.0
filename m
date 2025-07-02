Received: from relay.hostedemail.com (smtprelay0012.hostedemail.com [216.40.44.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D31433093BA;
	Wed,  2 Jul 2025 14:41:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751467271; cv=none; b=pWMlaRGcAmaOIcE2IFhgyE9E7qyDFJSq5TitW/MxqyTBUNefvkDGd3xtvyr+YBoXlSF+vSnqm9OKayUDEOSty0FiNuRPQx2OpM2obm4m2gWrkOj7O1UzqTDTCMnVyIU894soFEb2YFRSfPUTZWyII9ofkDNgxVTCYEBAi13eSiM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751467271; c=relaxed/simple;
	bh=WRet4M06rog+wFdfSt2px7AmtWl6KzJ+GTWBH8UUvQY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EJ1hVbjPrC0Zhu3AEV0lmye4Azfl42MHIEBg0sYetQdr0mLmBH42gN88nWsqF66fAzuXmCrgHLTQXdPY0dBGZf7qtQozGI17nnS1kL2KzL3YTohPwVNHx4enOsv7Fi2OtZ4SGS5lBIlnNpGTt2jw/c6/C81zxusx5VfFCAa/Yb8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf19.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay06.hostedemail.com (Postfix) with ESMTP id 1C9041063CA;
	Wed,  2 Jul 2025 14:41:02 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf19.hostedemail.com (Postfix) with ESMTPA id 5652F20025;
	Wed,  2 Jul 2025 14:41:00 +0000 (UTC)
Date: Wed, 2 Jul 2025 10:40:58 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Gabriele Paoloni <gpaoloni@redhat.com>
Cc: mhiramat@kernel.org, mathieu.desnoyers@efficios.com,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Subject: Re: [RFC PATCH RESEND] tracing: add kernel documentation for
 trace_array_set_clr_event, trace_set_clr_event and supporting functions
Message-ID: <20250702104058.3cf9c1a3@batman.local.home>
In-Reply-To: <CA+wEVJY2a_ERXemup7EefPPXHOv8DAfyauuP6Mn5vHYFkbbBcQ@mail.gmail.com>
References: <20250620085618.4489-1-gpaoloni@redhat.com>
	<20250701195939.3e297e20@gandalf.local.home>
	<CA+wEVJY2a_ERXemup7EefPPXHOv8DAfyauuP6Mn5vHYFkbbBcQ@mail.gmail.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: jtbz5wbqdes6fx3uhtmo84wsziofmoii
X-Rspamd-Server: rspamout04
X-Rspamd-Queue-Id: 5652F20025
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1/AALfJX9sgK9zLsCiTDOxcYJjjbo838Wg=
X-HE-Tag: 1751467260-89356
X-HE-Meta: U2FsdGVkX19yJuGCQVlnZnoTB83Km9/4pS0xoC+zzuZdM+PxY17LjHGlbmKyMFPG8w/X+IMvW2Z+E2Z2zP+kqO+qFKOADnQeXF4S3M6bxI/Jtc+o3XAJktF9e6IjOj37ojVb5Eg2Nsq+GKdoJmdfII6Tgz9mWeiC0vbLVlWK3iRCHzcHFNuNptn1abZAaDCmjXiWFsMwGgCgHJW1bsfC42VKfX4OLuCHTjLB/8RxoQYv+eaQ2ESMENTkqbpab9dgrP0Ft1lVhIT4HCBLn6DRe7sxs+v5TkT6esWyo+Mjx+dO/Xid6jg8Ky7sDJTAXisNHDtLyyDFXQnnXlRtQFvhmfKIrjqgx76l

On Wed, 2 Jul 2025 15:45:41 +0200
Gabriele Paoloni <gpaoloni@redhat.com> wrote:

> >  
> > > For each of the documented functions, as part of the extensive
> > > description, a set of "Function's expectations" are described in
> > > a way that facilitate:
> > > 1) evaluating the current code and any proposed modification
> > >    to behave as described;
> > > 2) writing kernel tests to verify the code to behave as described.
> > >
> > > Signed-off-by: Gabriele Paoloni <gpaoloni@redhat.com>
> > > ---
> > > Re-sending as no feedbacks have been received.  
> 
> Now that I am reading this I realized that I missed the most important
> discussion comments from v1, so I am adding them back here inline
> below (BTW one more reason to avoid RESENDs):
> 
> While working on the documentation of __ftrace_event_enable_disable,
> I realized that the EVENT_FILE_FL_SOFT_MODE flag is mainly used
> internally in the function itself, whereas it is EVENT_FILE_FL_SOFT_DISABLED
> that prevents tracing the event.
> In this perspective I see that, starting from the initial state, if for
> a specific event we invoke __ftrace_event_enable_disable with enable=1
> and soft_disable=0, the EVENT_FILE_FL_ENABLED is set whereas
> EVENT_FILE_FL_SOFT_MODE and EVENT_FILE_FL_SOFT_DISABLED are not.
> Now if for that event we invoke __ftrace_event_enable_disable again with
> enable=1 and soft_disable=1, EVENT_FILE_FL_ENABLED stays set,
> EVENT_FILE_FL_SOFT_MODE is set, while EVENT_FILE_FL_SOFT_DISABLED
> remains not set. Instead if from the initial state we directly invoke
> __ftrace_event_enable_disable with enable=1 and soft_disable=1, all
> the status flag mentioned above are all set (EVENT_FILE_FL_ENABLED,
> EVENT_FILE_FL_SOFT_MODE and EVENT_FILE_FL_SOFT_DISABLED).
> Now I wonder if:
> a) such a behaviour is consistent with the code expectation;

Yes, and I verified it by looking at the comments in the code. But this
should have been documented at the top of the function too.

> b) if it would make sense to have a standard enable invocation followed
>    by a soft enable invocation to end up in the same state as a single
>    invocation of soft enable;

No, because the two need to be done together.

> c) eventually if we could get rid of the soft_mode flag and simplify
>    the code to only use the soft_disabled flag.

The reason for the soft_mode flag is that this needs to handle two
users of the same event. One has it enabled (no soft mode at all) and
the other has it disabled in a soft mode.

The SOFT_MODE flag is to state that there's at least one user that is
using this in soft mode and has it disabled.

Let me explain the purpose of SOFT_MODE.

When you echo 1 into the enable file of an event it enables the event
and it starts tracing immediately. This would be: enable=1 soft_disable=0.

Same for echoing in 0 into the enable file. It would disable the event:
enable=0 soft_disable=0.

To enable or disable an event, it requires an expensive update to the
static branches to turn the nops in the code into calls to the tracing
infrastructure.

Now we have a feature where you could enable one event when another
event is hit with specific fields (or any field).

  echo 'enable_event:irq:irq_handler_entry if next_comm=="migrate"' > /sys/kernel/tracing/events/sched/sched_switch/trigger

The above adds a trigger to the sched_switch event where if the
next_comm is "migrate", it will enable the irq:irq_handler_entry event.

But to enable an event from an event handler which doesn't allow
sleeping or locking, it can't simply call
__ftrace_event_enable_disable() to enable the event. That would most
likely cause a kernel crash or lockup if it did.

To handle this case, when the trigger is added, it enables the event
but puts the event into "soft mode" disabled. The trigger code would
call __ftrace_event_enable_disable() with enable=1 and soft_disable=1.
Meaning, "enable this event, but also set the soft_disable bit".

This enables the event with the soft_disable flag set. That means, the
irq_handler_entry event will call into the tracing system every time.
But because the SOFT_DISABLE is set in the event, it will simply do
nothing.

After doing the above trigger:

  # cat /sys/kernel/tracing/events/irq/irq_handler_entry/enable 
  0*

That means it's disabled in "soft mode".

But let's say I also want to enable the event!

  # echo 1 > /sys/kernel/tracing/events/irq/irq_handler_entry/enable 
  # cat /sys/kernel/tracing/events/irq/irq_handler_entry/enable 
  1*

The above called __ftrace_event_enable_disable() with: enable=1 and soft_disable=0.

Which means "enable this event for real". Well, it can't forget that
there's a trigger on it. But the event shouldn't be ignored when
triggered, so it will clear the SOFT_DISABLE flag and have the event be
traced.

But if we disable it again:

  # echo 0 > /sys/kernel/tracing/events/irq/irq_handler_entry/enable 
  # cat /sys/kernel/tracing/events/irq/irq_handler_entry/enable 
  0*

It must still remember that there's a user that has this event soft
disabled and may enable it in the future.

When the trigger fires, it will clear the SOFT_DISABLE bit making the
event "enabled".

The __ftrace_event_enable_disable() needs to keep track of all the
users that have this event enabled but will switch between soft disable
and enable. To add itself, it calls this function with enable=1
soft_disable=1 and to remove itself, it calls it with enable=0 and
soft_disable=1.

Now technically, the SOFT_MODE bit should only be set iff the ref count
is greater than zero. But it's easier to test a flag than to always
test a ref count.

Hope that explains this better. And yes, it can get somewhat confusing,
which is why I said this is a good function to document the
requirements for ;-)

-- Steve
