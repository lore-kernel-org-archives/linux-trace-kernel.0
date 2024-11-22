Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93E3319BBA;
	Fri, 22 Nov 2024 20:32:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732307541; cv=none; b=bqyNyzoM/f37u4jz00XogvyKB34RRyHQFwuJRymWDGT2JGLzWxzHeXLhzQSYShUf6w/W8zJyQZfD1xcmdrxB0bdUm9IGHDDseehH2dKxYpANRt7TjSarhv0tBaQgX4+dyM0RzJDf0JOg6ZZpNrzwsdhNF9MWW+K0Tt7KvMNLg48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732307541; c=relaxed/simple;
	bh=7vdo7FtHCsTf76XvLsysW/REooqcZteNA5N/XIuZY94=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aSGZwdh6Of1Ru23aAIFdzNPhWhcZPuFqM4BylwtYlVsnAN6UxEcnq/MvmUX6UVosvDucDAoB5lfZzupcEwdN6x53Hlg1ND2zDGvXwdrb0L+dM1fAC/Xn4nmtXdHzVLmkRhk8uwq98Ev+i9i5kVCDBrqspc+PwBJHuFe20pI2ru0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56770C4CECE;
	Fri, 22 Nov 2024 20:32:19 +0000 (UTC)
Date: Fri, 22 Nov 2024 15:32:59 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org, Peter
 Zijlstra <peterz@infradead.org>, tglx@linutronix.de, mingo@kernel.org,
 juri.lelli@redhat.com, vincent.guittot@linaro.org,
 dietmar.eggemann@arm.com, bsegall@google.com, mgorman@suse.de,
 vschneid@redhat.com, ankur.a.arora@oracle.com, efault@gmx.de, Masami
 Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>
Subject: Re: [PATCH v3] tracing: Record task flag NEED_RESCHED_LAZY.
Message-ID: <20241122153259.4c1c9e38@gandalf.local.home>
In-Reply-To: <20241122202952.3W3XY_2h@linutronix.de>
References: <20241122173201.tsqK0eeD@linutronix.de>
	<20241122143742.038c77fa@gandalf.local.home>
	<20241122145839.15fc318d@gandalf.local.home>
	<20241122202952.3W3XY_2h@linutronix.de>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 22 Nov 2024 21:29:52 +0100
Sebastian Andrzej Siewior <bigeasy@linutronix.de> wrote:

> On 2024-11-22 14:58:39 [-0500], Steven Rostedt wrote:
> > Actually, on Monday, can you send me a v4 with this fix?  
> 
> already done.

Thanks.

> 
> > I just realized that this patch depends on both my branch (which I'm still
> > waiting for Linus to pull) and the code that is already in Linus's tree.
> > Once Linus pulls my branch, I'll apply this on that merge commit. But that
> > will not be until next week.  
> 
> okay. But that one is ready ;)

Yeah, but I can't do anything with it until Linus pulls in my branch. And I
did the pull request on Wednesday. Would have been earlier, but some people
sent me some bug fixes, so I decided to add them on top. But that required
the normal testing and pushing to linux-next, and waiting a few days.

-- Steve

