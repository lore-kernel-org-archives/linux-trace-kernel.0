Received: from relay.hostedemail.com (smtprelay0016.hostedemail.com [216.40.44.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A06B2264D6;
	Wed,  8 Jul 2026 13:18:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783516686; cv=none; b=fOGplIXwMVjizEclRUqfi2GUZ06fRThqdaeSG/J57QSibPSEnh7hMu+ypFZ2ElbWsOWz7BKMQwAxX8ZKVP9YyvlBRNRE9FF6WWhkt20kwW17lnQmEmGsaKsPHB+60REq7tys3c3iEFenbVedwnY98LLUbbNZ3Wdbll5/I1bMOHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783516686; c=relaxed/simple;
	bh=pC5HU+YDjve7MW45Pmb3FmzLWx3e9EB9adYp5W46pH8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sE1bRdiSvrdgN8WibEr1xEoo2tiiU5f7itnBzU5MF26BnIMnG9Adr1LocjJvsIvoaztT4Ue9tN8ZxatCeZ58cZm/9UBKXQLxB4rVT2NF8fYUWCaWBhOg/a1fRkgmloIF0lpgKDn23ncTvaY3ib0n1/ni80qTA1dPCJxcTYRXPuQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf12.hostedemail.com (lb01a-stub [10.200.18.249])
	by unirelay10.hostedemail.com (Postfix) with ESMTP id 793D1C0558;
	Wed,  8 Jul 2026 13:18:02 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf12.hostedemail.com (Postfix) with ESMTPA id 7821F22;
	Wed,  8 Jul 2026 13:18:00 +0000 (UTC)
Date: Wed, 8 Jul 2026 09:18:04 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Jeongho Choi <jh1012.choi@samsung.com>
Cc: linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org,
 mhiramat@kernel.org, ji2yoon.jo@samsung.com, minki.jang@samsung.com,
 hajun.sung@samsung.com
Subject: Re: [BUG] tracing: Too many tries to read user space
Message-ID: <20260708091804.584975f9@gandalf.local.home>
In-Reply-To: <20260708123753.GB1386@KORCO121415.samsungds.net>
References: <CGME20260708123754epcas2p1f15cc305ddb09f97164491d750769ef7@epcas2p1.samsung.com>
 <20260708123753.GB1386@KORCO121415.samsungds.net>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 7821F22
X-Stat-Signature: ayo6yw5i56okybob9rha8wkzbkimonaq
X-Rspamd-Server: rspamout07
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1/TuME3qHqEM3uPYt8yGPinGG9tNSATsBs=
X-HE-Tag: 1783516680-258155
X-HE-Meta: U2FsdGVkX1/YZqOX93pyTqWqk30o9PFjMOTPVpOlMFKaDgcq501Wa6SUmNtWULieM4fZrBXsAOd6iJxTPPieXio/qJHgna+DuBltakxwlflQ0BRDX1EAB3j8syQnu8nz5GEQfO3xpdIU8/PrnlAXuyEepckbsWRjMFIEO1SySY2cx34cSZNJhhgMcPl7ioeCUQlDjxKbtc6QhF2YA1ZeuA0PC00e7GhSKtCA/DxLuNlArJRpLVS2Xmk6ybG91ltW9aZmGvw+/ieRoTsAZO2BL828dfAAsDTGQbZ6iJbxQT3rTvIaXr7gJxGOojls+Yt2xo7YZrz0fpQ4m09i6co7V8muzYSGW7Iz5ZQiuiWG+BOexW6fwdyGqQ==

On Wed, 8 Jul 2026 21:37:53 +0900
Jeongho Choi <jh1012.choi@samsung.com> wrote:

> The code at the WARN location mentioned in the log above is as follows.
> 
> 7374                 if (WARN_ONCE(trys++ > 100, "Error: Too many
>   tries to read user space"))
> 7375                         return NULL;
> 

This happens when something forces a schedule.

> 
> Our current analysis is as follows:
> 
> In the Gmail process, during a low memory situation, LMKD writes strings
> to /sys/kernel/tracing/trace_marker for systrace recording. At the same
> time, it broadcasts a sigkill due to low memory, which is causing the
> LMKD trace marker operation to stall.
> 

Can you see what is being scheduled in? Perhaps use the persistent ring
buffer (if you can) and enable sched_switch tracepoint in it.

The loop is this:

	do {
		/*
		 * It is possible that something is trying to migrate this
		 * task. What happens then, is when preemption is enabled,
		 * the migration thread will preempt this task, try to
		 * migrate it, fail, then let it run again. That will
		 * cause this to loop again and never succeed.
		 * On failures, enabled and disable preemption with
		 * migration enabled, to allow the migration thread to
		 * migrate this task.
		 */
		if (trys) {
			preempt_enable_notrace();
			preempt_disable_notrace();
			cpu = smp_processor_id();
			buffer = per_cpu_ptr(tinfo->tbuf, cpu)->buf;
		}

		/*
		 * If for some reason, copy_from_user() always causes a context
		 * switch, this would then cause an infinite loop.
		 * If this task is preempted by another user space task, it
		 * will cause this task to try again. But just in case something
		 * changes where the copying from user space causes another task
		 * to run, prevent this from going into an infinite loop.
		 * 100 tries should be plenty.
		 */
		if (WARN_ONCE(trys++ > 100, "Error: Too many tries to read user space"))
			return NULL;

		/* Read the current CPU context switch counter */
		cnt = nr_context_switches_cpu(cpu);

		/*
		 * Preemption is going to be enabled, but this task must
		 * remain on this CPU.
		 */
		migrate_disable();

		/*
		 * Now preemption is being enabled and another task can come in
		 * and use the same buffer and corrupt our data.
		 */
		preempt_enable_notrace();

		/* Make sure preemption is enabled here */
		lockdep_assert_preemption_enabled();

		if (copy_func) {
			ret = copy_func(buffer, ptr, size, data);
		} else {
			ret = __copy_from_user(buffer, ptr, size);
		}

		preempt_disable_notrace();
		migrate_enable();

		/* if it faulted, no need to test if the buffer was corrupted */
		if (ret)
			return NULL;

		/*
		 * Preemption is disabled again, now check the per CPU context
		 * switch counter. If it doesn't match, then another user space
		 * process may have schedule in and corrupted our buffer. In that
		 * case the copying must be retried.
		 */
	} while (nr_context_switches_cpu(cpu) != cnt);

What it does is to write into a per CPU buffer from user space. If it
schedules out while trying this, it will try again as another task could
have come in and corrupted the buffer.

For some reason, when preemption is enabled to copy from user, something
is forcing a schedule of the process. If we can figure out what is doing
that, perhaps we can fix this. A similar thing happened with the migration
thread that commit edca33a56297d ("tracing: Fix failure to read user space
from system call trace events") fixed.

-- Steve
