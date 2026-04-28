Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A2853BE175
	for <linux-trace-kernel@vger.kernel.org>; Tue, 28 Apr 2026 19:05:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777403115; cv=none; b=PQUDCT/Yl4RQTa2FUf0CPh8MBJsAlOjIv92a2AOJ18DLAwrteNgS6N8qCjCTAiRNlmS28h7/oBkvWW6BxvK1eV1WA7FoGJYzLd3oZnj9IIybPk5yU7hRM8nmq9ilZ0KblGhIASCQ62KrMpJIoWMDohOKmziFWOmtFKd4oFlaKQA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777403115; c=relaxed/simple;
	bh=oe9/LorvbldPXApaJ1uINu+WfI8iyH6lVXVgGhbGo6s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=kqE9iuU8T1H2dLT1Hjz1v3F5UNSV4fx64VzWERW3Ry7VBlVF9vPp1lm9pA+6PHT4MT48FH2ycdJ2NELnvMu1lB7y3doX+DMc5ClrYyBT+5Mo4VpQantXlPqZ1NQb4qXA5/iuxSQtpRF2VdeBWt7p5qHRKJ5SoHkKP+s/OWvp+vs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=eXubQsD+; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eXubQsD+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1777403111;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=BIAMbdy0cssQQTKdmugxg2QLO3l+Cm+Po+DS5JV3HG4=;
	b=eXubQsD+/1wfXDrSD6AzY0+h9AnkQR3os+w7zjP078M5nWxzcGzMVGnZ3SNWRqC0aTcbIy
	RprRl1UJEFhqREQ3lIPv8BNY69cP3q2FDQA51zxSIj9p0wc3lDM5OscCXllizXUELFbZiV
	2tuax0n/IHMK36eDXond7/MSHWmqFxs=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-495-1700_jWgNfKyfYwpLbXXDA-1; Tue,
 28 Apr 2026 15:05:07 -0400
X-MC-Unique: 1700_jWgNfKyfYwpLbXXDA-1
X-Mimecast-MFC-AGG-ID: 1700_jWgNfKyfYwpLbXXDA_1777403105
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id F3D0E19560BB;
	Tue, 28 Apr 2026 19:05:04 +0000 (UTC)
Received: from 192.168.0.21 (unknown [10.22.80.105])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id 0E759300756E;
	Tue, 28 Apr 2026 19:04:57 +0000 (UTC)
Date: Tue, 28 Apr 2026 16:04:56 -0300
From: Wander Lairson Costa <wander@redhat.com>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Juri Lelli <juri.lelli@redhat.com>, Vincent Guittot <vincent.guittot@linaro.org>, 
	Dietmar Eggemann <dietmar.eggemann@arm.com>, Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>, 
	Valentin Schneider <vschneid@redhat.com>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Andrew Morton <akpm@linux-foundation.org>, 
	open list <linux-kernel@vger.kernel.org>, "open list:TRACING" <linux-trace-kernel@vger.kernel.org>, 
	acme@kernel.org, williams@redhat.com, gmonaco@redhat.com
Subject: Re: [PATCH v3 4/4] trace/preemptirq: Implement trace_irqflags hooks
Message-ID: <afEEvUdt_o35nrzI@192.168.0.21>
References: <20260311125021.197638-1-wander@redhat.com>
 <20260311125021.197638-5-wander@redhat.com>
 <20260311194305.GT606826@noisy.programming.kicks-ass.net>
 <20260428145405.64d30ece@gandalf.local.home>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20260428145405.64d30ece@gandalf.local.home>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
X-Mimecast-MFC-PROC-ID: Q6fy54fqY7tVsjKDz_Z9LQHGO1VzfwvR7CXAZGN9X90_1777403105
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Apr 28, 2026 at 02:54:05PM -0400, Steven Rostedt wrote:
> On Wed, 11 Mar 2026 20:43:05 +0100
> Peter Zijlstra <peterz@infradead.org> wrote:
> 
> > On Wed, Mar 11, 2026 at 09:50:18AM -0300, Wander Lairson Costa wrote:
> > > +#define local_irq_enable()				\
> > > +	do {						\
> > > +		if (tracepoint_enabled(irq_enable))	\
> > > +			trace_local_irq_enable();	\  
> > 
> > I'm thinking you didn't even look at the assembly generated :/
> > 
> > Otherwise you would have written this like:
> > 
> > 		if (tracepoint_enabled(irq_enable))
> > 			__do_trace_local_irq_enable();
> > 
> > > +		raw_local_irq_enable();			\
> > > +	} while (0)  
> > 
> > Again, this was one instruction, and you clearly didn't bother looking
> > at the mess you've generated :/
> 
> We now have trace_call__#name(), thus the above can be:
> 
> 		if (tracepoint_enabled(irq_enable))
> 			trace_call__local_irq_enable();
> 
> See commit 677a3d82b6407 ("tracepoint: Add trace_call__##name() API")

Great, I will update the patches.

> 
> Just in case there's a v4.
> 
> -- Steve
> 

