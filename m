Received: from relay.hostedemail.com (smtprelay0015.hostedemail.com [216.40.44.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9802541D234;
	Thu, 23 Jul 2026 13:49:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784814581; cv=none; b=olpGG3rm0i2hiqO+hktPGuowuvJQzIKFIMxGH9ZX9EuGjsD7QBovl/BxBC6QbR35dsafOPQuN0KHAyQ++6q2ZAHW4/aGUKT9WEiX/cOf/9JwS/5CBPliP9ulilFIiFblABjWRpt9XwRHAJ2kmIk+u9EvrXmel33F3eAp22Dj7BM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784814581; c=relaxed/simple;
	bh=IkNmIb96kbGhcDkZVs8PqyjNEG20ZK0UbycuU/X6kCs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nDylWmD7u8TdCAT2Bzoj59V6nB47YeupqGV5IW86Y9vI2IZ46WCdW5307FENlf3urYHbg5jeYJfXWF8ESWkruFd5sSxZH/EUuHINzVRafVL8rV4Y03jbz2K4F1Pzi55TRwuDBuxr+WpgrFKWcRjFi3pzcXlW/X8qOp8THcEVc40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf13.hostedemail.com (lb01a-stub [10.200.18.249])
	by unirelay01.hostedemail.com (Postfix) with ESMTP id 59F181C04E1;
	Thu, 23 Jul 2026 13:49:38 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf13.hostedemail.com (Postfix) with ESMTPA id 9BC602000E;
	Thu, 23 Jul 2026 13:49:36 +0000 (UTC)
Date: Thu, 23 Jul 2026 09:49:58 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Linux Trace Kernel
 <linux-trace-kernel@vger.kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>
Subject: Re: [PATCH] tracing: Do not clean up hiter in mmiotrace read
 function
Message-ID: <20260723094958.47c2dfea@gandalf.local.home>
In-Reply-To: <20260723082435.3dcdef7b52fe661d6ff506c9@kernel.org>
References: <20260721212010.76e9ed61@gandalf.local.home>
	<20260723082435.3dcdef7b52fe661d6ff506c9@kernel.org>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: rdurcpgxse7jj5ihanck5xprem9yibbx
X-Rspamd-Server: rspamout04
X-Rspamd-Queue-Id: 9BC602000E
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1/AZCzKpvuQYBJ7mUF4zDg0ZULqoGSxTR0=
X-HE-Tag: 1784814576-199755
X-HE-Meta: U2FsdGVkX18JosvVlWQKXkBAz7+/2xwUlZL4avwvyJJRIXcSF9LfHPi4+6INBav0Ee4ql8VcFwyrCLnchnqVPU3UBfJUz8SLyKwWxcHnmJA6ERJNBJJDECI129wjyJzjtsSpdgWuKoiAPFYZq8o1SqFjhPMgeMsl7gYWUZNNMtwmvGCJl/jkUJaRXbAjEe4Q09g3CFuHPPPzyslUAifxROT9HRHfd3jxXM0pPJIUFuF5EPMmccti4+Kxn9E/Iz2eGoaxJXLeNSL2uDUy5HsInsq/sYESmtu1/we3NbHe7qt1bWfEVZ8QucsrMbiBKEX3u4HkZpoa6EFLy/3gDfZ3K2oJpCHvKPrTPPAO11v4AgXNHSzpbXj6oFbpHSu8S+YNDude+l3P3871EbGSP2oXeWu2Sf2MyF+as/X/Mao+r/4=

On Thu, 23 Jul 2026 08:24:35 +0900
Masami Hiramatsu (Google) <mhiramat@kernel.org> wrote:

> On Tue, 21 Jul 2026 21:20:10 -0400
> Steven Rostedt <rostedt@goodmis.org> wrote:
> 
> > From: Steven Rostedt <rostedt@goodmis.org>
> > 
> > When the mmiotrace trace was first created, it allocated a descriptor in
> > its pipe_open() method. Since there was no pipe_close() method when it was
> > created (in May of 2008, and pipe_close() was added in December of 2009),
> > it cleaned up the allocated descriptors in the read.
> > 
> > Now that the clean up is in the pipe_close() method that now exists,
> > remove the clean up from the read as it is no longer needed.
> > 
> > Also simplify the code by inverting the early exit conditional into a
> > conditional to perform the logic and get rid of the goto.
> > 
> > Link: https://lore.kernel.org/all/20260715143604.14481-1-gaikwad.dcg@gmail.com/
> > Link: https://lore.kernel.org/all/20260721211143.36dbd559@gandalf.local.home/
> > 
> > Signed-off-by: Steven Rostedt <rostedt@goodmis.org>
> > ---
> >  kernel/trace/trace_mmiotrace.c | 14 +++-----------
> >  1 file changed, 3 insertions(+), 11 deletions(-)
> > 
> > diff --git a/kernel/trace/trace_mmiotrace.c b/kernel/trace/trace_mmiotrace.c
> > index b88b8d9923ad..ba604c22d2d2 100644
> > --- a/kernel/trace/trace_mmiotrace.c
> > +++ b/kernel/trace/trace_mmiotrace.c
> > @@ -142,21 +142,13 @@ static ssize_t mmio_read(struct trace_iterator *iter, struct file *filp,
> >  		if (!overrun_detected)
> >  			pr_warn("mmiotrace has lost events\n");
> >  		overrun_detected = true;
> > -		goto print_out;  
> 
> Is this intentional change? Removing this goto means we will change
> the hiter->dev even if overrun happens. Previously we can resume
> output in the next read for current hiter->dev, but this will skip
> the current hiter->dev?

But doesn't it still add to the buffer here?

> 
> Thanks,
> 
> >  	}
> >  
> > -	if (!hiter || !hiter->dev)
> > -		return 0;
> > -
> > -	mmio_print_pcidev(s, hiter->dev);
> > -	hiter->dev = pci_get_device(PCI_ANY_ID, PCI_ANY_ID, hiter->dev);
> > -
> > -	if (!hiter->dev) {
> > -		destroy_header_iter(hiter);
> > -		iter->private = NULL;
> > +	if (hiter && hiter->dev) {
> > +		mmio_print_pcidev(s, hiter->dev);

The current hiter->dev get's read here doesn't it?

It's stored in the trace_seq and should still be printed.

Or am I missing something?

Either way, it looks like I should split this patch up into two:

One that removes the unneeded clean up, and the other that removes the
goto. The clean up removal is trivial with the new changes that cleans it
up on close. But the removal of the goto has more subtle effects and we
want to be able to detect it if it does cause issues.

I wasn't planning on adding this patch to the next merge window anyway, so
it can wait.

-- Steve


> > +		hiter->dev = pci_get_device(PCI_ANY_ID, PCI_ANY_ID, hiter->dev);
> >  	}
> >  
> > -print_out:
> >  	ret = trace_seq_to_user(s, ubuf, cnt);
> >  	return (ret == -EBUSY) ? 0 : ret;
> >  }
> > -- 
> > 2.53.0
> >   
> 
> 

