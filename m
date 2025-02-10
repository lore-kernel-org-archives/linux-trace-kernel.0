Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EB1C2512D0;
	Mon, 10 Feb 2025 19:43:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739216602; cv=none; b=ag6YRPr6ioiPc95I7k9T1PdquWAP04KlnhKD5SRxuikEc6Nf8oEjlEyCzBFkRQDwBVJJQkVmj6dURJTSOpbPgaYDY5Rkp9kurt0ZpcN6QlXCsNOtz/AzgcObMCKn6zGG46ELWGlUwUIRPA4cPjKm8kNmYNQH5n+rD+alOgkzccA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739216602; c=relaxed/simple;
	bh=iab6DLq8QCaVTgKuguUf/VPXGoCpOhRDiChAN+QVTq0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JbdIuho6bypJDLLE/Kv+HknriOMFYLYoHj+aOK+zPyy+XggQQyAgq1TRHFVJ1bZRgQ9Hk4QeKCl3yF++A/synJ9upXkDXNfaGIzJfQrV7Vl+m4I4rapIdAiK6A9jgINFcaSbokddODstaPtmwOF0aQegpmdd5aD2pZapeMKdOII=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8EC45C4CED1;
	Mon, 10 Feb 2025 19:43:18 +0000 (UTC)
Date: Mon, 10 Feb 2025 14:43:21 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Joel Fernandes <joel@joelfernandes.org>, Prakash Sangappa
 <prakash.sangappa@oracle.com>, Peter Zijlstra <peterz@infradead.org>,
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
Message-ID: <20250210144321.1f5974a6@gandalf.local.home>
In-Reply-To: <20250206134408.lD_POjuG@linutronix.de>
References: <EC77D83D-DD17-4CCD-9EF6-C4C39FCE16E7@oracle.com>
	<9DA1FAE6-A008-4785-BDF9-541457E29807@joelfernandes.org>
	<20250204220418.35949317@gandalf.local.home>
	<CAEXW_YQxTi2y_hY_e4AjLSa6RwVVLn3DPj5d4Cfewq0js-0UTA@mail.gmail.com>
	<20250205081635.397eacb0@gandalf.local.home>
	<CAEXW_YQY2zuU+XZjrYWLS860+PJno0nf9WAe1iPU=EyDkA7H4Q@mail.gmail.com>
	<20250206083039.0916ad24@gandalf.local.home>
	<20250206134408.lD_POjuG@linutronix.de>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 6 Feb 2025 14:44:08 +0100
Sebastian Andrzej Siewior <bigeasy@linutronix.de> wrote:

> I did add a scheduling point in rt_spin_unlock() if LAZY was set and
> based on few tests it was something between noise and worse. It seems
> that "run to completion" is better than interrupt the kernel in the
> middle whatever it is doing. "Don't preempt the lock owner" is already
> handled by LAZY with the scheduling point on return to userland.

Does that mean that PREEMPT_RT requires a non preempt method for
SCHED_OTHER for SCHED_OTHER to not hit the issues that we were originally
hitting? That is, with being able to preempt spin_locks in PREEMPT_RT,
running a system with PREEMPT_RT in full preemption mode will still suffer
performance issues against a non PREEMPT_RT running in full preemption mode?

-- Steve
