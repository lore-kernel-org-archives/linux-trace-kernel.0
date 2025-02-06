Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D5ED1A317F;
	Thu,  6 Feb 2025 14:56:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738853792; cv=none; b=BtwWbJir8ow/xC+EaNeQm0m6BdL6P4gEsvAUHfJOVI/4noSCT2I7w1eIwdxB3SF9jXIyrwIKDfrpClTXsFeugkaPrN8XuHJGEzIU5iwyFhDnJq019Tz4r6ceW5M8HUESaHGX5tU+9OzDkeoI10MTBXirA0XjekFDmqaC3nSJqrI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738853792; c=relaxed/simple;
	bh=5UHJsNjDXs62YUdOMcsq/9tf8PVGSLIq75PwMvF+egA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=A+mgYUyKJ9b1Rmap0tePqI5gSSF6jF7xktHcwWptJg+meeCFnN2ZmYEDP936ZsguLwVCXtmW3g3zDs6DXDUCjnVRVF2BIU1plTRv8hORR4VL2SuyHoNsSwFRaKUF8T9IkdrMdQlItRO8thHTZoY1WxJmF3USfids3H1Cm02axN0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 533F7C4CEDD;
	Thu,  6 Feb 2025 14:56:28 +0000 (UTC)
Date: Thu, 6 Feb 2025 09:57:09 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Joel Fernandes
 <joel@joelfernandes.org>, Prakash Sangappa <prakash.sangappa@oracle.com>,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, Thomas
 Gleixner <tglx@linutronix.de>, Ankur Arora <ankur.a.arora@oracle.com>,
 Linus Torvalds <torvalds@linux-foundation.org>, linux-mm@kvack.org,
 x86@kernel.org, Andrew Morton <akpm@linux-foundation.org>, luto@kernel.org,
 bp@alien8.de, dave.hansen@linux.intel.com, hpa@zytor.com,
 juri.lelli@redhat.com, vincent.guittot@linaro.org, willy@infradead.org,
 mgorman@suse.de, jon.grimm@amd.com, bharata@amd.com,
 raghavendra.kt@amd.com, Boris Ostrovsky <boris.ostrovsky@oracle.com>,
 Konrad Wilk <konrad.wilk@oracle.com>, jgross@suse.com,
 Andrew.Cooper3@citrix.com, Vineeth Pillai <vineethrp@google.com>, Suleiman
 Souhlal <suleiman@google.com>, Ingo Molnar <mingo@kernel.org>, Mathieu
 Desnoyers <mathieu.desnoyers@efficios.com>, Clark Williams
 <clark.williams@gmail.com>, daniel.wagner@suse.com, Joseph Salisbury
 <joseph.salisbury@oracle.com>, broonie@gmail.com
Subject: Re: [RFC][PATCH 1/2] sched: Extended scheduler time slice
Message-ID: <20250206095709.7a93ac36@gandalf.local.home>
In-Reply-To: <20250206142717.GS7145@noisy.programming.kicks-ass.net>
References: <20250204220418.35949317@gandalf.local.home>
	<CAEXW_YQxTi2y_hY_e4AjLSa6RwVVLn3DPj5d4Cfewq0js-0UTA@mail.gmail.com>
	<20250205081635.397eacb0@gandalf.local.home>
	<CAEXW_YQY2zuU+XZjrYWLS860+PJno0nf9WAe1iPU=EyDkA7H4Q@mail.gmail.com>
	<20250206083039.0916ad24@gandalf.local.home>
	<20250206134408.lD_POjuG@linutronix.de>
	<20250206134859.GP7145@noisy.programming.kicks-ass.net>
	<20250206135353.i1tp4vDv@linutronix.de>
	<20250206135744.GQ7145@noisy.programming.kicks-ass.net>
	<20250206142234.-kcSg0xr@linutronix.de>
	<20250206142717.GS7145@noisy.programming.kicks-ass.net>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 6 Feb 2025 15:27:17 +0100
Peter Zijlstra <peterz@infradead.org> wrote:

> I'm assuming you have a recent number around -- what's sane? 5us, less?

It really doesn't matter what the number is. No matter what it is, it adds
to the latency.

Just adding the timer and another interrupt just doubled the interrupt
latency. If an RT task were to wake up but this flag is set to extend the
currently running task, even if you made it 5us, it will be more than that.
You need to enable a new timer, get back to user space, trigger another
interrupt, before you can schedule the RT task from its original time it
was to wake up and run.

-- Steve
