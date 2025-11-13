Received: from relay.hostedemail.com (smtprelay0015.hostedemail.com [216.40.44.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 038FD30149D;
	Thu, 13 Nov 2025 15:50:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763049059; cv=none; b=jr3pahq8arGqtt5NZaDaTf3G57G0eTwfiuhe+SEZ1DduyXYntwKvkppNeBudO8yvGPgiKLS0gZcrEpE0TjfKpaQ3GxS/1d2T0I5rizwIti9JWUILPGbifsIkicdhVUmMWUUzV6HX/seEYbgObtbVrayv5wW8rJzeKSXwVTrX5RQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763049059; c=relaxed/simple;
	bh=PwkVRKaMSLAcyP6zL/aun5R8mjLMLdMTMJono8Dtbak=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=U2Z50ULFrdoQqloqYE8OoDM4NzVLwNmyDELdM37SqNpkvJ1G5UY8HxHmcMgy7fCa40hvq/WOizcW/ZdXNCplj1j6az/3iDQ/a6rhUeSYS8aeSURb7ilekSaBD+OD+Rd/GczUZ5Ytf/O10daUokqnSdHHpZW6G/RbOQQb8y96wmE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf15.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay07.hostedemail.com (Postfix) with ESMTP id 428EB160A83;
	Thu, 13 Nov 2025 15:50:53 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf15.hostedemail.com (Postfix) with ESMTPA id 26D771A;
	Thu, 13 Nov 2025 15:50:51 +0000 (UTC)
Date: Thu, 13 Nov 2025 10:51:06 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Yongliang Gao <leonylgao@gmail.com>, mhiramat@kernel.org,
 mathieu.desnoyers@efficios.com, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, frankjpliu@tencent.com, Yongliang Gao
 <leonylgao@tencent.com>, Huang Cun <cunhuang@tencent.com>
Subject: Re: [PATCH v3] trace/pid_list: optimize pid_list->lock contention
Message-ID: <20251113105106.4270f6ac@gandalf.local.home>
In-Reply-To: <20251113153508.9mYBNQlL@linutronix.de>
References: <20251113000252.1058144-1-leonylgao@gmail.com>
	<20251113073420.yko6jYcI@linutronix.de>
	<CAJxhyqCyB3-CyDKgPtP-EoC=G9cWAYgLvse003+i2n6U4Pgv1w@mail.gmail.com>
	<20251113141515.iZSIDK0T@linutronix.de>
	<20251113100524.5c5f6bdc@gandalf.local.home>
	<20251113151729.4Zky6d-t@linutronix.de>
	<20251113102445.3e70c1ec@gandalf.local.home>
	<20251113153508.9mYBNQlL@linutronix.de>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: 8pmdubdjr6feomb6b6bihm5d38tjq3kt
X-Rspamd-Server: rspamout07
X-Rspamd-Queue-Id: 26D771A
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1/34RX2m2UlryiZHnR60z+yTRgqGR5lXYY=
X-HE-Tag: 1763049051-983190
X-HE-Meta: U2FsdGVkX19hlj42w6I3HMGRpy6h/Vu/YglqDpXeWrCKeoqb8o7Dg4pgeBKHIOTkQxjJaZ9M+rxT0pKEJAyoqf5O5nE7a8KcVKORLNlob7ed2wTwdXPdb3RGEVDjjCanYRdaqyxZ61Ez0864zvHUquTHFkDZpSpm/8HA+ORAFPPsjH+K5+jQEPQODQYr01Lz2A3x883qdZgcVUcnG5jOmUroiGspZPJrg9OX+8H+u5MzVxJ4ivXWxR4/gXOhL7otNy4s38TRQ/0dZ5KB8Vxbdarzq+h82eqPVLEqzomENJiYIO/Wmrad/xi8Ram6xoJG

On Thu, 13 Nov 2025 16:35:08 +0100
Sebastian Andrzej Siewior <bigeasy@linutronix.de> wrote:


> > A couple of issues. One, the chunks are fully used. There's no place to put
> > a "rcu_head" in them. Well, we may be able to make use of them.  
> 
> This could be the first (16?) bytes of the memory chunk.

Yes, but this will make things more complex.

> 
> > Second, if there's a lot of tasks exiting and forking, we can easily run
> > out of chunks that are waiting to be "freed" via call_rcu().  
> 
> but this is a general RCU problem and not new here. The task_struct and
> everything around it (including stack) is RCU freed.

But this doesn't happen under memory pressure. Allocations are not
performed if a chunk is not available. If a chunk isn't available, then we
just stop tracing the filtered task. Hmm, it currently silently fails.
Perhaps I need to add a printk when this happens.


> > > This adding/ add-on-fork, removing and remove-on-exit is the only write
> > > side?  
> > 
> > That and manual writes to the set_ftrace_pid file.  
> 
> This looks like minimal. I miss understood then that context switch can
> also contribute to it.

sched_switch is only a reader, not a writer.

> And the callers of trace_pid_list_is_set() are always in the RCU read
> section then? I assume so, since it wouldn't make sense otherwise.

Yes, because they are only tested in sched_switch and fork and exit tracepoints.

Although, this was written when tracepoint callbacks were always called
under preempt disable. Perhaps we need to change that call to:

	tracepoint_synchronize_unregister()

Or add a preempt_disable() around the callers.

I'm very nervous about using RCU here. It will add a lot more corner cases
that needs to be accounted for. The complexity doesn't appear to be worth
it. I'd rather just keep the raw spin locks than to convert it to RCU.

The seqcount makes sense to me. It's simple and keeps the same paradigm as
what we have. What's wrong with using it?

-- Steve

