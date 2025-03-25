Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A28619F422;
	Tue, 25 Mar 2025 21:56:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742939769; cv=none; b=q7s1Sw69gOj8yIm8Sp+2uXUDgl2A1YChBqonANB082AQVgCqDaPgogLcCJzQJEWcjate6DqqC1AFodldr0Db7Fh24E0bUpen6sEAd8bFIlXj7pup2cM6UeNSlwWbMa8iBl1UhhGgeltFeK6hncepfX7chkBAl4o8si47UHBxe2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742939769; c=relaxed/simple;
	bh=4ifqJtJbofI2xLx93Gi3OwiRVjusXlxOWrfih4v8Wx0=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=Vsj9DMVrOjqt3yfa6XRZyEnaaRlNWpDhDKz1uG649p7NbLQC5crNG/7zXa1uA3pN5j6aO2ruGYgs7jUtlsMw42P/Hcn2cTV9uNO/5Vcm9CDGHfdEHvsH3z+oZikTpBmWfJBGZxOQDKQi7/8YDd7RSlxmwoIOv/ip5ncuZqi2aYQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=osfpcF8m; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="osfpcF8m"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63E57C4CEE4;
	Tue, 25 Mar 2025 21:56:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742939768;
	bh=4ifqJtJbofI2xLx93Gi3OwiRVjusXlxOWrfih4v8Wx0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=osfpcF8mgWVyiLLi5K63WAeLkrFeSyjo4rT7SwqsSViUuKfo556CizgofpP5aPuNE
	 XemItG9Z6Uuo3abMDrgowCyf7NBr1LPUNsfHp6tK4p+cKAWZOGBXr5Uz5N2A/V4ZX0
	 uTnPgpSZqyphORrQONuqpkjhE+ceRhFrjG1EoDWJClT3LO0RhBfPzj9Tc6MRJOZguj
	 VF3Ck0xO56gCDFo+ixGHqiyW94R5fXxvjCi+9d6IGu/nDcjNn8XWUiqSK8ETBXoqLP
	 QSkCZhDFr4gi2XwAMILcCXMfAt6zozVs3zgfYFqKPTOc4kz9Y3vghEPZy0t+JPTRF/
	 tYzYZA3JwixMQ==
Date: Wed, 26 Mar 2025 06:56:05 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH 3/4] tracing: fprobe-events: Register fprobe-events only
 when it is enabled
Message-Id: <20250326065605.f2ba50780414fb9ba1110ab5@kernel.org>
In-Reply-To: <20250325144111.48fc4ec3@gandalf.local.home>
References: <174212767109.348872.18231451508464729427.stgit@devnote2>
	<174212770238.348872.12106623852892827796.stgit@devnote2>
	<20250325144111.48fc4ec3@gandalf.local.home>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 25 Mar 2025 14:41:11 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> On Sun, 16 Mar 2025 21:21:42 +0900
