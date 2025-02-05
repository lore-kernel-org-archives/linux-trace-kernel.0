Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74D5EA32;
	Wed,  5 Feb 2025 13:09:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738760984; cv=none; b=DNVLZPklYDQ1xc5ZswwJcifqQdu4A1s0WcSOfaBv3trz3Z4HIuRJXhNbw/MrAprnTVn+cvBOlOusmP7671KDhgL7ICi2XoxTeZu14PqMfaM6M44D8JMb8dy5NBK2xwAcifiUEY6piPepqywHFR/Ay84MKL0TxTcna2Uwnu1QJwQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738760984; c=relaxed/simple;
	bh=9sDaFK6pvtFS0KyaDEqOFYxir/auLO2wbEouokFe/Uw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=V6KPqjHJlNu/lPF5vY2wcRUatdI1KlR9yK9sBxrQPncaiXxwACVZq+SjAqgbxhdfh/La8WL5y22P1SOql61tkez7fYrK68XhJn0vfraH5pMtyOIYwGGup90mqbvZE+YDOME3GsA6bMq2cq7uy+tR+Zegsv2eafMJlXXxUpeoyLU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 685C2C4CED1;
	Wed,  5 Feb 2025 13:09:40 +0000 (UTC)
Date: Wed, 5 Feb 2025 08:10:19 -0500
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
Message-ID: <20250205081019.6f81f05a@gandalf.local.home>
In-Reply-To: <20250205090736.GY7145@noisy.programming.kicks-ass.net>
References: <20250201115906.GB8256@noisy.programming.kicks-ass.net>
	<F30E23B6-7452-46F9-BF53-48799AE02F75@goodmis.org>
	<20250201181129.GA34937@noisy.programming.kicks-ass.net>
	<20250201180617.491ce087@batman.local.home>
	<20250203084306.GC505@noisy.programming.kicks-ass.net>
	<20250203114537.6a30c7c0@gandalf.local.home>
	<20250204091613.GQ7145@noisy.programming.kicks-ass.net>
	<20250204075100.3fcbfda8@gandalf.local.home>
	<20250204153053.GX7145@noisy.programming.kicks-ass.net>
	<20250204111119.10ee37c8@gandalf.local.home>
	<20250205090736.GY7145@noisy.programming.kicks-ass.net>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 5 Feb 2025 10:07:36 +0100
Peter Zijlstra <peterz@infradead.org> wrote:

> > This is where we will disagree for the reasons I explained in my second
> > email. This feature affects other tasks. And no, making it 20us doesn't
> > make it better. Because from what I get from you, if we implement this, it
> > will be available for all preemption methods (including PREEMPT_RT), where
> > we do have less than 50us latency, and and even a 20us will break those
> > applications.  
> 
> Then pick another number; RT too has a max scheduling latency number (on
> some random hardware). If you stay below that, all is fine. 

So we set it to 1us?

Or does this have to calculate what that latency number is for each random
hardware?

> 
> > This was supposed to be only a hint to the kernel, not a complete feature  
> 
> That's a contradiction in terms -- even a hint is a feature.

Yes, a hint is a feature, I meant "complete feature" meaning it being not
just a hint, but guaranteed to do something.

> 
> > that is hard coded and will override how other tasks behave.   
> 
> Everything has some effect. My point is that if you limit this effect to
> be less than what it can already effect, you're not making things worse.
> 
> > As system
> > calls themselves can make how things are scheduled depending on the
> > preemption method,  
> 
> What?

Read my last email:

  https://lore.kernel.org/all/20250204100555.1a641b9b@gandalf.local.home/

I went into this in detail.


> 
> > I didn't want to add something that will change how
> > things are scheduled that ignores the preemption method that was chosen.  
> 
> Userspace is totally oblivious to the preemption method chosen, and it
> damn well should be.

Agreed, and user space doesn't have to know what preemption method was
chosen for this. Where does this say that it needs to know?

All this does is to give the kernel a hint that it is in a critical section
and the kernel decides to grant some more time or not.

The preemption method will influence that decision, but user space doesn't
need to be know.

-- Steve
