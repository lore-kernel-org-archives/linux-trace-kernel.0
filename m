Received: from abb.hmeau.com (abb.hmeau.com [180.181.231.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62AC321771B;
	Wed,  3 Sep 2025 04:22:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=180.181.231.80
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756873356; cv=none; b=MZojYYlNhi/DZZu7FqKQxagt59xf+v32i5Ws3r+SFJxqWDrz6vENrpMf4u/TQPF+x0l1RM59NTDwxqnDI2cKhp12R5RYl91kl8uQ9dfBwBu5j3M2rSUqzH9S46NZ/2UrMUlpqbo9RVesZDBleEGYDYIZDAEx2MWjoiN4wXH7uP4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756873356; c=relaxed/simple;
	bh=bUnPlAUDuytZwZB+RmwFWMXIzaTlHleVXCLGzp3kX/8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=h0PXLPTzYJjLrWCevNEFF8Z6xoi13ZcCHBp30t39m1k02xilMjYSmaEbZ/wIDUJX8i7tol/7WMvgYI56H+MJCT9Jy4J/ye4bDhf+RWQmMog6uPbH70BmFYdQgeYg07KKaqI8m/OWDC2XA9iqW7Poj64KekJogc8qqjmFd6T7OZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au; spf=pass smtp.mailfrom=gondor.apana.org.au; dkim=pass (2048-bit key) header.d=hmeau.com header.i=@hmeau.com header.b=efxb6A7f; arc=none smtp.client-ip=180.181.231.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hmeau.com header.i=@hmeau.com header.b="efxb6A7f"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hmeau.com;
	s=formenos; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=h1T/VJ13Yj29sa7Y17m34iJ5coI2Zh+zi5CLeplvDJE=; b=efxb6A7fx4GA/9nFkNRy5pnlnA
	mlJpN3mbPABV+BJtU56OQMd033uklI73XoNcDWPNVjTn3bxHIvG+c74SPDZ+h9tg5JCPJ1LlWuFJl
	J7dmXVCQ7e+WO/VcDCwaWxp05ZZ22pglLlKEHHGRR3yI2ok41aLbY9lrdtMm42vSjBhOiZNeriNQE
	Gm3+FJqKsltbPRcJwmstBn/X5kZj+TQSaXKbVufuq1JHPJTzEkbUKx6WKIDt+CsNBwejdyDiP9N0L
	VQ3NTP4qrRxEVcJ5ocq6VV0kGJB29yplFFx4GvWBPehZ5HXcc/Oad3YrdXDfxEdA6yI2a9b1S0QJE
	9iwPcH2Q==;
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.96 #2 (Debian))
	id 1utel5-002Crc-0L;
	Wed, 03 Sep 2025 12:22:04 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Wed, 03 Sep 2025 12:22:03 +0800
Date: Wed, 3 Sep 2025 12:22:03 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: menglong.dong@linux.dev
Cc: mhiramat@kernel.org, rostedt@goodmis.org,
	mathieu.desnoyers@efficios.com, linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org, oliver.sang@intel.com
Subject: Re: [PATCH] tracing: fprobe: fix suspicious rcu usage in fprobe_entry
Message-ID: <aLfCa1FkLc3T4QI3@gondor.apana.org.au>
References: <aLa2D4It1Zxc7bs0@gondor.apana.org.au>
 <3005966.e9J7NaK4W3@7940hx>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3005966.e9J7NaK4W3@7940hx>

On Tue, Sep 02, 2025 at 05:50:32PM +0800, menglong.dong@linux.dev wrote:
> On 2025/9/2 17:17 Herbert Xu <herbert@gondor.apana.org.au> write:
> > Menglong Dong <dongml2@chinatelecom.cn> wrote:
> > >
> > > diff --git a/kernel/trace/fprobe.c b/kernel/trace/fprobe.c
> > > index fb127fa95f21..fece0f849c1c 100644
> > > --- a/kernel/trace/fprobe.c
> > > +++ b/kernel/trace/fprobe.c
> > > @@ -269,7 +269,9 @@ static int fprobe_entry(struct ftrace_graph_ent *trace, struct fgraph_ops *gops,
> > >        if (WARN_ON_ONCE(!fregs))
> > >                return 0;
> > > 
> > > +       rcu_read_lock();
> > >        head = rhltable_lookup(&fprobe_ip_table, &func, fprobe_rht_params);
> > > +       rcu_read_unlock();
> > >        reserved_words = 0;
> > >        rhl_for_each_entry_rcu(node, pos, head, hlist) {
> > >                if (node->addr != func)
> > 
> > Actually this isn't quite right.  I know that it is a false-positive
> > so that it's actually safe, but if you're going to mark it with
> > rcu_read_lock, it should cover both the lookup as well as the
> > dereference which happens in the loop rhl_for_each_entry_rcu.
> 
> Yeah, I understand. The rcu_read_lock() here is totally used to
> suppress the suspicious rcu usage warning, not for the protection.
> So I used it just for the rhltable_lookup() to reduce the impact.
> Maybe I should add some comment for it.

My point is that after a lookup you will be doing some sort of a
dereference on the RCU pointer.  That would cause exactly the same
splat that rhltable_lookup itself generated.

For example, rhl_for_each_entry_rcu should have created the same
warning, but it doesn't because for some reason it is using
rcu_dereference_raw.  I'll need to dig up the history of this
to see if there is a good reason for it to not warn.

Cheers,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
