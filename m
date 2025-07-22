Received: from relay.hostedemail.com (smtprelay0012.hostedemail.com [216.40.44.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A979228153A;
	Tue, 22 Jul 2025 23:00:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753225225; cv=none; b=gbnxl62YrERIXYKL3zVl3YN5wYsGdH6faqZuhROxpJwfES997cSzNjnAKbWZKcJ/rWiPI8nDjRbKCADpmZFdWERuEkG3BSlpLYIQOyfAPqCaiz8nAnq2Uq2+SOIfTbz+0BeB17uT7OMlaDSmUuWGfJQJEunVxaX1Zkn9YIe/BQk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753225225; c=relaxed/simple;
	bh=CRFhfV141swPD8l+LLZFt1GQAYLI8Qvph8qAL0gbGBM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=e+2n400P6oKsMSOB6kQgvxl++9HISHHkfypevAJOsnkUSl8ZKnYj2E665f/bxQkpWTaQX5XDXc53FAj9mNLTNe/lZxteoU1zo4GEh73Ruaq57h+RRqp0Z3wVH9Zs3IPbRCAr6nriYGAQd/ZMI6FZRZyT12TEw45wsmH+qzIfxis=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf08.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay05.hostedemail.com (Postfix) with ESMTP id AA82C58AC7;
	Tue, 22 Jul 2025 23:00:19 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf08.hostedemail.com (Postfix) with ESMTPA id 64B6520025;
	Tue, 22 Jul 2025 23:00:17 +0000 (UTC)
Date: Tue, 22 Jul 2025 19:00:16 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: LKML <linux-kernel@vger.kernel.org>, Linux trace kernel
 <linux-trace-kernel@vger.kernel.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Ingo Molnar <mingo@kernel.org>, Peter
 Zijlstra <peterz@infradead.org>, Vincent Guittot
 <vincent.guittot@linaro.org>, Dietmar Eggemann <dietmar.eggemann@arm.com>,
 Mel Gorman <mgorman@suse.de>, Valentin Schneider <vschneid@redhat.com>
Subject: Re: [PATCH] tracing: sched: Hide numa balancing trace events
Message-ID: <20250722190016.7c462d56@gandalf.local.home>
In-Reply-To: <20250722104820.6c629734@batman.local.home>
References: <20250722104820.6c629734@batman.local.home>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: zt6hqkzrthfmtqkjg7fydzzmpgc5n9ta
X-Rspamd-Server: rspamout01
X-Rspamd-Queue-Id: 64B6520025
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX19WiFuqgyxBH6LA4hu1ZcV8o+KAAXzu0MU=
X-HE-Tag: 1753225217-5500
X-HE-Meta: U2FsdGVkX18s6pmuHFRVWSSP+I+IAIBmqBIFxzZ7ayy/uOXZi+SvTZnWwmi9kKP9ikqVWO9wX/VXbKS6DNpuwu5iTxjbeM4waKKbbH+3zyhYNHNN72ADzfe/WVKXJ+D7aaiLxjDKg9OJRvsi6Qcz6Sd86F6BHvjOD3HPXwXxwdu6EVniFzvH+4HtpPTUjSsLE6jg17Ef4Jhm3sJ8Ee+mwqxOJLHqmPpo2gfy1dKBx3tuLCPg/i91tem0n59uOda34crVgosOhQ9+O+7RxVuhI9PjE8Gw+sigoCIafx70N29hOWi7kTlAYxE9g/oI1SRqXL4aMRDrnXvx/lJnkTVMlBpLQPQUezWZFZu+9BErahGoEFGp8hkwGZM2sjHG5QlaKWBZEGtyUtE2GZZ3zZ99nA==

On Tue, 22 Jul 2025 10:48:20 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> From: Steven Rostedt <rostedt@goodmis.org>
> 
> The trace events sched_move_numa, sched_swap_numa and sched_stick_numa are
> only used when CONFIG_NUMA_BALANCING is enabled. Put an #ifdef guard
> around the definitions of these trace events so they are not defined when
> numa balancing is not enabled, otherwise they waste a bit of memory being
> unused.
> 

I just noticed that I already sent out a version of this patch here:

  https://lore.kernel.org/linux-trace-kernel/20250612100552.39672cf9@batman.local.home/

Which is a better version than this one.

> Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
> ---
>  include/trace/events/sched.h | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/include/trace/events/sched.h b/include/trace/events/sched.h
> index 4e6b2910cec3..51776b45549a 100644
> --- a/include/trace/events/sched.h
> +++ b/include/trace/events/sched.h
> @@ -628,6 +628,7 @@ TRACE_EVENT(sched_process_hang,
>  );
>  #endif /* CONFIG_DETECT_HUNG_TASK */
>  
> +#ifdef CONFIG_NUMA_BALANCING
>  /*
>   * Tracks migration of tasks from one runqueue to another. Can be used to
>   * detect if automatic NUMA balancing is bouncing between nodes.
> @@ -719,6 +720,7 @@ DEFINE_EVENT(sched_numa_pair_template, sched_swap_numa,
>  
>  	TP_ARGS(src_tsk, src_cpu, dst_tsk, dst_cpu)
>  );
> +#endif /* CONFIG_NUMA_BALANCING */
>  
>  #ifdef CONFIG_NUMA_BALANCING

Because You can just remove the above two CPP directives.

So please ignore this one.

-- Steve


>  #define NUMAB_SKIP_REASON					\

