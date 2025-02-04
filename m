Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F7662139D8;
	Tue,  4 Feb 2025 16:10:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738685448; cv=none; b=Dy84KqLQkHaP5VYnuiz51kDsuEGpsvNzVBScfPxPAUZubsIe11ncrx3/3K5+dC7M5o13ENX5vvQX+YGddnDNIMX+kI+e+gdUOcNkokIb3l0xq0QvFR2XnykNIhnYhEcEQFRayTQ5pUQ/pUAYreidKV3pmk7f2F7VuKF8McFhJTU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738685448; c=relaxed/simple;
	bh=llTE3rPaHgTKpUUhC+FAxtn94YVXULX/yIZ/ItD8z7U=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LmryDIaP1BXiYo2IAs5Z9sGDeNZwfAT9EgPWoE6sjFD4/QrAaOrVAmpWJl8k1mI3hBAP6tez+uBdd2BL4GfChVXchxf5tJEim6AczDo1Kyo0JpE+eg8MUcXzsogzRJkbTW/TPue1QSSorL1weJFwV4f5tzHgIaZsqWh02KyV7os=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A608FC4CEDF;
	Tue,  4 Feb 2025 16:10:43 +0000 (UTC)
Date: Tue, 4 Feb 2025 11:11:19 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, Thomas
 Gleixner <tglx@linutronix.de>, Ankur Arora <ankur.a.arora@oracle.com>,
 Linus Torvalds <torvalds@linux-foundation.org>, linux-mm@kvack.org,
 x86@kernel.org, akpm@linux-foundation.org, luto@kernel.org, bp@alien8.de,
 dave.hansen@linux.intel.com, hpa@zytor.com, juri.lelli@redhat.com,
 vincent.guittot@linaro.org, willy@infradead.org, mgorman@suse.de,
 jon.grimm@amd.com, bharata@amd.com, raghavendra.kt@amd.com,
 boris.ostrovsky@oracle.com, konrad.wilk@oracle.com, jgross@suse.com,
 andrew.cooper3@citrix.com, Joel Fernandes <joel@joelfernandes.org>, Vineeth
 Pillai <vineethrp@google.com>, Suleiman Souhlal <suleiman@google.com>, Ingo
 Molnar <mingo@kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Clark Williams
 <clark.williams@gmail.com>, bigeasy@linutronix.de, daniel.wagner@suse.com,
 joseph.salisbury@oracle.com, broonie@gmail.com
Subject: Re: [RFC][PATCH 1/2] sched: Extended scheduler time slice
Message-ID: <20250204111119.10ee37c8@gandalf.local.home>
In-Reply-To: <20250204153053.GX7145@noisy.programming.kicks-ass.net>
References: <20250131225837.972218232@goodmis.org>
	<20250131225942.365475324@goodmis.org>
	<20250201115906.GB8256@noisy.programming.kicks-ass.net>
	<F30E23B6-7452-46F9-BF53-48799AE02F75@goodmis.org>
	<20250201181129.GA34937@noisy.programming.kicks-ass.net>
	<20250201180617.491ce087@batman.local.home>
	<20250203084306.GC505@noisy.programming.kicks-ass.net>
	<20250203114537.6a30c7c0@gandalf.local.home>
	<20250204091613.GQ7145@noisy.programming.kicks-ass.net>
	<20250204075100.3fcbfda8@gandalf.local.home>
	<20250204153053.GX7145@noisy.programming.kicks-ass.net>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 4 Feb 2025 16:30:53 +0100
Peter Zijlstra <peterz@infradead.org> wrote:

> If you go back and reread that initial thread, you'll find the 50us is
> below the scheduling latency that random test box already had.
> 
> I'm sure more modern systems will have a lower number, and slower
> systems will have a larger number, but we got to pick a number :/
> 
> I'm fine with making it 20us. Or whatever. Its just a stupid number.
> 
> But yes. If we're going to be doing this, there is absolutely no reason
> not to allow DEADLINE/FIFO threads the same. Misbehaving FIFO is already
> a problem, and we can make DL-CBS enforcement punch through it if we
> have to.
> 
> And less retries on the RSEQ for FIFO can equally improve performance.
> 
> There is no difference between a 'malicious/broken' userspace consuming
> the entire window in userspace (50us, 20us whatever it will be) and
> doing a system call which we know will cause similar delays because it
> does in-kernel locking.

This is where we will disagree for the reasons I explained in my second
email. This feature affects other tasks. And no, making it 20us doesn't
make it better. Because from what I get from you, if we implement this, it
will be available for all preemption methods (including PREEMPT_RT), where
we do have less than 50us latency, and and even a 20us will break those
applications.

This was supposed to be only a hint to the kernel, not a complete feature
that is hard coded and will override how other tasks behave. As system
calls themselves can make how things are scheduled depending on the
preemption method, I didn't want to add something that will change how
things are scheduled that ignores the preemption method that was chosen.

-- Steve
