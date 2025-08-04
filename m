Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCAFB2BAF7;
	Mon,  4 Aug 2025 05:49:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754286592; cv=none; b=VL+B6Bm5m0PQJJbKA8mufSyGIA989iyzt3oPA/utVhh7LyTd09HM4bD6VrK5RILvF2meH3Oa2lQxmV25Py/f1fey1p6EInNt/bERHmn/PscMtnbRMsP5yGSu8Hen9rUQEh8OwkujMlYXjCCrNYVzc0RIbMrEtYdo0BU/28COBIY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754286592; c=relaxed/simple;
	bh=v6KOv9AwwPoGB+pXKveTCZw9kDFVMLUbbeeNYsX7GA0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=rlUrPHbKYJvAntBUlOe4ol3QTkd3qjfB3I6p84ZGeevoVRpg/eCwDWhRY3+t6dEUkzwBKD9Iz6EM/OQzmqETdwuA/k4c9hs0KFhVi7gUyapTnyW0Fv72Omagcq7XxwZaP5xH9OqtitehR/olFlBEhXvUSR/J9oi1xif2d02LeuQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=4oMYbmHB; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ejsJ4aSE; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="4oMYbmHB";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ejsJ4aSE"
From: Nam Cao <namcao@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1754286582;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=pE43r15NPasHIaYyV7dMb/iMne6ri7GQAz+8r8MJbhk=;
	b=4oMYbmHBtJLdK2sdZ3c7qJl+o3xWeHKd98TnJMRYY68YF/nSIV+BHCRMg649Xr4vQaUtUx
	zgyKTQY8It6EvGWWw6uY5apEOcSJsPnRIxm8svFHsYr3n8fDHM0PGcQ7xcCou3FHoQbE9b
	K7M9Q0Ch3Sp//ivmMg5/XtBftvdN5X7qigOgBJirV5ZAO6l1gIvHiMMN/IZ7zxIrXM+d1F
	05MvQ+2+609AJL3WorStgo72kNAhEdYwv35Cm9sveV/UAiZlsPdokO9B2KVcLpu/q6WFeE
	WhK4zUobaOiaNMywINem6ssBXP6UiqjQzUj0P+axz6B+z3N81sCkfNOXbZLthQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1754286582;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=pE43r15NPasHIaYyV7dMb/iMne6ri7GQAz+8r8MJbhk=;
	b=ejsJ4aSEQt/AV2fcPQ7ynzVzKYAlU1M1wJYJuPQX7k0LvGIcggFr3B8gSSEl+aZTDxFiLL
	tIUJ5/8LmoQmHODg==
To: K Prateek Nayak <kprateek.nayak@amd.com>, Gabriele Monaco
 <gmonaco@redhat.com>
Cc: Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu
 <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org, Ingo
 Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, Juri
 Lelli <juri.lelli@redhat.com>, Vincent Guittot
 <vincent.guittot@linaro.org>, Dietmar Eggemann <dietmar.eggemann@arm.com>,
 Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>, Valentin
 Schneider <vschneid@redhat.com>
Subject: Re: [PATCH 4/5] sched: Add rt task enqueue/dequeue trace points
In-Reply-To: <78775d05-b39e-4b8b-97dd-115f57582b50@amd.com>
References: <cover.1753879295.git.namcao@linutronix.de>
 <8f83869a5040bd7cd3096bd12090c1ab110ae5c4.1753879295.git.namcao@linutronix.de>
 <767a9d59081220594d21856f329fb35988ef7925.camel@redhat.com>
 <20250730151818.7RemAREO@linutronix.de>
 <5065c29035be39dee954f2b233a40ae15dcc5035.camel@redhat.com>
 <20250731073520.ktIOaGts@linutronix.de>
 <179674c6-f82a-4718-ace2-67b5e672fdee@amd.com>
 <20250801072946.nTiUlMwS@linutronix.de>
 <97c8a989-08b1-4233-8f5a-cb8b582b6c02@amd.com>
 <c403aacc94dc09aa9ad4441be6095d00b2091f68.camel@redhat.com>
 <78775d05-b39e-4b8b-97dd-115f57582b50@amd.com>
Date: Mon, 04 Aug 2025 07:49:29 +0200
Message-ID: <875xf3vdp2.fsf@yellow.woof>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

K Prateek Nayak <kprateek.nayak@amd.com> writes:

> Hello Gabriele,
>
> On 8/1/2025 4:34 PM, Gabriele Monaco wrote:
>> Hello Prateek,
>> 
>> thanks for the comments, this looks much more convoluted than I would
>> have expected.
>> As Nam pointed out, currently RV is not going to rely on those events
>> for fair tasks (existing monitors are fine with tracepoints like
>> wakeup/set_state/switch).
>> 
>> For the time being it might be better just add the tracepoints in the
>> RT enqueue/dequeue (the only needed for this series) and not complicate
>> things.
>> 
>> At most we may want to keep tracepoint names general, allowing the
>> tracing call to be added later to other locations (or moved to a
>> general one) without changing too much, besides existing users.
>> And perhaps a comment saying the tracepoints are currently only
>> supported on RT would do.
>
> Most of my comments was just thinking out loud around fair tasks being
> delayed on the dequeue path. If RV filters out RT tasks and the use-case
> one concerns them, then Nam's suggestion is good.
>
> I was just being cautious of folks expecting a "enqueued <--> dequeued"
> transition for *all* tasks and finding it doesn't hold after delayed
> dequeue. Since these are internal tracepoints, I'm sure folks using them
> with RV would do their due diligence when testing these monitors before
> deployment.
>
>> 
>> Anyway, that's your call Nam, I'm fine with your initial proposal as
>> well, unless some scheduler guys complain.
>
> I would be happy to help test alternate approaches if others have
> concerns around delayed dequeue but for all other cases, Nam's approach
> looks good. Sorry if my paranoia caused you folks any trouble!

No trouble at all, it was all helpful comments.

I agree with Gabriele, it is not important right now, so I will stick to
the latest diff I sent. Leaving it to the poor soul who needs this for
fair tasks to figure it out (which will probably be future me).

Thanks for the insights,
Nam
