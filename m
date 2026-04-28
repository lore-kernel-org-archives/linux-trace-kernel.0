Received: from relay.hostedemail.com (smtprelay0017.hostedemail.com [216.40.44.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C8693B5308;
	Tue, 28 Apr 2026 18:53:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777402437; cv=none; b=gTCf9KLaAKU6V8c4FYFplz2IjkV9Ysr+Z0G7nd4ziPvUaP09W109xViqXx2IBrDvRsP6iq3/1cTjn4nK9DB++vRrBxAGncqRn7CNS1iI8jqMY4Rby514WKBSAA6vWGObaHnnpq5+WbfHXVyJxBRta7HXoctZNaT3FJ7PkR8UJZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777402437; c=relaxed/simple;
	bh=yHcAy6owTCnRMqiYdylufO33oGU6SywtZn35hr2nJIg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TuieA942mqcfsz3JnC965pl6JkkpesRGllf9Md7tCFKEdnRanxmB75pVff7k9EF0DhnCHA/GDaVdMAQmtdtke5rol+Ij8mqNw7p4Tmdb/vTmHwLKjCy+5kGiEEHHwmek/szy/kDr2SNVcebQDMH6a1ufFV8weX1HbAR5SSMKvKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf11.hostedemail.com (lb01a-stub [10.200.18.249])
	by unirelay06.hostedemail.com (Postfix) with ESMTP id 2EF7B1B9648;
	Tue, 28 Apr 2026 18:53:54 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf11.hostedemail.com (Postfix) with ESMTPA id 97F0820029;
	Tue, 28 Apr 2026 18:53:50 +0000 (UTC)
Date: Tue, 28 Apr 2026 14:54:05 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Wander Lairson Costa <wander@redhat.com>, Ingo Molnar
 <mingo@redhat.com>, Juri Lelli <juri.lelli@redhat.com>, Vincent Guittot
 <vincent.guittot@linaro.org>, Dietmar Eggemann <dietmar.eggemann@arm.com>,
 Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>, Valentin
 Schneider <vschneid@redhat.com>, Masami Hiramatsu <mhiramat@kernel.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Andrew Morton
 <akpm@linux-foundation.org>, open list <linux-kernel@vger.kernel.org>,
 "open list:TRACING" <linux-trace-kernel@vger.kernel.org>, acme@kernel.org,
 williams@redhat.com, gmonaco@redhat.com
Subject: Re: [PATCH v3 4/4] trace/preemptirq: Implement trace_irqflags hooks
Message-ID: <20260428145405.64d30ece@gandalf.local.home>
In-Reply-To: <20260311194305.GT606826@noisy.programming.kicks-ass.net>
References: <20260311125021.197638-1-wander@redhat.com>
	<20260311125021.197638-5-wander@redhat.com>
	<20260311194305.GT606826@noisy.programming.kicks-ass.net>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: j7iu47jzdqnjces6so1f85bj7sro9hgk
X-Rspamd-Server: rspamout02
X-Rspamd-Queue-Id: 97F0820029
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX18FVydpJ96puJzP7fFhWI0btfJVN6iF3Ww=
X-HE-Tag: 1777402430-342153
X-HE-Meta: U2FsdGVkX1833EfLJ3muxjx229gP82wArt3goRnW6JaswEefJREAuKpr///cMWTOJOFNSIlwor4NUPuyZqAz3a5U3uj4GB9AzqWv0hfsdtvxewLLmzInLo/iiSHXJkF1WqUWNasVkfF6uatslfqlJjnO75xoMknh0f++7I+EVcdSG18hS3AClScaWJJ75tJNcUElv+VmnsC7mTIb2FIeDTcRzs4ibomYQ6Y9T2ZPyuIiuMsbt1EG1uekevZ67COVjMHsud4QqFHzV6gVrhirjH1qyzZJjgImTsp4YS+vuoB8df5k4xGlBmH5KvYO5ofUmiF1YFBH11GQCD8ZsYviOaneam9/iVe+QSfZHt2cAEmKSeszX43EHMq0+i9HcfBl

On Wed, 11 Mar 2026 20:43:05 +0100
Peter Zijlstra <peterz@infradead.org> wrote:

> On Wed, Mar 11, 2026 at 09:50:18AM -0300, Wander Lairson Costa wrote:
> > +#define local_irq_enable()				\
> > +	do {						\
> > +		if (tracepoint_enabled(irq_enable))	\
> > +			trace_local_irq_enable();	\  
> 
> I'm thinking you didn't even look at the assembly generated :/
> 
> Otherwise you would have written this like:
> 
> 		if (tracepoint_enabled(irq_enable))
> 			__do_trace_local_irq_enable();
> 
> > +		raw_local_irq_enable();			\
> > +	} while (0)  
> 
> Again, this was one instruction, and you clearly didn't bother looking
> at the mess you've generated :/

We now have trace_call__#name(), thus the above can be:

		if (tracepoint_enabled(irq_enable))
			trace_call__local_irq_enable();

See commit 677a3d82b6407 ("tracepoint: Add trace_call__##name() API")

Just in case there's a v4.

-- Steve
