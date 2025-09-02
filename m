Received: from out-171.mta0.migadu.com (out-171.mta0.migadu.com [91.218.175.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD3A92EF678
	for <linux-trace-kernel@vger.kernel.org>; Tue,  2 Sep 2025 09:50:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756806643; cv=none; b=uhQGWFJaqpPMmDtEm3y+110Lz4TZcPFuCxSnetKG+Eu4wfCcvrs2UR5QIvrH0vk9S6OxQAMaoP+JbgXVXanxaNKP6scvUc9agkerAjuYI4IUmWhqfDGkvRVz+V0Zm8NN0U/aeEb7Bb3fJfAKIlDZYfqJaHunxi9P8tz5NwXWiyg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756806643; c=relaxed/simple;
	bh=163G7NBdzqRIPtQG4d3ilwcmwlPRh8/kiwuM9ySu38A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PN6CPnjoWbrOaVbyasiPMWesxfuTmJoRmtBH3PD7lUCXxJfpt68WlJleLhvcGqas9v2Bys56mvDRT1l/YhmZFC2LIBt7XjJVYAvtPSxB7OG2p0CUmGkZ4fF8yornXPWjEXRoz7Ye8qbxxv7oVd61qWndHnEDEnlcT2Vl0Vw1/Tg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=NthiP3ZI; arc=none smtp.client-ip=91.218.175.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="NthiP3ZI"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1756806638;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8SdPs7YnNzYXwBnxMTAdg8ahsnKcBqqdQyzBDOBssAU=;
	b=NthiP3ZIVAXlk9mD7ngIFOyN2w4/wQyfgmMBCW5ewtH4ouXHfxEEgnYyjQBO+cJ2ox8FH4
	QHftcUgY7cE71r0IrgFzhDePBVz0vizJH4nZAv/PgTDcqPzIqBBiMHL7ZysltTvki9MRhZ
	rRzmQCBZvAXvWJ8IlMSKDrb9HbTOy20=
From: menglong.dong@linux.dev
To: Herbert Xu <herbert@gondor.apana.org.au>
Cc: mhiramat@kernel.org, rostedt@goodmis.org, mathieu.desnoyers@efficios.com,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 oliver.sang@intel.com
Subject: Re: [PATCH] tracing: fprobe: fix suspicious rcu usage in fprobe_entry
Date: Tue, 02 Sep 2025 17:50:32 +0800
Message-ID: <3005966.e9J7NaK4W3@7940hx>
In-Reply-To: <aLa2D4It1Zxc7bs0@gondor.apana.org.au>
References: <aLa2D4It1Zxc7bs0@gondor.apana.org.au>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"
X-Migadu-Flow: FLOW_OUT

On 2025/9/2 17:17 Herbert Xu <herbert@gondor.apana.org.au> write:
> Menglong Dong <dongml2@chinatelecom.cn> wrote:
> >
> > diff --git a/kernel/trace/fprobe.c b/kernel/trace/fprobe.c
> > index fb127fa95f21..fece0f849c1c 100644
> > --- a/kernel/trace/fprobe.c
> > +++ b/kernel/trace/fprobe.c
> > @@ -269,7 +269,9 @@ static int fprobe_entry(struct ftrace_graph_ent *trace, struct fgraph_ops *gops,
> >        if (WARN_ON_ONCE(!fregs))
> >                return 0;
> > 
> > +       rcu_read_lock();
> >        head = rhltable_lookup(&fprobe_ip_table, &func, fprobe_rht_params);
> > +       rcu_read_unlock();
> >        reserved_words = 0;
> >        rhl_for_each_entry_rcu(node, pos, head, hlist) {
> >                if (node->addr != func)
> 
> Actually this isn't quite right.  I know that it is a false-positive
> so that it's actually safe, but if you're going to mark it with
> rcu_read_lock, it should cover both the lookup as well as the
> dereference which happens in the loop rhl_for_each_entry_rcu.

Yeah, I understand. The rcu_read_lock() here is totally used to
suppress the suspicious rcu usage warning, not for the protection.
So I used it just for the rhltable_lookup() to reduce the impact.
Maybe I should add some comment for it.

This is the easiest way to suppress the warning, but not the  best,
as it can introduce addition overhead when PREEMPT is enabled.

As Masami said, maybe we can use guard(rcu)() here to obtain
better code readability.

It seems that it's hard to think of a way to suppress the warning
without holding the rcu_read_lock :/

Thanks!
Menglong Dong

> 
> Thanks,
> -- 
> Email: Herbert Xu <herbert@gondor.apana.org.au>
> Home Page: http://gondor.apana.org.au/~herbert/
> PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
> 
> 




