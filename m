Received: from relay.hostedemail.com (smtprelay0011.hostedemail.com [216.40.44.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81AB6178372;
	Mon, 24 Nov 2025 21:46:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764020791; cv=none; b=ryptiF+tT6uBC4FDbIFJCMJ+OW5fhN0d4y+SDDdDhp1OrhkfT+OzcB6ZjJOc79WntcRYwiP1a4WLGXrEziPpwNvKU1R6unPZyakZr7CLD0XT7InCNGSa3qQEG1sMR3yKQfdvQq7mCxrtQz07dqfFkmNTLZvlj45jfIjBFHVtVPI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764020791; c=relaxed/simple;
	bh=LbqzWgN/AXOV3ciLe9XOgbQ05AqyJCR8LtMULjucmFI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=L9QWwLRD6rLx2gT0jyYfafph483smI33oFej2NmBxtCXCRF4Z8pnQ/+4tE+kNLEp6UY+eZc+Nph2+OAs0dQWcJjVk2maZ69yAKeKLafl/esaN/GhR4Pt/YVcREWnUzYpKocEU4HdJRw8NOwBa3r2EOgt5zB2AVgVBOECKGNnI/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf13.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay09.hostedemail.com (Postfix) with ESMTP id 0BD5A88722;
	Mon, 24 Nov 2025 21:46:21 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf13.hostedemail.com (Postfix) with ESMTPA id 1815E20010;
	Mon, 24 Nov 2025 21:46:20 +0000 (UTC)
Date: Mon, 24 Nov 2025 16:47:01 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Donglin Peng <dolinux.peng@gmail.com>
Cc: linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org,
 Donglin Peng <pengdonglin@xiaomi.com>, Sven Schnelle <svens@linux.ibm.com>,
 Masami Hiramatsu <mhiramat@kernel.org>
Subject: Re: [PATCH v7] function_graph: Enable funcgraph-args and
 funcgraph-retaddr to work simultaneously
Message-ID: <20251124164701.1216a073@gandalf.local.home>
In-Reply-To: <20251114025522.2115359-1-dolinux.peng@gmail.com>
References: <20251114025522.2115359-1-dolinux.peng@gmail.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: b3zss4dmnugo3tw1r4bryw6tjhfm91f3
X-Rspamd-Server: rspamout03
X-Rspamd-Queue-Id: 1815E20010
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX19AbVZhW9+sXwUfSGdsTaYHQ6Hq8ZB3YCE=
X-HE-Tag: 1764020779-587844
X-HE-Meta: U2FsdGVkX1+J7wtQx14fhH+We6CZlfq69J40zH/Q1czi7V9hPK7r0mkm6ifuyOFQbBDRb9qwKkBIRx0ba70mKjTCL86g2GG9JRuyF2d8KFhA7twioKwV5ZSHNr+zCMg0N6qYDTWVf0a7Y4BGk1C3F3VwI0P1InqLM+9UsS4cuqeI3Sw25nAZdUOS8g4zJtrAKKdlTSkerr+lwkLKzRGu3YsTymIzEbAtbGwXpnoTuCNfZpaKAY7FPIrL7IjT0XuMnVASngySOXaRcQ//hZmOrQNeL7b0q0DRWaNkh5m+O4+0HbFPbJafcFecCcgcKv1nNdw7UnN2Ms5TLXWTLW3h8Zd5RaUFysjx

On Fri, 14 Nov 2025 10:55:22 +0800
Donglin Peng <dolinux.peng@gmail.com> wrote:

> --- a/kernel/trace/trace_entries.h
> +++ b/kernel/trace/trace_entries.h
> @@ -95,14 +95,14 @@ FTRACE_ENTRY_PACKED(fgraph_retaddr_entry, fgraph_retaddr_ent_entry,
>  	TRACE_GRAPH_RETADDR_ENT,
>  
>  	F_STRUCT(
> -		__field_struct(	struct fgraph_retaddr_ent,	graph_ent	)
> +		__field_struct(	struct ftrace_graph_ent,	graph_ent	)
>  		__field_packed(	unsigned long,	graph_ent,	func		)
>  		__field_packed(	unsigned int,	graph_ent,	depth		)
> -		__field_packed(	unsigned long,	graph_ent,	retaddr		)

You can't delete the retaddr without breaking user space.

Please keep that here.

Thanks,

-- Steve

> +		__dynamic_array(unsigned long,	args				)
>  	),
>  
>  	F_printk("--> %ps (%u) <- %ps", (void *)__entry->func, __entry->depth,
> -		(void *)__entry->retaddr)
> +		(void *)__entry->args[0])
>  );
>  
