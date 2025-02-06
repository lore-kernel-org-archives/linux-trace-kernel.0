Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00DEA1624D4;
	Thu,  6 Feb 2025 15:01:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738854118; cv=none; b=Jbji9DYblD6uAglZQgqEyDLRHjcHfMdMDCX31ooe/wuvlbhqGbGETjQhKzMvVegn6zJIT6Imt+NEneEtwK4Ju2zsso593IqK0GyLGve1fP/E4O+jdXuuybHJKkJ9x4G5EQflxZvSi3KbNmDao9IxnaJA/LtYd6FsjXVzUoV371w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738854118; c=relaxed/simple;
	bh=eyn2sdaPok/G/aBgXiRX3kCtssTC7rXuok6dLWUrWbQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WJzu3vg7bUYab4yC8bUen1InNL+Dl557SgWtvI9soUivj/PN4AU71QC9UDh77CkmwOBlz0hKxCmglcxfiw6PLJ0uM6if9K25W3QqL3RCxiCDNhk5XAIyUwztpgUY66aOPzMELsbajTMeZNErpLsPVQSDGnCPhcSpAifMNGmXj1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=WnqkPlDd; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=XMYuKqcg; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="WnqkPlDd";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="XMYuKqcg"
Date: Thu, 6 Feb 2025 16:01:52 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1738854114;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=C5we7CRCJYf2T2cXW5xWDkSUwqZKvYZDnh+kkqACzH4=;
	b=WnqkPlDddQRrl/XcuWgQ/VRu658eVuS3UVGJqoeadcyglAswOtlV6AFprqFA/cNNUi0TWU
	oIUn+c0sAewYOoDoFS15Bz5g2YH5abNebG8xMlQdWq7nTUI4eqiwFNT5aWVoZTQfs9gjax
	RSrDx1+/stHyVygesSBRXnxIeP1g/1cUILn9M2P0Bsi47+kfzHjIQvLpiLuSoqcp8wRu00
	oSeQhvp+AK72musR71bAsoEOyMVqUUXiSoiEp1tD5R6+4Pd1CrpRH2PWD7tgl24/fagTue
	4x3kjHqsKHrYec0h8lXZFzumhpILpWpFxnBvNj0ivFxWrpkk/FD1LnVQZaKzlQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1738854114;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=C5we7CRCJYf2T2cXW5xWDkSUwqZKvYZDnh+kkqACzH4=;
	b=XMYuKqcgF0VIaIxYp9mnlOO4guMNYbWXyWJdZvYXzv+QYRkS5Ov+IPzonT9WICuo2W1qm4
	ZPWI+RhxqMvk1rBQ==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Steven Rostedt <rostedt@goodmis.org>,
	Joel Fernandes <joel@joelfernandes.org>,
	Prakash Sangappa <prakash.sangappa@oracle.com>,
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
	Thomas Gleixner <tglx@linutronix.de>,
	Ankur Arora <ankur.a.arora@oracle.com>,
	Linus Torvalds <torvalds@linux-foundation.org>, linux-mm@kvack.org,
	x86@kernel.org, Andrew Morton <akpm@linux-foundation.org>,
	luto@kernel.org, bp@alien8.de, dave.hansen@linux.intel.com,
	hpa@zytor.com, juri.lelli@redhat.com, vincent.guittot@linaro.org,
	willy@infradead.org, mgorman@suse.de, jon.grimm@amd.com,
	bharata@amd.com, raghavendra.kt@amd.com,
	Boris Ostrovsky <boris.ostrovsky@oracle.com>,
	Konrad Wilk <konrad.wilk@oracle.com>, jgross@suse.com,
	Andrew.Cooper3@citrix.com, Vineeth Pillai <vineethrp@google.com>,
	Suleiman Souhlal <suleiman@google.com>,
	Ingo Molnar <mingo@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Clark Williams <clark.williams@gmail.com>, daniel.wagner@suse.com,
	Joseph Salisbury <joseph.salisbury@oracle.com>, broonie@gmail.com
Subject: Re: [RFC][PATCH 1/2] sched: Extended scheduler time slice
Message-ID: <20250206150152.-5Fauhtm@linutronix.de>
References: <CAEXW_YQxTi2y_hY_e4AjLSa6RwVVLn3DPj5d4Cfewq0js-0UTA@mail.gmail.com>
 <20250205081635.397eacb0@gandalf.local.home>
 <CAEXW_YQY2zuU+XZjrYWLS860+PJno0nf9WAe1iPU=EyDkA7H4Q@mail.gmail.com>
 <20250206083039.0916ad24@gandalf.local.home>
 <20250206134408.lD_POjuG@linutronix.de>
 <20250206134859.GP7145@noisy.programming.kicks-ass.net>
 <20250206135353.i1tp4vDv@linutronix.de>
 <20250206135744.GQ7145@noisy.programming.kicks-ass.net>
 <20250206142234.-kcSg0xr@linutronix.de>
 <20250206142717.GS7145@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20250206142717.GS7145@noisy.programming.kicks-ass.net>

On 2025-02-06 15:27:17 [+0100], Peter Zijlstra wrote:
> On Thu, Feb 06, 2025 at 03:22:34PM +0100, Sebastian Andrzej Siewior wrote:
> >  Then this feature adds 20us on top?
>=20
> The point has always been for the number to be < the observable
> scheduling latency.
>=20
> I'm not sure what that number is, and it is always hardware dependent. I
> measured it on a random test box when I did the prototype a long while
> ago, and ended up at 50us, but for all I know that machine was running a
> lockdep enabled kernel at the time (won't be the first and certainly
> won't be the last time I try and do a performance measurement on a debug
> kernel).

When I have lockdep enabled, I have scheduling latencies >1ms.

> That was not the important part -- but everybody fixates on the number,
> instead of the intent.

I don't mind to delay a SCHED_OTHER wakeup for the greater good. And
here a number, 50us, be it. This is certainly not something I complain.
I'm just asking not to delayed the wakeup of the RT task which should be
on CPU based on its priority.

Depending on RT application, it is not just the interrupt and
preempt-off section that you worry about. It could also involve to PI a
SCHED_OTHER task on a different CPU to release the lock in question so
that the RT application on _this_ CPU can make progress. So you have
50us on the this CPU and 50us on the remote CPU because it also does
LAZY thingy for performance reasons. And so the number doubled.

> I'm assuming you have a recent number around -- what's sane? 5us, less?

As I tried to explain any additional delay hurts. If your application
requires a latency of 1ms, you get max 100us based on testing then
additional 50us certainly won't hurt you. However if you require 200us
max, you already struggle with 160us especially if everything fires at
once and the caches are gone. In this the 5us will still fit the
requirement on paper but the buffer got smaller. Also, the 5us requires
a timer to fire etc=E2=80=A6

There are "bigger" x86 boxes with high clocked CPU and big caches which
can be partitioned and so on and everything is nice.
There are also smaller x86 boxes where you have two trace_printk() after
each other in an IRQ-off region 2us apart and yell at the scheduler for
taking 30us for a scheduling decision.

Sebastian
