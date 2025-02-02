Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDC84191;
	Sun,  2 Feb 2025 03:22:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738466536; cv=none; b=BprYQLP0YvpKjC5ntuP9s241A4TaITLZacS9t2Obn0JE+JVMpgEKw1bnxB5v5c0PI4plg/T3PFjJeMiylpCcfKPqlY87cy0GSeoLFtQBfPzJjXgq8BICDS/zzLbjLMknZlVaHEOCzdSkGVH75gK2HhxdMVaF6fsKBjbFpvd4pJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738466536; c=relaxed/simple;
	bh=vz5liTaXPVn2D0oinoH39X084X09GEP6enoBSEDFJ8M=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nOGJueGC5WBPuqX5nLK+tyiiw9/hkLZfGtiyf6gG4KBTWaHteucy5G2S1VKOYMX6nHwPW2I5yD58e6GTgRpnT/2HnCNfUdUGBetuQNAvegeMkW4oq3HDSE38f4l9bEkoBSs5dTF6MBNFiKLtorVn/7qneMB/PfH8G/UhFYiUmUk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C94BC4CED1;
	Sun,  2 Feb 2025 03:22:10 +0000 (UTC)
Date: Sat, 1 Feb 2025 22:22:08 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, Thomas
 Gleixner <tglx@linutronix.de>, Peter Zijlstra <peterz@infradead.org>, Ankur
 Arora <ankur.a.arora@oracle.com>, linux-mm@kvack.org, x86@kernel.org,
 akpm@linux-foundation.org, luto@kernel.org, bp@alien8.de,
 dave.hansen@linux.intel.com, hpa@zytor.com, juri.lelli@redhat.com,
 vincent.guittot@linaro.org, willy@infradead.org, mgorman@suse.de,
 jon.grimm@amd.com, bharata@amd.com, raghavendra.kt@amd.com,
 boris.ostrovsky@oracle.com, konrad.wilk@oracle.com, jgross@suse.com,
 andrew.cooper3@citrix.com, Joel Fernandes <joel@joelfernandes.org>, Vineeth
 Pillai <vineethrp@google.com>, Suleiman Souhlal <suleiman@google.com>, Ingo
 Molnar <mingo@kernel.org>, Clark Williams <clark.williams@gmail.com>,
 bigeasy@linutronix.de, daniel.wagner@suse.com, joseph.salisbury@oracle.com,
 broonie@gmail.com
Subject: Re: [RFC][PATCH 1/2] sched: Extended scheduler time slice
Message-ID: <20250201222208.0b0d0f5c@batman.local.home>
In-Reply-To: <CAHk-=wgTWVF6+dKPff-mhVwngFwBu_G9+fwOTF2Ds+YPj3xkeQ@mail.gmail.com>
References: <20250131225837.972218232@goodmis.org>
	<20250131225942.365475324@goodmis.org>
	<e83ce086-b55f-431a-a499-f83a434b70db@efficios.com>
	<20250201180810.1faf4906@batman.local.home>
	<CAHk-=wgTWVF6+dKPff-mhVwngFwBu_G9+fwOTF2Ds+YPj3xkeQ@mail.gmail.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 1 Feb 2025 15:18:15 -0800
Linus Torvalds <torvalds@linux-foundation.org> wrote:

> On Sat, 1 Feb 2025 at 15:08, Steven Rostedt <rostedt@goodmis.org> wrote:
> >
> > No it doesn't need to be yield. That just seemed like the obvious
> > system call to use. But any system call would force a schedule. We
> > could just optimize yield() though.  
> 
> No, "optimizing" yield is not on the table.

Note, I only mentioned this because Peter had it in his patch he
created when I first brought this up.

  https://lore.kernel.org/all/20231030132949.GA38123@noisy.programming.kicks-ass.net/

 SYSCALL_DEFINE0(sched_yield)
 {
+	if (current->rseq_sched_delay) {
+		trace_printk("yield -- made it\n");
+		schedule();
+		return 0;
+	}
+
 	do_sched_yield();
 	return 0;
 }


> 
> Why? Because it has *semantics* that people depend on because it has
> historical meaning. Things like "move the process to the end of the
> scheduling queue of that priority".

Yes, I know the historical meaning. It's also a system call I've been
telling people to avoid for the last 20 years. I haven't seen or heard
about any application that actually depends on that behavior today.

> 
> That may sound like a good thing, but it's ABSOLUTELY NOT what you
> should actually do unless you know *exactly* what the system behavior
> is.
> 
> For example, maybe the reason the kernel set NEED_RESCHED_LAZY is that
> a higher-priority process is ready to run. You haven't used up your
> time slice yet, but something more important needs the CPU.

If it's RT, it would set NEED_RESCHED and not LAZY. This is only for
SCHED_OTHER. Sure, it could be a task with a negative nice value.

> 
> So no. "yield()" does not mean "just reschedule". It rally means
> "yield my position in the scheduling queue".

The optimization would only treat sched_yield differently if the task
had asked for an extended time slice, and it was granted. Like in
Peter's patch, if that was the case, it would just call schedule and
return. This would not affect yield() for any other task not
implementing the rseq extend counter.

> 
> You are literally better off using absolutely *ANY* other system call.
> 
> The fact that you are confused about this kind of very basic issue
> does imply that this patch should absolutely be handled by somebody
> who knows the scheduler better.
> 

I'm not confused.

And before seeing Peter's use of yield(), I was reluctant to use it for
the very same reasons you mentioned above. In my test programs, I was
simply using getuid(), as that was one of the quickest syscalls.

-- Steve
