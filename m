Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49C952D2488;
	Wed, 11 Mar 2026 19:43:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773258196; cv=none; b=QnvrFsR4ePU5GchaqwFUUpIomMsJfXt5z5bv9MUUkbCUlL9Gvlo5K99lraJXM/YbpCxnUF0OHnXMwUJIn4kQ4BIiGFpcMwXX/lT7sEFH6Y+6y5AxgGbvBRQRnvaXfuKY25a3Zgw8Nn1Vo+aGI0SHSj9PhHFBOGlxgjFbcRbTErA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773258196; c=relaxed/simple;
	bh=tWuZWGWIIdy34/6ikze0VnjyJtcKHGPA9DsMtHRw6yA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CIrHz7wz4u9ex+U96wNExB0OQqfoffNUULcUlnhWrbCJImNCUYWp9S7o7U3NmpZ6E5Mmx1fzInDuuWpEaVU8hvcen6aMP4HkQ6jZScf2j3QqWqdEueM7FLfzDexK8Mh7ivfKn7rxhyG/QQIKxyAf/0mcItSYM77ZQ32a3e6ozsw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=eZ8Rkoe8; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="eZ8Rkoe8"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=jW30sOm34LIDik7ynHg5PrKBS5jGdsOHpTqCM6OkCP8=; b=eZ8Rkoe8Gn00yWfX+eALxQtgUF
	xfuRAT4q6uwU0chblVRBL815Bugsy+Y2x5eeRXMHMnC0sX+LTllIzARHoYEo4y3cheoph6jEtBdxa
	fYKtQtYmu3ckYV7evrwq/KGOIdb347kQi3aL7xyAmjLRMTNoqnn5w1CW9luSJQpzl30Z2JDVeC8XI
	CwUE2Kv/Z7vvD0NlucztM+jxvC8hYzkxNvmU8E36LzT9ppM49OxpSR8krFwTMG3bAgvKhX/Y7uDp+
	KJvknlHTER3oNXmA/iTTwTkBqraih3xhSk9/52vO5yZfpONqJTntvGlkij3jH2CRuOifRIUq3PqeL
	6iSOODCQ==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w0PSU-0000000ACTu-2esQ;
	Wed, 11 Mar 2026 19:43:06 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 2E896303178; Wed, 11 Mar 2026 20:43:05 +0100 (CET)
Date: Wed, 11 Mar 2026 20:43:05 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Wander Lairson Costa <wander@redhat.com>
Cc: Ingo Molnar <mingo@redhat.com>, Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	open list <linux-kernel@vger.kernel.org>,
	"open list:TRACING" <linux-trace-kernel@vger.kernel.org>,
	acme@kernel.org, williams@redhat.com, gmonaco@redhat.com
Subject: Re: [PATCH v3 4/4] trace/preemptirq: Implement trace_irqflags hooks
Message-ID: <20260311194305.GT606826@noisy.programming.kicks-ass.net>
References: <20260311125021.197638-1-wander@redhat.com>
 <20260311125021.197638-5-wander@redhat.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260311125021.197638-5-wander@redhat.com>

On Wed, Mar 11, 2026 at 09:50:18AM -0300, Wander Lairson Costa wrote:
> +#define local_irq_enable()				\
> +	do {						\
> +		if (tracepoint_enabled(irq_enable))	\
> +			trace_local_irq_enable();	\

I'm thinking you didn't even look at the assembly generated :/

Otherwise you would have written this like:

		if (tracepoint_enabled(irq_enable))
			__do_trace_local_irq_enable();

> +		raw_local_irq_enable();			\
> +	} while (0)

Again, this was one instruction, and you clearly didn't bother looking
at the mess you've generated :/
