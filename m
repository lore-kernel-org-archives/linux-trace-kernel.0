Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7B9B1CCB4E;
	Thu, 10 Oct 2024 14:52:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728571929; cv=none; b=sW0iLaDw0SRqeozTBCBQEonfRiwUAy8Y/KlDx7sN3D1XmMWaoolt1IHK7WU005FUyZX1NWOXEZXJ3iy97LMqymTd2uCLQRrlWmstkvDbLHmAw+dlbaWkmoTdC+iV6WC6BNZ1HV1PEJMu5NnwdDFiSX6ks8I+GhVfoPdBtlir4Qo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728571929; c=relaxed/simple;
	bh=TOVNudGA6vkdmv+kFkc6C7HqIf1ARFkyHiBrdybZqHo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MbYYZTLxvpHYBFd3TFlWGWhE7XADZmaLO04d1CRRhvbrYNB2QdQGNrLtECEMvV532KxmVaJTFp4qxxYeD2VoRMv/yDtzj/k5f0g91FDMhwjdotD7uT4JZfuG+rkXYMyM3r/0r2faUzWgWjZ2Qj/BVV7TrsyF2U1S/NeHwQnzDR4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD84AC4CEC5;
	Thu, 10 Oct 2024 14:52:07 +0000 (UTC)
Date: Thu, 10 Oct 2024 10:52:14 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Ankur Arora <ankur.a.arora@oracle.com>,
 linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org, Peter
 Zijlstra <peterz@infradead.org>, tglx@linutronix.de, mingo@kernel.org,
 juri.lelli@redhat.com, vincent.guittot@linaro.org,
 dietmar.eggemann@arm.com, bsegall@google.com, mgorman@suse.de,
 vschneid@redhat.com, efault@gmx.de, Masami Hiramatsu <mhiramat@kernel.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [PATCH 2/3] tracing: Record task flag NEED_RESCHED_LAZY.
Message-ID: <20241010105214.0b8f4375@gandalf.local.home>
In-Reply-To: <20241010105611.VArhcxcr@linutronix.de>
References: <20241009105709.887510-1-bigeasy@linutronix.de>
	<20241009105709.887510-3-bigeasy@linutronix.de>
	<87iku1b2vf.fsf@oracle.com>
	<20241009133328.23fc671c@gandalf.local.home>
	<87bjztaz7e.fsf@oracle.com>
	<20241010105611.VArhcxcr@linutronix.de>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 10 Oct 2024 12:56:11 +0200
Sebastian Andrzej Siewior <bigeasy@linutronix.de> wrote:

> +++ b/kernel/trace/trace.c
> @@ -2544,6 +2544,8 @@ unsigned int tracing_gen_ctx_irq_test(unsigned int irqs_status)
>  		trace_flags |= TRACE_FLAG_NEED_RESCHED;
>  	if (test_preempt_need_resched())
>  		trace_flags |= TRACE_FLAG_PREEMPT_RESCHED;
> +	if (IS_ENABLED(CONFIG_ARCH_HAS_PREEMPT_LAZY) && tif_test_bit(TIF_NEED_RESCHED_LAZY))
> +		trace_flags |= TRACE_FLAG_NEED_RESCHED_LAZY;
>  	return (trace_flags << 16) | (min_t(unsigned int, pc & 0xff, 0xf)) |
>  		(min_t(unsigned int, migration_disable_value(), 0xf)) << 4;
>  }

This is the only update you made from your previous version right?

If so, my reviewed-by stands.

-- Steve
