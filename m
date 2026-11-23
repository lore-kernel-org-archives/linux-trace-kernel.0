Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795455159;
	b=qHQjHrBC/zLKQUKQZsXsiYVL7yPuHvRQci/Lu15D2EGMnHji1bM8e59ajkD1ARmPuP2o
	 mPU6GCwgFhua+U3wu3lEOktR2eA3aUduLwvyT/eERgVnbAzRjMMkuhunODY/l90pQb4EN
	 +Mnd6/x4tRLaSIABC2SfWStFvIPW7XQ7SKnecDX0blqdJjD7Z/gGl0/CKB/ozBpNwDxYl
	 BzBI5EU6NGV8qbv6PP9px3CCwXysPa0sYowbuITKeAFE5OP+j+Dn86BW3w8Ju2UJ2nCmA
	 EYATtufShBKhO/aDznZh7NolgBu8GBGPWZsTkY85/NAiSZYahPDJuGfzoljRi7Neb8Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795455159;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:In-Reply-To:X-Scanned-By:
	 X-Mimecast-MFC-PROC-ID:X-Mimecast-Originator:Content-Type:
	 Content-Disposition;
	bh=Dac1FERf1Emk9l+Dj72gPWmV4FN/j45L9H+ZPXsL8co=;
	b=sCfoKKDxDC85HE0PvlvTVx/OUkIWv/CpoqmU0wyA3fXdgZ5rYh8dvQYoUP2G+7EPkjMP
	 dGUzO8onyhpcVZ143nDhca2rs7Rzpve0HhiD/VrIW29qAFuxn+GWY9CeyXYlw1YoMggur
	 KNv2eD1wPHGi8KuHvU6rrxxuxNwv0DvBdtW/YQlDwX/Cjxrv5zvYY1N1tsxQUgoNQVrTH
	 37N3fQX76iVreLbPBazD4KxXxqtx+ZMwjhU7gKDx6j+qzN3dU6hvtXxPA3UPK/BH8c2uh
	 gmAvWTY4P2RlsE/aGOFQsmv6hZzRY46rOXWdITbUTmUoYR2yCnSNF4fAf6meCUIn6UQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=EVAqQwGx;
	arc=none smtp.remote-ip=170.10.129.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6D01606A327
	for <linux-trace-kernel@vger.kernel.org>; Mon, 23 Nov 2026 17:32:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C6D01606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=EVAqQwGx
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1795455158;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Dac1FERf1Emk9l+Dj72gPWmV4FN/j45L9H+ZPXsL8co=;
	b=EVAqQwGxzsoptEKO4zBanzwbr1g85pg9teT3n680Jc+c7Mq6aQVDy+liRUY+fKmrDLJRrt
	CtjJ3if8cQzWNwDEvCEHlF/KHE+GoLNFZBKbC+aOPHDSZqCPJnpN9TxAnpo8HAs3X2ezh5
	uhwlQUQQwIz7wRzEji1dgoh4hOxRwkM=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-691-TP4QAAtUMu2j5Hiba3cvAQ-1; Mon,
 23 Nov 2026 17:32:30 +0000
X-MC-Unique: TP4QAAtUMu2j5Hiba3cvAQ-1
X-Mimecast-MFC-AGG-ID: TP4QAAtUMu2j5Hiba3cvAQ_1795455147
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 735EC180289D;
	Mon, 23 Nov 2026 17:32:27 +0000 (UTC)
Received: from onestero-thinkpadp1gen7.tpbc.csb (headnet04.pony-001.prod.iad2.dc.redhat.com [10.2.32.116])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id 1BA621955F01;
	Mon, 23 Nov 2026 17:32:22 +0000 (UTC)
Received: by onestero-thinkpadp1gen7.tpbc.csb (nbSMTP-1.00) for uid 13628
	oleg@redhat.com; Mon, 23 Nov 2026 18:32:27 +0100 (CET)
Date: Mon, 23 Nov 2026 18:32:22 +0100
From: Oleg Nesterov <oleg@redhat.com>
To: Keenan Dong <keenanat2000@gmail.com>,
	Andrii Nakryiko <andrii@kernel.org>
Cc: peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
	namhyung@kernel.org, mhiramat@kernel.org, mark.rutland@arm.com,
	alexander.shishkin@linux.intel.com, jolsa@kernel.org,
	irogers@google.com, adrian.hunter@intel.com, james.clark@linaro.org,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH] uprobes: clear extra_consumers before pooling return
 instances
Message-ID: <awR4plQC_oIvoc2R@redhat.com>
References: <20260408100247.2065245-1-keenanat2000@gmail.com>
 <awRRgnRmeMDUvUWz@redhat.com>
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Post: <mailto:linux-trace-kernel@vger.kernel.org>
List-Help: <mailto:linux-trace-kernel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-trace-kernel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
In-Reply-To: <awRRgnRmeMDUvUWz@redhat.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
X-Mimecast-MFC-PROC-ID: K-C71KPWaj6R5MtJpnrqyanu1j22o1vGDYHgpMJJ8TA_1795455147
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On 11/23, Oleg Nesterov wrote:
>
> Andrii, can you take a look? I never understood this code in details,
> and today I forgot everything...
>
> On 04/08, Keenan Dong wrote:
> >
> > ri_pool_push() returns a return_instance to the per-task pool for
> > later reuse. The pool reset clears cons_cnt, but it leaves
> > extra_consumers behind.
>
> So at first glance this doesn't look right no matter what...
>
> > A reused return_instance can later grow a fresh extra_consumers
> > array and then reach the cleanup path with a stale pointer from its
> > previous lifetime, leading to a double free of the recycled object.
>
> Can you add more details to explain the possible double free?
> This is not immediately obvious, at least not to me.

May be this has something to do with dup_utask() -> dup_return_instance() ?

If cons_cnt = 0 but ri->extra_consumers != NULL, then
dup_return_instance() -> kmemdup() will copy old->extra_consumers, but
but kmemdup(old->extra_consumers) won't be called?

Damn this code is too complex for me ;) Anyway, I think the changelog
should say more.

Oleg.

> > --- a/kernel/events/uprobes.c
> > +++ b/kernel/events/uprobes.c
> > @@ -1945,6 +1945,8 @@ unsigned long uprobe_get_trap_addr(struct pt_regs *regs)
> >  
> >  static void ri_pool_push(struct uprobe_task *utask, struct return_instance *ri)
> >  {
> > +	kfree(ri->extra_consumers);
> > +	ri->extra_consumers = NULL;
> >  	ri->cons_cnt = 0;
> >  	ri->next = utask->ri_pool;
> >  	utask->ri_pool = ri;
> > -- 
> > 2.43.0
> > 

