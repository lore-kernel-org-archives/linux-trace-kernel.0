Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D8AA757F3;
	Tue,  4 Mar 2025 01:24:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741051494; cv=none; b=uY6hz4xRC804PM9PhwVzWdek3JzlM7s7MtPFS/Y6VSQUP1vWkfvWGeEA59AMdjxDdLtCedo+zBEOXljKl7vYw3uvmUiCEYjl8d3JGlwIM2gAK9VKAv8qfGLytrx8L/3uOS+/IFp+MErBdrG7CI0A3z0KjTtV88/DMdAi4q3Aej4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741051494; c=relaxed/simple;
	bh=gDp+keTBGkyyzkgHraj9w+WxPdTkzEvYF2R34d3mnuk=;
	h=Message-ID:Date:From:To:Cc:Subject; b=EJDirptP7ANmmnbmz/0Nx0sW+78FQS523B2g2NBKrgOYVGSvEU+Gli3QwThzHeS2fBRRMjhfERzTpyb8dqc5w87PLIOlz8mMeh88V+ko84t0C1S6ulfB3iUyOulWZCdJWdDEsICySUyDJL0GiGd80tgHRMo5QiECJW7sWb+VIl8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 173C7C4CEE4;
	Tue,  4 Mar 2025 01:24:54 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.98)
	(envelope-from <rostedt@goodmis.org>)
	id 1tpH2Z-0000000CC4B-2zVP;
	Mon, 03 Mar 2025 20:25:47 -0500
Message-ID: <20250304012516.282694507@goodmis.org>
User-Agent: quilt/0.68
Date: Mon, 03 Mar 2025 20:25:16 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH v3 0/8] ring-buffer/tracing: Save module information in persistent memory
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>


This updates the persistent instance to record what modules were
loaded and what addresses they were loaded at.

First the KASLR offset is recorded in the persistent ring buffer instead of
a text address. This can be used to calculated the address offset.

Next the persistent memory is divided up differently so that there's
a single global meta data for the entire buffer that can hold the
global data, and each per CPU meta data can just hold what it needs.

A scratch area can be created by the caller, in this case the tracing
system, to store data in the persistent memory area.

As the KASLR offset is only needed by the tracer, that data is moved
from the ring buffer meta data into this new storage.

Next the modules that are loaded and where they are loaded is stored in this
new persistent storage.

The module list along with the KASLR offset is now exposed in the
last_boot_info if the buffer is from a previous boot. If it is from the
current boot, the file will only contain:

   # Current

in order to not leak the KASLR offset.

Finally, when new modules are loaded while the trace is active, they too
will be added to this persistent memory. Note, if tracing is stopped, and
then restarted, it clears the module list and will reload all the modules
again so that it doesn't need to keep track of what is loaded or unloaded
while no tracing is going on.

Changes since v2: https://lore.kernel.org/linux-trace-kernel/20250215034301.624019422@goodmis.org/

- Have the module loop be protected by RCU and not preemption disabling

- Take the scratch_mutex outside of save_mod() to prevent deadlocks

Changes since v1: https://lore.kernel.org/all/20250205225031.799739376@goodmis.org/

- Rebased on top of the urgent branch

- Allow the size of the scratch area in the persistent ring buffer to be
  defined by the caller.

- Change the output of the last_boot_info to show the kaslr instead of:
  "Offset: <offset>" to "<offset>\t[kernel]" to make it consistent with
  the module output.


Steven Rostedt (8):
      ring-buffer: Use kaslr address instead of text delta
      ring-buffer: Add buffer meta data for persistent ring buffer
      ring-buffer: Add ring_buffer_meta_scratch()
      tracing: Have persistent trace instances save KASLR offset
      module: Add module_for_each_mod() function
      tracing: Have persistent trace instances save module addresses
      tracing: Show module names and addresses of last boot
      tracing: Update modules to persistent instances when loaded

----
 include/linux/module.h      |   6 +
 include/linux/ring_buffer.h |   8 +-
 kernel/module/main.c        |  13 +++
 kernel/trace/ring_buffer.c  | 245 +++++++++++++++++++++++-----------------
 kernel/trace/trace.c        | 264 ++++++++++++++++++++++++++++++++++++++++----
 kernel/trace/trace.h        |  15 ++-
 kernel/trace/trace_events.c |  40 +++++--
 7 files changed, 448 insertions(+), 143 deletions(-)