> "Masami Hiramatsu (Google)" <mhiramat@kernel.org> wrote:
> 
> > From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> > 
> > Currently fprobe events are registered when it is defined. Thus it will
> > give some overhead even if it is disabled. This changes it to register the
> > fprobe only when it is enabled.
> > 
> > Suggested-by: Steven Rostedt <rostedt@goodmis.org>
> > Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> > ---
> >  include/linux/fprobe.h      |    8 +
> >  kernel/trace/fprobe.c       |   29 +++--
> >  kernel/trace/trace_fprobe.c |  234 +++++++++++++++++++++----------------------
> >  3 files changed, 140 insertions(+), 131 deletions(-)
> > 
> > diff --git a/include/linux/fprobe.h b/include/linux/fprobe.h
> > index 702099f08929..9635a24d5a25 100644
> > --- a/include/linux/fprobe.h
> > +++ b/include/linux/fprobe.h
> > @@ -94,6 +94,8 @@ int register_fprobe_ips(struct fprobe *fp, unsigned long *addrs, int num);
> >  int register_fprobe_syms(struct fprobe *fp, const char **syms, int num);
> >  int unregister_fprobe(struct fprobe *fp);
> >  bool fprobe_is_registered(struct fprobe *fp);
> > +int fprobe_alloc_ip_list_from_filter(const char *filter, const char *notfilter,
> > +	unsigned long **addrs);
> >  #else
> >  static inline int register_fprobe(struct fprobe *fp, const char *filter, const char *notfilter)
> >  {
> > @@ -115,6 +117,12 @@ static inline bool fprobe_is_registered(struct fprobe *fp)
> >  {
> >  	return false;
> >  }
> > +static inline int fprobe_alloc_ip_list_from_filter(const char *filter,
> > +						   const char *notfilter,
> > +						   unsigned long **addrs)
> > +{
> > +	return -EOPNOTSUPP;
> > +}
> >  #endif
> >  
> >  /**
> > diff --git a/kernel/trace/fprobe.c b/kernel/trace/fprobe.c
> > index 33082c4e8154..05050f1c2239 100644
> > --- a/kernel/trace/fprobe.c
> > +++ b/kernel/trace/fprobe.c
> > @@ -486,6 +486,24 @@ static int ip_list_from_filter(const char *filter, const char *notfilter,
> >  	return match.index ?: -ENOENT;
> >  }
> >  
> > +#define FPROBE_IPS_MAX	INT_MAX
> > +
> > +int fprobe_alloc_ip_list_from_filter(const char *filter, const char *notfilter,
> > +				     unsigned long **addrs)
> > +{
> > +	int ret;
> > +
> > +	/* Count the number of ips from filter. */
> > +	ret = ip_list_from_filter(filter, notfilter, NULL, FPROBE_IPS_MAX);
> > +	if (ret < 0)
> > +		return ret;
> > +
> > +	*addrs = kcalloc(ret, sizeof(unsigned long), GFP_KERNEL);
> > +	if (!*addrs)
> > +		return -ENOMEM;
> > +	return ip_list_from_filter(filter, notfilter, *addrs, ret);
> 
> This was in the old code, but I'm wondering. Does this code prevent modules
> from being loaded and unloaded too?

Ah, no. In that case we should do module_get() for each module
found in module_kallsyms_on_each_symbol(), hmm.

> 
> I'm asking because if we call the first instance of ip_list_from_filter()
> and it finds a list of functions from a module, and then that module is
> unloaded, the ip_list_from_filter() will return a failure, and *addrs would
> be a memory leak.

Good catch! Let me fix it.

Thanks,

> 
> -- Steve
> 
> > +}
> > +
> >  static void fprobe_fail_cleanup(struct fprobe *fp)
> >  {
> >  	kfree(fp->hlist_array);
> > @@ -528,8 +546,6 @@ static int fprobe_init(struct fprobe *fp, unsigned long *addrs, int num)
> >  	return 0;
> >  }
> >  
> > -#define FPROBE_IPS_MAX	INT_MAX
> > -
> >  /**
> >   * register_fprobe() - Register fprobe to ftrace by pattern.
> >   * @fp: A fprobe data structure to be registered.
> > @@ -549,14 +565,7 @@ int register_fprobe(struct fprobe *fp, const char *filter, const char *notfilter
> >  	if (!fp || !filter)
> >  		return -EINVAL;
> >  
> > -	ret = ip_list_from_filter(filter, notfilter, NULL, FPROBE_IPS_MAX);
> > -	if (ret < 0)
> > -		return ret;
> > -
> > -	addrs = kcalloc(ret, sizeof(unsigned long), GFP_KERNEL);
> > -	if (!addrs)
> > -		return -ENOMEM;
> > -	ret = ip_list_from_filter(filter, notfilter, addrs, ret);
> > +	ret = fprobe_alloc_ip_list_from_filter(filter, notfilter, &addrs);
> >  	if (ret > 0)
> >  		ret = register_fprobe_ips(fp, addrs, ret);
> >  


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
