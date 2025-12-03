Received: from relay.hostedemail.com (smtprelay0016.hostedemail.com [216.40.44.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14AD730276F;
	Wed,  3 Dec 2025 14:55:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764773750; cv=none; b=FkEBwM9GYmurPsJi6YIhMHVM4PA7S1X2x+YILxr8QOWRpJ/aYLkwKQeLf5y7pSMXjmRf2FM2T20ZWwDcJZb66gAJpdybsdsDdzmSkblRAUfW8G2W16lO56REMEZu8mT3oLeABCTOYowJzM+uuP7diiVD+NIwLf4p6eg7J2VuXyg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764773750; c=relaxed/simple;
	bh=8WjwNgZcsCaBu7llkaMXOeTnLTeJqD7ZSfXq/jnsmBw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=itn9Bb6HJXYkt4nZXdd0f3PGtDvr9aOxlk20XKauRM/YK1j6L7xUL4nZHUF3voIlzahDaTzopvGnv5Fj70e+sq8NoWFm/cxL3Tqi4HIPl0XWzdjqyd688O6HAfhViyCEMz4zae076/hLXTI2qam9YWXG/uwb+Xi0aWyQbiMfDBQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf13.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay10.hostedemail.com (Postfix) with ESMTP id D9490C041F;
	Wed,  3 Dec 2025 14:55:39 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf13.hostedemail.com (Postfix) with ESMTPA id EFE6120016;
	Wed,  3 Dec 2025 14:55:37 +0000 (UTC)
Date: Wed, 3 Dec 2025 09:56:40 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Linux Trace Kernel
 <linux-trace-kernel@vger.kernel.org>, Ye Bin <yebin@huaweicloud.com>,
 Naveen N Rao <naveen@kernel.org>, "David S . Miller" <davem@davemloft.net>,
 yebin10@huawei.com
Subject: Re: [PATCH] kprobes: avoid crash when rmmod/insmod after ftrace
 killed
Message-ID: <20251203095640.7a4fda6b@gandalf.local.home>
In-Reply-To: <176473947565.1727781.13110060700668331950.stgit@mhiramat.tok.corp.google.com>
References: <176473947565.1727781.13110060700668331950.stgit@mhiramat.tok.corp.google.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: xw5ri1z8siz99zsindwo3azqkmyj81ro
X-Rspamd-Server: rspamout01
X-Rspamd-Queue-Id: EFE6120016
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX18PQQuCkPZsrDD45EcZfaCkfLjqThTV++c=
X-HE-Tag: 1764773737-919111
X-HE-Meta: U2FsdGVkX1+i/QapEdPNROyaQNxYW1Q58g6sKTit57s+Lzv+6OBdgqajZvA9aTdmaTQauI7s4hrQLs2341D4xxAtA/oREghlvE3JPw7JrX8iV18wuOA1I1vE68d8qFvqGg6hDcI3lnZFhOztpjFMjCl5kYt5jmqPJn9mDEY6BxXmWkr/UVDtLU+mLRGcOBw5jWIA5epKEpNLEhuIao2VDm0jNXqloTS3Z5oEk/vbEgL4CFOisxBW1cwR0Nu8OcTortdovakiapt1wbi89t+XBKt3V1fuV/l/T1t1tvU1YBYsbknEjRWWDFCJfqQxI3XiVU5IzdBbTIivJmAIuutlu6mvCDpo+ld7BnjqrK+jr+Q5v/sLwIU9Efe8gixbDtK/4D8IeklkOubhocqO2Zdt6OhZa5RSAGsijrD5W9tPVlxHBR3wOuZJu9zQ1kOlo9Ii4/yj4JPLNQw=

On Wed,  3 Dec 2025 14:24:35 +0900
"Masami Hiramatsu (Google)" <mhiramat@kernel.org> wrote:

> From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> 
> After we hit ftrace is killed by some errors, the kernel crash if
> we remove modules in which kprobe probes.
> 
> BUG: unable to handle page fault for address: fffffbfff805000d
> PGD 817fcc067 P4D 817fcc067 PUD 817fc8067 PMD 101555067 PTE 0
> Oops: Oops: 0000 [#1] SMP KASAN PTI
> CPU: 4 UID: 0 PID: 2012 Comm: rmmod Tainted: G        W  OE
> Tainted: [W]=WARN, [O]=OOT_MODULE, [E]=UNSIGNED_MODULE
> RIP: 0010:kprobes_module_callback+0x89/0x790
> RSP: 0018:ffff88812e157d30 EFLAGS: 00010a02
> RAX: 1ffffffff805000d RBX: dffffc0000000000 RCX: ffffffff86a8de90
> RDX: ffffed1025c2af9b RSI: 0000000000000008 RDI: ffffffffc0280068
> RBP: 0000000000000000 R08: 0000000000000001 R09: ffffed1025c2af9a
> R10: ffff88812e157cd7 R11: 205d323130325420 R12: 0000000000000002
> R13: ffffffffc0290488 R14: 0000000000000002 R15: ffffffffc0280040
> FS:  00007fbc450dd740(0000) GS:ffff888420331000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: fffffbfff805000d CR3: 000000010f624000 CR4: 00000000000006f0
> Call Trace:
>  <TASK>
>  notifier_call_chain+0xc6/0x280
>  blocking_notifier_call_chain+0x60/0x90
>  __do_sys_delete_module.constprop.0+0x32a/0x4e0
>  do_syscall_64+0x5d/0xfa0
>  entry_SYSCALL_64_after_hwframe+0x76/0x7e
> 
> This is because the kprobe on ftrace does not correctly handles
> the kprobe_ftrace_disabled flag set by ftrace_kill().
> 
> To prevent this error, check kprobe_ftrace_disabled in
> __disarm_kprobe_ftrace() and skip all ftrace related operations.
> 
> Reported-by: Ye Bin <yebin10@huawei.com>
> Closes: https://lore.kernel.org/all/20251125020536.2484381-1-yebin@huaweicloud.com/
> Fixes: ae6aa16fdc16 ("kprobes: introduce ftrace based optimization")
> Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>

Acked-by: Steven Rostedt (Google) <rostedt@goodmis.org>

-- Steve
