Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 008452E7631;
	Wed, 19 Nov 2025 03:15:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763522136; cv=none; b=drXiVRYxuCHvmv4VW8T2OWAI+Re2hRn506rXr8ZyAUvs7D8fcMLGpptmwO1ZyB8DBOkrqfNuXv3TiCfIKdKkRo38dCBqbFxD+CunnErTU3ylVnR9FiM+lupn8zkqKLnqx5Z6Abe4Fh7VFLJnU40Ch6Z/3NUNGrAM/6Bx6Gh7AOU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763522136; c=relaxed/simple;
	bh=WSBXNTz/5SKZ3v9NkEu6THbuCzQ7JFwtAwUTX0liLys=;
	h=Message-ID:Date:From:To:Cc:Subject; b=XGTDkDAWBtttrIqVEJxXgW/FrlDilvCh9/AQ+A5NBD0kZ0Xw++GXLeWys6C7ojnV3kogHVWfBc5zTLn6WLICzJ5Hu5lTPWfc3O0N4WFSuTEj1XpfXfYGEXfrfE/bNYu8zPJA53DB2foiYS/7ei7WUZ6Bvt0BgxCib2H6CYLUb54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DYnbE9Bc; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DYnbE9Bc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A10EC2BCB0;
	Wed, 19 Nov 2025 03:15:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763522135;
	bh=WSBXNTz/5SKZ3v9NkEu6THbuCzQ7JFwtAwUTX0liLys=;
	h=Date:From:To:Cc:Subject:From;
	b=DYnbE9BcQeba2YRdQmn8wTCrRPs2ImsqoLpS1AeCG9piiMqFDtiiIqhpZuceeeAsE
	 dmAhEeOxifv+JSSfqIoCE14p7L2p6DOfxmwl+PrMJGb24yr1RhXWLc/iPgGQBuHZZc
	 S78+vtylDeaiWWswtDh1O3mDBa0peTorPb8qvYYoGetSIwmX4gU9bhK/B3hI+INyq7
	 DIPDMk6WOr8wU/evAQuJRKxiNnRzC1cK97aIFlAJlUCzf4zU51+44i9UKEQDkehHQ0
	 gq+SOi6mvNpJOT5y4WVarcAJLnZ7SNnVjCXodqprk43jzKjoE7Ad0zqo3tMDNnDtUR
	 UD9WvuoVfEc5A==
Received: from rostedt by gandalf with local (Exim 4.98.2)
	(envelope-from <rostedt@kernel.org>)
	id 1vLYfr-00000003Ndm-1wUD;
	Tue, 18 Nov 2025 22:16:03 -0500
Message-ID: <20251119031042.328864818@kernel.org>
User-Agent: quilt/0.68
Date: Tue, 18 Nov 2025 22:10:42 -0500
From: Steven Rostedt <rostedt@kernel.org>
To: linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Tom Zanussi <zanussi@kernel.org>
Subject: [PATCH 0/2] tracing: Clean up trigger code my merging structures
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>


The struct event_command has a callback function called get_trigger_ops().
This callback returns the "trigger_ops" to use for the trigger. These ops
define the trigger function, how to init the trigger, how to print the
trigger and how to free it.

The only reason there's a callback function to get these ops is because
some triggers have two types of operations. One is an "always on"
operation, and the other is a "count down" operation. If a user passes in
a parameter to say how many times the trigger should execute. For example:

  echo stacktrace:5 > events/kmem/kmem_cache_alloc/trigger

It will trigger the stacktrace for the first 5 times the kmem_cache_alloc
event is hit.

Instead of having two different trigger_ops since the only difference
between them is the tigger itself (the print, init and free functions are
all the same), just use a single ops that the event_command points to and
add a function field to the trigger_ops to have a count_func.

When a trigger is added to an event, if there's a count attached to it and
the trigger ops has the count_func field, the data allocated to represent
this trigger will have a new flag set called COUNT.

Then when the trigger executes, it will check if the COUNT data flag is
set, and if so, it will call the ops count_func(). If that returns false,
it returns without executing the trigger.

After making the struct event_trigger_ops be mapped one to one with the
struct event_command, merge the former into the latter.

Steven Rostedt (2):
      tracing: Remove get_trigger_ops() and add count_func() from trigger ops
      tracing: Merge struct event_trigger_ops into struct event_command

----
 kernel/trace/trace.h                | 124 ++++++-------
 kernel/trace/trace_eprobe.c         |  19 +-
 kernel/trace/trace_events_hist.c    | 143 +++++----------
 kernel/trace/trace_events_trigger.c | 344 +++++++++++++-----------------------
 4 files changed, 231 insertions(+), 399 deletions(-)
