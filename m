Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DC881DD526;
	Wed,  5 Feb 2025 22:50:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738795823; cv=none; b=FxOQ9/BN4WWwKVDEwASqNElr+I9DiOwPZGvlPEP/Yxopu3Sf1IZK9dGonARxk2w85djc2gpzPDE3LJrxox6PGJKnF66ZhL+1Xc7RIttRopfmEj7Jr2bDqAIykEr/zpf3gBGdcYmiFN/2/iu6Q/WqOZ6YytvY7YE+hGpTY7Az7U8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738795823; c=relaxed/simple;
	bh=ExylWPmVTCGzSIONXZj62US7v/dbLQHKex1yVQEMa8s=;
	h=Message-ID:Date:From:To:Cc:Subject; b=n3FGnqJM4XuW0zITSFo93m9ZfbxjmD7hVHlhxNvrZ+ctSAVkifonZTwOSINswCzYqQNfa+2C2Nrbluo/6KhB8/6ihCk+T4b8wtMxF0UVH0gcBCh5M/UI0IddNy/sXGDz+RYRKk8l3XUd7wi3N8+M5biU6DGizhEvIYwGaa77Ap4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6ECDC4CED1;
	Wed,  5 Feb 2025 22:50:22 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.98)
	(envelope-from <rostedt@goodmis.org>)
	id 1tfoEZ-00000007gT6-0Fz8;
	Wed, 05 Feb 2025 17:51:03 -0500
Message-ID: <20250205225031.799739376@goodmis.org>
User-Agent: quilt/0.68
Date: Wed, 05 Feb 2025 17:50:31 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 0/8] ring-buffer/tracing: Save module information in persistent memory
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

As the single global meta data is a full page, anything left over in
that page that the ring buffer doesn't need can be used by the tracing
system to store its own data.

As the KASLR offset is only needed by the tracer, that data is moved
from the ring buffer meta data into this new storage.

Next the modules that are loaded and where they are loaded is stored in this
new persistent storage.

The module list along with the KASLR offset is now exposed in the
last_boot_info if the buffer is from a previous boot. If it is from the
current boot, the file will only contain:

   Offset: current

in order to not leak the KASLR offset.

Finally, when new modules are loaded while the trace is active, they too
will be added to this persistent memory. Note, if tracing is stopped, and
then restarted, it clears the module list and will reload all the modules
again so that it doesn't need to keep track of what is loaded or unloaded
while no tracing is going on.

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
 include/linux/ring_buffer.h |   3 +-
 kernel/module/main.c        |  14 +++
 kernel/trace/ring_buffer.c  | 216 ++++++++++++++++++++----------------
 kernel/trace/trace.c        | 259 ++++++++++++++++++++++++++++++++++++++++----
 kernel/trace/trace.h        |  15 ++-
 kernel/trace/trace_events.c |  40 +++++--
 7 files changed, 418 insertions(+), 135 deletions(-)
