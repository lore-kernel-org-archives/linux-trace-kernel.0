Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2698A126C16;
	Wed,  5 Feb 2025 13:44:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738763054; cv=none; b=pHpUReWQOc7acUvoVhpPyoALrfBaUAxH/bgw7Zm+XROE3KqGdfn67lwTAEj7HSF/KiYGZ7nHXkmao8AcWVYkqYz9r1wFEMuq5dzo/9nml660rA22rHnpLYYI7vUCE55GwBxA4eKX11tWM+TobCHGLqGRppWfs4dEYs7bee2Qz3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738763054; c=relaxed/simple;
	bh=DyoO0bDkkGwqDojQ2Ceg0QQyvmnaHFwenu6GP62/ut4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oAJ/ZN7TjVMPoAOAkmV8PZwBa8CsjgnAjxcOtKn9++i5xLyYwHlW0bQdBYUXts0t0+R8eU7I4ZR5NlYjaP5YJilBEDGPZIkBFxDv73BLwvm6lim7eQtTxoP3AWTQgOLyejXnPZeOIxHyOL0XKbHh4CKpO8VypZ9tXYZ9mL/9EC0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2165AC4CED1;
	Wed,  5 Feb 2025 13:44:10 +0000 (UTC)
Date: Wed, 5 Feb 2025 08:44:49 -0500
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
Message-ID: <20250205084449.1bca619d@gandalf.local.home>
In-Reply-To: <20250205081019.6f81f05a@gandalf.local.home>
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
	<20250205081019.6f81f05a@gandalf.local.home>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 5 Feb 2025 08:10:19 -0500
Steven Rostedt <rostedt@goodmis.org> wrote:

> The preemption method will influence that decision, but user space doesn't
> need to be know.

If your issue is that this depends on the preemption method, I have a
slight change to make it work for all preemption methods. I just replied to
Joel about this:

  https://lore.kernel.org/all/20250205083857.3cc06aa7@gandalf.local.home/

I'll repeat some of it here.

Currently we have:

TYPE       |       Sched Tick      |      RT Wakeup       |
===========+=======================+======================+
None       |    NEED_RESCHED_LAZY  |   NEED_RESCHED_LAZY  |
-----------+-----------------------+----------------------+
Voluntary  |    NEED_RESCHED_LAZY  |     NEED_RESCHED     |
-----------+-----------------------+----------------------+
Full       |      NEED_RESCHED     |     NEED_RESCHED     |
-----------+-----------------------+----------------------+

Now, if we set NEED_RESCHED_LAZY in PREEMPT_FULL (and PREEMPT_RT) on a
scheduler tick if it interrupted user space (not the kernel) then we have
this:

TYPE       |           Sched Tick              |      RT Wakeup       |
===========+===================================+======================+
None       |        NEED_RESCHED_LAZY          |  NEED_RESCHED_LAZY   |
-----------+-----------------------------------+----------------------+
Voluntary  |        NEED_RESCHED_LAZY          |    NEED_RESCHED      |
-----------+-----------------------------------+----------------------+
Full       | NEED_RESCHED or NEED_RESCHED_LAZY |    NEED_RESCHED      |
-----------+-----------------------------------+----------------------+

Then going back to user space from the interrupt, we can use rseq and the
LAZY bit to know if we should extend the tick or not! Even without rseq,
this would behave the same as NEED_RESCHED_LAZY will schedule just like
NEED_RESCHED when going back to user space.

This will allow this schedule tick extension to work in all the preemption
methods.

Would this be something you are more OK with? I can go and test this out.

-- Steve
