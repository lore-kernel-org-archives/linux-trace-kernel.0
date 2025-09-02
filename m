Received: from relay.hostedemail.com (smtprelay0010.hostedemail.com [216.40.44.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 413352AD31;
	Tue,  2 Sep 2025 14:58:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756825085; cv=none; b=EOsFJjaZjl0K5cs3td87xYBuN/h2bEc26fcTwWVdQTGm3nVDUfGKlm6ucBUTZP27Oe4X4UfPLHL0t+Logvb7TPCdid2uiJA+L7DLbjheEYKoVxH7W+4n6CJbZL5D8Qpu7BY7aD+nOzikaBMX2ul6cXzEH3qQAxOgeBetfAs+bvI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756825085; c=relaxed/simple;
	bh=xh+D3Otgus7FpZ6lCewwtO5uO4rsEfid5DjiL6LZ9hk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FcrKx36emMGLkHZ8xGp0FBIeNRjttI9lcGFAhBnVbrECWazJfXVOj3vSdYQN1qigvWPC9bmeU7tZ4IsOhPZ5OcOiPqNs3ncTtzMdDIx+H25HfvoKz3CWIM2oAaPVLF6b5wxwQY9pn8x7NXG7C23uKqO8HGO+pkfQlVA292t0wqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf17.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay09.hostedemail.com (Postfix) with ESMTP id CF2D5838C8;
	Tue,  2 Sep 2025 14:57:59 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf17.hostedemail.com (Postfix) with ESMTPA id 2C02519;
	Tue,  2 Sep 2025 14:57:58 +0000 (UTC)
Date: Tue, 2 Sep 2025 10:57:57 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Herbert Xu <herbert@gondor.apana.org.au>
Cc: Menglong Dong <dongml2@chinatelecom.cn>, mhiramat@kernel.org,
 mathieu.desnoyers@efficios.com, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, oliver.sang@intel.com
Subject: Re: [PATCH] tracing: fprobe: fix suspicious rcu usage in
 fprobe_entry
Message-ID: <20250902105757.16a78aea@batman.local.home>
In-Reply-To: <aLa2D4It1Zxc7bs0@gondor.apana.org.au>
References: <20250829021436.19982-1-dongml2@chinatelecom.cn>
	<aLa2D4It1Zxc7bs0@gondor.apana.org.au>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 2C02519
X-Stat-Signature: kexuroswazy4anmpbiun1id7yeqi66t7
X-Rspamd-Server: rspamout06
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1+/Ny8/UnxoGIoq71DQSFmlT+LfizK97EE=
X-HE-Tag: 1756825078-309006
X-HE-Meta: U2FsdGVkX1/LQ1in0ngiEYGxxhNUy5fGrzzzAtyz208XAeFe+oEJM4lCaJDsqGNNY1jV5ehtRkmhgZyqCCSfyZaZ6WvJiZ7i9z6lKpaencayh1V5Z+abLn0OdXpmGOPv/JFLL2Step3ZmWyGGwpCDgOBRnNRHsmwKO8OdAK7dRhGSN45H7rGYHdnWLwZ2vgNSJqoXd8ToLZ0S0YixYnlWXDHgNzGRVycva536pljzVR5JvCA7V5/GN/REBoMOoZuJsrA/HpH+x661tHzj2I/d2VqhIvAUzbz0fqejzPBdVhnMGUpomH0JfdbqVt4BLdNWTHSToFCrzC0tlDB4TgChpxZY4KDeqz1V/Kpp9s/nUHnGK5s452jeMwfiNvy3Eyu

On Tue, 2 Sep 2025 17:17:03 +0800
Herbert Xu <herbert@gondor.apana.org.au> wrote:

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
> 

I disagree. It's a false positive as RCU is actually enabled here
because preemption is disabled. Now we are spreading the internals of
rhltable into the fprobe code.

We should just wrap it as is with a comment saying that currently RCU
checking doesn't have a good way to know preemption is disabled in all
config settings.

That is, I don't want rcu disabled here where people will think it's
actually needed when it isn't. Wrapping the call with rcu_read_lock()
with a comment that says it's to quiet a false positive is enough, as
then we are not misrepresenting the code.

Maybe instead have:

/*
 * fprobes calls rhltable_lookup() from a preempt_disabled location.
 * This is equivalent to rcu_read_lock(). But rcu_deferefernce_check()
 * will trigger a false positive when PREEMPT_COUNT is not defined.
 * Quiet the check.
 */
#ifndef CONFIG_PREEMPT_COUNT
# define quiet_rcu_lock_check() rcu_read_lock()
# define quiet_rcu_unlock_check() rcu_read_unlock()
#else
# define quiet_rcu_lock_check()
# define_quiet_rcu_unlock_check()
#endif

And then have:

       quiet_rcu_read_lock_check();
       head = rhltable_lookup(&fprobe_ip_table, &func, fprobe_rht_params);
       quiet_rcu_read_unlock_check();

-- Steve
