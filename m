Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BB442BE02A
	for <linux-trace-kernel@vger.kernel.org>; Fri, 16 Jan 2026 14:00:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768572060; cv=none; b=sHvnX9l1ksQCI08wDL5FEetQvm0TqhhO7oO2+JueNb1nQtRXs9w910dGfHI1nitTUGySPaQ+q9hXsowc+QXJVhjIGd5HQQWM7wxh9lP8zWyn6lMN5d5A/+3JIY4PBS4BpmTWQMIjEPtCfNgOcwxbCnoKzLh8400u6ENt6Ik9kaY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768572060; c=relaxed/simple;
	bh=WGoIrscibU6eXxN11U2HcMzNQjl95T/V/aOys2BsJyA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gjSQOG5XAoi0/Xqq1DCRkc9FY+w05uVGulpiqnZdQOa/xjs7Jwsv47bfesOtIkiqgHe0yz6IHqm5HB/IR+fkxRcHTZe/Ht11gNrD5tY5L8EE1f/vMFYoHMgOdil4/WU9DUQl8be5r0nEkxWHPQNOi0nQdYqrvLACV8+viOmw1i4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=jKFZtw5M; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="jKFZtw5M"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1768572058;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=LWbtC1glOuH4yOpTJJ1NT24bIujIOUdPKF+lks/r4n4=;
	b=jKFZtw5M/L2C3a/iJRiMo/NNLQRXAEZwTPH4/7O0kRvzYVh4Wra3tMxJQuvm/hNef0QTAz
	WPDBRiiZjxDE6A5ekZtP5NNAFhp96Ai5xP7NgXVbW6GwUWQu128vxrkdSldFTlbK5XQEk+
	LIrkiqeHBb2+0PRvFoYPGpC4HmV/fdQ=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-670-hev7inl4OgiLg4D-DBjPTw-1; Fri,
 16 Jan 2026 09:00:55 -0500
X-MC-Unique: hev7inl4OgiLg4D-DBjPTw-1
X-Mimecast-MFC-AGG-ID: hev7inl4OgiLg4D-DBjPTw_1768572053
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 34A0519560A5;
	Fri, 16 Jan 2026 14:00:53 +0000 (UTC)
Received: from pauld.westford.csb (unknown [10.22.64.71])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 81644180049F;
	Fri, 16 Jan 2026 14:00:50 +0000 (UTC)
Date: Fri, 16 Jan 2026 09:00:47 -0500
From: Phil Auld <pauld@redhat.com>
To: Gabriele Monaco <gmonaco@redhat.com>
Cc: linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>,
	Nam Cao <namcao@linutronix.de>, Juri Lelli <jlelli@redhat.com>,
	Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Tomas Glozar <tglozar@redhat.com>,
	Clark Williams <williams@redhat.com>,
	John Kacur <jkacur@redhat.com>, linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH v4 08/15] sched: Export hidden tracepoints to modules
Message-ID: <20260116140047.GA1129681@pauld.westford.csb>
References: <20260116123911.130300-1-gmonaco@redhat.com>
 <20260116123911.130300-9-gmonaco@redhat.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260116123911.130300-9-gmonaco@redhat.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

Hi Gabriele,

On Fri, Jan 16, 2026 at 01:39:04PM +0100 Gabriele Monaco wrote:
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
> Fixes: adcc3bfa8806 ("sched: Adapt sched tracepoints for RV task model")
> Reviewed-by: Phil Auld <pauld@redhat.com>
> Signed-off-by: Gabriele Monaco <gmonaco@redhat.com>

You can probably skip this one now, yes?


Cheers,
Phil


> ---
>  kernel/sched/core.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index 60afadb6eede..6380afe3de63 100644
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

-- 

