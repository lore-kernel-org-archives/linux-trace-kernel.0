Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 656203232;
	Tue,  4 Feb 2025 03:56:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738641408; cv=none; b=sV1sJD2RK5QyJ91cvjrobjdCUI0hrWIM7ocBlAIUOyrdmtaofW88GOi6gSEOFiTorQXTZp+Gtv/TFNUYDQGHIS3p+zhwk/R0OPnTv3NjFF8NEAHciyN1soPpOz4Qw/Pfyi9mKf7kZvGmjNuOO7v6qVbU3J2B7/qCJBL8BID28Ek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738641408; c=relaxed/simple;
	bh=Ppizzw9Cw8fQF4LKV8INLwas6UyZGTGi5DVVuXWdU6w=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=o7QRZG7I3Do3NQqJdg59Nix2l424Zfkpn6J9Bsh3gCr/zZ04Tb//e3VmlVBRWA3zBaCzmsU+p4Y5h/UVFEM8IKMfMZN8Noz6k18b2CvmAlI6JpWhOiXP53Pq3ZrAphvjqbC/QYlF/zK6KRKdnXLHqJHDK9uny+IkfYypbzhePlg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 511F2C4CEDF;
	Tue,  4 Feb 2025 03:56:44 +0000 (UTC)
Date: Mon, 3 Feb 2025 22:57:19 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Suleiman Souhlal <suleiman@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
 Ankur Arora <ankur.a.arora@oracle.com>, Linus Torvalds
 <torvalds@linux-foundation.org>, linux-mm@kvack.org, x86@kernel.org,
 akpm@linux-foundation.org, luto@kernel.org, bp@alien8.de,
 dave.hansen@linux.intel.com, hpa@zytor.com, juri.lelli@redhat.com,
 vincent.guittot@linaro.org, willy@infradead.org, mgorman@suse.de,
 jon.grimm@amd.com, bharata@amd.com, raghavendra.kt@amd.com,
 boris.ostrovsky@oracle.com, konrad.wilk@oracle.com, jgross@suse.com,
 andrew.cooper3@citrix.com, Joel Fernandes <joel@joelfernandes.org>, Vineeth
 Pillai <vineethrp@google.com>, Ingo Molnar <mingo@kernel.org>, Mathieu
 Desnoyers <mathieu.desnoyers@efficios.com>, Clark Williams
 <clark.williams@gmail.com>, bigeasy@linutronix.de, daniel.wagner@suse.com,
 joseph.salisbury@oracle.com, broonie@gmail.com
Subject: Re: [RFC][PATCH 1/2] sched: Extended scheduler time slice
Message-ID: <20250203225719.3152a78f@gandalf.local.home>
In-Reply-To: <CABCjUKA2w9Xip2QDjMRDCWnvmZc52SWbn74-57q52gmpXcT+EA@mail.gmail.com>
References: <20250131225837.972218232@goodmis.org>
	<20250131225942.365475324@goodmis.org>
	<20250201115906.GB8256@noisy.programming.kicks-ass.net>
	<F30E23B6-7452-46F9-BF53-48799AE02F75@goodmis.org>
	<20250201181129.GA34937@noisy.programming.kicks-ass.net>
	<20250201180617.491ce087@batman.local.home>
	<20250203084306.GC505@noisy.programming.kicks-ass.net>
	<20250203114537.6a30c7c0@gandalf.local.home>
	<CABCjUKA2w9Xip2QDjMRDCWnvmZc52SWbn74-57q52gmpXcT+EA@mail.gmail.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 4 Feb 2025 12:28:41 +0900
Suleiman Souhlal <suleiman@google.com> wrote:

> Can you explain why this approach requires PREEMPT_LAZY?
> 
> Could  exit_to_user_mode_loop() be changed to something like the
> following (with maybe some provision to only do it once)?
> 
> if ((ti_work & _TIF_NEED_RESCHED) && !rseq_delay_resched())
>     schedule();

The main reason is that we need to differentiate a preemption based on a
SCHED_OTHER scheduling tick, and an RT task waking up. We should not delay
any RT tasks ever. If PREEMPT_LAZY becomes default, IIUC then even the old
"server" version will have RT tasks preempt tasks within the kernel without
waiting for another tick.

Currently, the only way to differentiate between a SCHED_OTHER scheduler
tick preemption and an RT task waking up is with the NEED_RESCHED_LAZY vs
NEED_RESCHED. Now, if we wanted to (and I'm not sure we do), we could add
another way to differentiate the two and still allow this to work.

> 
> I suppose there would also need to be some additional changes to make
> sure full preemption also doesn't preempt, maybe in
> preempt_schedule*().

Which may be quite difficult as the cr_counter is in user space and can
only be read from a user space faultable context.

-- Steve
