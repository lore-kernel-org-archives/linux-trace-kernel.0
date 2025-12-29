Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E03B4A0C
	for <linux-trace-kernel@vger.kernel.org>; Mon, 29 Dec 2025 10:54:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767005682; cv=none; b=aqu38J+u0Sux0aUrLfQUJ6GTT6x34MWEL8qBWCC81brGs7SxH3nMutvpF+VPibsMtFUzVXwdmVd0T80iprjrTPyNVgtGq/1DkNWuoyWe6tjd8mxieMV7JvXi6mSpPYfug0mboD4RM6HDrTzQNQQTdMKYr+Mh7W+E/SJJ3WsJI7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767005682; c=relaxed/simple;
	bh=rRhzqE0GjBkOpPzAOIMjFCaIrpK569o/S6+3CrWFfkA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=FhKxzaleZpWMfs4QOvEG40FETOtWu4mW9Mg+TBAtACXS2suNfmO4gys2sNTE/31YKkcD1b+pce98PUqcgPKro6bItzOJMJDUoAVI2bpMmrmtQPenLmfZoinlZy16kYFSJxip0SmA9+fDr4dww2vfjvLmIAA/aG6J7tSs8gv+br8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=Xl3mYaqY; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="Xl3mYaqY"
Received: from LAPTOP-U3CCR7C6.corp.microsoft.com (unknown [108.143.43.187])
	by linux.microsoft.com (Postfix) with ESMTPSA id DC65A200D65A;
	Mon, 29 Dec 2025 02:54:32 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com DC65A200D65A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1767005674;
	bh=yJlbbI284/D8x4Ik/0uEnuc7Flo2SmmRKYLOMZleia0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Xl3mYaqYJ2gM2xqPep/sY7XF3o6JNO92pGmbiB4Cd1QxH5OUhy7TDzMPHxs8udkH2
	 /ezSr32QYnhPLslrzhFOzyQKS7lwx3naEcyU0blqMwJe/JYk3aQ2GUSQc+jfey3890
	 37ZsECY9rpop0J7J8gL5LTc5OZLPB+C7pUxIq2jc=
From: Thomas Ballasi <tballasi@linux.microsoft.com>
To: rostedt@goodmis.org
Cc: akpm@linux-foundation.org,
	linux-mm@kvack.org,
	linux-trace-kernel@vger.kernel.org,
	mhiramat@kernel.org,
	tballasi@linux.microsoft.com
Subject: Re: [PATCH v2 2/2] mm: vmscan: add PIDs to vmscan tracepoints
Date: Mon, 29 Dec 2025 02:54:27 -0800
Message-Id: <20251229105427.14720-1-tballasi@linux.microsoft.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251216130302.5202ca81@gandalf.local.home>
References: <20251216130302.5202ca81@gandalf.local.home>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Tue, Dec 16, 2025 at 01:03:02PM -0500, Steven Rostedt wrote:
> On Tue, 16 Dec 2025 06:02:52 -0800
> Thomas Ballasi <tballasi@linux.microsoft.com> wrote:
> 
> > The changes aims at adding additionnal tracepoints variables to help
> > debuggers attribute them to specific processes.
> > 
> > The PID field uses in_task() to reliably detect when we're in process
> > context and can safely access current->pid.  When not in process
> > context (such as in interrupt or in an asynchronous RCU context), the
> > field is set to -1 as a sentinel value.
> > 
> > Signed-off-by: Thomas Ballasi <tballasi@linux.microsoft.com>
> 
> Is this really needed? The trace events already show if you are in
> interrupt context or not.
> 
> # tracer: nop
> #
> # entries-in-buffer/entries-written: 25817/25817   #P:8
> #
> #                                _-----=> irqs-off/BH-disabled
> #                               / _----=> need-resched
> #                              | / _---=> hardirq/softirq   <<<<------ Shows irq context
> #                              || / _--=> preempt-depth
> #                              ||| / _-=> migrate-disable
> #                              |||| /     delay
> #           TASK-PID     CPU#  |||||  TIMESTAMP  FUNCTION
> #              | |         |   |||||     |         |
>           <idle>-0       [002] d..1. 11429.293552: rcu_watching: Startirq 0 1 0x74c
>           <idle>-0       [000] d.H1. 11429.293564: rcu_utilization: Start scheduler-tick
>           <idle>-0       [000] d.H1. 11429.293566: rcu_utilization: End scheduler-tick
>           <idle>-0       [002] dN.1. 11429.293567: rcu_watching: Endirq 1 0 0x74c
>           <idle>-0       [002] dN.1. 11429.293568: rcu_watching: Start 0 1 0x754
>           <idle>-0       [000] d.s1. 11429.293577: rcu_watching: --= 3 1 0xdf4
>           <idle>-0       [002] dN.1. 11429.293579: rcu_utilization: Start context switch
>           <idle>-0       [002] dN.1. 11429.293580: rcu_utilization: End context switch
>        rcu_sched-15      [002] d..1. 11429.293589: rcu_grace_period: rcu_sched 132685 start
>           <idle>-0       [000] dN.1. 11429.293592: rcu_watching: Endirq 1 0 0xdf4
>        rcu_sched-15      [002] d..1. 11429.293592: rcu_grace_period: rcu_sched 132685 cpustart
>        rcu_sched-15      [002] d..1. 11429.293592: rcu_grace_period_init: rcu_sched 132685 0 0 7 ff
>           <idle>-0       [000] dN.1. 11429.293593: rcu_watching: Start 0 1 0xdfc
> 
> Thus, you can already tell if you are in interrupt context or not, and you
> always get the current pid. The 'H', 'h' or 's' means you are in a
> interrupt type context. ('H' for hard interrupt interrupting a softirq, 'h'
> for just a hard interrupt, and 's' for a softirq).
> 
> What's the point of adding another field to cover the same information
> that's already available?
> 
> -- Steve

(re-sending the reply as I believe I missed the reply all)

It indeed shows whether or not we're in an IRQ, but I believe the
kernel shouldn't show erronous debugging values. Even though it can be
obvious that we're in an interrupt, some people might look directly at
the garbage PID value without having second thoughts and taking it for
granted. On the other hand, it takes just a small check to mark the
debugging information as clearly invalid, which complements the IRQ
context flag.

If we shouldn't put that check there, I'd happily remove it, but I'd
tend to think it's a trivial addition that can only be for the best.

Thomas

