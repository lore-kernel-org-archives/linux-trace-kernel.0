Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB89831355C
	for <linux-trace-kernel@vger.kernel.org>; Thu, 12 Mar 2026 17:09:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773335383; cv=none; b=KDmhCr3d/m25rowaaKnBPmOrcKuiuRfoawIRMenAd8IlOed1WDO2aUvIkskLCMiZvQ1/RGyfkbfSE3JzHvdUKdFmUfZ5Pb3MXerdqF3iag2ylf73LeRXTpj0KKF6mNjlOrOy7rHJKXrSyf7kD5JdOQQHm37uztIs95QXym8Zy9Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773335383; c=relaxed/simple;
	bh=SQJXH2Lng0/Te4K+K3c2xTEx/SZtWpZNQfxEhqPHMOM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=Xp/qI1xSQlxx8Ct+BFobOR6CXBzUSASA8ir3jdXrFQbNwG4r+mcbosQWzd8d6kAdR50sfNrPYo2mmV38+qy6QU1DpiH9OqmrRP31EvjDJ9g2WA52/R5P4cA36dzRUC2AztwW+p+fLIXQfgJ3sh9Hh+fSQb5sSsGEejhI+w7Lz5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=jGTJtk8S; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="jGTJtk8S"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1773335379;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=s1z7pcT1uz8zxPdYOzPxObIUEn0V+CgU9oMxRhagwLk=;
	b=jGTJtk8SzzCUFaxobIU5OUcqBU/Pdxg4GA0tc33JgbOxg/br1lqMzUDDqN2UqDWAivztOD
	48XHSmxQOfYjIpD1n4+4vKsueyS7937AE6zDHI9oO+ORTrHS03cUKtzlXRCc5PMYWjSB8s
	tiIwb+Q9t8688omJFNBdmzH49cdmFfg=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-551-TBGkomtuMnyhmI_VZ7ey1Q-1; Thu,
 12 Mar 2026 13:09:30 -0400
X-MC-Unique: TBGkomtuMnyhmI_VZ7ey1Q-1
X-Mimecast-MFC-AGG-ID: TBGkomtuMnyhmI_VZ7ey1Q_1773335362
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 699211956096;
	Thu, 12 Mar 2026 17:09:21 +0000 (UTC)
Received: from fedora (unknown [10.22.64.99])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id 6FBE919540C2;
	Thu, 12 Mar 2026 17:09:15 +0000 (UTC)
Date: Thu, 12 Mar 2026 14:09:14 -0300
From: Wander Lairson Costa <wander@redhat.com>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@redhat.com>, Juri Lelli <juri.lelli@redhat.com>, 
	Vincent Guittot <vincent.guittot@linaro.org>, Dietmar Eggemann <dietmar.eggemann@arm.com>, 
	Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>, 
	Valentin Schneider <vschneid@redhat.com>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Andrew Morton <akpm@linux-foundation.org>, 
	open list <linux-kernel@vger.kernel.org>, "open list:TRACING" <linux-trace-kernel@vger.kernel.org>, 
	acme@kernel.org, williams@redhat.com, gmonaco@redhat.com
Subject: Re: [PATCH v3 4/4] trace/preemptirq: Implement trace_irqflags hooks
Message-ID: <abLxvmiwP_pEf8pQ@fedora>
References: <20260311125021.197638-1-wander@redhat.com>
 <20260311125021.197638-5-wander@redhat.com>
 <20260311194305.GT606826@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20260311194305.GT606826@noisy.programming.kicks-ass.net>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
X-Mimecast-MFC-PROC-ID: x6jK5gqTFsk02QB5yuMTKjtkOiTdTCJ3GcyjVasJlK4_1773335362
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Mar 11, 2026 at 08:43:05PM +0100, Peter Zijlstra wrote:
> On Wed, Mar 11, 2026 at 09:50:18AM -0300, Wander Lairson Costa wrote:
> > +#define local_irq_enable()				\
> > +	do {						\
> > +		if (tracepoint_enabled(irq_enable))	\
> > +			trace_local_irq_enable();	\
> 
> I'm thinking you didn't even look at the assembly generated :/

Yes, I did. But I was more concerned with the hot path, making sure it
only adds the NOP instruction generated by the static_key machinery.

> 
> Otherwise you would have written this like:
> 
> 		if (tracepoint_enabled(irq_enable))
> 			__do_trace_local_irq_enable();
> 
> > +		raw_local_irq_enable();			\
> > +	} while (0)
> 

Steve already opposed to using internal functions. When trace invoke
public API is available, we can always come back and replace the call.

> Again, this was one instruction, and you clearly didn't bother looking
> at the mess you've generated :/
> 

I might have missed something (as was the case for preempt_enable), but
I spent quite some time looking at the assembly code. I did my best, but
there lots of people far more skilled than me. And patch submission is
the way to connect to these people.

