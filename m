Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE2B33054E4;
	Thu, 23 Jul 2026 23:10:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784848213; cv=none; b=gUBRguPMiFKGYvIuRq7Kx8dOy3UGM4oK6XZV/jPpdf00G74uPNQkxmxbmF2aES9MipNgVABTHjEsj3TgRdJ7IqBdGAwfCr+87lbFzFSQCli/h1ZDFHRUoBTe5kjKM17qsIsxOfOFWwu9DJ3Ls+JxKptgwFuKHMjtWTe7q32ffsk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784848213; c=relaxed/simple;
	bh=jckZPYc9ZXYQwg5E/i5MBmWSYqizAuFBXCXdOiqHjUQ=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=DEVKQLVfcRVXemA6OJrkBKVwZgadbOlOvplyVoBVr3F5prXvdsfJGZSHQMydpGbj/TNTbFB1mROthWrF0m/4NPzSpwHy7deODV/ttQRfonNsGyFUczuCRVqVoaSJso6j/VpyOCTivhlPSSSH49EssB3ISuCxHgxF9p80qdQqCfc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R66qayIU; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R66qayIU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9043F1F00A3D;
	Thu, 23 Jul 2026 23:10:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784848211;
	bh=+v6hjRoTLtkeyK0zP1XZDkrpnDNsTX7nlkKU26LhVAI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=R66qayIUoE5cfLpjAud+0bzrvE/kpKF94WA/eKOPebB2R3TsgY2S8Z7QzG9GGY4Qc
	 ApNseRpHP+BSF6PWSdi+wh5sG9hlykus1AoCSOsWzt+5YbFx8urt6c19jsCXqxG4jg
	 NUdQ+hmGcW/OUJpf+CMyHypWwAZ8+3WiKLbcMwOTuzn6wjjHEmdPAAk4lkEXJlu+H4
	 gUBQFgeX30xjFRy+H74TDOsnPdSESjUo7ebfUntbv6uyZKEim5iCySTvokDx09BGw3
	 q/As1jRn1908VEh7mq4QR/RiEUkDgZc47FkJncqCV3dszaywlzbK40SnIdx66fpCFr
	 86OAB3rqFr82Q==
Date: Fri, 24 Jul 2026 08:10:06 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Linux Trace Kernel
 <linux-trace-kernel@vger.kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>
Subject: Re: [PATCH] tracing: Do not clean up hiter in mmiotrace read
 function
Message-Id: <20260724081006.b24a391b55789c27580528ab@kernel.org>
In-Reply-To: <20260723094958.47c2dfea@gandalf.local.home>
References: <20260721212010.76e9ed61@gandalf.local.home>
	<20260723082435.3dcdef7b52fe661d6ff506c9@kernel.org>
	<20260723094958.47c2dfea@gandalf.local.home>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 23 Jul 2026 09:49:58 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> On Thu, 23 Jul 2026 08:24:35 +0900
> Masami Hiramatsu (Google) <mhiramat@kernel.org> wrote:
> 
> > On Tue, 21 Jul 2026 21:20:10 -0400
> > Steven Rostedt <rostedt@goodmis.org> wrote:
> > 
> > > From: Steven Rostedt <rostedt@goodmis.org>
> > > 
> > > When the mmiotrace trace was first created, it allocated a descriptor in
> > > its pipe_open() method. Since there was no pipe_close() method when it was
> > > created (in May of 2008, and pipe_close() was added in December of 2009),
> > > it cleaned up the allocated descriptors in the read.
> > > 
> > > Now that the clean up is in the pipe_close() method that now exists,
> > > remove the clean up from the read as it is no longer needed.
> > > 
> > > Also simplify the code by inverting the early exit conditional into a
> > > conditional to perform the logic and get rid of the goto.
> > > 
> > > Link: https://lore.kernel.org/all/20260715143604.14481-1-gaikwad.dcg@gmail.com/
> > > Link: https://lore.kernel.org/all/20260721211143.36dbd559@gandalf.local.home/
> > > 
> > > Signed-off-by: Steven Rostedt <rostedt@goodmis.org>
> > > ---
> > >  kernel/trace/trace_mmiotrace.c | 14 +++-----------
> > >  1 file changed, 3 insertions(+), 11 deletions(-)
> > > 
> > > diff --git a/kernel/trace/trace_mmiotrace.c b/kernel/trace/trace_mmiotrace.c
> > > index b88b8d9923ad..ba604c22d2d2 100644
> > > --- a/kernel/trace/trace_mmiotrace.c
> > > +++ b/kernel/trace/trace_mmiotrace.c
> > > @@ -142,21 +142,13 @@ static ssize_t mmio_read(struct trace_iterator *iter, struct file *filp,
> > >  		if (!overrun_detected)
> > >  			pr_warn("mmiotrace has lost events\n");
> > >  		overrun_detected = true;
> > > -		goto print_out;  
> > 
> > Is this intentional change? Removing this goto means we will change
> > the hiter->dev even if overrun happens. Previously we can resume
> > output in the next read for current hiter->dev, but this will skip
> > the current hiter->dev?
> 
> But doesn't it still add to the buffer here?
> 
> > 
> > Thanks,
> > 
> > >  	}
> > >  
> > > -	if (!hiter || !hiter->dev)
> > > -		return 0;
> > > -
> > > -	mmio_print_pcidev(s, hiter->dev);
> > > -	hiter->dev = pci_get_device(PCI_ANY_ID, PCI_ANY_ID, hiter->dev);
> > > -
> > > -	if (!hiter->dev) {
> > > -		destroy_header_iter(hiter);
> > > -		iter->private = NULL;
> > > +	if (hiter && hiter->dev) {
> > > +		mmio_print_pcidev(s, hiter->dev);
> 
> The current hiter->dev get's read here doesn't it?
> 
> It's stored in the trace_seq and should still be printed.
> 
> Or am I missing something?

Ah, I got it. Previously, it was separated into 2 reads, but
this makes it 1 read. Got it.

> 
> Either way, it looks like I should split this patch up into two:
> 
> One that removes the unneeded clean up, and the other that removes the
> goto. The clean up removal is trivial with the new changes that cleans it
> up on close. But the removal of the goto has more subtle effects and we
> want to be able to detect it if it does cause issues.
> 
> I wasn't planning on adding this patch to the next merge window anyway, so
> it can wait.

OK, this looks good to me.

Reviewed-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>

Thanks,

> 
> -- Steve
> 
> 
> > > +		hiter->dev = pci_get_device(PCI_ANY_ID, PCI_ANY_ID, hiter->dev);
> > >  	}
> > >  
> > > -print_out:
> > >  	ret = trace_seq_to_user(s, ubuf, cnt);
> > >  	return (ret == -EBUSY) ? 0 : ret;
> > >  }
> > > -- 
> > > 2.53.0
> > >   
> > 
> > 
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
