Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA2C428CF49
	for <linux-trace-kernel@vger.kernel.org>; Fri,  5 Dec 2025 13:36:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764941770; cv=none; b=FlDBbbuKpMQzzsR7lQFlNptM+qtmx5I6NMdoS9bOOGDgDUETfBZ4TbdrjATp4xZQJ6QKdg4u3RYlb86xsP4r2tjso+bNIiPKUf2nrO1YpuEvdh6NR05ur/qkZB2cB9s+mZuQDO5cgZ7cJyoJ5BmE+T6Xkez53d+pbJn2AgCZiqw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764941770; c=relaxed/simple;
	bh=arLf4kU80H/e7vbLBHLXuwIDQSOyeTB0gHMDyDA5OtM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=j/3D2ha/Uk5i6zL0sRaV5mLEP4f7bRSZPDBv5SD8GOuIN11lqH601bElfkoP86btyNpgu78tKrCHi9jDOd2LcZGyO/tHibl1za9YF+jbtTdgZKKWjDMFrbtA0K5WGtSam2En+iJpG/RiDdn/MAGjP7oGhH75/bIEg6obhdtxFfA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=eWnNf0rQ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eWnNf0rQ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1764941764;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=FVY4K3c9ObHB4UD5+yFxCnpsWBLNszi9/BNynAQ32mE=;
	b=eWnNf0rQSXcL/677+y4dkj4+RmWRKgTu2wlkfpJ/2A6Uu4BkpzGH+UG9c0Wg6SHCZ0L6JB
	ThD2rZcXnN1iXsROQ7vvbAIjhPprH535WRQgeqSjFJ+8eAFUD9NKebjt6fhhMi6kBSaEv+
	IMQZZb4gRLxHz2EYF/eNd9KyVe4Lbcc=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-464-A9PWNW_tOGGGu7zHycNP8g-1; Fri,
 05 Dec 2025 08:36:01 -0500
X-MC-Unique: A9PWNW_tOGGGu7zHycNP8g-1
X-Mimecast-MFC-AGG-ID: A9PWNW_tOGGGu7zHycNP8g_1764941760
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 6DF22195608A;
	Fri,  5 Dec 2025 13:35:59 +0000 (UTC)
Received: from pauld.westford.csb (unknown [10.22.88.194])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 68F93180035A;
	Fri,  5 Dec 2025 13:35:55 +0000 (UTC)
Date: Fri, 5 Dec 2025 08:35:52 -0500
From: Phil Auld <pauld@redhat.com>
To: Gabriele Monaco <gmonaco@redhat.com>
Cc: linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>,
	Nam Cao <namcao@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Tomas Glozar <tglozar@redhat.com>, Juri Lelli <jlelli@redhat.com>,
	Clark Williams <williams@redhat.com>,
	John Kacur <jkacur@redhat.com>, linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH v3 08/13] sched: Export hidden tracepoints to modules
Message-ID: <20251205133552.GA400972@pauld.westford.csb>
References: <20251205131621.135513-1-gmonaco@redhat.com>
 <20251205131621.135513-9-gmonaco@redhat.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251205131621.135513-9-gmonaco@redhat.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

On Fri, Dec 05, 2025 at 02:16:16PM +0100 Gabriele Monaco wrote:
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

This makes sense.

Reviewed-by: Phil Auld <pauld@redhat.com>


Cheers,
Phil

> ---
>  kernel/sched/core.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index 41ba0be16911..5516778c19eb 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -119,6 +119,9 @@ EXPORT_TRACEPOINT_SYMBOL_GPL(sched_util_est_cfs_tp);
>  EXPORT_TRACEPOINT_SYMBOL_GPL(sched_util_est_se_tp);
>  EXPORT_TRACEPOINT_SYMBOL_GPL(sched_update_nr_running_tp);
>  EXPORT_TRACEPOINT_SYMBOL_GPL(sched_compute_energy_tp);
> +EXPORT_TRACEPOINT_SYMBOL_GPL(sched_entry_tp);
> +EXPORT_TRACEPOINT_SYMBOL_GPL(sched_exit_tp);
> +EXPORT_TRACEPOINT_SYMBOL_GPL(sched_set_need_resched_tp);
>  
>  DEFINE_PER_CPU_SHARED_ALIGNED(struct rq, runqueues);
>  DEFINE_PER_CPU(struct rnd_state, sched_rnd_state);
> -- 
> 2.52.0
> 
> 

-- 

