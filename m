Received: from relay.hostedemail.com (smtprelay0014.hostedemail.com [216.40.44.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BED238AC8F;
	Wed, 11 Mar 2026 20:07:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773259640; cv=none; b=GVVu4dKlyK3pZ8KrY+pBtjUcMOM8jaGPSYpeMHaCOI4Dmxd11xEhNmsqq+AVb6RkBOVI+Aor0awh/H8rcHvLcSjpO2XAUS4sJK9ixz6ga2UHagHYf3OFMt/TWOE+2rhuYJ6j2/nIJ60aJ7TbBvEUZ3+ybHVhKCz4PvATKsjnYHk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773259640; c=relaxed/simple;
	bh=K0MqOFH/U/mvzu5mN0LqnqmX3LCvyeOWZzPIWvngXaM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PR/qVU7USNpJecfZMeWgMu02wIHbrb3nXdNMkpO3vfe+K+FxNgtnJEaA0Yrp7vp2oyz5uEUbT67SqBYzQtVROb9bhZlpPHE3usoQ0OfhNdzbGwAih0+xkB0lWlpMfJMC2zYLHJBAxmwciMzPJ9rTaY3QPUe7LxfuKNJlOJojZbs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf07.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay02.hostedemail.com (Postfix) with ESMTP id 58FCF134022;
	Wed, 11 Mar 2026 20:07:06 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf07.hostedemail.com (Postfix) with ESMTPA id A8B432002C;
	Wed, 11 Mar 2026 20:07:02 +0000 (UTC)
Date: Wed, 11 Mar 2026 16:07:14 -0400
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
Message-ID: <20260311160714.1e6b7a37@gandalf.local.home>
In-Reply-To: <20260311195310.GU606826@noisy.programming.kicks-ass.net>
References: <20260311125021.197638-1-wander@redhat.com>
	<20260311125021.197638-5-wander@redhat.com>
	<20260311194305.GT606826@noisy.programming.kicks-ass.net>
	<20260311154842.0823790f@gandalf.local.home>
	<20260311195310.GU606826@noisy.programming.kicks-ass.net>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: pk59sjahwz4ucmra9wzme894x46ewshz
X-Rspamd-Server: rspamout04
X-Rspamd-Queue-Id: A8B432002C
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1++eoFg1yM/HKTDbgQ53Fg7T/dUh43iPL8=
X-HE-Tag: 1773259622-470558
X-HE-Meta: U2FsdGVkX1/mSlonuHfLEVCsh0GYeipZ7JSYF7FtSfA/Bg25iCmngovuPmjZ80/NOxQypQKNf1QZcJ0FRUOM27migaNZtT/LSaKLoDWFKWK2d38fUywezbXYzexaWrCYHuRy4J9kmDcQLPLkCFnnwind4Hsek86A1Sef3/uLfpFl6UGQvSW6+B6Yx2xYAgLBb6/MESe6rUT2m3vPWwS4Y5/so69gQdidBUBQw8LY/ao4CvZjyT+2eHZCpmw93qTsd7ECsghB7agFVfdPlNtP45CpriidfuDmZ8F6JgXc+fHIsjSXKkqauFhBqgWnS5cBY343/ccAJRWQnqsedpe5EqtebyiW1cvkxmvSyKjvYBLUimo+a1NnMw+wYhFR+JXY

On Wed, 11 Mar 2026 20:53:10 +0100
Peter Zijlstra <peterz@infradead.org> wrote:

> > Which basically is just __do_trace_<event>(), but as a wrapper that can
> > handle updates that may be needed, but supplies a proper API where thing
> > wont randomly break when __do_trace_<event>() changes.  
> 
> That's like a 3 line patch, hardly worth the effort. Its not like it'll
> be hard to find and fix any users if you do ever change that.

No, but I prefer clean code, and not hacks that use internal functions with
underscores in their names. Not to mention, it properly handles different
cases:

diff --git a/include/linux/tracepoint.h b/include/linux/tracepoint.h
index 22ca1c8b54f3..07219316a8e1 100644
--- a/include/linux/tracepoint.h
+++ b/include/linux/tracepoint.h
@@ -294,6 +294,10 @@ static inline struct tracepoint *tracepoint_ptr_deref(tracepoint_ptr_t *p)
 			WARN_ONCE(!rcu_is_watching(),			\
 				  "RCU not watching for tracepoint");	\
 		}							\
+	}								\
+	static inline void trace_invoke_##name(proto)			\
+	{								\
+		__do_trace_##name(args);				\
 	}
 
 #define __DECLARE_TRACE_SYSCALL(name, proto, args, data_proto)		\
@@ -313,6 +317,11 @@ static inline struct tracepoint *tracepoint_ptr_deref(tracepoint_ptr_t *p)
 			WARN_ONCE(!rcu_is_watching(),			\
 				  "RCU not watching for tracepoint");	\
 		}							\
+	}								\
+	static inline void trace_invoke_##name(proto)			\
+	{								\
+		might_fault();						\
+		__do_trace_##name(args);				\
 	}


Then it goes through and updates every location that has a:

	if (trace_<event>_enabled()) {
		[..]
		trace_<event>();
	}

With the new proper API.

-- Steve
