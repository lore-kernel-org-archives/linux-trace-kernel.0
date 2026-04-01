Received: from relay.hostedemail.com (smtprelay0014.hostedemail.com [216.40.44.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE75633A9CF;
	Wed,  1 Apr 2026 17:14:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775063682; cv=none; b=IpfQuM8ZHqMiSHkFalnT18dZn45X63wRnKn+TgciTrLctxFHpPDIdIy6R1L1cainXPU6ehNq9k5F+iUEEjWDLaQrH696z/vUkHkktgBtXNyJclSZNdDL+qRWL1khua00+bFgIl1uGCH/+pDyXMeyc2nik3lELiQQZLOz4tuAql8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775063682; c=relaxed/simple;
	bh=efJyqRe0w5limItzT8Diz/hzxtMEAsoUENPex4tkLGI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=C38mG7z5ypO47N1+H/WtObBwHKKQYfYA/Z8YzDbjkiWjznRzPLNfn9H5uVnBnxAhL3OA0n9bzt9sx2D3JgYJ+pvIk6HDHIDaHdIlO9hFJE/J9QqiVXHGe7S93HmYTcRJcqpjKog/XfpSsZqNC6C3yB7Lb36AsUtKdWcjPwqYwiE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf13.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay01.hostedemail.com (Postfix) with ESMTP id B56DCE0223;
	Wed,  1 Apr 2026 17:14:38 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf13.hostedemail.com (Postfix) with ESMTPA id 349772000E;
	Wed,  1 Apr 2026 17:14:36 +0000 (UTC)
Date: Wed, 1 Apr 2026 13:15:36 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, Peter
 Zijlstra <peterz@infradead.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Mark Rutland
 <mark.rutland@arm.com>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>, Thomas Gleixner
 <tglx@linutronix.de>, Brian Geffon <bgeffon@google.com>, John Stultz
 <jstultz@google.com>, Ian Rogers <irogers@google.com>, Suleiman Souhlal
 <suleiman@google.com>
Subject: Re: [PATCH v3 0/3] tracing: Read user data from futex system call
 trace event
Message-ID: <20260401131536.443b073e@gandalf.local.home>
In-Reply-To: <20260331181349.062575155@kernel.org>
References: <20260331181349.062575155@kernel.org>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: rspamout05
X-Rspamd-Queue-Id: 349772000E
X-Stat-Signature: cu5t4p799kb8nhstgdyfpyfac17i7c7r
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1/0wT/q3Rr/DtciHt+yy/pt1ghU1a/bobI=
X-HE-Tag: 1775063676-459694
X-HE-Meta: U2FsdGVkX18CSX5+XLyu3u+EJ823z6ChfilPOkqtCEaj0F6nUfIu1XJh03XqhMinvMQza/bmXtha32s+1aaJ5DhBx+VW0oymhCgsNEoNaHceJPFOCdVS2uUwWbqJOYTwuWXQnyJB+n/35sUWh+BmZRnOIKmppXfzaFyWHhqt7IeE4mW5nQAw80qOb4A67IVAeBhLYdZscp/Gq49LnPjj6pO8+cu0YqcaCdmNoyERl1TcJGMXCB4EIdXnBniZR35oJ8ztfIlmdljXbU+YlV0JoCiNTcyQU3zr8J5XvfyaqBLKrOIMobmC9aYHrqQNd5JYjzEry6WDMV0jk34Fyp9KZPC6MF355XT4


Peter,

Any thoughts on this version?

-- Steve


On Tue, 31 Mar 2026 14:13:49 -0400
Steven Rostedt <rostedt@kernel.org> wrote:

> We are looking at the performance of futexes and require a bit more
> information when tracing them.
> 
> The two patches here extend the system call reading of user space to
> create specific handling of the futex system call. It now reads the
> user space relevant data (the addr, utime and addr2), as well as
> parses the flags. This adds a little smarts to the trace event as
> it only shows the parameters that are relevant, as well as parses
> utime as either a timespec or as val2 depending on the futex_op.
> 
> Here's an example of the new output:
> 
>  sys_futex(uaddr: 0x56196292e830 (0), FUTEX_WAKE|FUTEX_PRIVATE_FLAG)
>  sys_futex(uaddr: 0x56196292e834 (0x4a7) tid: 1191, FUTEX_UNLOCK_PI|FUTEX_PRIVATE_FLAG)
>  sys_futex(uaddr: 0x56196292e834 (0) tid: 0, FUTEX_LOCK_PI|FUTEX_PRIVATE_FLAG)
>  sys_futex(uaddr: 0x56196292e830 (0), FUTEX_WAIT|FUTEX_PRIVATE_FLAG)
>  sys_futex(uaddr: 0x56196292e838 (0), FUTEX_WAIT_REQUEUE_PI|FUTEX_PRIVATE_FLAG, timespec: 0x7ffc1b91a9f0 (163.048528790), uaddr2: 0x56196292e834 (4aa), val3: 0)
>  sys_futex(uaddr: 0x56196292e834 (0x4aa) tid: 1194, FUTEX_LOCK_PI|FUTEX_PRIVATE_FLAG)
>  sys_futex(uaddr: 0x56196292e838 (0), FUTEX_WAIT_REQUEUE_PI|FUTEX_PRIVATE_FLAG, timespec: 0x7ffc1b91a9f0 (163.048528790), uaddr2: 0x56196292e834 (800004aa), val3: 0)
>  sys_futex(uaddr: 0x7f7ed6b29990 (0x4ab), FUTEX_WAIT_BITSET|FUTEX_CLOCK_REALTIME)
>  sys_futex(uaddr: 0x56196292e834 (0x800004aa) tid: 1194 (WAITERS), FUTEX_LOCK_PI|FUTEX_PRIVATE_FLAG)
>  sys_futex(uaddr: 0x56196292e838 (0), FUTEX_WAIT_REQUEUE_PI|FUTEX_PRIVATE_FLAG, timespec: 0x7ffc1b91a9f0 (163.048528790), uaddr2: 0x56196292e834 (800004aa), val3: 0)
>  sys_futex(uaddr: 0x56196292e834 (0x800004aa) tid: 1194 (WAITERS), FUTEX_LOCK_PI|FUTEX_PRIVATE_FLAG)
> 
> Changes since v2: https://lore.kernel.org/all/20260310200954.285663884@kernel.org/
> 
> - Removed unused "buf" variable (kernel test robot)
> 
> - Iterate __futex_cmds[] make the print statement.
>   Note this required exposing __futex_cmds[] to trace_syscall.c
>   (Masami Hiramatsu)
> 
> - Added back val statement (with the move to futex/syscall.c the
>   third parameter was dropped).
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace.git
> futex/core
> 
> Head SHA1: 79b0609ad15b24d0bbfb1790e17902a6c210ae69
> 
> 
> Steven Rostedt (3):
>       tracing: Have futex syscall trace event show specific user data
>       tracing: Update futex syscall trace event to show more commands
>       tracing: Show TID and flags for PI futex system call trace event
> 
> ----
>  include/linux/futex.h         |  39 ++++++-
>  kernel/futex/syscalls.c       | 137 +++++++++++++++++++++---
>  kernel/trace/trace_syscalls.c | 237 +++++++++++++++++++++++++++++++++++++++++-
>  3 files changed, 396 insertions(+), 17 deletions(-)

