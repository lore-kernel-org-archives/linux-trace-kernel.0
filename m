Received: from relay.hostedemail.com (smtprelay0012.hostedemail.com [216.40.44.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F33D43002A7;
	Tue, 18 Nov 2025 20:24:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763497451; cv=none; b=kCOw8JE5aKfAwPzmBdHRwTMPjPU3uW39/YWGq9PxRsWZJ9MpbzsvL8QZHfhgxWGdOH14XhU16A7TFAoI00ajCQ/bAy/lL5G9Y2JYx9eZaakResbXRI4I3glEGWSa6M8kMKq0Iseu24kLxdxWWC/+T+vA1OiC7GP8AzL2ygVvXIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763497451; c=relaxed/simple;
	bh=gbbX7/BOui2VKT6AvjbLXaKvC8C6+AJQ1G27NgC6SAk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uG1Kf7oRBw7w9M24Q98KJU09Ee45YZGEE+hBgCTIljWZYrxiMe3xrjIOrA4zzE91lFQRaRIDU1GHpvMHVGCcGPY2x8E41xbbgMR9FqPzR/9bedH3xY8qWpXER+ElfDRMABEK0d5OBnAur8GL59yBMsUndr0q6wu4uslow5tTleA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf17.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay03.hostedemail.com (Postfix) with ESMTP id 9ED34B6AFF;
	Tue, 18 Nov 2025 20:24:00 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf17.hostedemail.com (Postfix) with ESMTPA id C2BA217;
	Tue, 18 Nov 2025 20:23:57 +0000 (UTC)
Date: Tue, 18 Nov 2025 15:24:25 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Steven Rostedt <rostedt@kernel.org>, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Andrew Morton
 <akpm@linux-foundation.org>, Thomas Gleixner <tglx@linutronix.de>, Ian
 Rogers <irogers@google.com>, Namhyung Kim <namhyung@kernel.org>, Arnaldo
 Carvalho de Melo <acme@kernel.org>, Jiri Olsa <jolsa@kernel.org>, Douglas
 Raillard <douglas.raillard@arm.com>
Subject: Re: [POC][RFC][PATCH 1/3] tracing: Add perf events
Message-ID: <20251118152425.6b3bee21@gandalf.local.home>
In-Reply-To: <20251118084226.1e531c4b@gandalf.local.home>
References: <20251118002950.680329246@kernel.org>
	<20251118003531.644484343@kernel.org>
	<20251118083510.GI3245006@noisy.programming.kicks-ass.net>
	<20251118084226.1e531c4b@gandalf.local.home>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: rspamout08
X-Rspamd-Queue-Id: C2BA217
X-Stat-Signature: xseauqs67nqm6o6wewxg7nq1ag64xyy9
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX191Dnu6RCNbNSxwlmFMlwGsQjIPIVb2lC0=
X-HE-Tag: 1763497437-128984
X-HE-Meta: U2FsdGVkX18uHeVyqDnFOZ+9GeGnqHiVNyPbYYkD/Qv97ei1JiRtKyd4sKTJNtMdfqWNJUjof8O6iU6zSST4Eh0w3bK/f/c7mMiCxmT350HpEZEuJtMeIIsUNC+2nMBt/6Fu5vIQAFljTsChOLzKNMtznaSTFMXP1amgyydNL5Vgj36Exfq4BuFf0dKlcsqHwCli4VftqW+ZfBIt/ufbBO/42YEL0EPJWVBWBdNEHTwwfPzzEIBTOcovKdiGdXYZ2xY2rd957CSypmkzOVmo+L772KxHzXqarv7BabtVHIXhPu8MmkriWpkP2QGGLeEzAMqsoqKocrfSBMSVjoIXXu9MkB3Ds/d1GnzKdSoiTNpieN7XuRyy3ycZE3Kmf5Og

On Tue, 18 Nov 2025 08:42:26 -0500
Steven Rostedt <rostedt@goodmis.org> wrote:

> > 
> > What you wanted to use was perf_event_read_local().  
> 
> Great! I didn't know about that. Which is why I posted this as a
> PROOF-OF-CONCEPT and not even a normal RFC, so that I could learn about the
> proper way of doing this.

I folded in this change:

diff --git a/kernel/trace/trace_event_perf.c b/kernel/trace/trace_event_perf.c
index ff864d300251..34962f80dce1 100644
--- a/kernel/trace/trace_event_perf.c
+++ b/kernel/trace/trace_event_perf.c
@@ -478,6 +478,7 @@ u64 do_trace_perf_event(int type)
 	struct trace_perf_event __percpu **pevents;
 	struct trace_perf_event __percpu *events;
 	struct perf_event *e;
+	u64 val;
 	int *count;
 	int cpu;
 
@@ -499,8 +500,10 @@ u64 do_trace_perf_event(int type)
 	if (!e)
 		return 0;
 
-	e->pmu->read(e);
-	return local64_read(&e->count);
+	if (perf_event_read_local(e, &val, NULL, NULL) < 0)
+		return 0;
+
+	return val;
 }
 
 static void __free_trace_perf_events(struct trace_perf_event __percpu *events)

Thanks!

-- Steve
