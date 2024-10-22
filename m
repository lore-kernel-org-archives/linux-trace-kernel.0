Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74F7612FB2E;
	Tue, 22 Oct 2024 07:18:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729581512; cv=none; b=Jlw1SmsPdFvPyuJ4/haq3gLcklxeTfoK6wm9fIGYlAgedJLxYzs9HrZkTcIAx2ZeyP8KWsRbtGsuQROYbb6SnXy0+H9UKqqD8b+OAwpa1SXv2EKp9aAbjZeTvMnNqCUeIN+eAfHXd67OaTB4v/t5Mce4mtp5QdvrecNKin+hEto=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729581512; c=relaxed/simple;
	bh=ynG+1i39ho8PEG2SqP7DoDCKjD2QG0RoXTtMVCnnppA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DyrUIbGhEMuazyVdCkL7LriZ31Xu3RUIZHaEFYu+TNupeozLqVV0EuS8gmN3ICW0bVfQqKycxqWk2jP8Q4vI+KJtdWgCry2euhEySHReezbDVVZU1PmdwU6XQin/mPbYzYseIRHpEUwk1q+C6TCGUtTO403x2LSO6YP2rrAqh0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C21CC4CEC3;
	Tue, 22 Oct 2024 07:18:29 +0000 (UTC)
Date: Tue, 22 Oct 2024 03:18:27 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org, Peter
 Zijlstra <peterz@infradead.org>, tglx@linutronix.de, mingo@kernel.org,
 juri.lelli@redhat.com, vincent.guittot@linaro.org,
 dietmar.eggemann@arm.com, bsegall@google.com, mgorman@suse.de,
 vschneid@redhat.com, ankur.a.arora@oracle.com, efault@gmx.de, Masami
 Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>
Subject: Re: [PATCH v2 2/3] tracing: Record task flag NEED_RESCHED_LAZY.
Message-ID: <20241022031827.21e70b2b@rorschach.local.home>
In-Reply-To: <20241021151257.102296-3-bigeasy@linutronix.de>
References: <20241021151257.102296-1-bigeasy@linutronix.de>
	<20241021151257.102296-3-bigeasy@linutronix.de>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 21 Oct 2024 17:08:41 +0200
Sebastian Andrzej Siewior <bigeasy@linutronix.de> wrote:

>  enum trace_flag_type {
>  	TRACE_FLAG_IRQS_OFF		= 0x01,
>  	TRACE_FLAG_NEED_RESCHED		= 0x02,
> +	TRACE_FLAG_NEED_RESCHED_LAZY	= 0x04,
>  	TRACE_FLAG_HARDIRQ		= 0x08,
>  	TRACE_FLAG_SOFTIRQ		= 0x10,
>  	TRACE_FLAG_PREEMPT_RESCHED	= 0x20,

As I stated in the other email, these are user visible. Should probably
make the LAZY flag 0x100, as the trace_flags are 16 bits worth.

-- Steve
