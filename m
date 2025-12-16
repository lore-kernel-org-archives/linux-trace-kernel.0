Received: from relay.hostedemail.com (smtprelay0012.hostedemail.com [216.40.44.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2865731064B
	for <linux-trace-kernel@vger.kernel.org>; Tue, 16 Dec 2025 18:01:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765908095; cv=none; b=X0j26lUXfGxzaUTabZOjOutkiKK2oCLMQI8eQ9jS6AwcLvZhjKPUlGavGMrmBBxXaXwc6X8GyN7xBB7UXMcMn/MCwFDackh5XkdI2OpJlbeB5ZNl5y0TRGyAEypPzIERKhLtUgM/Wr0GWZpcYohzrpKshpai5v/31spqAzwuLe4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765908095; c=relaxed/simple;
	bh=3NP0F0eFoqcMgJwauEnDwVQoZLFM86L9kbWpl/sPCMk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=egll6v29jds7C0NlvuT4yR8S0cJiY9qB+Hwa2q+xul6U4RDSw79ks5KQ995rWMoh1tkTvm/5B6XclEyungOIvlS0hI0SzIi1RG5UTxxELL7Qrj+ymOImuRvUzh9mnH55NRXVIlWuR7Ojiapihrk+2z/Eoy/f5llLzsyQuVkGd1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf12.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay07.hostedemail.com (Postfix) with ESMTP id E567416079A;
	Tue, 16 Dec 2025 18:01:30 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf12.hostedemail.com (Postfix) with ESMTPA id 262161B;
	Tue, 16 Dec 2025 18:01:29 +0000 (UTC)
Date: Tue, 16 Dec 2025 13:03:02 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Thomas Ballasi <tballasi@linux.microsoft.com>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Andrew Morton
 <akpm@linux-foundation.org>, linux-mm@kvack.org,
 linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] mm: vmscan: add PIDs to vmscan tracepoints
Message-ID: <20251216130302.5202ca81@gandalf.local.home>
In-Reply-To: <20251216140252.11864-3-tballasi@linux.microsoft.com>
References: <20251208181413.4722-1-tballasi@linux.microsoft.com>
	<20251216140252.11864-1-tballasi@linux.microsoft.com>
	<20251216140252.11864-3-tballasi@linux.microsoft.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: rspamout07
X-Rspamd-Queue-Id: 262161B
X-Stat-Signature: neyr1nmuts5wexwx7tiqaoiag9y95ziz
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1/gSVUVC1Luhd1KKN6bim/ZsiMZToeGzrA=
X-HE-Tag: 1765908089-601784
X-HE-Meta: U2FsdGVkX18NhAw5Ps3xOJyawPzAkuUVlBj4w4fI5r3yBkKYySUpsLuNVLyYeIt95ZWS8JjABl+wHYKJ5QCqeGuK684kXcrRNodJGid6oeq0Qycggl2j1SN5LgsHkN/VSUpQHDzaGyjVmHaAaaJmbmkFjBFH4ypK4tpcvEJs5pLMKc/SV1qmJWcOp1lgrHZv2lui4aZDnIfuyh4Kw4hApUd02RbgRV99rfWOeAwy2VsxafLHyJgRSBvPVpavRoJnVk+BdIynCNTwPAxxfJ8o6aVJZsLiI3mYIBlfFzaq+NeNzmR4Pqo8mLGX7DXpZ+KxevonZXSzFgSvsWmyeSGrB7sC3QJFIxH7

On Tue, 16 Dec 2025 06:02:52 -0800
Thomas Ballasi <tballasi@linux.microsoft.com> wrote:

> The changes aims at adding additionnal tracepoints variables to help
> debuggers attribute them to specific processes.
> 
> The PID field uses in_task() to reliably detect when we're in process
> context and can safely access current->pid.  When not in process
> context (such as in interrupt or in an asynchronous RCU context), the
> field is set to -1 as a sentinel value.
> 
> Signed-off-by: Thomas Ballasi <tballasi@linux.microsoft.com>

Is this really needed? The trace events already show if you are in
interrupt context or not.

# tracer: nop
#
# entries-in-buffer/entries-written: 25817/25817   #P:8
#
#                                _-----=> irqs-off/BH-disabled
#                               / _----=> need-resched
#                              | / _---=> hardirq/softirq   <<<<------ Shows irq context
#                              || / _--=> preempt-depth
#                              ||| / _-=> migrate-disable
#                              |||| /     delay
#           TASK-PID     CPU#  |||||  TIMESTAMP  FUNCTION
#              | |         |   |||||     |         |
          <idle>-0       [002] d..1. 11429.293552: rcu_watching: Startirq 0 1 0x74c
          <idle>-0       [000] d.H1. 11429.293564: rcu_utilization: Start scheduler-tick
          <idle>-0       [000] d.H1. 11429.293566: rcu_utilization: End scheduler-tick
          <idle>-0       [002] dN.1. 11429.293567: rcu_watching: Endirq 1 0 0x74c
          <idle>-0       [002] dN.1. 11429.293568: rcu_watching: Start 0 1 0x754
          <idle>-0       [000] d.s1. 11429.293577: rcu_watching: --= 3 1 0xdf4
          <idle>-0       [002] dN.1. 11429.293579: rcu_utilization: Start context switch
          <idle>-0       [002] dN.1. 11429.293580: rcu_utilization: End context switch
       rcu_sched-15      [002] d..1. 11429.293589: rcu_grace_period: rcu_sched 132685 start
          <idle>-0       [000] dN.1. 11429.293592: rcu_watching: Endirq 1 0 0xdf4
       rcu_sched-15      [002] d..1. 11429.293592: rcu_grace_period: rcu_sched 132685 cpustart
       rcu_sched-15      [002] d..1. 11429.293592: rcu_grace_period_init: rcu_sched 132685 0 0 7 ff
          <idle>-0       [000] dN.1. 11429.293593: rcu_watching: Start 0 1 0xdfc

Thus, you can already tell if you are in interrupt context or not, and you
always get the current pid. The 'H', 'h' or 's' means you are in a
interrupt type context. ('H' for hard interrupt interrupting a softirq, 'h'
for just a hard interrupt, and 's' for a softirq).

What's the point of adding another field to cover the same information
that's already available?

-- Steve
