Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E21DA218E91
	for <linux-trace-kernel@vger.kernel.org>; Tue,  6 Jan 2026 20:21:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767730898; cv=none; b=SQI/ghlr4CBuSErBISpCW7eUoiLa/Gv0XL1qDMwSL5os4Qk3XyxF+AZWyoP1qF8+ZdF/99PrWeEF15iDyXbWo3/y3P2d6b06EaR1iKg+yTsaGnb0Vhy2OLOiRSBQx8K2oUkHa3TtnwfIShVHb0TvCnEl2PyTVNfcNlQVH8ZafO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767730898; c=relaxed/simple;
	bh=8JScIQPr4+VCXK2OisNel78o25mqB81NGhnI6lAi3gw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I2CkRrRFu+v/UAo4pN1VYqXUPc04N2sVBGzDKyJ5Q8uLl+riwNW7y0yOBGeEOkbPk+SSHWQzeCXJ/7woAnKeZQgUsdtUBNDJTnjR6XkDsOmfG103VWqLqszQ5GemPt3SfPGXlFQEbawlD6rWg9nPwVF6HBs116hMhGqzdmOIaWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QGEJsUph; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QGEJsUph"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1767730895;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=csijp+RWt7sKbkNSiyb6B92HOwDRjpWdJYGhRcdiOKw=;
	b=QGEJsUphHmB0lfwJPicXfrM9KXxAMkQ4IrI3vl1v/3qeCOP3YCQfEzzIBKEdjmaN0Dwusl
	4Um8FZfu4lAAxQ1W2IGla+4SgqvqfbPWGWSMN2h+m3qo9HQriVhOXtOoYGJf4BR1oHIZrM
	JQbNAeJOj2TM8N4dMj4Mo4ZbMtAZEZQ=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-39-LKzVER5KOC2lJg6L9F3i1g-1; Tue,
 06 Jan 2026 15:21:32 -0500
X-MC-Unique: LKzVER5KOC2lJg6L9F3i1g-1
X-Mimecast-MFC-AGG-ID: LKzVER5KOC2lJg6L9F3i1g_1767730891
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 0450A19560B2;
	Tue,  6 Jan 2026 20:21:31 +0000 (UTC)
Received: from pauld.westford.csb (unknown [10.22.64.202])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id B465430001B9;
	Tue,  6 Jan 2026 20:21:27 +0000 (UTC)
Date: Tue, 6 Jan 2026 15:21:24 -0500
From: Phil Auld <pauld@redhat.com>
To: Gabriele Monaco <gmonaco@redhat.com>
Cc: linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>,
	Nam Cao <namcao@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Tomas Glozar <tglozar@redhat.com>, Juri Lelli <jlelli@redhat.com>,
	Clark Williams <williams@redhat.com>,
	John Kacur <jkacur@redhat.com>, linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH v3 08/13] sched: Export hidden tracepoints to modules
Message-ID: <20260106202124.GA401789@pauld.westford.csb>
References: <20251205131621.135513-1-gmonaco@redhat.com>
 <20251205131621.135513-9-gmonaco@redhat.com>
 <20251205133552.GA400972@pauld.westford.csb>
 <20251211223643.GA557546@pauld.westford.csb>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251211223643.GA557546@pauld.westford.csb>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4


Ping...

On Fri, Dec 12, 2025 at 07:36:43AM +0900 Phil Auld wrote:
> 
> Hi Peter,
> 
> On Fri, Dec 05, 2025 at 08:35:52AM -0500 Phil Auld wrote:
> > On Fri, Dec 05, 2025 at 02:16:16PM +0100 Gabriele Monaco wrote:
> > > The tracepoints sched_entry, sched_exit and sched_set_need_resched
> > > are not exported to tracefs as trace events, this allows only kernel
> > > code to access them. Helper modules like [1] can be used to still have
> > > the tracepoints available to ftrace for debugging purposes, but they do
> > > rely on the tracepoints being exported.
> > > 
> > > Export the 3 not exported tracepoints.
> > > Note that sched_set_state is already exported as the macro is called
> > > from modules.
> > > 
> > > [1] - https://github.com/qais-yousef/sched_tp.git
> > > 
> > > Signed-off-by: Gabriele Monaco <gmonaco@redhat.com>
> > 
> > This makes sense.
> > 
> > Reviewed-by: Phil Auld <pauld@redhat.com>
> > 
> 
> Any chance we can get this one in even if the rest of the series
> needs more time?
> 
> Without this, out of tree modules fail to link.

Any thoughts on this? Please?

Anything including linux/sched.h fails to link due to
these:
__trace_set_need_resched 
__tracepoint_sched_set_need_resched_tp



Thanks,
Phil

> 
> I don't know if it's worth adding:
> 
> Fixes: adcc3bfa8806 ("sched: Adapt sched tracepoints for RV task model")
> 
> 
> Cheers,
> Phil
> 
> > 
> > Cheers,
> > Phil
> > 
> > > ---
> > >  kernel/sched/core.c | 3 +++
> > >  1 file changed, 3 insertions(+)
> > > 
> > > diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> > > index 41ba0be16911..5516778c19eb 100644
> > > --- a/kernel/sched/core.c
> > > +++ b/kernel/sched/core.c
> > > @@ -119,6 +119,9 @@ EXPORT_TRACEPOINT_SYMBOL_GPL(sched_util_est_cfs_tp);
> > >  EXPORT_TRACEPOINT_SYMBOL_GPL(sched_util_est_se_tp);
> > >  EXPORT_TRACEPOINT_SYMBOL_GPL(sched_update_nr_running_tp);
> > >  EXPORT_TRACEPOINT_SYMBOL_GPL(sched_compute_energy_tp);
> > > +EXPORT_TRACEPOINT_SYMBOL_GPL(sched_entry_tp);
> > > +EXPORT_TRACEPOINT_SYMBOL_GPL(sched_exit_tp);
> > > +EXPORT_TRACEPOINT_SYMBOL_GPL(sched_set_need_resched_tp);
> > >  
> > >  DEFINE_PER_CPU_SHARED_ALIGNED(struct rq, runqueues);
> > >  DEFINE_PER_CPU(struct rnd_state, sched_rnd_state);
> > > -- 
> > > 2.52.0
> > > 
> > > 
> > 
> > -- 
> > 
> 
> -- 
> 
> 

-- 

