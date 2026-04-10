Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 247551DFDA1;
	Fri, 10 Apr 2026 00:19:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775780343; cv=none; b=CgHZuohHW9ehJRUr5hjzY07rerI7Dt7Db2L/Cf+wn2xlS5+ExAqn0YlzT5QYWOEPuuhhACJEgzus+Pi88Mh9yyugEJY1AIhFcO1GX4GHoXLxsTz2TGTiYui8g70AlKIBj2LpN3Y3sLYsIVzGdbh5+Dib7xlT7z76pM51fd6y1lE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775780343; c=relaxed/simple;
	bh=uYcj87n7iaRR9VHQ2Yp/Bib99GJEeBgdLxze5PGshtM=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=KKTkZfUpb8u9x0YrkZ987EOVssWDn1ZKailR8z6xAoA8Wpkp9HfDfhpo2OZADrQfxRAXAsAyyAcp+KeoYxY6umkj1027eS4za+Pm6a6NWD8dgV043KA8Hm+9Zu7LSUg2gFKSz0F+kSWhmAgKLynIzYs18XSfU17/FDxfEneEX/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l9K0I92S; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l9K0I92S"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BFC93C4CEF7;
	Fri, 10 Apr 2026 00:19:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775780342;
	bh=uYcj87n7iaRR9VHQ2Yp/Bib99GJEeBgdLxze5PGshtM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=l9K0I92SunLtalwJKKQ+UHA8r7is2zTPAIx2+gIKOhh0b0PbkvZ/cghrjXoZDUFXh
	 0Sevk4xI2pFwmcmWsape6XlL3L6vvSwnDPHak1DcxTRvkVHkV3wQi8X+jLLqx2/iO+
	 Ou8uBWiGGuoqDFtl1CiDWNPm/yER2J8k4gPC2hjlOusPmBIBtTjEfaaluQDiPG+VMI
	 qwpppmMFIm7mJ76EJMU1S/A6fINMp0RPMh/P2RyaySOlLdcSJvYnR4MohF1wLWujiE
	 pqcgPEWx6Ls4jwh4VV47lKKPNYuK47h/NNNOby7K2HEoYPEX0xK1bVTjECT3P45ZuX
	 9ub/9IeYNobqQ==
Date: Fri, 10 Apr 2026 09:19:00 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Menglong Dong <menglong.dong@linux.dev>
Cc: Steven Rostedt <rostedt@goodmis.org>, Menglong Dong
 <menglong8.dong@gmail.com>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, jiang.biao@linux.dev,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] tracing/fprobe: Avoid kcalloc() in rcu_read_lock
 section
Message-Id: <20260410091900.d9dff4cef540e7d61d4a83c8@kernel.org>
In-Reply-To: <2258680.irdbgypaU6@7940hx>
References: <177573094819.3666478.11900825120958856397.stgit@mhiramat.tok.corp.google.com>
	<177573095696.3666478.4412068539797028855.stgit@mhiramat.tok.corp.google.com>
	<2258680.irdbgypaU6@7940hx>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 09 Apr 2026 20:05:13 +0800
Menglong Dong <menglong.dong@linux.dev> wrote:

> On 2026/4/9 18:35 Masami Hiramatsu (Google) <mhiramat@kernel.org> write:
> > From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> > 
> > fprobe_remove_node_in_module() is called under RCU read locked, but
> > this invokes kcalloc() if there are more than 8 fprobes installed
> > on the module. Sashiko warns it because kcalloc() can sleep [1].
> > 
> >  [1] https://sashiko.dev/#/patchset/177552432201.853249.5125045538812833325.stgit%40mhiramat.tok.corp.google.com
> > 
> > To fix this issue, expand the batch size to 128 and do not expand
> > the fprobe_addr_list, but just cancel walking on fprobe_ip_table,
> > update fgraph/ftrace_ops and retry the loop again.
> > 
> > Fixes: 0de4c70d04a4 ("tracing: fprobe: use rhltable for fprobe_ip_table")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> > ---
> >  kernel/trace/fprobe.c |   53 ++++++++++++++++++-------------------------------
> >  1 file changed, 19 insertions(+), 34 deletions(-)
> > 
> > diff --git a/kernel/trace/fprobe.c b/kernel/trace/fprobe.c
> > index 56d145017902..058cf6ef7ebb 100644
> > --- a/kernel/trace/fprobe.c
> > +++ b/kernel/trace/fprobe.c
> > @@ -536,7 +536,7 @@ static void fprobe_graph_remove_ips(unsigned long *addrs, int num)
> 
> Hi, Masami. Thanks for the fixes. Overall, the whole series
> LGTM.
> 
> Some nits below.
> 
> >  
> >  #ifdef CONFIG_MODULES
> >  
> [...]
> >  				  unsigned long val, void *data)
> > @@ -591,6 +567,7 @@ static int fprobe_module_callback(struct notifier_block *nb,
> >  	struct fprobe_hlist_node *node;
> >  	struct rhashtable_iter iter;
> >  	struct module *mod = data;
> > +	bool retry;
> >  
> >  	if (val != MODULE_STATE_GOING)
> >  		return NOTIFY_DONE;
> > @@ -600,13 +577,19 @@ static int fprobe_module_callback(struct notifier_block *nb,
> >  	if (!alist.addrs)
> >  		return NOTIFY_DONE;
> 
> The "retry" confuse me a little. How about we use "again" and "more"
> here:
> 
> +again:
> +	more = false;


OK. And Sashiko pointed out that we can retry right after calling
rhltable_walk_enter(), and it seems true according to 
https://lwn.net/Articles/751374/

We can seep inside rhltable_walk_enter()/exit() but not inside
rhashtable_walk_start()/end().

So let me update it.

> 
> >  
> > +retry:
> > +	retry = false;
> > +	alist.index = 0;
> >  	mutex_lock(&fprobe_mutex);
> >  	rhltable_walk_enter(&fprobe_ip_table, &iter);
> >  	do {
> >  		rhashtable_walk_start(&iter);
> >  
> >  		while ((node = rhashtable_walk_next(&iter)) && !IS_ERR(node))
> > -			fprobe_remove_node_in_module(mod, node, &alist);
> > +			if (fprobe_remove_node_in_module(mod, node, &alist) < 0) {
> > +				retry = true;
> > +				break;
> > +			}
> 
> Wrap the code within the "while" with {}?

OK.

Thank you!

> 
> Thanks!
> Menglong Dong
> 
> >  
> >  		rhashtable_walk_stop(&iter);
> >  	} while (node == ERR_PTR(-EAGAIN));
> > @@ -615,6 +598,8 @@ static int fprobe_module_callback(struct notifier_block *nb,
> >  	if (alist.index > 0)
> >  		fprobe_set_ips(alist.addrs, alist.index, 1, 0);
> >  	mutex_unlock(&fprobe_mutex);
> > +	if (retry)
> > +		goto retry;
> >  
> >  	kfree(alist.addrs);
> >  
> > 
> > 
> > 
> 
> 
> 
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
