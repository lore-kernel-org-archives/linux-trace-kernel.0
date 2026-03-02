Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4555D40149D
	for <linux-trace-kernel@vger.kernel.org>; Mon,  2 Mar 2026 14:15:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772460960; cv=none; b=qamBBNGMFpUSmmBGOyP7I6mIWp4d8Mo0Q11MN911eQAQm9b9LQ9KfMSUcK1z4TpMeGJql++tWHNrLWBPl8Df80S2CDhrmNqR67zvBh+QbeWMJChxa3v7Fp4p3M6VJFeByd7YUdohDX+pDwZv65rCQK0YVqmKHyW13AsMj2U2OPo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772460960; c=relaxed/simple;
	bh=7ZLOBw+V/Ytjc97Wt5/Nmpbf+IdKeEYCzCRPqnZy4JU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=IZArtTw0m7Q6ZekUeant2k5OzGXIUEJA3By96fxkcnbZ50pVTWfKDF17coCJtedha2oBpW+uIwJcuPKCibgPuR1RbHWJt02HltUol7tOpfqrr4wTYS+SwsnF4upryr0OlNimrim/7BdX/+8A01STdkWWtr4V0ELL9024vPWYqy8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Fi/sbdOR; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Fi/sbdOR"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1772460958;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=H3dNL6Ecogn7179PIU+RK7iPFZtmAH+GeUTZmsoq0sw=;
	b=Fi/sbdOREZRK9ZV09g5dXwwDyKsXFi1kuzzc8tok3VsdbxBYO7IqsbdtM96vnk2ldYR47Q
	awDEhpFi81YgiUbt5Gc5mEordPBardyu4QQ8JW7WTMc+UoGUWrFsoO7U4ylPsg7bpvJJQO
	dmhkTG+c2Z4NKlYtCBti3EtWalrgdh4=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-342-pGkMohxZO6ir90rEOMsUUQ-1; Mon, 02 Mar 2026 09:15:57 -0500
X-MC-Unique: pGkMohxZO6ir90rEOMsUUQ-1
X-Mimecast-MFC-AGG-ID: pGkMohxZO6ir90rEOMsUUQ_1772460956
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-483a24db6ecso54691585e9.1
        for <linux-trace-kernel@vger.kernel.org>; Mon, 02 Mar 2026 06:15:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772460956; x=1773065756;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=H3dNL6Ecogn7179PIU+RK7iPFZtmAH+GeUTZmsoq0sw=;
        b=GMDDwqf3HweI3oD8KcRnkKrwgNuy86AGBLO+nr7W2ehefkvyNT9OhXJ1r4VFQjiHKl
         VaUF/CuW9/Y9dOVNlPwYLmFtjL9fmtTXFNkOaMLFtPqlxBpe/ybx8G8DnlJGNzPHOa9Y
         FeXEP+agbaAe5MoHBMKiV2ktlp5lTY0I1JAMGV/7AtkvnPPjXH8qoQNmhuwxaPVX3c8L
         QtmTIczyFaaQfRv+njA7QquSl3/siZD8GNBcFUOHLdYr0Cnb7410SaFew2wAt4sAkJQ9
         h0w4yNSVrlUWDEWemVt/oSsB/7F7/1j684J8XnoRRDMt1jFxxub6y+0LILcz/4BGnqWJ
         abYw==
X-Forwarded-Encrypted: i=1; AJvYcCXDVzChDLsl62b/sCczVMtVP8wwP55zXmyWS46UpcdHCjtpIq8GM3OQOb28WyJY2A+bbQa9aHSW52rbFHFTssDuwPc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyCtsOLrnLhh1Z5PIYvM/LNuWL2NjoYxcL5O+lIWwEnyZ5rlOfM
	RiCX4eS4+nxsA9AP9b31J7AH9fSb8xcf38C+vQFME7BYIExV3VL4em55AUFr7/38zbUZihSf9dB
	fQoWbUA94fZ7qJV5DxvHnCC0H0YKUKopuhsuRqJa3K8auFNvBI30qRpC4oZGlX0MgsqiJFX/ysw
	==
