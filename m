Received: from out-171.mta1.migadu.com (out-171.mta1.migadu.com [95.215.58.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC0C92E7F38;
	Sun, 17 May 2026 09:52:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779011552; cv=none; b=kkGZi/4ZumghmF+ZBTKlim/+8at3tv/aJ7X3rBsBBP3hSMSeRSba2j+hqrf6rllE6GQTK4Ho3kH3wUeFjCwXGRdX9wwwgZIhwgc3NgvHL7sOTcK1WuKGoyJ2+YtOMxpz6vrkMEjliQVb5nwAfAY2uIGEQcFQJZ2kq9JRkOyKD7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779011552; c=relaxed/simple;
	bh=yfQGAosQv9cGyoXT4VZyRFVu4b6vq87T8KPp43v2OUI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fhrhgJC9nKHa+jbAtW50gNwrtqe3+VWFDFBS0F300ctTdAmP8CQlfIfpeNWqLTwjr4kwRs74cwWbxmmSI0IzMnla5nFgQC5++15O7q5CbuVdzsQKMgFdgPyoUloA2UUecTrlhVgNP9z8FnLraDr5eRyFDt0q1QXaElBQH+dYhxg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Mbqu1i6G; arc=none smtp.client-ip=95.215.58.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Mbqu1i6G"
Message-ID: <c4a3c4fc-7efb-4eb0-81d6-cc7a0d51f8fa@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1779011548;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=c/u6BjZbSkMKWNDVeJkoo/BjsuNmO0Puap8rGkPuwgc=;
	b=Mbqu1i6GAmnYY52g9UYo79pbzxk+Kob0tZ/QBKCNWJhc4RuHzGFHR/x4RHy0TFXg/g0yaW
	3GesR99fFUq8O2207bJe70TCiFoNH0HWTe9vKHUn9bYymp/92QdEDsAm/GDVZb7rLGH9iY
	AybKixGbwCetaelry4ECh53hs4+Ei+4=
Date: Sun, 17 May 2026 17:52:16 +0800
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH 9/9] rv: Mandate deallocation for per-obj monitors
To: Gabriele Monaco <gmonaco@redhat.com>, linux-kernel@vger.kernel.org,
 Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu
 <mhiramat@kernel.org>, linux-trace-kernel@vger.kernel.org
Cc: Nam Cao <namcao@linutronix.de>
References: <20260512140250.262190-1-gmonaco@redhat.com>
 <20260512140250.262190-10-gmonaco@redhat.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Wen Yang <wen.yang@linux.dev>
In-Reply-To: <20260512140250.262190-10-gmonaco@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT


One gap: tools/verification/rvgen/rvgen/templates/dot2k/main.c uses 
RV_MON_%%MONITOR_TYPE%% but generates no deallocation code, may fail
to build with a -Wunused-function warning.


--
Best wishes,
Wen

On 5/12/26 22:02, Gabriele Monaco wrote:
> The per-object monitors use a hash tables and dynamic allocation of the
> monitor storage, functions to clean a monitor that is no longer needed
> are provided but nothing ensures the monitor actually uses them.
> 
> Remove the inline specifier on the deallocation function to let the
> compiler warn in case it isn't referenced. If the monitor really doesn't
> need one (for instance because instances will never cease to exist
> before disabling the monitor), the da_skip_deallocation() helper macro
> can be used to silence the warning.
> 
> Signed-off-by: Gabriele Monaco <gmonaco@redhat.com>
> ---
>   include/rv/da_monitor.h                      | 14 +++++++++++++-
>   kernel/trace/rv/monitors/deadline/deadline.h |  5 ++++-
>   2 files changed, 17 insertions(+), 2 deletions(-)
> 
> diff --git a/include/rv/da_monitor.h b/include/rv/da_monitor.h
> index 402d3b935c08..378d23ab7dfb 100644
> --- a/include/rv/da_monitor.h
> +++ b/include/rv/da_monitor.h
> @@ -489,8 +489,11 @@ static inline monitor_target da_get_target_by_id(da_id_type id)
>    * locks.
>    * This function includes an RCU read-side critical section to synchronise
>    * against da_monitor_destroy().
> + * NOTE: inline is omitted on purpose to let the compiler warn if this function
> + * is never referenced. For monitors that don't require a deallocation hook,
> + * da_skip_deallocation() can be used.
>    */
> -static inline void da_destroy_storage(da_id_type id)
> +static void da_destroy_storage(da_id_type id)
>   {
>   	struct da_monitor_storage *mon_storage;
>   
> @@ -504,6 +507,15 @@ static inline void da_destroy_storage(da_id_type id)
>   	kfree_rcu(mon_storage, rcu);
>   }
>   
> +/*
> + * da_skip_deallocation - explicitly mark a deallocation function as not required
> + *
> + * Only use when you are absolutely sure the monitor doesn't require a
> + * deallocation hook (i.e. it's not possible for an object to finish existing
> + * when the monitor is still running).
> + */
> +#define da_skip_deallocation(hook) ((void)hook)
> +
>   static void da_monitor_reset_all(void)
>   {
>   	struct da_monitor_storage *mon_storage;
> diff --git a/kernel/trace/rv/monitors/deadline/deadline.h b/kernel/trace/rv/monitors/deadline/deadline.h
> index 78fca873d61e..c39fd79148c2 100644
> --- a/kernel/trace/rv/monitors/deadline/deadline.h
> +++ b/kernel/trace/rv/monitors/deadline/deadline.h
> @@ -194,7 +194,10 @@ static void __maybe_unused handle_newtask(void *data, struct task_struct *task,
>   		da_create_storage(EXPAND_ID_TASK(task), NULL);
>   }
>   
> -static void __maybe_unused handle_exit(void *data, struct task_struct *p, bool group_dead)
> +/*
> + * Deallocation hook, use da_skip_deallocation() when not necessary
> + */
> +static void handle_exit(void *data, struct task_struct *p, bool group_dead)
>   {
>   	if (p->policy == SCHED_DEADLINE)
>   		da_destroy_storage(get_entity_id(&p->dl, DL_TASK, DL_TASK));
