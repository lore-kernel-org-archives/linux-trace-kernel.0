Received: from relay.hostedemail.com (smtprelay0017.hostedemail.com [216.40.44.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79A4B2951AC;
	Tue, 29 Jul 2025 15:50:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753804229; cv=none; b=lP56x6Ud5yIimX1QdYmGr6jVYoBHuF9L1P2VKmxTIaGYSWmiXUwswoebYtkqk9ncAmKOtANSDhRTmj8x/Dt476Ykg1veylC3dWkfdS9DPgdZ7NZu5xln0TwbEl/ArmB1tbb4EDsf5CwgjdZ6x19dJcFfOFrfZG1078ZVzcgFHXw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753804229; c=relaxed/simple;
	bh=wHypNep/AelK9Q9u/VXzH9QeoHr0mcMmzF8OY7GSz6w=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Xy9zvsodI/ubb3sgwnu7paQ/tHV2H8vQguwb+fWbtcJEz8fjTatcWDeU2XQMOuQATSryZ0d1XNavaJi3xwIidpey0V3vhkJaUkppaDZJ3xWN+kb9g2qqCrIDf6V6gX76HeaeYUqNbjYiJgYIUl6WkNVXVQwU69hdXScJ/hS4iAA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf18.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay09.hostedemail.com (Postfix) with ESMTP id BF15A80196;
	Tue, 29 Jul 2025 15:50:24 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf18.hostedemail.com (Postfix) with ESMTPA id 7EC8432;
	Tue, 29 Jul 2025 15:50:22 +0000 (UTC)
Date: Tue, 29 Jul 2025 11:50:21 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Randy Dunlap <rdunlap@infradead.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Linux trace kernel
 <linux-trace-kernel@vger.kernel.org>, linux-doc@vger.kernel.org, Masami
 Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Mark Rutland <mark.rutland@arm.com>,
 Andrew Morton <akpm@linux-foundation.org>, Namhyung Kim
 <namhyung@kernel.org>, Jonathan Corbet <corbet@lwn.net>
Subject: Re: [PATCH] Documentation: tracing: Add documentation about eprobes
Message-ID: <20250729115021.135bca64@batman.local.home>
In-Reply-To: <f6cd51e6-c025-4182-8df8-a621379af6bf@infradead.org>
References: <20250728171522.7d54e116@batman.local.home>
	<f6cd51e6-c025-4182-8df8-a621379af6bf@infradead.org>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: i37xcmmif8zwc1f88xqrpiffppysfi6t
X-Rspamd-Server: rspamout03
X-Rspamd-Queue-Id: 7EC8432
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1/qmwqhQLsniCEAGDaMLNIiDcNTspjaYIA=
X-HE-Tag: 1753804222-608836
X-HE-Meta: U2FsdGVkX185POT3YrZC8hmBCVLW2j99FeE2Z6DOM0fqvQjjwnJMZBbHpXvb7JYlLyx5Bqb8GfV3yLwRjdhyj0wvT/LXdiapu7c3fbsII2Rf8N6ZedXlxwFDuDZSiHZ16LeZNctFz7aHVhukYl9Kd1X9M9bn4GBvXu7wpjC2JCGO48i1qvjkN1Dr7xt5q7PfFCnHwWdKn13pRjv5dfWpcfdc3yJN52g/7sImhRl3Lht0n/KFKhEBwIyv/nmjTsEW6z9EO8MB1GQ9vmD4N/MtUWP2isHFFtibDRHV5olBoMJnvmApQCyBXDM+uG+5GmhyU+6v5wJ+Ir5fVTn/G7vPNUrmyQPBGkSHboBZVQfspQYWBgYKv8Pd+yQeMTgm1O+/

On Mon, 28 Jul 2025 18:02:37 -0700
Randy Dunlap <rdunlap@infradead.org> wrote:
> > +Overview
> > +========
> > +
> > +Eprobes are dynamic events that are placed on existing events to eiter  
> 
>                                                                     either
> 
> > +dereference a field that is a pointer, or simply to limit what fields get  
> 
>                                                        (preference:)     are
> 
> > +recorded in the trace event.
> > +
> > +Eprobes depend on kprobe events so to enable this feature, build your kernel  
> 
>                                                          s/,/;/

OK.


> > +  FETCHARG:TYPE : Set TYPE as the type of FETCHARG. Currently, basic types
> > +		  (u8/u16/u32/u64/s8/s16/s32/s64), hexadecimal types
> > +		  (x8/x16/x32/x64), VFS layer common type(%pd/%pD), "char",
> > +                  "string", "ustring", "symbol", "symstr" and bitfield are  
> 
> 		Should bitfield be quoted?

Hmm, probably. And we should fix kprobetrace.rst as that's where I copied it from.

> > +
> > +Attaching to dynamic events
> > +---------------------------
> > +
> > +Note that eprobes may attach to dynamic events as well as to normal events. It  
> 
> Don't need "Note that".

OK.

> 
> > +may attach to a kprobe event, a synthetic event or a fprobe event. This is  
> 
>                                       I would say:    an fprobe event.
> 

OK.


> > +
> > +Example 2
> > +---------
> > +
> > +If syscall events are not enabled but the raw syscall are (systemcall  
> 
>                                                  syscalls are (system call
> 
> > +events are not normal events, but are created from the raw_syscall events
> > +within the kernel). In order to trace the openat system call, one can create  
> 
>                     ^^ not a complete sentence.

Ah, I'm thinking that "This example is for the case that syscall events
are not enabled..."

But it came out as the above. Will fix.

> 
> 
> > +an event probe on top of the raw_syscall event:
> > +::
> > +
> > + # cd /sys/kernel/tracing
> > + # cat events/raw_syscalls/sys_enter/format
> > + name: sys_enter
> > + ID: 395
> > + format:
> > +	field:unsigned short common_type;	offset:0;	size:2;	signed:0;
> > +	field:unsigned char common_flags;	offset:2;	size:1;	signed:0;
> > +	field:unsigned char common_preempt_count;	offset:3;	size:1;	signed:0;
> > +	field:int common_pid;	offset:4;	size:4;	signed:1;
> > +
> > +	field:long id;	offset:8;	size:8;	signed:1;
> > +	field:unsigned long args[6];	offset:16;	size:48;	signed:0;
> > +
> > + print fmt: "NR %ld (%lx, %lx, %lx, %lx, %lx, %lx)", REC->id, REC->args[0], REC->args[1], REC->args[2], REC->args[3], REC->args[4], REC->args[5]
> > +
> > +From the source code, the sys_openat() has:
> > +::
> > +
> > + int sys_openat(int dirfd, const char *path, int flags, mode_t mode)
> > + {
> > +	return my_syscall4(__NR_openat, dirfd, path, flags, mode);
> > + }
> > +
> > +The path is the second parameter, and that is what is wanted.  
> 
> s/wanted/want/

Really? That sounds funny to me:

   The path is the second parameter and that is what is want.

??


> 
> > +::
> > +
> > + # echo 'e:openat raw_syscalls.sys_enter nr=$id filename=+8($args):ustring' >> dynamic_events
> > +
> > +This is being run on x86_64 where the word size is 8 bytes and the openat
> > +systemcall __NR_openat is set at 257.  
> 
>    system call

OK.


> > +The filename shows "(fault)". This is likely because the filename has not been
> > +pulled into memory yet and currently trace events cannot fault in memory that
> > +is not present. When a eprobe tries to read memory that has not been faulted  
> 
>                         an eprobe

OK.


> > +Now that the address of the filename has been passed to the end of the
> > +systemcall, create another eprobe to attach to the exit event to show the  
> 
>    system call,

OK.

> 
> Thanks for the new documentation.
> 

It was a long time coming :-p

-- Steve
