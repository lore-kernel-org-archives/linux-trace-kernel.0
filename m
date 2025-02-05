Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1948136326;
	Wed,  5 Feb 2025 13:38:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738762702; cv=none; b=AUZBpKo3CnCO2d80EHS0TNwECVyA8VNyGpMhCzf2frw2TlDgN3GIBGcKcCumSa3H6EKFFku6utBvIihaWJkST8+bZqb6O4MZd49gqshtzWPmiFHKrloCgib7OezoWoUOmBCGAMxYVhVVFX5878w71Xn7xl2oC3dBYlfZALKtV3w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738762702; c=relaxed/simple;
	bh=TvQYTQI2caqCgYr0ko4ZYxI25bCsN32KMP1UcW9wIiw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=if/sc/bLx+UDo5r8NNWUV3qLOA3msWzKWLyFkU5Xcu0NvpaWItb2Lsx2unsmzjcX6ktbTvymFo4mLHBkGPRaLxPERz5LS5QuH+9og9pkS1CeloOgzdYk4yIDA5KjmpGcVFXngqSrLdY2+dSQ6zKpdlWS+uoZ7BCslnesqmtzrYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA8D5C4CED1;
	Wed,  5 Feb 2025 13:38:18 +0000 (UTC)
Date: Wed, 5 Feb 2025 08:38:57 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Joel Fernandes <joel@joelfernandes.org>
Cc: Prakash Sangappa <prakash.sangappa@oracle.com>, Peter Zijlstra
 <peterz@infradead.org>, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
 Ankur Arora <ankur.a.arora@oracle.com>, Linus Torvalds
 <torvalds@linux-foundation.org>, linux-mm@kvack.org, x86@kernel.org, Andrew
 Morton <akpm@linux-foundation.org>, luto@kernel.org, bp@alien8.de,
 dave.hansen@linux.intel.com, hpa@zytor.com, juri.lelli@redhat.com,
 vincent.guittot@linaro.org, willy@infradead.org, mgorman@suse.de,
 jon.grimm@amd.com, bharata@amd.com, raghavendra.kt@amd.com, Boris Ostrovsky
 <boris.ostrovsky@oracle.com>, Konrad Wilk <konrad.wilk@oracle.com>,
 jgross@suse.com, Andrew.Cooper3@citrix.com, Vineeth Pillai
 <vineethrp@google.com>, Suleiman Souhlal <suleiman@google.com>, Ingo Molnar
 <mingo@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Clark Williams <clark.williams@gmail.com>, bigeasy@linutronix.de,
 daniel.wagner@suse.com, Joseph Salisbury <joseph.salisbury@oracle.com>,
 broonie@gmail.com
Subject: Re: [RFC][PATCH 1/2] sched: Extended scheduler time slice
Message-ID: <20250205083857.3cc06aa7@gandalf.local.home>
In-Reply-To: <20250205081635.397eacb0@gandalf.local.home>
References: <EC77D83D-DD17-4CCD-9EF6-C4C39FCE16E7@oracle.com>
	<9DA1FAE6-A008-4785-BDF9-541457E29807@joelfernandes.org>
	<20250204220418.35949317@gandalf.local.home>
	<CAEXW_YQxTi2y_hY_e4AjLSa6RwVVLn3DPj5d4Cfewq0js-0UTA@mail.gmail.com>
	<20250205081635.397eacb0@gandalf.local.home>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 5 Feb 2025 08:16:35 -0500
Steven Rostedt <rostedt@goodmis.org> wrote:

> Correct. And why I don't think this should be used for RT. It's SCHED_OTHER
> that doesn't have any control of the sched tick, where this hint can help.

Honestly, I don't care that much if it is used on all preemption models,
but I do care if it affects RT tasks. The LAZY flag just happens to let us
know if the next schedule is mandatory or not. NEED_RESCHED_LAZY means,
this schedule is not that important, where as the NEED_RESCHED means it is.

That's why I picked that to decide if the task can get extended or not. Has
nothing to do with the preemption method. The preemption method currently
sets that flag.

Now we could just change when NEED_RESCHED_LAZY is set and this could work
with all preemption methods.

To explain this better. Currently we have:

TYPE       |       Sched Tick      |      RT Wakeup       |
===========+=======================+======================+
None       |    NEED_RESCHED_LAZY  |   NEED_RESCHED_LAZY  |
-----------+-----------------------+----------------------+
Voluntary  |    NEED_RESCHED_LAZY  |     NEED_RESCHED     |
-----------+-----------------------+----------------------+
Full       |      NEED_RESCHED     |     NEED_RESCHED     |
-----------+-----------------------+----------------------+

Perhaps if we do:

TYPE       |           Sched Tick              |      RT Wakeup       |
===========+===================================+======================+
None       |        NEED_RESCHED_LAZY          |  NEED_RESCHED_LAZY   |
-----------+-----------------------------------+----------------------+
Voluntary  |        NEED_RESCHED_LAZY          |    NEED_RESCHED      |
-----------+-----------------------------------+----------------------+
Full       | NEED_RESCHED or NEED_RESCHED_LAZY |    NEED_RESCHED      |
-----------+-----------------------------------+----------------------+

Where on the scheduler tick, for PREEMPT_FULL (and even PREEMPT_RT), we set
NEED_RESCHED if the task is in the kernel and NEED_RESCHED_LAZY if it is in
user space then this patch will work in all preemption methods. As the LAZY
bit will decide if the task gets extended or not.

That is, any SCHED_OTHER task that is being preempted due to its scheduler
tick can be granted 50us more, regardless of the preemption method.

Now on PREEMPT_NONE, it may even get to preempt a RT task a bit more, but
RT tasks have more to worry about if they are running on a PREEMPT_NONE
system anyway!

-- Steve
