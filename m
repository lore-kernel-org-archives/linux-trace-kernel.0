Received: from relay.hostedemail.com (smtprelay0012.hostedemail.com [216.40.44.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBD7B2C11E1;
	Wed, 12 Nov 2025 15:30:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762961433; cv=none; b=kj3oIRzoJCciMEAuYmHTtVmzyFrNkDDvK0WD05mFuYxRxE3i6cxLvOxU/UbbWAxaJnCL12r9A5iQKT3IUIhgoOuyohT3ZxG4uO/600loC2o8QsuQ3BmBDuvu+mvTHZIhPQ+JfxPKysNgvt0R7+Ig+yemQxI1qUsCoIDkyL3M9jM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762961433; c=relaxed/simple;
	bh=7VFsJfEGUrKyNCaCQcPW8jB+qtLLTYHyL0f1OcWn7bA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XdzqJBnCte6l+kSO4oeFr1GEVWEtRmGfUsn2PqsktGeqeqI/vZAClxLqXHwKtLpp7thd/t8JTtliBH7cxZ+UV3b54/HxlOoEvAgGm6vKN72D5eynfpNGLqjA/0ipiv7xPO2a0deMlK3SV/aH5PFQbkPeTJmZmC1bRqtpzm5Rx7g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf16.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay02.hostedemail.com (Postfix) with ESMTP id 9965713B422;
	Wed, 12 Nov 2025 15:30:23 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf16.hostedemail.com (Postfix) with ESMTPA id AC37B20013;
	Wed, 12 Nov 2025 15:30:21 +0000 (UTC)
Date: Wed, 12 Nov 2025 10:30:34 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc: Donglin Peng <dolinux.peng@gmail.com>,
 linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org, Donglin
 Peng <pengdonglin@xiaomi.com>, Sven Schnelle <svens@linux.ibm.com>
Subject: Re: [PATCH v3 RESEND] function_graph: Enable funcgraph-args and
 funcgraph-retaddr to work simultaneously
Message-ID: <20251112103034.5ad110db@gandalf.local.home>
In-Reply-To: <20251112141705.a7f2f79f6d7b058201307e89@kernel.org>
References: <20251112034333.2901601-1-dolinux.peng@gmail.com>
	<20251112141705.a7f2f79f6d7b058201307e89@kernel.org>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: AC37B20013
X-Stat-Signature: bj43mu58c6ce8wkdpk3z68tpzwdis5y8
X-Rspamd-Server: rspamout02
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1/gHN7wjFfY6NcK1Tl9vFvDbpHUzBRzwxI=
X-HE-Tag: 1762961421-782756
X-HE-Meta: U2FsdGVkX1+gFwiHrxTmh9NNMhbUhR/STGPwvRdFNQPfAAC450SqwgPrxSNlSZjeH12u58E0VJiXedhviRrVqvmmlCqviVzbvwWG2NQXkLYWoeLiSrRi7faeh0SXO2/wdN7eecz2cHEZ8+dm+Fz4LR2MSfSmLrBjqJzqGD1lAwEXML4LLS1qtvl1/7APnpyIgCRVwRkRVlr7dsqh+SAxBEOnGf2kCnuVuARtRYEeYbKY084wgu7ig4CK0s9HcaehYspEWqiswPuO0D6lGozT86NzgQIixixjVr7HLDww9JnmGdl0jS0b75QnASiOca02SRKlYtBDS8lEQoosIeC+eg0tVTCmnJLnFg3JN6eQc/VOp8tqIthS/w==

On Wed, 12 Nov 2025 14:17:05 +0900
Masami Hiramatsu (Google) <mhiramat@kernel.org> wrote:

> >  #if defined(CONFIG_FUNCTION_GRAPH_RETVAL) || defined(CONFIG_FUNCTION_GRAPH_RETADDR)
> > @@ -869,10 +858,12 @@ static void print_graph_retval(struct trace_seq *s, struct ftrace_graph_ent_entr
> >  		trace_seq_printf(s, "%ps", func);
> >  
> >  		if (args_size >= FTRACE_REGS_MAX_ARGS * sizeof(long)) {
> > -			print_function_args(s, entry->args, (unsigned long)func);
> > +			print_function_args(s, entry->args + ARGS_OFFS(args_size),
> > +					    (unsigned long)func);
> >  			trace_seq_putc(s, ';');
> > -		} else
> > +		} else {  
> 
> nit: you don't need to add braces for a single line block.
> 
> >  			trace_seq_puts(s, "();");
> > +		}
> >  

Actually you do.

The rule for if/else is if one side requires { }, then both do.

  https://docs.kernel.org/process/coding-style.html#placing-braces-and-spaces

Yes, this has been inconsistent and my older code breaks this rule, but I
try to follow it in newer code.

-- Steve
