Received: from relay.hostedemail.com (smtprelay0015.hostedemail.com [216.40.44.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E5E338757F;
	Thu, 30 Apr 2026 20:01:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777579301; cv=none; b=qrXsRvM3JK+70mPE7MgkAQzA18WjwT2cYb4prg+VQFDrEt2JhHRqjMsGk3I145bwDtQIGS4C02KBA879+QCnw14ghBbaCKs8YrbaMbbh69kMCbUt4I6tJM2uYGNPXx9xZKX2ASermGu/Gkt0HMw9wS30SaCmHoRrTg444o6PjXQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777579301; c=relaxed/simple;
	bh=7oGY8yQZmZVqH7VogZXoTauvK3oFgVKItJcXm+ZnCu4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=J2WexwCSz0j8RI1DawuFGb2b07tI5ocIiXiTBPv86ggrfR9DoeV/CmsPkucMmRwtqXm3jJRKIsiVRZ+2QoCqz+f2SRoIk1yRR6iMvFEkgDfQaPTj5evqg4oTmJO0ymbUOe4yDouteVyjktxcKc6wMaXSgly+Gq1tAu+4vmRRA0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf09.hostedemail.com (lb01a-stub [10.200.18.249])
	by unirelay08.hostedemail.com (Postfix) with ESMTP id 7799C140170;
	Thu, 30 Apr 2026 20:01:38 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf09.hostedemail.com (Postfix) with ESMTPA id 5D4412002A;
	Thu, 30 Apr 2026 20:01:36 +0000 (UTC)
Date: Thu, 30 Apr 2026 16:01:34 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: David Carlier <devnexen@gmail.com>
Cc: linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org,
 mhiramat@kernel.org, mathieu.desnoyers@efficios.com, peterz@infradead.org,
 vineeth@bitbyteword.org
Subject: Re: [PATCH v2] tracepoint: add lockdep rcu_is_watching() check to
 trace_##name##_enabled()
Message-ID: <20260430160134.2964130a@gandalf.local.home>
In-Reply-To: <20260430144159.10985-1-devnexen@gmail.com>
References: <20260430053511.8767-1-devnexen@gmail.com>
	<20260430144159.10985-1-devnexen@gmail.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: 44bijysaxrc4cb9k5jmnencubwenb8os
X-Rspamd-Server: rspamout08
X-Rspamd-Queue-Id: 5D4412002A
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX19FvYrAG7ZUJ3Jezkz5hCVnYWn1NtdQ9Eo=
X-HE-Tag: 1777579296-131249
X-HE-Meta: U2FsdGVkX1+XpKaBKLOUnFXyauiP5W6EnrVvwsWumqcihxTqLyeDWVN8ktNtiSoDF/268JovkZXsUvS/Tp6HjjruPSj7zEp68+BuQ9oe4JCJvPmS9vqms19LwAKz2AqXL8qjIWkzW9SbTObI+lSCvG827cDbWNKveBsbQCu3Q981kffLt3+JIPhjNtdvJGa7lsFG9FtC9RxTGy6defPY17AVtaM3HDebfD+pnIUnn5JKDMnqEi7fEgRJDGX+0OtIRkAE1XC0Xpf+GLYgw0pRSBaNAj1a/4EyzAScW+eE5ococ0cu09ahjOiG8C+ibwvB3ae8jVAUGPgiSqy/d3VgBs60kSLSupnG2TsjuSLyNoCIxxPAX1GkA8g+jsfAM/dahQrqnHfK+RJPbUU+L8JtTABERzPfb3aUDPgAgo4XsKtieP8IPjCWwKAslWcYGwiHeMul85lAmO1uWeTx93f+kqezrAeMqstJ6GM9YTB1pRey7uYamC9cM8R4/Vz0AbpWGRI7XjFa1FEc8AJHBOJTaMfEFTejeDa71seLcPDNnJ8=

On Thu, 30 Apr 2026 15:41:59 +0100
David Carlier <devnexen@gmail.com> wrote:

> trace_call__##name() was added by commit 677a3d82b640 ("tracepoint: Add
> trace_call__##name() API") for callers that already gate on
> trace_##name##_enabled(), letting them skip the redundant
> static_branch_unlikely() re-evaluation. The LOCKDEP rcu_is_watching()
> WARN_ONCE() that trace_##name() carries on the disabled path was not
> mirrored, so the cold-path coverage added by commit c2679254b9c9
> ("tracing: Make tracepoint lockdep check actually test something") is
> lost for trace_call__##name() callers when the tracepoint is disabled.
> 
> When the tracepoint is enabled, the rcu_dereference inside
> __DO_TRACE_CALL() already trips under PROVE_RCU, so the warning is
> only needed on the !enabled path. The natural place is the gate that
> trace_call__##name() callers consult: trace_##name##_enabled().
> 
> Fixes: 677a3d82b640 ("tracepoint: Add trace_call__##name() API")

Thanks, but I'm 86'ing the Fixes tag. The above commit has absolutely
nothing to do with this patch. This issue was there from the beginning of
having the trace_*_enabled() macro. This isn't a fix.

I'll modify the change log to be more accurate as well.

-- Steve


> Cc: Vineeth Pillai (Google) <vineeth@bitbyteword.org>
> Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> Cc: Masami Hiramatsu <mhiramat@kernel.org>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Signed-off-by: David Carlier <devnexen@gmail.com>
> ---
>  include/linux/tracepoint.h | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/include/linux/tracepoint.h b/include/linux/tracepoint.h
> index 578e520b6ee6..3b3ab19c2627 100644
> --- a/include/linux/tracepoint.h
> +++ b/include/linux/tracepoint.h
> @@ -293,6 +293,10 @@ static inline struct tracepoint *tracepoint_ptr_deref(tracepoint_ptr_t *p)
>  	static inline bool						\
>  	trace_##name##_enabled(void)					\
>  	{								\
> +		if (IS_ENABLED(CONFIG_LOCKDEP)) {			\
> +			WARN_ONCE(!rcu_is_watching(),			\
> +				  "RCU not watching for tracepoint");	\
> +		}							\
>  		return static_branch_unlikely(&__tracepoint_##name.key);\
>  	}
>  

