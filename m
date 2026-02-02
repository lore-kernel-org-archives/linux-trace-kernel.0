Received: from relay.hostedemail.com (smtprelay0014.hostedemail.com [216.40.44.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 864BC38945D;
	Mon,  2 Feb 2026 17:59:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770055181; cv=none; b=Hb0Z76BzAY9X1NARe6uplN5NwJtlR6A9CzWHt3Nmz0tKdDv5fzIHJzSJLC4w57zXRrvAdGc0mN8dh4a3XEzhZR9v9YCK9ktZWjcW7mIi4TBLU6wO32+Pu5zx3nx4VJAS2xaZDbU3dKFHkRISYLfkGviwJlNUYGPPnUwD7j6scu8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770055181; c=relaxed/simple;
	bh=UplLe8vdSE1RGE2jttDPSJx2P29TJXbCmcXucSXUS/c=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=M/Pp4eowy+Qy0LO8/phDqsyTl5qf7bEwf2VTO7BgRCJwT19H8T/0c7D6QCR01GXEqGPEYIfJpa5uD7TQtMq6x/eA7/Ud+aBa2wUsuIm6AysMJq3Xk2FxJowBq1Jn23BW2vUjf2iieYkNacyIUpfseu+R1YCYyYjaLO1wVUMR7HY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf09.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay02.hostedemail.com (Postfix) with ESMTP id 5D0DA13A08D;
	Mon,  2 Feb 2026 17:59:37 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf09.hostedemail.com (Postfix) with ESMTPA id 3E1D420025;
	Mon,  2 Feb 2026 17:59:34 +0000 (UTC)
Date: Mon, 2 Feb 2026 12:59:59 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Arnd Bergmann <arnd@kernel.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Simon Horman <horms@kernel.org>,
 Jeff Layton <jlayton@kernel.org>, Anna Schumaker
 <anna.schumaker@oracle.com>, Chuck Lever <chuck.lever@oracle.com>, Arnd
 Bergmann <arnd@arndb.de>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Andrew Morton
 <akpm@linux-foundation.org>, Andy Shevchenko
 <andriy.shevchenko@linux.intel.com>, Randy Dunlap <rdunlap@infradead.org>,
 Yury Norov <ynorov@nvidia.com>, Joel Fernandes <joelagnelf@nvidia.com>,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH] tracing: remove __printf() attribute on
 __ftrace_vbprintk()
Message-ID: <20260202125959.49ce289f@gandalf.local.home>
In-Reply-To: <20260202095834.1328352-1-arnd@kernel.org>
References: <20260202095834.1328352-1-arnd@kernel.org>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 3E1D420025
X-Stat-Signature: dompomngpjn5xqfza3c6tnise6x4ad5o
X-Rspamd-Server: rspamout05
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX18UVFuNctC5jvMsSWfQBuFUD9tkvJuR2GQ=
X-HE-Tag: 1770055174-634833
X-HE-Meta: U2FsdGVkX197nBmnTWLcQ4TORyAlhsubvM0JQy5kbMtq96uuAQ5Hw8C7B0JbrF/Phazg3unfy3QtYT9j9LrAmeDULDYFBZrxJZn7j6UfwSlfqGyUpB4Wi/980TfWLD79Pr3ULFg/sTUtqPpDTbjh9WdYQBnJXIVzVqPd5mJUPpekLOPDqJzZf8+mcI1Sd2nCtP0H3yDgnb4Sl26uKHCfwk6a4tACzHr9bQZU+v9BzuqsMynv1z4cHVwGZkh82zO3SCQMJL+d+vUuuBtjWzoQXA37QgWjbOCXyeAGOM6RRL0qSHBsAKeIbb3lBVvW2WvLOhb7nrrIxwxly3UrSRJvlayoIMqXNIzKaOohxXtlP4kAIznpaW470POIb1mEvX7bdMuGrPoDfqtcdSVfrpt0iQ==

On Mon,  2 Feb 2026 10:58:27 +0100
Arnd Bergmann <arnd@kernel.org> wrote:

> From: Arnd Bergmann <arnd@arndb.de>
> 
> The sunrpc change to use trace_printk() for debugging caused
> a new warning for every instance of dprintk() in some configurations,
> when -Wformat-security is enabled:
> 
> fs/nfs/getroot.c: In function 'nfs_get_root':
> fs/nfs/getroot.c:90:17: error: format not a string literal and no format arguments [-Werror=format-security]
>    90 |                 nfs_errorf(fc, "NFS: Couldn't getattr on root");
> 
> I've been slowly chipping away at those warnings over time with the
> intention of enabling them by default in the future. While I could not
> figure out why this only happens for this one instance, I see that the
> __trace_bprintk() function is always called with a local variable as
> the format string, rather than a literal.
> 
> Remove the __printf(2,3) annotation on this function, as this is can
> only be validated for literals. The format strings still get checked
> because the underlying literal keeps getting passed into __trace_printk()
> in the "else" branch, which is not taken but still evaluated for
> compile-time warnings.
> 
> Fixes: ec7d8e68ef0e ("sunrpc: add a Kconfig option to redirect dfprintk() output to trace buffer")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Acked-by: Steven Rostedt (Google) <rostedt@goodmis.org>

-- Steve

> ---
>  include/linux/trace_printk.h | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/include/linux/trace_printk.h b/include/linux/trace_printk.h
> index bb5874097f24..2670ec7f4262 100644
> --- a/include/linux/trace_printk.h
> +++ b/include/linux/trace_printk.h
> @@ -107,7 +107,6 @@ do {									\
>  		__trace_printk(_THIS_IP_, fmt, ##args);			\
>  } while (0)
>  
> -extern __printf(2, 3)
>  int __trace_bprintk(unsigned long ip, const char *fmt, ...);
>  
>  extern __printf(2, 3)