X-Gm-Gg: ATEYQzysYgd0T8EmxzeMsQOGy01YFxEwfTCpKaRBo7wyB4LxrM4CH95LeyT+6UyYUyt
	m4kiG17uTLaHq36RJQBx8HpCYcT7r8gTcPKION9i3112chYGaUStQ/X6iF9jwbW8hlBpF8FRQmL
	aKxfNCOZp5fqCBJZIOiej7hIbaS1SRrTwwfyPyixlIcxZzGvoR18+yCaZkX+4F9IM+S7YDm2rVe
	X+vgyCv+9pV56yqwY8E3jrra6Y3o/7inpoZROhoLd5SPFTB8QANu+xCc9U5i9+tT/1/Dq8SYpHV
	wVcDBLLPfw+I4QTIo/Y7f/k/Ni5usmxNB+eA75pM0DEtfaPF46Eaz4CeLjR9VF33uQXqCI7iWNy
	jZDIYJFL9ykgaSkRQ48yN6AaeJObda+LpQxD6ZNduUHV4PNedW84=
X-Received: by 2002:a05:600c:4f50:b0:477:6d96:b3e5 with SMTP id 5b1f17b1804b1-483c9bb8ef7mr229825975e9.7.1772460956014;
        Mon, 02 Mar 2026 06:15:56 -0800 (PST)
X-Received: by 2002:a05:600c:4f50:b0:477:6d96:b3e5 with SMTP id 5b1f17b1804b1-483c9bb8ef7mr229822075e9.7.1772460953490;
        Mon, 02 Mar 2026 06:15:53 -0800 (PST)
Received: from jlelli-thinkpadt14gen4.remote.csb ([151.29.73.19])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-483bfba9a5esm285799125e9.4.2026.03.02.06.15.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Mar 2026 06:15:52 -0800 (PST)
Date: Mon, 2 Mar 2026 15:15:50 +0100
From: Juri Lelli <juri.lelli@redhat.com>
To: Gabriele Monaco <gmonaco@redhat.com>
Cc: linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>,
	Nam Cao <namcao@linutronix.de>, Juri Lelli <jlelli@redhat.com>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	linux-trace-kernel@vger.kernel.org, Phil Auld <pauld@redhat.com>,
	Tomas Glozar <tglozar@redhat.com>,
	Clark Williams <williams@redhat.com>,
	John Kacur <jkacur@redhat.com>
Subject: Re: [PATCH v6 12/16] sched: Add deadline tracepoints
Message-ID: <aaWblsXCWP-L0WbB@jlelli-thinkpadt14gen4.remote.csb>
References: <20260225095122.80683-1-gmonaco@redhat.com>
 <20260225095122.80683-13-gmonaco@redhat.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20260225095122.80683-13-gmonaco@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: zANSVV5iH1NdnH5MrHGH77t_r_9PDOVmzOevyVM07jg_1772460956
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello,

