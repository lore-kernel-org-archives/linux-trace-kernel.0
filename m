Received: from relay.hostedemail.com (smtprelay0015.hostedemail.com [216.40.44.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2638C265CA8;
	Thu, 13 Nov 2025 15:24:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763047477; cv=none; b=P84+aH1XCZsf0wbV+fk2/HWVZ9P28ecERmRSaX/B5BsVtONX0JsMsYmj+yFOKMIUXaBsSyH7l1W0jQKBi+3HpoM311vwyWnOreO+QjsJhGX3yOcvi6sfhMAiixMFv6iKDPpbCMELfe6eV+G0gGUnPOoo3ynVqIO6yvYPEnfvgOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763047477; c=relaxed/simple;
	bh=2It9o6JabpBJyviUFjHoEtWYMON2YRsbiX+X2ReFwXY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=o6To6wNrIsJR4URRlBO1LU8qRNJUzSlKxQ863o4Nlbc+tKJDQbaBiOmUrdD8Tx4cHm11sjAddRIVYS8Zy785WOiuesosZow//yMh9zEtzIcgC9veOH3O/dVe9qV7XIBMm7MwQjfAIeDweiBVUmCiUwdbH/5yXpAc5cZMafF/Eas=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf14.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay07.hostedemail.com (Postfix) with ESMTP id 6177E160A35;
	Thu, 13 Nov 2025 15:24:32 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf14.hostedemail.com (Postfix) with ESMTPA id 26B6B2D;
	Thu, 13 Nov 2025 15:24:30 +0000 (UTC)
Date: Thu, 13 Nov 2025 10:24:45 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Yongliang Gao <leonylgao@gmail.com>, mhiramat@kernel.org,
 mathieu.desnoyers@efficios.com, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, frankjpliu@tencent.com, Yongliang Gao
 <leonylgao@tencent.com>, Huang Cun <cunhuang@tencent.com>
Subject: Re: [PATCH v3] trace/pid_list: optimize pid_list->lock contention
Message-ID: <20251113102445.3e70c1ec@gandalf.local.home>
In-Reply-To: <20251113151729.4Zky6d-t@linutronix.de>
References: <20251113000252.1058144-1-leonylgao@gmail.com>
	<20251113073420.yko6jYcI@linutronix.de>
	<CAJxhyqCyB3-CyDKgPtP-EoC=G9cWAYgLvse003+i2n6U4Pgv1w@mail.gmail.com>
	<20251113141515.iZSIDK0T@linutronix.de>
	<20251113100524.5c5f6bdc@gandalf.local.home>
	<20251113151729.4Zky6d-t@linutronix.de>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: nn86zzbryeh16jhya5sq9kjkaouuroup
X-Rspamd-Server: rspamout01
X-Rspamd-Queue-Id: 26B6B2D
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1/k7+5HGHEXXge806eidABq3yIxNovnI0k=
X-HE-Tag: 1763047470-513433
X-HE-Meta: U2FsdGVkX1/R7pU2DyCLzS2PoGceG06boACnxiYi1H3EPyqXaWilg5TSyRTpqhm/zUeNiqmHfZe91Vkl/NKWVo52TdT4JiivfkQNODz9oj3aXwjwW6v5ZF1TkJd/wtPSt/R8OhqkkaNVYhC10cE/2YSnnU5GBy/fPeMo2WWWX/IhXGbEdS7SScA1diD6XB5wWrjjC8JUtupJ28LMjfGkRwifBu8+Nywm0n8M98U5Bs6dAXSmSszKS5ZL95VW5CvajJsyK7fKDnKabaH+/FTr6Mpesn1NYE+JO4e6Ev2drl7ObpJ8MXW3LVwk8Z5+d+SW

On Thu, 13 Nov 2025 16:17:29 +0100
Sebastian Andrzej Siewior <bigeasy@linutronix.de> wrote:

> On 2025-11-13 10:05:24 [-0500], Steven Rostedt wrote:
> > This means that the chunks are not being freed and we can't be doing
> > synchronize_rcu() in every exit.  
> 
> You don't have to, you can do call_rcu().

But the chunk isn't being freed. They may be used right away.


> So if the kfree() is not an issue, it is just the use of the block from
> the freelist which must not point to a wrong item? And therefore the
> seqcount?

Correct.

> 
> > > So I *think* the RCU approach should be doable and cover this.  
> > 
> > Where would you put the synchronize_rcu()? In do_exit()?  
> 
> simply call_rcu() and let it move to the freelist.

A couple of issues. One, the chunks are fully used. There's no place to put
a "rcu_head" in them. Well, we may be able to make use of them.

Second, if there's a lot of tasks exiting and forking, we can easily run
out of chunks that are waiting to be "freed" via call_rcu().

> 
> > Also understanding what this is used for helps in understanding the scope
> > of protection needed.
> > 
> > The pid_list is created when you add anything into one of the pid files in
> > tracefs. Let's use /sys/kernel/tracing/set_ftrace_pid:
> > 
> >   # cd /sys/kernel/tracing
> >   # echo $$ > set_ftrace_pid
> >   # echo 1 > options/function-fork
> >   # cat set_ftrace_pid
> >   2716
> >   2936
> >   # cat set_ftrace_pid
> >   2716
> >   2945
> > 
> > What the above did was to create a pid_list for the function tracer. I
> > added the bash process pid using $$ (2716). Then when I cat the file, it
> > showed the pid for the bash process as well as the pid for the cat process,
> > as the cat process is a child of the bash process. The function-fork option
> > means to add any child process to the set_ftrace_pid if the parent is
> > already in the list. It also means to remove the pid if a process in the
> > list exits.  
> 
> This adding/ add-on-fork, removing and remove-on-exit is the only write
> side?

That and manual writes to the set_ftrace_pid file.

> > What we are protecting against is when one chunk is freed, but then
> > allocated again for a different set of PIDs. Where the reader has the chunk,
> > it was freed and re-allocated and the bit that is about to be checked
> > doesn't represent the bit it is checking for.  
> 
> This I assumed.
> And the kfree() at the end can not happen while there is still a reader?

Correct. That's done by the pid_list user:

In clear_ftrace_pids():

	/* Wait till all users are no longer using pid filtering */
	synchronize_rcu();

	if ((type & TRACE_PIDS) && pid_list)
		trace_pid_list_free(pid_list);

	if ((type & TRACE_NO_PIDS) && no_pid_list)
		trace_pid_list_free(no_pid_list);

-- Steve

