Received: from relay.hostedemail.com (smtprelay0016.hostedemail.com [216.40.44.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0668E1DF980;
	Tue, 24 Mar 2026 12:38:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774355907; cv=none; b=EpWTu7Hujal8se7l7Xg0OpRno9803qvQDAQeO4ODJ7MtsBjqWRagbz3V1FtLQeZiJEg80XLtXgNJ4RRI+mb2/IjuDmbzwQAJiquruLTypXj5dKGFHUfKCH9Qp+vJuy6g6+z4MAw7Pm2noRLU3WOrFO4X6h7ZUZkvvSHTtGjXjzY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774355907; c=relaxed/simple;
	bh=6SI9y8m/OHmwOY4jJ91uhi4+UdGQdJyw4oq2Ofh+hM0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bMOZGSExeYr9m0vlkvqHICZmr2QT85sehlaXx7R+k5ExqjKXMFG42/nBrGIMLhrnKVJAixHd6hyGDK5DaNhG/nYnFXS5CV3OIJsfhbrW+kn4EbtXlaLd8+9u4Aj/P1dkEQMS2E4KZwrBIjlKWDv3pAa5HinpRqzUY0alsCyEi1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf17.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay03.hostedemail.com (Postfix) with ESMTP id 940FEBA44E;
	Tue, 24 Mar 2026 12:38:24 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf17.hostedemail.com (Postfix) with ESMTPA id D155117;
	Tue, 24 Mar 2026 12:38:22 +0000 (UTC)
Date: Tue, 24 Mar 2026 08:39:03 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Martin Kaiser <martin@kaiser.cx>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, linux-trace-kernel@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] tracing: fprobe: do not zero out unused fgraph_data
Message-ID: <20260324083903.414352aa@gandalf.local.home>
In-Reply-To: <20260324084804.375764-1-martin@kaiser.cx>
References: <20260323102020.239567-1-martin@kaiser.cx>
	<20260324084804.375764-1-martin@kaiser.cx>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: D155117
X-Stat-Signature: kcio7beqtmqt5dc1f7wi5aumf58khno8
X-Rspamd-Server: rspamout03
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1+HLER84+fSlHH/X84/OfEjdWtC5reKrSg=
X-HE-Tag: 1774355902-599556
X-HE-Meta: U2FsdGVkX19Nfof1UU2EMvymvjD7ssybtCHLQxLMmjalIyr+I4zsDWFGNiM3t+K1D63x1WmGUymLs6waFlVIXBJIvSFOpeCIUdBsjOz7wYksELEKgL1kEWpsvQbOsrnsIuqk5eIMzHJvtLNEDTCHLcoD+w/vBJRswjyLLJzEolZrbL7FLmci9JUbGzqAJ1ggQx5s+ddVhBjVl2GciIkBYtKCmj76UpvyfJk/zLl8a6m2S20LcEZ2w5RQppZaS6xX4gdukinqmf6Bbo/20O/OFYTLWtqm3zuncfMaF8e2AWUPUWx5LqhOI0Nge9hbJOgnWVr0EA769bhVXliQ/EeOfNUdO16a8SCDtVpi2H5fMdxIoaV3s8prBGdqqZBE/0m6r+pPCLIt4Vor+3V9a4iDww==

On Tue, 24 Mar 2026 09:47:08 +0100
Martin Kaiser <martin@kaiser.cx> wrote:

Hi Martin,

First, please do not send a v2 as a reply to v1. A new version should
always start a new mail thread.

> If fprobe_entry does not fill the allocated fgraph_data completely, the
> unused part does not have to be zeroed.
> 
> fgraph_data is a short-lived part of the shadow stack. The preceding
> length field allows locating the end regardless of the content.
> 
> Signed-off-by: Martin Kaiser <martin@kaiser.cx>
> ---
> v2:

But to maintain a link to the previous version, I recommend adding here:

Changes since v1: https://lore.kernel.org/all/20260324084804.375764-1-martin@kaiser.cx


>  - remove the memset instead of fixing the length
> 
>  kernel/trace/fprobe.c | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/kernel/trace/fprobe.c b/kernel/trace/fprobe.c
> index dcadf1d23b8a..56d145017902 100644
> --- a/kernel/trace/fprobe.c
> +++ b/kernel/trace/fprobe.c
> @@ -450,8 +450,6 @@ static int fprobe_fgraph_entry(struct ftrace_graph_ent *trace, struct fgraph_ops
>  				used += FPROBE_HEADER_SIZE_IN_LONG + size_words;
>  		}
>  	}
> -	if (used < reserved_words)
> -		memset(fgraph_data + used, 0, reserved_words - used);
>  
>  	/* If any exit_handler is set, data must be used. */
>  	return used != 0;

As for the patch,

Reviewed-by: Steven Rostedt (Google) <rostedt@goodmis.org>

-- Steve
