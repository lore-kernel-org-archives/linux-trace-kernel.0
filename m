Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9272C1EA7F4;
	Mon,  7 Jul 2025 11:20:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751887216; cv=none; b=X2QhdqeQN+AAiPwU2UEqeTIb0F757F5lqBfRMHF5+gI0wHm+evTTBaYxvyS0XaKhpACEgM1QK5VqF5Zxat30wkDyvSQL/IVQ/MZs3kEYI+3Cpa5syb//SoM6oMGM8BB8Wrwduxj5411VL5/eXo9NmfM6zdPv/Z9SSEU7UbhDTTo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751887216; c=relaxed/simple;
	bh=jGJv2jD1XliaBIVIsdqHQMv9dLKCXfRhTPtoA4SGGAE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gMqEeU8JYl+uFWNznKedfxfwGSTWIXFTfSNx2DZ0pUfJkQLge8LCMH/oTz99N48jNWcL3hbJjXpyw3zatL2rYGdfdltKzTY0DgOHJtLUl4SSbZnp2yEdYyLWGjAEJVCPdl5kdXrYU2hxQMxKN6sXkTRwEBKE+STWcbgPxjjQXAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=R8LinyIA; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="R8LinyIA"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=AFfQkkgZzfauywkGBPgbqC8epe1MW8MLE7JR074khWM=; b=R8LinyIA58zjWkyc7cu3rYC/52
	QZcZ01yx++c2zOAcfnhH10NsxZ4ceEpqwyFmXyHRye2oE2t8ZseJ8+HJrWJh/qGc+oi8m2lMeRn8A
	p/cZIigLytjdPiCz/8iSV/q+SfXzYrr2YWCveOdy5kgDcvVt0b2qPejgcz0ydp87WTq8QeY44T9xa
	SxC3kgyjKKE3JHNs8mBZpqWRQkuNpQ1dn5ae2IlNDRJYpPPMDNZhTolgl/KLjbKSUIqF95LyMuVPh
	/JPzRIwM4ME3MMfZ8uUkNJPcJPxYWGa835ACJ1yuPofqhYsfOCthJaRC3Q8QvGVN+SMKuPkbCqt7F
	+RDbidiw==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uYjtD-00000008TYL-3zoG;
	Mon, 07 Jul 2025 11:20:04 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 7CB5B300399; Mon, 07 Jul 2025 13:20:03 +0200 (CEST)
Date: Mon, 7 Jul 2025 13:20:03 +0200
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
	David Woodhouse <dwmw@amazon.co.uk>,
	Thomas Gleixner <tglx@linutronix.de>,
	Boqun Feng <boqun.feng@gmail.com>,
	open list <linux-kernel@vger.kernel.org>,
	"open list:TRACING" <linux-trace-kernel@vger.kernel.org>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Clark Williams <williams@redhat.com>,
	Gabriele Monaco <gmonaco@redhat.com>
Subject: Re: [PATCH v3 2/2] tracing/preemptirq: Optimize
 preempt_disable/enable() tracepoint overhead
Message-ID: <20250707112003.GY1613376@noisy.programming.kicks-ass.net>
References: <20250704170748.97632-1-wander@redhat.com>
 <20250704170748.97632-3-wander@redhat.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250704170748.97632-3-wander@redhat.com>

On Fri, Jul 04, 2025 at 02:07:43PM -0300, Wander Lairson Costa wrote:
> Similar to the IRQ tracepoint, the preempt tracepoints are typically
> disabled in production systems due to the significant overhead they
> introduce even when not in use.
> 
> The overhead primarily comes from two sources: First, when tracepoints
> are compiled into the kernel, preempt_count_add() and preempt_count_sub()
> become external function calls rather than inlined operations. Second,
> these functions perform unnecessary preempt_count() checks even when the
> tracepoint itself is disabled.
> 
> This optimization introduces an early check of the tracepoint static key,
> which allows us to skip both the function call overhead and the redundant
> preempt_count() checks when tracing is disabled. The change maintains all
> existing functionality when tracing is active while significantly
> reducing overhead for the common case where tracing is inactive.
> 

This one in particular I worry about the code gen impact. There are a
*LOT* of preempt_{dis,en}able() sites in the kernel and now they all get
this static branch and call crud on.

We spend significant effort to make preempt_{dis,en}able() as small as
possible.
