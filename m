Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3857B1DE2B4;
	Fri, 14 Feb 2025 22:30:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739572207; cv=none; b=jkWBR81VSMc7BTswVo+bfqT1n8/aRrPlR1/cp2bUaFio9rHT0V8LJjHh3iLn58djwln0MS1ZfP7OEgzMh35VzcMXNO2KnMMXdiPGoBHwEbfHKZzBZclMbe6/HJDTd2Y9Uft3hrF+C+OG9CLTXeH7QUS2DAXHAFORyu0dRvwdstI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739572207; c=relaxed/simple;
	bh=YrG3eqr3JuNDaow29YjpUS4/F477rGkaY7COfj9rjYo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CWFa7Rr79ZPijwKDA1uu6QD3PEHa5Wn2vTvpMrOtP0d/ZEpQ4BZBihzIiMyDWgz7reinslLQf3jwvRlSFu5WNRog7w4Syz04YlFvOAJWAA2X9dfS6rSUoG3PV2C9QEiQwV/2nXrbvANX0HlFzqn06aM8n6T+HtKzQthbGZf0RH8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A44DC4CED1;
	Fri, 14 Feb 2025 22:30:05 +0000 (UTC)
Date: Fri, 14 Feb 2025 17:30:17 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>, Luis Chamberlain
 <mcgrof@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, Mark
 Rutland <mark.rutland@arm.com>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Andrew Morton
 <akpm@linux-foundation.org>, Petr Pavlu <petr.pavlu@suse.com>, Sami
 Tolvanen <samitolvanen@google.com>, Daniel Gomez <da.gomez@samsung.com>,
 linux-modules@vger.kernel.org
Subject: Re: [PATCH 5/8] module: Add module_for_each_mod() function
Message-ID: <20250214173017.07b0b250@gandalf.local.home>
In-Reply-To: <20250206102720.0fd57129@gandalf.local.home>
References: <20250205225031.799739376@goodmis.org>
	<20250205225103.760856859@goodmis.org>
	<20250206142817.91853f475c681bc2ef7ca962@kernel.org>
	<20250206102720.0fd57129@gandalf.local.home>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 6 Feb 2025 10:27:20 -0500
Steven Rostedt <rostedt@goodmis.org> wrote:

> > BTW, do we really need to disable preempt or is it enough to call
> > rcu_read_lock()?  
> 
> Bah, as I expected this function to be changed, I didn't spend too much
> time on looking at its implementation. I just cut and pasted how the other
> loops worked. But yes, it should not be disabling preemption. In fact, I
> think the module code itself should not be disabling preemption!
> 
> I'll have to go and look into that.

It really looks like it requires preempt_disable(), as the code in
kernel/module/main.c has in several places:

	preempt_disable();

	list_for_each_entry_rcu(mod, &modules, list) {
		[..]
	}

	preempt_enable();

Or

	module_assert_mutex_or_preempt();

	[..]

	list_for_each_entry_rcu(mod, &modules, list,
				lockdep_is_held(&module_mutex)) {


So it looks like it either requires preempt_disable or holding the
module_mutex.

As I need to call this with trace_types_lock held, and there's a place
where trace_types_lock is within a module callback, I don't think it's safe
to take that lock in that loop, otherwise we have the ABBA deadlock.

Luis,

Is this patch OK, and also is there any plan to move the module code to
using just rcu_read_lock instead of preempt_disable?

-- Steve
