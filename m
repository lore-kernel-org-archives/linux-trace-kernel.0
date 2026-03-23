Received: from relay.hostedemail.com (smtprelay0013.hostedemail.com [216.40.44.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C14B523BF9B;
	Mon, 23 Mar 2026 14:47:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774277269; cv=none; b=XIQitCeIN2g0fUfsX9Jnffyi/QZSR0E+mBonM3+Hvbx0aVI2drxWsTv6g2zzC5UlxD4vg+g4Jc1BEqVz+arREztOWY7sgIa2IbnWW1grywz9DmjkykFPEVBgB9FwHq3KO42tdNO5NNwwhZ4EZOWurIc7OI+AxLVtLciOW1VGOxA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774277269; c=relaxed/simple;
	bh=wx27HLfc1Mby95e07F47G7ImVUVS1FPA99JGLu7byMI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DV9Suk/OEqAMs5yvJDQ3pkcL8NtS89ahYboFCsvNbizT4FD5ChhlQG0ZbX9l22Wr+g9RYOylqHdv8L7PXSAfGAQQ3Nl/xxuv7gq8sJDMhmpf8aW5FiG2P6k/iSmO6KvUMPPhMur6qitdEXDV2LwmShpjTNc9wZ+OxhaSBMBzOZ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf18.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay08.hostedemail.com (Postfix) with ESMTP id 7D4F7140BE7;
	Mon, 23 Mar 2026 14:47:40 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf18.hostedemail.com (Postfix) with ESMTPA id 9C37230;
	Mon, 23 Mar 2026 14:47:38 +0000 (UTC)
Date: Mon, 23 Mar 2026 10:48:18 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Martin Kaiser <martin@kaiser.cx>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, linux-trace-kernel@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] tracing: fprobe: fix the length of unused fgraph_data
Message-ID: <20260323104818.0ad25dd5@gandalf.local.home>
In-Reply-To: <20260323102020.239567-1-martin@kaiser.cx>
References: <20260323102020.239567-1-martin@kaiser.cx>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: rspamout05
X-Rspamd-Queue-Id: 9C37230
X-Stat-Signature: qdryheyu4goxamer6p6uodgymifwsn41
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1/RJ/0oIroKCPVbTwh/jWUZPuS5heflfwY=
X-HE-Tag: 1774277258-969674
X-HE-Meta: U2FsdGVkX1+d1Vg5OjngaG+rstbu/9rWp8kKHTSqvW+8jLLkOMX58KiLb5/SP1kQ/RJaPjzD3fTpWALLaE8UOVydLDX+707WuzChB9SHsPEMsUGpq6xsNvt+uv1AG5FGsIgTq8jXwUTCfwNEWXgWQ4kfmpUgcii+5QknlFJOBNj0t5oFTEkzAERiA3ttojPfBIjGQG86yqqnhWysnFD7xAa2PsCReJnInymsirSmnvCN4+kgS8z6MaFZiaLgVhhanz/7IVNlDlcbZDSyBcvu6hrWBOd1OuI5BloMJNg8Fi5qfxE2PGmhCmNYaq0jL31pQUGDLQLYDBw0Z2SNhJyxjv6gc7PQ0rS0

On Mon, 23 Mar 2026 11:19:36 +0100
Martin Kaiser <martin@kaiser.cx> wrote:

> If fprobe_entry does not fill the allocated fgraph_data completely, the
> unused part is zeroed with memset.
> 
> Fix the length for this memset call. Both reserved_words and used are in
> units of return stack words, but memset needs the number of bytes.
> 
> Cc: stable@vger.kernel.org
> Fixes: 4346ba160409 ("fprobe: Rewrite fprobe on function-graph tracer")
> Signed-off-by: Martin Kaiser <martin@kaiser.cx>
> ---
>  kernel/trace/fprobe.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/kernel/trace/fprobe.c b/kernel/trace/fprobe.c
> index dcadf1d23b8a..6a1192515afd 100644
> --- a/kernel/trace/fprobe.c
> +++ b/kernel/trace/fprobe.c
> @@ -451,7 +451,7 @@ static int fprobe_fgraph_entry(struct ftrace_graph_ent *trace, struct fgraph_ops
>  		}
>  	}
>  	if (used < reserved_words)
> -		memset(fgraph_data + used, 0, reserved_words - used);
> +		memset(fgraph_data + used, 0, (reserved_words - used) * sizeof(long));

So fgraph_data is only used internally between the fprobe_fgraph_entry()
and fprobe_return() as it only exists on the fgraph shadow stack. I'm not
even sure if the unused portion needs to be zeroed out.

Thus, this may be correct, but it doesn't look like a true bug that needs a
stable tag.

-- Steve


>  
>  	/* If any exit_handler is set, data must be used. */
>  	return used != 0;

