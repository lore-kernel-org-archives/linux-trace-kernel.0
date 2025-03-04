Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 866AD2980A7;
	Tue,  4 Mar 2025 17:14:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741108497; cv=none; b=rxOg0MdFGNQpo8AWDSgXt0d3+xzwedgVjIUoVhlzkf2swFviy9MDeYfH/R1pObJ6M3dS6SPJNmvDgATSyqwMu0YSijqTcuCgLQ2AuNVm5AFWtAYkVyJ9R/U3UcdFSVLicFuhrrNW3oZZpjFigjNMqJ2EUFOfwMEnHv3J7la9fgw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741108497; c=relaxed/simple;
	bh=RMqjiifsdaNCSsKNNjk7Yod7Whvmu0ULCvKNeUA77+w=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=L2kmdhkw2K3j69KQ6XhI8wdXYTpClZ8cjlli1Gq9Ptuz+WJhI1lBFKYWjrr9byKNcJlYKjUIcr7RVfji/d5Q+mN2ijLSUzeXJvpMLWddgrZuOyZK1jSlU4A4LWo7XXkw0/TohvlaC5qFYpGkCD8bu7JcQ/KFiiEP5xlEyIBC+1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3AF68C4CEE5;
	Tue,  4 Mar 2025 17:14:56 +0000 (UTC)
Date: Tue, 4 Mar 2025 12:15:50 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Gabriele Monaco <gmonaco@redhat.com>, linux-kernel@vger.kernel.org, Ingo
 Molnar <mingo@redhat.com>, Masami Hiramatsu <mhiramat@kernel.org>,
 linux-trace-kernel@vger.kernel.org, Juri Lelli <juri.lelli@redhat.com>
Subject: Re: [PATCH v4 03/11] sched: Add sched tracepoints for RV task model
Message-ID: <20250304121550.097bffe2@gandalf.local.home>
In-Reply-To: <20250227204623.5e29e101@gandalf.local.home>
References: <20250218123121.253551-1-gmonaco@redhat.com>
	<20250218123121.253551-4-gmonaco@redhat.com>
	<20250227204623.5e29e101@gandalf.local.home>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit


Peter,

Are you OK with adding these tracepoints? They are not trace events
(doesn't show up in tracefs) but are required for the runtime verifier.

-- Steve


On Thu, 27 Feb 2025 20:46:23 -0500
Steven Rostedt <rostedt@goodmis.org> wrote:

> On Tue, 18 Feb 2025 13:31:08 +0100
> Gabriele Monaco <gmonaco@redhat.com> wrote:
> 
> > Add the following tracepoints:
> > * sched_entry(bool preempt, ip)
> >     Called while entering __schedule
> > * sched_exit(bool is_switch, ip)
> >     Called while exiting __schedule
> > * sched_set_state(task, curr_state, state)
> >     Called when a task changes its state (to and from running)
> > 
> > These tracepoints are useful to describe the Linux task model and are
> > adapted from the patches by Daniel Bristot de Oliveira
> > (https://bristot.me/linux-task-model/).
> > 
> > Signed-off-by: Gabriele Monaco <gmonaco@redhat.com>  
> 
> I'll need an Ack from the scheduler maintainer to take this series.
> 
> -- Steve

