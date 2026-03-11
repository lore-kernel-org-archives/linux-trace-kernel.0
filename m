Received: from relay.hostedemail.com (smtprelay0016.hostedemail.com [216.40.44.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C75EF32E757;
	Wed, 11 Mar 2026 19:48:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773258518; cv=none; b=e3I3KgKrTKVKXiHv2diT4KPbvSv5Rt5swjjRD/u7j53IbsEQe52ZUotpbdKFrK0VYkzt7M2Ul6WzabO+0X2vdjavPfhWUQjC581t92i8vmRyk+Eic2I0MiNZzxsua3UyHihKUzmO4xBMiXB79BUBnErhhp9i9EVMkOSdkQDJXWs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773258518; c=relaxed/simple;
	bh=PO4NaSdxsT81M4TLAmq+VTtb8IV6OuNQFhsyUu26+EE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=L3A+mpnX9z21QAmBsfz0hZKMO6+vKFWtCaz8gurkRntk7r87Z+cy0e7pEST8z4DjEY6dgRIlMy3svpkTurC2gEjhYkC2Lfce1AEBLPPeDHETWVkK9ImVE09P9xI/ivuQsZwKPVucuCLZAONs+KELKkoJoU/vJ/bPFc/+lUOeaaI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf20.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay04.hostedemail.com (Postfix) with ESMTP id 5013B1A0331;
	Wed, 11 Mar 2026 19:48:34 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf20.hostedemail.com (Postfix) with ESMTPA id 8F18820029;
	Wed, 11 Mar 2026 19:48:30 +0000 (UTC)
Date: Wed, 11 Mar 2026 15:48:42 -0400
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
 williams@redhat.com, gmonaco@redhat.com, Vineeth Pillai
 <vineethrp@google.com>
Subject: Re: [PATCH v3 4/4] trace/preemptirq: Implement trace_irqflags hooks
Message-ID: <20260311154842.0823790f@gandalf.local.home>
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
X-Rspamd-Queue-Id: 8F18820029
X-Stat-Signature: x3hhbccapi9em8yrxawqy1d5k5er4sdt
X-Rspamd-Server: rspamout03
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1/gjITfxTKNjmo1eEqjLUbc90Rd7f4DTII=
X-HE-Tag: 1773258510-396672
X-HE-Meta: U2FsdGVkX1/kXhRrL41d3viOqotZZRIDvC98t416ndGzlJghr9CILnkQ0zo+s5CW3PLQmV3ilbTCBLLyXSUO9d6jDtaJY8xqoeU+gOvXmyXvgI96Ys2+VzP90E2pEawS/m9hP3vhCAezTISKXsU5K2PEfXAj2OezAPCpaRJDHVml2sv6UTtKUoPmMZ0g9d/c9mPubh4RCdjTnAVo0Zb9SKGtBAndaYncI6Gie06ZxHmBCbItmeX6/eRp8XZuwq5Gb4pR+HkytMWTEjDxWr0KojGaDoU3KGeRbmG3zrlZl2iUXS8TUaG3IfBq+S9YJOCltBsn8clHml1so2V1Sx7HbsU4o8t+8SzADUjHFo150SD6Ci6Q7HuHxN2R8CE7cvmR

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

Please don't use the internal functions outside of the tracepoint.h

Vineeth is currently working on a patch set to properly do that. It's going
to introduce:

  trace_invoke_<event>()

Which basically is just __do_trace_<event>(), but as a wrapper that can
handle updates that may be needed, but supplies a proper API where thing
wont randomly break when __do_trace_<event>() changes.

-- Steve


> 
> > +		raw_local_irq_enable();			\
> > +	} while (0)  
> 
> Again, this was one instruction, and you clearly didn't bother looking
> at the mess you've generated :/
