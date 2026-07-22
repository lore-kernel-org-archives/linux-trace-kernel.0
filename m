Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C52E135C183;
	Wed, 22 Jul 2026 23:24:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784762680; cv=none; b=YRRIBvSrPfZMqR7N28fHVtvSZ8WvYnAYE8g4qVLwvYa624NCa9e5xCoUAVfewVM2QdBWzdQmG/0N534Qsi9jYNNHYQ/2QBS83jmr57hBqlxjF8C+YvET/Q+Qru/Ju8rIvEgA6BUzIIVAPM603YAtJ5sDXt2OJdIXN68sYZa9tHE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784762680; c=relaxed/simple;
	bh=MSlgPFqtjZxFtWbiRP6zZUAfpxsx8Gz2wDngTMxfujw=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=qGC69qN2kPKnzFYEMEoxAj4t4qPC9MC4eB6WRASw93cZLgY2BBxsSpbZ9J3hddYhydh/ycjFYLGR1C1puB71ep5q0GDnRxGOz4zed437ujmFPBtbzwXqsw2Sec72cDIvqHLHXq5hvYCY1wjQ/r9Gf7d22okXCL+qRMq/z8gtAoI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ddm4xlkw; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ddm4xlkw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B8571F000E9;
	Wed, 22 Jul 2026 23:24:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784762679;
	bh=hXRM7rbaN2a23lghqxnP+ConCgxPQL62G/x17rkHHlI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=ddm4xlkw+SGfnRysQxppXh0p4Taw7kOGlQc6te6NfkmCTMeaitSUBbFTrjdqUIxcw
	 8C55P2gy6cSsD8BXfouweALBi1XDVdHTmMYFqmPF08fFCSo3XpF/Qns3MVmaXaOCTW
	 bep+gSiiggxdyRJSdKMTs/oZXw1VZBEAvum7H9NyOOKzP8u60vTVJ9GeJp3sC/Q22t
	 bZQESHwvhOve9mq+Yp9upumYDwoFwg4H5deAoaO+RkGbQptewzUHgStqA+qaw8ygt/
	 64eg6zD2guJKoBnjUtXI2mC3vsmxFlh/eqPvH4MUInDiocQLJB2WIAHhcGt9iZ4bOb
	 llKlSuN3w7lMw==
Date: Thu, 23 Jul 2026 08:24:35 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Linux Trace Kernel
 <linux-trace-kernel@vger.kernel.org>, Masami Hiramatsu
 <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [PATCH] tracing: Do not clean up hiter in mmiotrace read
 function
Message-Id: <20260723082435.3dcdef7b52fe661d6ff506c9@kernel.org>
In-Reply-To: <20260721212010.76e9ed61@gandalf.local.home>
References: <20260721212010.76e9ed61@gandalf.local.home>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 21 Jul 2026 21:20:10 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> From: Steven Rostedt <rostedt@goodmis.org>
> 
> When the mmiotrace trace was first created, it allocated a descriptor in
> its pipe_open() method. Since there was no pipe_close() method when it was
> created (in May of 2008, and pipe_close() was added in December of 2009),
> it cleaned up the allocated descriptors in the read.
> 
> Now that the clean up is in the pipe_close() method that now exists,
> remove the clean up from the read as it is no longer needed.
> 
> Also simplify the code by inverting the early exit conditional into a
> conditional to perform the logic and get rid of the goto.
> 
> Link: https://lore.kernel.org/all/20260715143604.14481-1-gaikwad.dcg@gmail.com/
> Link: https://lore.kernel.org/all/20260721211143.36dbd559@gandalf.local.home/
> 
> Signed-off-by: Steven Rostedt <rostedt@goodmis.org>
> ---
>  kernel/trace/trace_mmiotrace.c | 14 +++-----------
>  1 file changed, 3 insertions(+), 11 deletions(-)
> 
> diff --git a/kernel/trace/trace_mmiotrace.c b/kernel/trace/trace_mmiotrace.c
> index b88b8d9923ad..ba604c22d2d2 100644
> --- a/kernel/trace/trace_mmiotrace.c
> +++ b/kernel/trace/trace_mmiotrace.c
> @@ -142,21 +142,13 @@ static ssize_t mmio_read(struct trace_iterator *iter, struct file *filp,
>  		if (!overrun_detected)
>  			pr_warn("mmiotrace has lost events\n");
>  		overrun_detected = true;
> -		goto print_out;

Is this intentional change? Removing this goto means we will change
the hiter->dev even if overrun happens. Previously we can resume
output in the next read for current hiter->dev, but this will skip
the current hiter->dev?

Thanks,

>  	}
>  
> -	if (!hiter || !hiter->dev)
> -		return 0;
> -
> -	mmio_print_pcidev(s, hiter->dev);
> -	hiter->dev = pci_get_device(PCI_ANY_ID, PCI_ANY_ID, hiter->dev);
> -
> -	if (!hiter->dev) {
> -		destroy_header_iter(hiter);
> -		iter->private = NULL;
> +	if (hiter && hiter->dev) {
> +		mmio_print_pcidev(s, hiter->dev);
> +		hiter->dev = pci_get_device(PCI_ANY_ID, PCI_ANY_ID, hiter->dev);
>  	}
>  
> -print_out:
>  	ret = trace_seq_to_user(s, ubuf, cnt);
>  	return (ret == -EBUSY) ? 0 : ret;
>  }
> -- 
> 2.53.0
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
