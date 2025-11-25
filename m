Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BB7D289E13;
	Tue, 25 Nov 2025 20:08:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764101328; cv=none; b=IRG8KhYEkSMWlimTnIVF3EMboOqiqJ7Y5G5fK5M/1A3C+2Ui5M4qLH2dWe8aoCfXKv1EZ1fDF5CMdXBtRYErsGWP1AWJxKC0sXwCT+hguyU4LuoABy4gAGCiNBSFFPsC2ymm8wnKGlQJ9+iJ41S9JoiBlNnTiiwnH/UcSE3xPSQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764101328; c=relaxed/simple;
	bh=BqIMLE+Cx8gncbHlRvjyhiy/IiSe1U04BY5C9o+2Mnc=;
	h=Message-ID:Date:From:To:Cc:Subject; b=HqXft3KqKPLSjn5AhkQD2IQzOMSl25WhZmN0FeHUi4ZvwcjlQ0A1zJPJ0bNEyzjklVZLrx+KyDTlh2jRw5CijrsqfahSeWLDbTqEf6ucRApvImcnYGykKppREFLRF+A8l6kgibfaxl97O+a7mzSwbk17K7OymKXmSc1dReIOjxc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NnrGJlCl; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NnrGJlCl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D772C4CEF1;
	Tue, 25 Nov 2025 20:08:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764101328;
	bh=BqIMLE+Cx8gncbHlRvjyhiy/IiSe1U04BY5C9o+2Mnc=;
	h=Date:From:To:Cc:Subject:From;
	b=NnrGJlClpXOXW7aKNoRSEF73qxJIhBYXkrhXFzYg5rgnoWD94szUM58nuMFyJ+UWs
	 YLlFoK7MGUpUo7T/a0dWE/AClg3dEVPvYE8/F+4pUjMM/0r6yvRYOXh2bELMwTFMiY
	 O/B5jVxJO5P12C8P0wG41Eow5UwbCxQB5RT1fg8Zir17aUQeeURUseZK1jMTD9L/4u
	 hgCPu5iRYtWqjoQw9jS59pmxhNhWvjlJxtr25gHQUdU3xfAtGATGs9HuUj2VPTjnIG
	 ECCLnLD35dZvM1D14JptAh3W6zIg08GChYix8cKsmmSMHXxwROTAURgf5t18flJqGX
	 vNMgEDJtorEKw==
Received: from rostedt by gandalf with local (Exim 4.98.2)
	(envelope-from <rostedt@kernel.org>)
	id 1vNzLw-00000005p0v-13If;
	Tue, 25 Nov 2025 15:09:32 -0500
Message-ID: <20251125200857.975524485@kernel.org>
User-Agent: quilt/0.68
Date: Tue, 25 Nov 2025 15:08:57 -0500
From: Steven Rostedt <rostedt@kernel.org>
To: linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Tom Zanussi <zanussi@kernel.org>
Subject: [PATCH v2 0/2] tracing: Clean up trigger code my merging structures
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

Changes since v1: https://lore.kernel.org/linux-trace-kernel/20251119031042.328864818@kernel.org

- Removed duplicate declaration of trigger_hist_cmd (Tom Zanussi)

Steven Rostedt (2):
      tracing: Remove get_trigger_ops() and add count_func() from trigger ops
      tracing: Merge struct event_trigger_ops into struct event_command

----
 kernel/trace/trace.h                | 124 ++++++-------
 kernel/trace/trace_eprobe.c         |  19 +-
 kernel/trace/trace_events_hist.c    | 143 +++++----------
 kernel/trace/trace_events_trigger.c | 344 +++++++++++++-----------------------
 4 files changed, 230 insertions(+), 400 deletions(-)
