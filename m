Received: from abb.hmeau.com (abb.hmeau.com [180.181.231.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 131CB242D98;
	Tue,  2 Sep 2025 09:17:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=180.181.231.80
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756804642; cv=none; b=qCVhHrhfIF2A5hHXoTveX3ZrvR/giB3HZYXraairoz4rdj+vK9a7rYegfhwjygqwVkvHkcXTD6N2haAM886xdy34dLoOC2OF2NkmVqujlmiNMcKORa2kZj9oOnzJ5QMxerVzliJ4EDmaneRYUJ+jJO+7AeiQvrwsVT13KG5/2z8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756804642; c=relaxed/simple;
	bh=u/gpzFc54E7Qkui3Rf+FQee8DH7Jl2fl0v2tnQNBejs=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=mI+bIWXjt7zO6tA2VqT13z3xa5cXNCQOOyNQu+qIiWZdgNo+/PcQKx45e8LMjPZCzGcpzzO7JoT7l+UH860qPJ4gDHNCoK172+3+Y1si6eFLzWsYupn+EiL/Lwy7bpbFIPHwTKH4QBlyy1VCYVBCvhiIBtFWjeBrmm2737UgxVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au; spf=pass smtp.mailfrom=gondor.apana.org.au; dkim=pass (2048-bit key) header.d=hmeau.com header.i=@hmeau.com header.b=kWNUjHso; arc=none smtp.client-ip=180.181.231.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hmeau.com header.i=@hmeau.com header.b="kWNUjHso"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hmeau.com;
	s=formenos; h=In-Reply-To:Content-Type:MIME-Version:Message-ID:Subject:Cc:To:
	From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:References:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=2Dmf2HsAjLA9aMcC0oK5XbhwP0WeOH0TUSdhNSFuoWg=; b=kWNUjHso6SRKfHUaQV0X1yfbm0
	fdGdpbbUrng21bwO4DHcKE2NjzYFD0RDzw4CYke6Y7od3AKYiCJthROr7U4SJkJm8KO7SPw3QfAwy
	1WRWtJ8MiKS94qm0OZIF7kF4sVAH7tfiEAITMJ7SU1PuVQ2rDsTJNdicyvlUxnGyyAWSl6r1arbPS
	n/bbJQiCpmCWbrH42wGlDI+OuKy3n/izvdnSXHmhdoPVNo7Vj3h7oh4H0ZHbp23BSnD02t1ONd/zY
	URPWEI8rmJdSoqwskcX7uV2VMMCOTqC7rqtbXrSLdlvTzyq7VsZuD02gFcyJyazBEZNR/OYHrGjgM
	tPICuk9g==;
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.96 #2 (Debian))
	id 1utMt1-001wj9-1v;
	Tue, 02 Sep 2025 17:17:05 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Tue, 02 Sep 2025 17:17:03 +0800
Date: Tue, 2 Sep 2025 17:17:03 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: Menglong Dong <dongml2@chinatelecom.cn>
Cc: mhiramat@kernel.org, rostedt@goodmis.org,
	mathieu.desnoyers@efficios.com, linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org, oliver.sang@intel.com
Subject: Re: [PATCH] tracing: fprobe: fix suspicious rcu usage in fprobe_entry
Message-ID: <aLa2D4It1Zxc7bs0@gondor.apana.org.au>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250829021436.19982-1-dongml2@chinatelecom.cn>
X-Newsgroups: apana.lists.os.linux.kernel

Menglong Dong <dongml2@chinatelecom.cn> wrote:
>
> diff --git a/kernel/trace/fprobe.c b/kernel/trace/fprobe.c
> index fb127fa95f21..fece0f849c1c 100644
> --- a/kernel/trace/fprobe.c
> +++ b/kernel/trace/fprobe.c
> @@ -269,7 +269,9 @@ static int fprobe_entry(struct ftrace_graph_ent *trace, struct fgraph_ops *gops,
>        if (WARN_ON_ONCE(!fregs))
>                return 0;
> 
> +       rcu_read_lock();
>        head = rhltable_lookup(&fprobe_ip_table, &func, fprobe_rht_params);
> +       rcu_read_unlock();
>        reserved_words = 0;
>        rhl_for_each_entry_rcu(node, pos, head, hlist) {
>                if (node->addr != func)

Actually this isn't quite right.  I know that it is a false-positive
so that it's actually safe, but if you're going to mark it with
rcu_read_lock, it should cover both the lookup as well as the
dereference which happens in the loop rhl_for_each_entry_rcu.

Thanks,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
