Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=216.40.44.15
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795541815;
	b=az6fdvsN3lZxJG8EDujuIyMSLdsQ9fH0Ouk2giDYtSZpMjv8OJMw0tR4kvR1F4hXS/De
	 PjoDU7H6pcxM7uQBM9Yo5RXvmOgyYshFHZLv9/+f2d82VWpk4XyRoLR+e82IrfFtA1csE
	 WX214gaqwwR9ArHg3fRUiu8mueqblAUM0ztjNpIm4F8Haq0FelbKsXLc8FF7JFHz1RflN
	 1E3edsXwfnSqF6WhprcLaURfjwQTJlzf+x7k60rbj6tcj9N/GMocJ1QnYYnzndMOekWSz
	 RCCGP299zqS+aatzssCKMfsjs3CdygttqI0gV+Mo3OgNhn4B3Om48rgAkNa7aYVOGbQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795541815;
	h=DMARC-Filter:Received:Received:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-Stat-Signature:X-Spam-Status:
	 X-Rspamd-Server:X-Rspamd-Queue-Id:X-Session-Marker:X-Session-ID:
	 DKIM-Signature:X-HE-Tag:X-HE-Meta;
	bh=cgbskdNiwv1foCu8NskiI0D1syGORGzYIPtRO06UAuE=;
	b=SDlNltqE4KlXUTHhCmJfaXaTSI8rmH5Lc39ZDKaxtT19DwfyhvjsMAj0uHP+9gh2yn4L
	 mBYTWfyJFOWGhEWo+PlzIEmb53ICAGB5gGgPUB3r9yFOyj3YBlj/MkPgTUu3Uwo+a0VHY
	 9dCfJSmxM7eDzN7w1+psr6C86unH9FkV1H0RSMKgMspgtJ+kxsoQoUfokUsuTMciCSJ/h
	 wqZVXnlndAm36VvVMJd8xAmMo7e+lQAlkIf1ScaQ2JCIl4rQNaY/DY5ofzx2S8CPK4mvN
	 a6P85JRXuljJna1SqqUlbXlhivLE+G077vSULpYgpUiM+Sxfkf45vDC+dDHHrDjhltQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=goodmis.org;
	spf=pass smtp.mailfrom=goodmis.org;
	dkim=pass header.d=goodmis.org header.i=@goodmis.org header.a=rsa-sha256 header.s=dkim1 header.b=IKsjSGKG;
	arc=none smtp.remote-ip=216.40.44.15
