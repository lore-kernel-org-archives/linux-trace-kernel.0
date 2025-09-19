Received: from relay.hostedemail.com (smtprelay0014.hostedemail.com [216.40.44.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B858E2F83BA;
	Fri, 19 Sep 2025 15:36:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758296210; cv=none; b=CKwXI33ZPiPdqPxOBXQXX+eaWi9WNiaJ/a2aVL8E5IrPSKBJUW7GiPWAss3Aia2r78zYy10NnrjRjQX979u5c4KvGhbX05lFSH7UPbbnxXNk5J7zOOwRw8gUiWMYBDkwyaxtdFINyWwcX78nec0/BvGVgRqulaK3+5tWdDw0qYU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758296210; c=relaxed/simple;
	bh=8Su+R0xuYEFi7xFi6vvhkFNxAOiU4JxeiBYHcFcYnGo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EqeCQljROlfSU/ohOynoZvsuGe/JjjiBRe0VnYGyamq3cvxhZvwKXh7533K3uMSms1HTuNpvrwtdxpdxSLKYAnTrVzg4udKGMXBjEw7v5SIj9J2D9xoRZ3796xFy5xN47h1XVofMCcnBUNqw+9zOBJYzQvIp2BLWO7i7ZALkLqI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf09.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay07.hostedemail.com (Postfix) with ESMTP id 0CAD1160262;
	Fri, 19 Sep 2025 15:36:41 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf09.hostedemail.com (Postfix) with ESMTPA id CCBF020025;
	Fri, 19 Sep 2025 15:36:38 +0000 (UTC)
Date: Fri, 19 Sep 2025 11:37:49 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Gabriele Monaco <gmonaco@redhat.com>
Cc: linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>, Peter
 Zijlstra <peterz@infradead.org>, Nam Cao <namcao@linutronix.de>, Tomas
 Glozar <tglozar@redhat.com>, Juri Lelli <jlelli@redhat.com>, Clark Williams
 <williams@redhat.com>, John Kacur <jkacur@redhat.com>,
 linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH v2 16/20] sched: Export hidden tracepoints to modules
Message-ID: <20250919113749.7ee1f249@gandalf.local.home>
In-Reply-To: <20250919140954.104920-17-gmonaco@redhat.com>
References: <20250919140954.104920-1-gmonaco@redhat.com>
	<20250919140954.104920-17-gmonaco@redhat.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: 9g4jmygwyi15ubfrj9tt9ef466enohpf
X-Rspamd-Server: rspamout05
X-Rspamd-Queue-Id: CCBF020025
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX18Ny81I3+Lr9/vOXvloqaeDNiGKg0B2T4c=
X-HE-Tag: 1758296198-285191
X-HE-Meta: U2FsdGVkX1/QbP5EPoowLIXs7Vb/qZvGYf0529WxessEWV/kBogdbDISTzKebqeQjD0bXGANcP1VsJyHSh7izo7fu6za049kFncVL2Oip7aso/9bpNa158zXDfD76FmQ44PyePxr3WjQtRKaBCgWXEQYGj+W3k5iPSGEK069+Ll3SeyQKmK0Tpsc8ELQYS9BVbU266cTA1PhTlgk7ajuZtVpUTjYy2EgqEEy+NrBqevt3TZyTKummTc0wFoeTrACKnszj1pjO8yA7XwS5dumm9jEVsJU5eUFTfQFbCiPGaJrcL/EHpNqQROz7kCR7BwJuHB9jmJzIL5jRyy1CDOysR53gOlCN9uvBLSWzsJCsmWhfgTuhWSrBA==

On Fri, 19 Sep 2025 16:09:50 +0200
Gabriele Monaco <gmonaco@redhat.com> wrote:

> The tracepoints sched_entry, sched_exit and sched_set_need_resched
> are not exported to tracefs as trace events, this allows only kernel
> code to access them. Helper modules like [1] can be used to still have
> the tracepoints available to ftrace for debugging purposes, but they do
> rely on the tracepoints being exported.
> 
> Export the 3 not exported tracepoints.
> Note that sched_set_state is already exported as the macro is called
> from modules.
> 
> [1] - https://github.com/qais-yousef/sched_tp.git
> 
> Signed-off-by: Gabriele Monaco <gmonaco@redhat.com>

Note, for all the scheduler changes, we need an acked-by from the scheduler
maintainers.

After you have acks and are satisfied with the code (hopefully someone else
can review them), you can send me a pull request to be added into linux-next.
I'll still run them through my own tests.

Which BTW, there should be a bunch of tests in:

  tools/testing/selftests/verification/

(which doesn't yet exist).

-- Steve


> ---
>  kernel/sched/core.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index ccba6fc3c3fe..334ff5b214d7 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -117,6 +117,9 @@ EXPORT_TRACEPOINT_SYMBOL_GPL(sched_util_est_cfs_tp);
>  EXPORT_TRACEPOINT_SYMBOL_GPL(sched_util_est_se_tp);
>  EXPORT_TRACEPOINT_SYMBOL_GPL(sched_update_nr_running_tp);
>  EXPORT_TRACEPOINT_SYMBOL_GPL(sched_compute_energy_tp);
> +EXPORT_TRACEPOINT_SYMBOL_GPL(sched_entry_tp);
> +EXPORT_TRACEPOINT_SYMBOL_GPL(sched_exit_tp);
> +EXPORT_TRACEPOINT_SYMBOL_GPL(sched_set_need_resched_tp);
>  
>  DEFINE_PER_CPU_SHARED_ALIGNED(struct rq, runqueues);
>  

