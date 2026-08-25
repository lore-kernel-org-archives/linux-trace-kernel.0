Received: from latitanza.investici.org (latitanza.investici.org [185.218.207.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC2E44334DC;
	Tue, 25 Aug 2026 14:54:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.218.207.228
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787669678; cv=none; b=tOIEjypN41fS9WIn/3PbHnOOJJcOSj8zjRCgQCJJah9avUb7fldJ+iQlx5+bBXYyqMhSAhku00n9Tp8XgxptLaObRuKCcb1NpJdtrQ4W5d+Brnz/iokqnCqbAY+6eVCot/fWuR1wDyJNI7LI18doZ8gmXGHjYuW6FbsNrbrhN5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787669678; c=relaxed/simple;
	bh=ooS6WSzPjkV6d4xIGwUBk1BeeUpPzHFb6bY1SShQyIA=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=f6FMJepslREXJSRNEOytXN0yB/Vi91cJHhArcW8MoVsVOJLNfXUUm1eqZxyAj1FAt/magzQ1sEOcelkG36wsCapFpDKM+FhTM9y6qxGHqjskXFzr4NK1688WPj2ufmwiqW0HwnTNi1FsiYHN/9GlpkwJHwvrAeWjjkmRh6iWfUA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=grrlz.net; spf=pass smtp.mailfrom=grrlz.net; dkim=pass (1024-bit key) header.d=grrlz.net header.i=@grrlz.net header.b=hNFjmHis; arc=none smtp.client-ip=185.218.207.228
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=grrlz.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=grrlz.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=grrlz.net header.i=@grrlz.net header.b="hNFjmHis"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=grrlz.net;
	s=stigmate; t=1787669202;
	bh=6L5K17uPqCf9aL6YK3qU3TpJyuU7aWhcVGE5C5jmqXw=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=hNFjmHisFKIebxBzdbYq+/ouKGX4zCwvzNoS11QFhlwFJyKvqCXQC2ZgTEtdsxz+b
	 tY8uFCGqwkQ4xDlOK9FrYwvtdrWU4xvP7P9bI4PJGy9crlQj67tDHBUDcUfA9BcU/+
	 nlNOw5KnxPUFpb6mwr/ZwZDCKfvctdckmd2oVfyQ=
Received: from mx3.investici.org (unknown [127.0.0.1])
	by latitanza.investici.org (Postfix) with ESMTP id 4hTrFt06BQzGpBc;
	Tue, 25 Aug 2026 14:46:42 +0000 (UTC)
Received: by mx3.investici.org (Postfix) id 4hTrFs4NK4zGpBX;
	Tue, 25 Aug 2026 14:46:41 +0000 (UTC)
Date: Tue, 25 Aug 2026 15:46:41 +0100
From: Bradley Morgan <include@grrlz.net>
To: Steven Rostedt <rostedt@goodmis.org>,
 =?ISO-8859-1?Q?J=E9r=E9my_Jean?= <Jeremy.Jean@oss.cyber.gouv.fr>
CC: mhiramat@kernel.org, mathieu.desnoyers@efficios.com,
 LKML <linux-kernel@vger.kernel.org>,
 Linux Trace Kernel <linux-trace-kernel@vger.kernel.org>
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH=5D_tracing/user=5Fevents=3A_Clear_co?=
 =?US-ASCII?Q?pied_tracing_state_before_fork_duplication?=
In-Reply-To: <20260825104433.2f08ba46@gandalf.local.home>
References: <20260824210814.3726486-2-Jeremy.Jean@oss.cyber.gouv.fr> <20260824215040.0509ff1b@fedora> <20260825104433.2f08ba46@gandalf.local.home>
Message-ID: <1198FC08-4DFE-4504-AD09-73131E09CF16@grrlz.net>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 8bit

On 25 August 2026 15:44:33 BST, Steven Rostedt <rostedt@goodmis.org> wrote:
>
>Oh, and you forgot to Cc any mailing list. You need to Cc linux-kernel and
>linux-trace-kernel to have this include, otherwise it will never appear in
>patchwork, which means it will never appear in the kernel.
>
>-- Steve
>

He knows, don't worry. He submitted another version, I thought it looked
okay. But you didn't, sorry for being wrong :(



>
>On Mon, 24 Aug 2026 21:50:40 -0400
>Steven Rostedt <rostedt@goodmis.org> wrote:
>
>> On Mon, 24 Aug 2026 21:08:15 +0000
>> Jérémy Jean <Jeremy.Jean@oss.cyber.gouv.fr> wrote:
>> 
>> > User events keep per-mm tracing state in task_struct::user_event_mm.
>It
>> > tracks the registrations and enablers created through the tracefs
>> > user_events_data interface.
>> > 
>> > dup_task_struct() starts a fork by copying this pointer from the
>parent.
>> > user_events_fork() must then either share it for CLONE_VM, or create
>new
>> > state for a child with a separate address space.
>> > 
>> > The second case can fail. If user_event_mm_dup() cannot allocate the
>new
>> > state or copy one of its enablers, it returns without replacing the
>> > pointer copied by dup_task_struct(). The child now points at the
>parent's
>> > tracing state, but did not take a task reference to it.
>> > 
>> > When the child exits, user_event_mm_remove() can drop the parent's
>task
>> > count to zero and queue its tracing state for release. The next
>> > user-events registration in the parent calls current_user_event_mm()
>and
>> > writes to the freed object.  
>> 
>> Please, do not cut and paste AI into your change log. Read it,
>> understand it, and summerize it!
>> 
>> The above is just mumbo jumble and is way too verbose for such a simple
>> change. Show me you understand what the bug is. And tell me what was
>> wrong. The above is totally not helpful for a change log. It's way too
>> verbose and makes it very difficult to know what the bug is.
>> 
>> > 
>> > KASAN reports:
>> > 
>> >     BUG: KASAN: slab-use-after-free in
>current_user_event_mm+0x51/0x1d0
>> >     Write of size 4 at addr ffff888005010d30 by task init/44
>> > 
>> >     Call Trace:
>> >      <TASK>
>> >      kasan_report+0xce/0x100
>> >      kasan_check_range+0x10f/0x1e0
>> >      current_user_event_mm+0x51/0x1d0
>> >      user_events_ioctl+0x82e/0x15c0
>> >      __x64_sys_ioctl+0x139/0x1c0
>> >      do_syscall_64+0xce/0x450
>> >      entry_SYSCALL_64_after_hwframe+0x77/0x7f
>> > 
>> >     Allocated by task 44:
>> >      __kasan_kmalloc+0x8f/0xa0
>> >      __kmalloc_cache_noprof+0x180/0x3a0
>> >      user_event_mm_alloc+0x3c/0x1f0
>> >      current_user_event_mm+0x88/0x1d0
>> > 
>> >     Freed by task 42:
>> >      __kasan_slab_free+0x43/0x70
>> >      kfree+0x13a/0x390
>> >      process_one_work+0x696/0xf90
>> >      worker_thread+0x420/0xba0
>> > 
>> > Clear the child's copied user_event_mm before starting the fallible
>> > duplication. If duplication fails, the child has no user-events
>tracing
>> > state to release. The CLONE_VM case remains unchanged because
>> > user_events_fork() explicitly installs the shared pointer and
>increments
>> > its task count.
>> > 
>> > Fixes: 7235759084a4 ("tracing/user_events: Use remote writes for event
>enablement")
>> > Assisted-by: Codex:gpt-daybreak-blue
>> > Signed-off-by: Jérémy Jean <Jeremy.Jean@oss.cyber.gouv.fr>
>> > ---
>> >  include/linux/user_events.h | 1 +
>> >  1 file changed, 1 insertion(+)
>> > 
>> > diff --git a/include/linux/user_events.h b/include/linux/user_events.h
>> > index 57d1ff0..2c9ac7b 100644
>> > --- a/include/linux/user_events.h
>> > +++ b/include/linux/user_events.h
>> > @@ -48,6 +48,7 @@ static inline void user_events_fork(struct
>task_struct *t,
>> >  		return;
>> >  	}
>> >  
>> > +	t->user_event_mm = NULL;
>> >  	user_event_mm_dup(t, old_mm);  
>> 
>> Honestly, that line should be in user_event_mm_dup() and not here.
>> 
>> -- Steve
>> 
>> 
>> >  }
>> >    
>> 
>
>

Thanks!
