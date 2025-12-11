Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5189072602
	for <linux-trace-kernel@vger.kernel.org>; Thu, 11 Dec 2025 22:37:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765492629; cv=none; b=QByw0Ji+sNk4/ZWXjseeJmEnlZ4QvqD4zO5MObEBJys8OLmPwFW9GMxzt0hgyE4KLrGGIdgFXzv4y4f2BAWQk7Co5l4IzQzg3b0cyYCutqBg+H0xKuXNCjKzoTwkDdYAzFLHC+zBdG0t3/Aik/9fQ93z33bhtwZz+7DLrgLFths=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765492629; c=relaxed/simple;
	bh=jmciuINnwAIhiC76b6NblDmvAMobl2rpVPRmCRpG41M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kqVFlXzpOnbD/QSZGJtsUtVkO6TN5XrX+epm5tESlhvZwjxSxPBDTjEAQ7Oy05E6xDPKY3ZVOeksdapOxjrdw6/B7dTAYHo/HsajCa4jsEWbhD8EtDazkgdq0qyQdkOZ6tt5ir4GtaN83V953OwhBS72boxq2JH9LdHy50wjAWI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gcoaRxMF; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gcoaRxMF"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1765492625;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=bxp6KL19Gq6qRMUwve9v7rC8d7HK+M8mM1/+QFg153c=;
	b=gcoaRxMFdxCLTmOk0z1x7wdiKrd96l69lqFyTwVGIBtp7gJxxcR3GRhFWkpyjC0gi8SSXP
	pQQs5bCTW8tRknrq0aE+cT+Jvm5qZrmW/5WJLhjnb/S+fhujixvGAXw2cPOA5hs76rIghG
	FW3wibO6/lOxSxmu4/d/zX/VlNEEnDY=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-45-hzBXEZ8dPQS8L24yg3RRsg-1; Thu,
 11 Dec 2025 17:37:00 -0500
X-MC-Unique: hzBXEZ8dPQS8L24yg3RRsg-1
X-Mimecast-MFC-AGG-ID: hzBXEZ8dPQS8L24yg3RRsg_1765492615
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 4DC241956061;
	Thu, 11 Dec 2025 22:36:55 +0000 (UTC)
Received: from pauld.westford.csb (unknown [10.64.240.7])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id DAF5A1956056;
	Thu, 11 Dec 2025 22:36:48 +0000 (UTC)
Date: Fri, 12 Dec 2025 07:36:43 +0900
From: Phil Auld <pauld@redhat.com>
To: Gabriele Monaco <gmonaco@redhat.com>
Cc: linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>,
	Nam Cao <namcao@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Tomas Glozar <tglozar@redhat.com>, Juri Lelli <jlelli@redhat.com>,
	Clark Williams <williams@redhat.com>,
	John Kacur <jkacur@redhat.com>, linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH v3 08/13] sched: Export hidden tracepoints to modules
Message-ID: <20251211223643.GA557546@pauld.westford.csb>
References: <20251205131621.135513-1-gmonaco@redhat.com>
 <20251205131621.135513-9-gmonaco@redhat.com>
 <20251205133552.GA400972@pauld.westford.csb>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251205133552.GA400972@pauld.westford.csb>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17


Hi Peter,

On Fri, Dec 05, 2025 at 08:35:52AM -0500 Phil Auld wrote:
> On Fri, Dec 05, 2025 at 02:16:16PM +0100 Gabriele Monaco wrote:
> > The tracepoints sched_entry, sched_exit and sched_set_need_resched
> > are not exported to tracefs as trace events, this allows only kernel
> > code to access them. Helper modules like [1] can be used to still have
> > the tracepoints available to ftrace for debugging purposes, but they do
> > rely on the tracepoints being exported.
> > 
> > Export the 3 not exported tracepoints.
> > Note that sched_set_state is already exported as the macro is called
> > from modules.
> > 
> > [1] - https://github.com/qais-yousef/sched_tp.git
> > 
> > Signed-off-by: Gabriele Monaco <gmonaco@redhat.com>
> 
> This makes sense.
> 
> Reviewed-by: Phil Auld <pauld@redhat.com>
> 

Any chance we can get this one in even if the rest of the series
needs more time?

Without this, out of tree modules fail to link.

I don't know if it's worth adding:

Fixes: adcc3bfa8806 ("sched: Adapt sched tracepoints for RV task model")


Cheers,
Phil

> 
> Cheers,
> Phil
> 
> > ---
> >  kernel/sched/core.c | 3 +++
> >  1 file changed, 3 insertions(+)
> > 
> > diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> > index 41ba0be16911..5516778c19eb 100644
> > --- a/kernel/sched/core.c
> > +++ b/kernel/sched/core.c
> > @@ -119,6 +119,9 @@ EXPORT_TRACEPOINT_SYMBOL_GPL(sched_util_est_cfs_tp);
> >  EXPORT_TRACEPOINT_SYMBOL_GPL(sched_util_est_se_tp);
> >  EXPORT_TRACEPOINT_SYMBOL_GPL(sched_update_nr_running_tp);
> >  EXPORT_TRACEPOINT_SYMBOL_GPL(sched_compute_energy_tp);
> > +EXPORT_TRACEPOINT_SYMBOL_GPL(sched_entry_tp);
> > +EXPORT_TRACEPOINT_SYMBOL_GPL(sched_exit_tp);
> > +EXPORT_TRACEPOINT_SYMBOL_GPL(sched_set_need_resched_tp);
> >  
> >  DEFINE_PER_CPU_SHARED_ALIGNED(struct rq, runqueues);
> >  DEFINE_PER_CPU(struct rnd_state, sched_rnd_state);
> > -- 
> > 2.52.0
> > 
> > 
> 
> -- 
> 

-- 

