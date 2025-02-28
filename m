Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4261AC2F2;
	Fri, 28 Feb 2025 01:45:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740707141; cv=none; b=O5XGeYe5twoBKUwnT6gktlZosih0r7gF9y/V/7CfZD8PxiODxdKzStKtQaErL/Lt1E1uM53PE4jp7eW0+kyaO1lUypO/Ukhs2ozNBM4syGsWAW6SUOYGFJTM7/VrPHbt9VSLq6rZJd3tZXDiKjVtW7cdqkeK7KH6UtF1YEm2mbI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740707141; c=relaxed/simple;
	bh=FdM+SWazuMviL3adW6k2iGTQW1/8u96S5utnExJhd0A=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OjKwpJr9+TQj2z7lYzw7jkPA7s4PzsRs+GjdziU9iZV9oydHpzPuM8zBsLQwoZWT4YiJx2PEBKD9Lj/z2TtFqpDKmWqq29PxPqu/A7P2tcDBK49oO6n6G2soSLKt80h4GB1Onj5LnEAtgFvRk33zt6rhTVb9gf/v1/Lpd3kvxBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4683C4CEDD;
	Fri, 28 Feb 2025 01:45:39 +0000 (UTC)
Date: Thu, 27 Feb 2025 20:46:23 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Gabriele Monaco <gmonaco@redhat.com>
Cc: linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>, Peter
 Zijlstra <peterz@infradead.org>, Masami Hiramatsu <mhiramat@kernel.org>,
 linux-trace-kernel@vger.kernel.org, Juri Lelli <juri.lelli@redhat.com>
Subject: Re: [PATCH v4 03/11] sched: Add sched tracepoints for RV task model
Message-ID: <20250227204623.5e29e101@gandalf.local.home>
In-Reply-To: <20250218123121.253551-4-gmonaco@redhat.com>
References: <20250218123121.253551-1-gmonaco@redhat.com>
	<20250218123121.253551-4-gmonaco@redhat.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 18 Feb 2025 13:31:08 +0100
Gabriele Monaco <gmonaco@redhat.com> wrote:

> Add the following tracepoints:
> * sched_entry(bool preempt, ip)
>     Called while entering __schedule
> * sched_exit(bool is_switch, ip)
>     Called while exiting __schedule
> * sched_set_state(task, curr_state, state)
>     Called when a task changes its state (to and from running)
> 
> These tracepoints are useful to describe the Linux task model and are
> adapted from the patches by Daniel Bristot de Oliveira
> (https://bristot.me/linux-task-model/).
> 
> Signed-off-by: Gabriele Monaco <gmonaco@redhat.com>

I'll need an Ack from the scheduler maintainer to take this series.

-- Steve
