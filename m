Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 790DD190679;
	Tue, 25 Mar 2025 18:40:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742928028; cv=none; b=VVLo5E2r0tPpL0xsDOzS3/5GD7xnRwHNdq/NVg/OApeadyxiZ86ErARd55dwfKsix6HZ6sIdD2+45mt2PI9SnPLqgPs3V+2YT3cbrMliuZtG98wEoioRSqYW4m2gaQSkcplslTmWJt8ufbEptAvXyET73Zc0ouBlzHSpgoROSXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742928028; c=relaxed/simple;
	bh=MLk+dsT0FjWvcnVOCjx4fsC4BnHgimBM0JuFTMio7co=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FdNCjnYNZKuLo6dPGUoZ5BK8fYBkN5qe9PWxWoJIG6qUQvOAD8dxUlZxQHHh/fBoZl92GPm4YQluyYtzIMHLxQxaS/MQHz25k+7NuLYsrsOeyfG8Wy7Iw/4CUncJ6MUoIF28IWOYTpR7Uw+yJfskfYJ7J9PyUnmCQce1ezsibQQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62A05C4CEE4;
	Tue, 25 Mar 2025 18:40:27 +0000 (UTC)
Date: Tue, 25 Mar 2025 14:41:11 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH 3/4] tracing: fprobe-events: Register fprobe-events only
 when it is enabled
Message-ID: <20250325144111.48fc4ec3@gandalf.local.home>
In-Reply-To: <174212770238.348872.12106623852892827796.stgit@devnote2>
References: <174212767109.348872.18231451508464729427.stgit@devnote2>
	<174212770238.348872.12106623852892827796.stgit@devnote2>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 16 Mar 2025 21:21:42 +0900
"Masami Hiramatsu (Google)" <mhiramat@kernel.org> wrote:

> From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> 
> Currently fprobe events are registered when it is defined. Thus it will
> give some overhead even if it is disabled. This changes it to register the
> fprobe only when it is enabled.
> 
> Suggested-by: Steven Rostedt <rostedt@goodmis.org>
> Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> ---
>  include/linux/fprobe.h      |    8 +
>  kernel/trace/fprobe.c       |   29 +++--
>  kernel/trace/trace_fprobe.c |  234 +++++++++++++++++++++----------------------
>  3 files changed, 140 insertions(+), 131 deletions(-)
> 
> diff --git a/include/linux/fprobe.h b/include/linux/fprobe.h
> index 702099f08929..9635a24d5a25 100644
> --- a/include/linux/fprobe.h
> +++ b/include/linux/fprobe.h
> @@ -94,6 +94,8 @@ int register_fprobe_ips(struct fprobe *fp, unsigned long *addrs, int num);
>  int register_fprobe_syms(struct fprobe *fp, const char **syms, int num);
>  int unregister_fprobe(struct fprobe *fp);
>  bool fprobe_is_registered(struct fprobe *fp);
> +int fprobe_alloc_ip_list_from_filter(const char *filter, const char *notfilter,
> +	unsigned long **addrs);
>  #else
>  static inline int register_fprobe(struct fprobe *fp, const char *filter, const char *notfilter)
>  {
> @@ -115,6 +117,12 @@ static inline bool fprobe_is_registered(struct fprobe *fp)
>  {
>  	return false;
>  }
> +static inline int fprobe_alloc_ip_list_from_filter(const char *filter,
> +						   const char *notfilter,
> +						   unsigned long **addrs)
> +{
> +	return -EOPNOTSUPP;
> +}
>  #endif
>  
>  /**
> diff --git a/kernel/trace/fprobe.c b/kernel/trace/fprobe.c
> index 33082c4e8154..05050f1c2239 100644
> --- a/kernel/trace/fprobe.c
> +++ b/kernel/trace/fprobe.c
> @@ -486,6 +486,24 @@ static int ip_list_from_filter(const char *filter, const char *notfilter,
>  	return match.index ?: -ENOENT;
>  }
>  
> +#define FPROBE_IPS_MAX	INT_MAX
> +
> +int fprobe_alloc_ip_list_from_filter(const char *filter, const char *notfilter,
> +				     unsigned long **addrs)
> +{
> +	int ret;
> +
> +	/* Count the number of ips from filter. */
> +	ret = ip_list_from_filter(filter, notfilter, NULL, FPROBE_IPS_MAX);
> +	if (ret < 0)
> +		return ret;
> +
> +	*addrs = kcalloc(ret, sizeof(unsigned long), GFP_KERNEL);
> +	if (!*addrs)
> +		return -ENOMEM;
> +	return ip_list_from_filter(filter, notfilter, *addrs, ret);

This was in the old code, but I'm wondering. Does this code prevent modules
from being loaded and unloaded too?

I'm asking because if we call the first instance of ip_list_from_filter()
and it finds a list of functions from a module, and then that module is
unloaded, the ip_list_from_filter() will return a failure, and *addrs would
be a memory leak.

-- Steve

> +}
> +
>  static void fprobe_fail_cleanup(struct fprobe *fp)
>  {
>  	kfree(fp->hlist_array);
> @@ -528,8 +546,6 @@ static int fprobe_init(struct fprobe *fp, unsigned long *addrs, int num)
>  	return 0;
>  }
>  
> -#define FPROBE_IPS_MAX	INT_MAX
> -
>  /**
>   * register_fprobe() - Register fprobe to ftrace by pattern.
>   * @fp: A fprobe data structure to be registered.
> @@ -549,14 +565,7 @@ int register_fprobe(struct fprobe *fp, const char *filter, const char *notfilter
>  	if (!fp || !filter)
>  		return -EINVAL;
>  
> -	ret = ip_list_from_filter(filter, notfilter, NULL, FPROBE_IPS_MAX);
> -	if (ret < 0)
> -		return ret;
> -
> -	addrs = kcalloc(ret, sizeof(unsigned long), GFP_KERNEL);
> -	if (!addrs)
> -		return -ENOMEM;
> -	ret = ip_list_from_filter(filter, notfilter, addrs, ret);
> +	ret = fprobe_alloc_ip_list_from_filter(filter, notfilter, &addrs);
>  	if (ret > 0)
>  		ret = register_fprobe_ips(fp, addrs, ret);
>  