On 25/02/26 10:51, Gabriele Monaco wrote:
> Add the following tracepoints:
> 
> * sched_dl_throttle(dl_se, cpu, type):
>     Called when a deadline entity is throttled
> * sched_dl_replenish(dl_se, cpu, type):
>     Called when a deadline entity's runtime is replenished
> * sched_dl_update(dl_se, cpu, type):
>     Called when a deadline entity updates without throttle or replenish
> * sched_dl_server_start(dl_se, cpu, type):
>     Called when a deadline server is started
> * sched_dl_server_stop(dl_se, cpu, type):
>     Called when a deadline server is stopped
> 
> Those tracepoints can be useful to validate the deadline scheduler with
> RV and are not exported to tracefs.
> 
> Reviewed-by: Phil Auld <pauld@redhat.com>
> Signed-off-by: Gabriele Monaco <gmonaco@redhat.com>
> ---
> 
> Notes:
>     V6:
>     * Add dl_se type to differentiate between fair and ext servers
>     * Add event to track dl_update_curr not firing other events
>     V3:
>     * Rename dl argument to dl_se in tracepoints
> 
>  include/trace/events/sched.h | 26 ++++++++++++++++++++++++++
>  kernel/sched/core.c          |  4 ++++
>  kernel/sched/deadline.c      | 25 ++++++++++++++++++++++++-
>  3 files changed, 54 insertions(+), 1 deletion(-)
> 
> diff --git a/include/trace/events/sched.h b/include/trace/events/sched.h
> index 5844147ec5fd..944d65750a64 100644
> --- a/include/trace/events/sched.h
> +++ b/include/trace/events/sched.h
> @@ -904,6 +904,32 @@ DECLARE_TRACE(sched_dequeue,
>  	TP_PROTO(struct task_struct *tsk, int cpu),
>  	TP_ARGS(tsk, cpu));
>  
> +#define DL_OTHER 0
> +#define DL_TASK 1
> +#define DL_SERVER_FAIR 2
> +#define DL_SERVER_EXT 3
> +
> +DECLARE_TRACE(sched_dl_throttle,
> +	TP_PROTO(struct sched_dl_entity *dl_se, int cpu, uint8_t type),
> +	TP_ARGS(dl_se, cpu, type));
> +
> +DECLARE_TRACE(sched_dl_replenish,
> +	TP_PROTO(struct sched_dl_entity *dl_se, int cpu, uint8_t type),
> +	TP_ARGS(dl_se, cpu, type));
> +
> +/* Call to update_curr_dl_se not involving throttle or replenish */
> +DECLARE_TRACE(sched_dl_update,
> +	TP_PROTO(struct sched_dl_entity *dl_se, int cpu, uint8_t type),
> +	TP_ARGS(dl_se, cpu, type));
> +
> +DECLARE_TRACE(sched_dl_server_start,
> +	TP_PROTO(struct sched_dl_entity *dl_se, int cpu, uint8_t type),
> +	TP_ARGS(dl_se, cpu, type));
> +
> +DECLARE_TRACE(sched_dl_server_stop,
> +	TP_PROTO(struct sched_dl_entity *dl_se, int cpu, uint8_t type),
> +	TP_ARGS(dl_se, cpu, type));
> +
>  #endif /* _TRACE_SCHED_H */
>  
>  /* This part must be outside protection */
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index 4ca79ff58fca..b5bb2eb112bf 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -124,6 +124,10 @@ EXPORT_TRACEPOINT_SYMBOL_GPL(sched_exit_tp);
>  EXPORT_TRACEPOINT_SYMBOL_GPL(sched_set_need_resched_tp);
>  EXPORT_TRACEPOINT_SYMBOL_GPL(sched_enqueue_tp);
>  EXPORT_TRACEPOINT_SYMBOL_GPL(sched_dequeue_tp);
> +EXPORT_TRACEPOINT_SYMBOL_GPL(sched_dl_throttle_tp);
> +EXPORT_TRACEPOINT_SYMBOL_GPL(sched_dl_replenish_tp);
> +EXPORT_TRACEPOINT_SYMBOL_GPL(sched_dl_server_start_tp);
> +EXPORT_TRACEPOINT_SYMBOL_GPL(sched_dl_server_stop_tp);

Don't we need to export sched_dl_update_tp as well?

>  DEFINE_PER_CPU_SHARED_ALIGNED(struct rq, runqueues);
>  DEFINE_PER_CPU(struct rnd_state, sched_rnd_state);

...

> @@ -1532,7 +1551,8 @@ static void update_curr_dl_se(struct rq *rq, struct sched_dl_entity *dl_se, s64
>  
>  		if (!is_leftmost(dl_se, &rq->dl))
>  			resched_curr(rq);
> -	}
> +	} else
> +		trace_sched_dl_update_tp(dl_se, cpu_of(rq), dl_get_type(dl_se, rq));

This wants braces even if it's a single statement.

>  
>  	/*
>  	 * The dl_server does not account for real-time workload because it

Thanks,
Juri

