Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5537545948;
	Wed,  9 Oct 2024 14:25:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728483920; cv=none; b=Qa1X1Atu21oYXxKbmtEOHNVdRubXR/NNcZdXwC9QjDbbC1MjnGuUfjrEYPi3/tBYFvrRK6mmLgHwVRbe3f50cnWl+6z9wMUgzXcAOrOxqped8/XRfeCHsi0PARNKqIIIBZ82aSFVeovtwdO/vqWdTvCtIZSQ4xeSpoLIcMhbNXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728483920; c=relaxed/simple;
	bh=NiiA1ilrm43oeHu9GlFTmchewfrZmOn44dPv0EwUWgo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IjH3CZt/tzIjy1tyoS2b5JUfNMNkSayoI62ab+3cojRtJO4tPoxyzfIHh+uvcbnGIe6SyWPOJeaIrzO+SDSeG1xkyNE/SrzpWhUJERhBO0kQrI9Wvo3PhOVf+8aHTwxLlCu2ki6L9lOBW3YV4xasVNhGIJkgmwRRGH5nQnOh82Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 121A6C4CEC3;
	Wed,  9 Oct 2024 14:25:17 +0000 (UTC)
Date: Wed, 9 Oct 2024 10:25:22 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org, Peter
 Zijlstra <peterz@infradead.org>, tglx@linutronix.de, mingo@kernel.org,
 juri.lelli@redhat.com, vincent.guittot@linaro.org,
 dietmar.eggemann@arm.com, bsegall@google.com, mgorman@suse.de,
 vschneid@redhat.com, ankur.a.arora@oracle.com, efault@gmx.de, Masami
 Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>
Subject: Re: [PATCH 2/3] tracing: Record task flag NEED_RESCHED_LAZY.
Message-ID: <20241009102522.6707438f@gandalf.local.home>
In-Reply-To: <20241009105709.887510-3-bigeasy@linutronix.de>
References: <20241009105709.887510-1-bigeasy@linutronix.de>
	<20241009105709.887510-3-bigeasy@linutronix.de>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed,  9 Oct 2024 12:50:56 +0200
Sebastian Andrzej Siewior <bigeasy@linutronix.de> wrote:

> The scheduler added NEED_RESCHED_LAZY scheduling. Record this state as
> part of trace flags and expose it in the need_resched field.
> 
> Record and expose NEED_RESCHED_LAZY.
> 
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

Reviewed-by: Steven Rostedt (Google) <rostedt@goodmis.org>

-- Steve

> ---
>  include/linux/trace_events.h |  1 +
>  kernel/trace/trace.c         |  2 ++
>  kernel/trace/trace_output.c  | 14 +++++++++++++-
>  3 files changed, 16 insertions(+), 1 deletion(-)

