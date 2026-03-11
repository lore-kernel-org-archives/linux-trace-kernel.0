Received: from relay.hostedemail.com (smtprelay0016.hostedemail.com [216.40.44.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05D463A16B8;
	Wed, 11 Mar 2026 23:16:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773270986; cv=none; b=toMOJT4mpG/rGJkqV5ibURMZFJgTgj9W+jinQwF8rRsm+cEPlL05hF/Qj/R0JePOcLH3qhZ6M+hGgmNhs3ekuvzO2fFkwVBY1ZVqTbsKLw+fz3bj3ZpBcfYK6r17ClBDuobmu7BAYnFR94fL45yd3fvs8xXlZcr3NCmCKdJp6Ek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773270986; c=relaxed/simple;
	bh=sVN81DEmTyoIQMvYnAlqHOwHhjWH4+ALTRsXY5uyLOE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dUYWBbiLLR32wWzotg0W+H9Fex69TLzRvcsCnAbrgwXtZRND3pouKZmAHPuPI0Bmxx2trv1flNoaanav8STBUnsDbCHxsEBEmhvr8zUsuxZdcN7lW5AcfMjrO1YPvVgeEq4lgw0syF2DkDaw0r4qZ61gsaGQ9EoqTVNVkVUhDEs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf12.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay10.hostedemail.com (Postfix) with ESMTP id 3BCC7C1CF7;
	Wed, 11 Mar 2026 23:16:22 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf12.hostedemail.com (Postfix) with ESMTPA id BDFF717;
	Wed, 11 Mar 2026 23:16:18 +0000 (UTC)
Date: Wed, 11 Mar 2026 19:16:31 -0400
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
Message-ID: <20260311191631.7895f55a@gandalf.local.home>
In-Reply-To: <20260311204607.GF2277644@noisy.programming.kicks-ass.net>
References: <20260311125021.197638-1-wander@redhat.com>
	<20260311125021.197638-5-wander@redhat.com>
	<20260311194305.GT606826@noisy.programming.kicks-ass.net>
	<20260311154842.0823790f@gandalf.local.home>
	<20260311195310.GU606826@noisy.programming.kicks-ass.net>
	<20260311160714.1e6b7a37@gandalf.local.home>
	<20260311204607.GF2277644@noisy.programming.kicks-ass.net>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: rxk191zbasue3cfuxjrrxmsch9hsgpd6
X-Rspamd-Server: rspamout04
X-Rspamd-Queue-Id: BDFF717
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX19b4tzybDSWRP4dSQaXN7EtFXHykw+f+28=
X-HE-Tag: 1773270978-697714
X-HE-Meta: U2FsdGVkX1/uRpNYf812QyOfQoiQ6yZV1kKQFv4/z+5wfsAzkQNitpTgkBPY1yEbU4uuWDf2nwWtfCS8amtCru7WlUwHyjrdb4LNL3vUHmklSHFb3+o2lNi2JjWH7UKT0UYGh7ERnUU+g3tDbszMOYPJrqbtrAPi+cXw1tcF3YZ06BEaOQuFhknA0jvtGH/sH4hE0GK2/HcHDnfVUr3CWMOpoWkEKtEdP6qbqpLaqT3qe9VsOaQMyk+G5PTMNuqKiMJyrfOk5ikE4LUIJjUeVIsTTIH/NplwRt8kpOPwd0bYvthaw0urCgtS6a8hc/Pku07Sp8dd2q4Oos6gJpDdYMouuTA218Jg0DgPlF5LIBmXtxI1E1EVzXekqwIobI+U

On Wed, 11 Mar 2026 21:46:07 +0100
Peter Zijlstra <peterz@infradead.org> wrote:

> > Then it goes through and updates every location that has a:
> > 
> > 	if (trace_<event>_enabled()) {
> > 		[..]
> > 		trace_<event>();
> > 	}  
> 
> We have Cocinelle for that :-), and while I absolutely suck at writing
> Cocinelle, I had some limited success using Gemini to write some for me
> the other day.

Heh, I believe Vineeth used claude ;-)

-- Steve
