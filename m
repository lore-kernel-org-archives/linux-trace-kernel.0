Received: from mx.treblig.org (mx.treblig.org [46.235.229.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F34128488;
	Mon,  6 May 2024 23:35:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.229.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715038556; cv=none; b=kF2k3zQKl7s6gTx5K+y9ATxltwFt8RSRlJr9PXt5u0P7IZN4iwe6M+gDFwKMZWxXTbGGL8QYbNdjgNL/bfxPorhd2aSGnsjhZMxHmHmsd4xFqy8e7B04Gq9R7YWX/NEgS98HSG9yWpO+xE9jmtzBVLY+m7LC43KzGdMGXAmjKbs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715038556; c=relaxed/simple;
	bh=tbRUo/ZY8tsnwsSYC8QlERsWU0wcW+Yqa99oMONVUvk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IpYb1PO7a9/FiX1SvjsM4/Uquo/0X7ROnfHDBZh+oX0IIKy0PleeCNn574EEP8xGdZYJNAyimAINvsoU6M7DQVkXut0pltXrqWIsStqPL41AiXQyYwUeqpUoYSVaO73fAYrd9TW5/9Izg08T2K9oJsjtPHZDUGsual2JKnX7HbA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org; spf=pass smtp.mailfrom=treblig.org; dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b=hGHbRpXd; arc=none smtp.client-ip=46.235.229.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=treblig.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b="hGHbRpXd"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
	; s=bytemarkmx; h=Content-Type:MIME-Version:Message-ID:Subject:From:Date:From
	:Subject; bh=B9J5PbkRZxuQ4xRn2oZUPk1RxNStO+E9RLxsDG6zlw8=; b=hGHbRpXdCM1xvaAf
	HLwpB74yydh3i205MGgGA4K5Y2zv85pZe1V3Bzz4aEecat2U9QJhLwpMT4SWJyQz6c8oX6wa0Gk87
	2PdXWzLDUW50sw/MtSK2k7KwNPN/FtCMo0+lw5mikrLqJ8XnDZCHd59EL9MGfMkcqTubP/X5cPbFY
	lG7Qn042gwirMiFd2ayKw8HVnPjK0DMaxRB3cpMLfL3Rcj9c5suiFIK617TtwQ1XCvdiaKSZrSHR7
	Or6amqk86XYnCSyVaFJlnFJuiW/YO1QSYmQIYgXF8RokRZhvw5j1xmDt4W3+GHxOUCloDHVBEjF8X
	Aib3lBIR7xkpwnFJWA==;
Received: from dg by mx.treblig.org with local (Exim 4.96)
	(envelope-from <dg@treblig.org>)
	id 1s47s6-0051XU-2v;
	Mon, 06 May 2024 23:35:50 +0000
Date: Mon, 6 May 2024 23:35:50 +0000
From: "Dr. David Alan Gilbert" <linux@treblig.org>
To: rostedt@goodmis.org, mhiramat@kernel.org
Cc: linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ftrace: Remove unused global 'ftrace_direct_func_count'
Message-ID: <ZjlpVueeKcocCFAf@gallifrey>
References: <20240506233305.215735-1-linux@treblig.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20240506233305.215735-1-linux@treblig.org>
X-Chocolate: 70 percent or better cocoa solids preferably
X-Operating-System: Linux/6.1.0-17-amd64 (x86_64)
X-Uptime: 23:35:28 up 125 days,  2:25,  1 user,  load average: 0.02, 0.01,
 0.00
User-Agent: Mutt/2.2.12 (2023-09-09)

* linux@treblig.org (linux@treblig.org) wrote:
> From: "Dr. David Alan Gilbert" <linux@treblig.org>
> 
> Commit 8788ca164eb4b ("ftrace: Remove the legacy _ftrace_direct API")
> stopped setting the 'ftrace_direct_func_count' variable, but left
> it around.  Clean it up.
> 
> Signed-off-by: Dr. David Alan Gilbert <linux@treblig.org>

FYI this is on top of my earlier 'ftrace: Remove unused list 'ftrace_direct_funcs'

Dave

> ---
>  include/linux/ftrace.h |  2 --
>  kernel/trace/fgraph.c  | 11 -----------
>  kernel/trace/ftrace.c  |  1 -
>  3 files changed, 14 deletions(-)
> 
> diff --git a/include/linux/ftrace.h b/include/linux/ftrace.h
> index b01cca36147ff..e3a83ebd1b333 100644
> --- a/include/linux/ftrace.h
> +++ b/include/linux/ftrace.h
> @@ -413,7 +413,6 @@ struct ftrace_func_entry {
>  };
>  
>  #ifdef CONFIG_DYNAMIC_FTRACE_WITH_DIRECT_CALLS
> -extern int ftrace_direct_func_count;
>  unsigned long ftrace_find_rec_direct(unsigned long ip);
>  int register_ftrace_direct(struct ftrace_ops *ops, unsigned long addr);
>  int unregister_ftrace_direct(struct ftrace_ops *ops, unsigned long addr,
> @@ -425,7 +424,6 @@ void ftrace_stub_direct_tramp(void);
>  
>  #else
>  struct ftrace_ops;
> -# define ftrace_direct_func_count 0
>  static inline unsigned long ftrace_find_rec_direct(unsigned long ip)
>  {
>  	return 0;
> diff --git a/kernel/trace/fgraph.c b/kernel/trace/fgraph.c
> index c83c005e654e3..a130b2d898f7c 100644
> --- a/kernel/trace/fgraph.c
> +++ b/kernel/trace/fgraph.c
> @@ -125,17 +125,6 @@ int function_graph_enter(unsigned long ret, unsigned long func,
>  {
>  	struct ftrace_graph_ent trace;
>  
> -#ifndef CONFIG_HAVE_DYNAMIC_FTRACE_WITH_ARGS
> -	/*
> -	 * Skip graph tracing if the return location is served by direct trampoline,
> -	 * since call sequence and return addresses are unpredictable anyway.
> -	 * Ex: BPF trampoline may call original function and may skip frame
> -	 * depending on type of BPF programs attached.
> -	 */
> -	if (ftrace_direct_func_count &&
> -	    ftrace_find_rec_direct(ret - MCOUNT_INSN_SIZE))
> -		return -EBUSY;
> -#endif
>  	trace.func = func;
>  	trace.depth = ++current->curr_ret_depth;
>  
> diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
> index b18b4ece3d7c9..adf34167c3418 100644
> --- a/kernel/trace/ftrace.c
> +++ b/kernel/trace/ftrace.c
> @@ -2538,7 +2538,6 @@ ftrace_find_unique_ops(struct dyn_ftrace *rec)
>  /* Protected by rcu_tasks for reading, and direct_mutex for writing */
>  static struct ftrace_hash __rcu *direct_functions = EMPTY_HASH;
>  static DEFINE_MUTEX(direct_mutex);
> -int ftrace_direct_func_count;
>  
>  /*
>   * Search the direct_functions hash to see if the given instruction pointer
> -- 
> 2.45.0
> 
-- 
 -----Open up your eyes, open up your mind, open up your code -------   
/ Dr. David Alan Gilbert    |       Running GNU/Linux       | Happy  \ 
\        dave @ treblig.org |                               | In Hex /
 \ _________________________|_____ http://www.treblig.org   |_______/
