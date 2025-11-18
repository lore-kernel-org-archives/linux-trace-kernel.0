Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E427225BEE7;
	Tue, 18 Nov 2025 08:35:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763454922; cv=none; b=I55CZxPRF/RMrE/jn8MnR16MiPEsBnZ5l+wHvD2Rh+zT4EJLhUMaZwo5Z6ERoDyuOTbF47sZkrV5Sl8qn/OTfL0CiF04rWm7wgiaLXgt0ws7IF6RCtMEhVTWRtcN5JWGn8Scab8QB3vZ5LcnqB8LGDs71q1yZTHsjXk2I/8oH9Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763454922; c=relaxed/simple;
	bh=RXkm2E5Vg455vq1PY7m6tmxlNSui7Vyn0Y+Cae08bcc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EKiLpw7rh++nVD4UT8XGLvkyHMp8g4fQ1rVwqAABbuk40rpfZikg59Gbf3atFp7cOKo3HCzBEPgtCZki/5BMtnTATwa7PGYDsRWyvssE80O6D1pB+0DealfDcnyUvRgi582sRSL+gukbsLnQj3Y7m0y2eZpACLn4Z54t2k8e2Ng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=CEA7cLdW; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="CEA7cLdW"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=kRnZGk99wwMXp5mUkVdrvOYQwHDVWDiRokff8sTdbGM=; b=CEA7cLdWb/AaV/nM/VbIHNiFzo
	3ziG7uK7z+4u6VrWnCLOwe6LO6PlkYX+C7VaU2aDIl+AITRkHZd9fSozLSuvz8sCPb2pqyzHnnKOf
	oOLYHmCj0+vJiJj7q/ZDoY395fBfKdK+a2fVbK8VU+uaQJSi6bdwurcx8tPocoJW9SmqmcK8xPIWy
	ZM/cDPKVD/Y4z26jAK+B2i1eWkDiTth5SQHBkRuNgQGen5KF1CX3FyzOxlYNX1Un/WGlSDeVo6D7H
	U6nHAO21yCM3J1dTTS/Rga7eMTgOSoFSn0pBlhySm45pdEWhnuLIleFcBH/bS2K8eGHjLKhrDxNmz
	pxziXv2g==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vLHB9-0000000FCQq-3VgJ;
	Tue, 18 Nov 2025 08:35:11 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 5774E300325; Tue, 18 Nov 2025 09:35:10 +0100 (CET)
Date: Tue, 18 Nov 2025 09:35:10 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Steven Rostedt <rostedt@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ian Rogers <irogers@google.com>, Namhyung Kim <namhyung@kernel.org>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Jiri Olsa <jolsa@kernel.org>,
	Douglas Raillard <douglas.raillard@arm.com>
Subject: Re: [POC][RFC][PATCH 1/3] tracing: Add perf events
Message-ID: <20251118083510.GI3245006@noisy.programming.kicks-ass.net>
References: <20251118002950.680329246@kernel.org>
 <20251118003531.644484343@kernel.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251118003531.644484343@kernel.org>

On Mon, Nov 17, 2025 at 07:29:51PM -0500, Steven Rostedt wrote:
> +u64 do_trace_perf_event(int type)
> +{
> +	struct trace_perf_event __percpu **pevents;
> +	struct trace_perf_event __percpu *events;
> +	struct perf_event *e;
> +	int *count;
> +	int cpu;
> +
> +	if (set_perf_type(type, NULL, NULL, &count, &pevents) < 0)
> +		return 0;
> +
> +	if (!*count)
> +		return 0;
> +
> +	guard(preempt)();
> +
> +	events = READ_ONCE(*pevents);
> +	if (!events)
> +		return 0;
> +
> +	cpu = smp_processor_id();
> +
> +	e = per_cpu_ptr(events, cpu)->event;
> +	if (!e)
> +		return 0;
> +
> +	e->pmu->read(e);
> +	return local64_read(&e->count);
> +}

NAK, wtf do you think its okay to use internal stuff like that? And
wrongly while at it.

What you wanted to use was perf_event_read_local().