Received: from relay.hostedemail.com (smtprelay0015.hostedemail.com [216.40.44.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0E01606A331;
	Tue, 24 Nov 2026 17:36:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A0E01606A331
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=goodmis.org header.i=@goodmis.org header.a=rsa-sha256 header.s=dkim1 header.b=IKsjSGKG
Received: from omf08.hostedemail.com (lb01a-stub [10.200.18.249])
	by unirelay04.hostedemail.com (Postfix) with ESMTP id 98CE81A0C2A;
	Tue, 24 Nov 2026 17:36:48 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf08.hostedemail.com (Postfix) with ESMTPA id 5C8E520025;
	Tue, 24 Nov 2026 17:36:40 +0000 (UTC)
Date: Tue, 24 Nov 2026 12:36:38 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Karl Mehltretter <kmehltretter@gmail.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Thomas Gleixner
 <tglx@kernel.org>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>, Ingo Molnar <mingo@redhat.com>, Andy
 Lutomirski <luto@kernel.org>, Frederic Weisbecker <frederic@kernel.org>,
 "Paul E. McKenney" <paulmck@kernel.org>, Boqun Feng <boqun@kernel.org>,
 Waiman Long <longman@redhat.com>, Juri Lelli <juri.lelli@redhat.com>,
 Vincent Guittot <vincent.guittot@linaro.org>, Dietmar Eggemann
 <dietmar.eggemann@arm.com>, Ben Segall <bsegall@google.com>, Mel Gorman
 <mgorman@suse.de>, Valentin Schneider <vschneid@redhat.com>, K Prateek
 Nayak <kprateek.nayak@amd.com>, Hongyan Xia <hongyan.xia@transsion.com>,
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>,
 Randy Dunlap <rdunlap@infradead.org>, Andrew Morton
 <akpm@linux-foundation.org>, Nathan Chancellor <nathan@kernel.org>, Nick
 Desaulniers <ndesaulniers@google.com>, Bill Wendling <morbo@google.com>,
 Justin Stitt <justinstitt@google.com>,
 linux-arm-kernel@lists.infradead.org, linux-trace-kernel@vger.kernel.org,
 linux-rt-devel@lists.linux.dev, linux-doc@vger.kernel.org,
 llvm@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH v2 03/13] sched: Split preempt-count bookkeeping
 from raw updates
Message-ID: <20261124123638.0a4e795f@gandalf.local.home>
In-Reply-To: <20261028033127.82193-4-kmehltretter@gmail.com>
References: <20261028033127.82193-1-kmehltretter@gmail.com>
	<20261028033127.82193-4-kmehltretter@gmail.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Post: <mailto:linux-trace-kernel@vger.kernel.org>
List-Help: <mailto:linux-trace-kernel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-trace-kernel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: o7t4gho3twp1pjm483fepzra6sqea1zo
X-Rspamd-Server: rspamout07
X-Rspamd-Queue-Id: 5C8E520025
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX19jjJfeX0Pq5rKkc5XDNag2YF12GXEJJ0c=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=goodmis.org; h=date:from:to:cc:subject:message-id:in-reply-to:references:mime-version:content-type:content-transfer-encoding; s=dkim1; bh=cgbskdNiwv1foCu8NskiI0D1syGORGzYIPtRO06UAuE=; b=IKsjSGKGP88SZhny+HOXUAncmF19+0BUUDc0u5l131xdPNIc+2cg03+qSMi4x6VuvPafyYRbcZOODK7TaUD++oAq/LMHs2D0SKg5emJipMmethrJ58TkI4h8EoUxZ0NZ8yxGtlukmRBcEXebp911C1pjPZXIb3/Pn1vcULBVoBE=
X-HE-Tag: 1795541800-76208
X-HE-Meta: U2FsdGVkX1//0KdiMOWlABzDJ67uxFLp67YDmtynpCt6dGXlAXSOGXfWHH0NQNs4J18yoejLLirzKE6G+vDscomrddt0UbSWq2IScO0sdUJn1oCI575V2BTFdRhwUotSimZAihEXlFEgu3xlutyREHxNwcNEBrwolkeD0shXWG2W2MBsl/ucTPI5lO1Iea1l0g38kDuJ8CQrWgVl5qMnbwe4rUtj4gpUSI2wgRhN2vevOwdKbe4O6wS7u77F+Iug+Lna94xG+7dS6JKnxC5hF52AwE7bilNEZN4y7ubYvJ6DOkX3WMV2o5HCvaD6l7VtjteZjoPT6dth7kBCDU7R1W5RCOmwKVa0

On Wed, 28 Oct 2026 04:31:17 +0100
Karl Mehltretter <kmehltretter@gmail.com> wrote:

> diff --git a/include/linux/irqentry_hardirq.h b/include/linux/irqentry_hardirq.h
> new file mode 100644
> index 0000000000000..1937fc972e846
> --- /dev/null
> +++ b/include/linux/irqentry_hardirq.h
> @@ -0,0 +1,81 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +#ifndef __LINUX_IRQENTRY_HARDIRQ_H
> +#define __LINUX_IRQENTRY_HARDIRQ_H
> +
> +#include <linux/preempt.h>
> +
> +struct irqentry_hardirq_cookie {
> +#if defined(CONFIG_DEBUG_PREEMPT) && \
> +	!defined(CONFIG_HAS_SEPARATE_PREEMPT_RESCHED_BITS)
> +	bool applied;
> +#endif
> +};
> +
> +static __always_inline bool
> +irqentry_hardirq_count_applied(struct irqentry_hardirq_cookie cookie)
> +{
> +#if defined(CONFIG_DEBUG_PREEMPT) && \
> +	!defined(CONFIG_HAS_SEPARATE_PREEMPT_RESCHED_BITS)
> +	return cookie.applied;
> +#else
> +	return true;
> +#endif
> +}
> +
> +static __always_inline bool irqentry_hardirq_count_valid(void)
> +{
> +#ifdef CONFIG_DEBUG_PREEMPT
> +	/*
> +	 * Without separate reschedule bits, preempt_count() excludes any
> +	 * shared reschedule bit. A negative result therefore denotes an
> +	 * existing underflow.
> +	 */
> +	if (!IS_ENABLED(CONFIG_HAS_SEPARATE_PREEMPT_RESCHED_BITS) &&
> +	    preempt_count() < 0)
> +		return false;
> +#endif
> +	return true;
> +}
> +
> +#if defined(CONFIG_DEBUG_PREEMPT) && \
> +	!defined(CONFIG_HAS_SEPARATE_PREEMPT_RESCHED_BITS)
> +struct irqentry_hardirq_cookie noinstr
> +__irqentry_hardirq_count_start_slow(void);
> +#endif
> +
> +/*
> + * Attempt the non-instrumentable part of a staged hardirq-count addition and
> + * record whether it was applied. The returned cookie must be passed to the
> + * matching irqentry_hardirq_count_finish() and subtraction preparation. A
> + * rejected cookie attempts deferred reporting and suppresses post-add
> + * bookkeeping and the matching subtraction regardless of warning
> + * suppression.
> + */
> +static __always_inline struct irqentry_hardirq_cookie
> +irqentry_hardirq_count_start(void)
> +{
> +	struct irqentry_hardirq_cookie cookie = { };
> +
> +#if defined(CONFIG_DEBUG_PREEMPT) && \
> +	!defined(CONFIG_HAS_SEPARATE_PREEMPT_RESCHED_BITS)
> +	cookie.applied = true;
> +	/* DEBUG_LOCKS_WARN_ON() permits the addition during an oops. */
> +	if (unlikely(!irqentry_hardirq_count_valid()))
> +		return __irqentry_hardirq_count_start_slow();
> +#endif
> +	__preempt_count_add(HARDIRQ_OFFSET);
> +
> +	return cookie;
> +}
> +

BTW, the above would look so much better and be much easier to maintain if
you just made stubs when not needed:

#if defined(CONFIG_DEBUG_PREEMPT) && !defined(CONFIG_HAS_SEPARATE_PREEMPT_RESCHED_BITS)

struct irqentry_hardirq_cookie {
	bool applied;
};

static __always_inline bool
irqentry_hardirq_count_applied(struct irqentry_hardirq_cookie cookie)
{
	return cookie.applied;
}

static __always_inline bool irqentry_hardirq_count_valid(void)
{
	/*
	 * Without separate reschedule bits, preempt_count() excludes any
	 * shared reschedule bit. A negative result therefore denotes an
	 * existing underflow.
	 */
	return preempt_count >= 0;
}

#else /* !CONFIG_DEBUG_PREEMPT || CONFIG_HAS_SEPARATE_PREEMPT_RESCHED_BITS
struct irqentry_hardirq_cookie {
};
static __always_inline bool
irqentry_hardirq_count_applied(struct irqentry_hardirq_cookie cookie)
{
	return true;
}
static __always_inline bool irqentry_hardirq_count_valid(void)
{
	return true;
}
#endif /* defined(CONFIG_DEBUG_PREEMPT) && !defined(CONFIG_HAS_SEPARATE_PREEMPT_RESCHED_BITS) */

-- Steve
