Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E81121D54D1;
	Mon,  6 Jan 2025 11:18:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736162300; cv=none; b=V90bhYcEsXDMhhcPwerEHg6DZdw4OQt7DkyA88ktBbC3H4Z8xMC7+L3LRQ/OgOSxHtULuTdMeJHQXZSmpZ/DHVf08Kt/8fn9qromcdaWuJg/wsAhS/kfoh4EYvRstaUZL7taocCIq7jN/1xWLmEVd5w13FQVkn6zpVdOmQOJiJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736162300; c=relaxed/simple;
	bh=gn7rNQ5nM+Nkm/gsoHRW+6gvFc4vHWW+pO6IFJUb7Q8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sEwudqz3nC+2FyZ4g3cc7QBz+iUNMfFwFlJDFH5yehQJbFWggc/MZQdhf75Y97Gsf5UnBpnNtJL9c2odhaM1VcZTbsYreiP5lukf9H0WYu2pV8mnqEpCKM3zbqfx5Qzyxzpc9c7sMpmeifhPO0Me2Or8FV1mkPERr19dI4/z+Ls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=jU1M0ySW; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="jU1M0ySW"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=Fprgz+aZ2auBmI3itVFYhJxZ5zqk7JkuQ0zdzEodny0=; b=jU1M0ySWqYpwKJtcwBGsjNsWfY
	SxpFJcURKf0CEiKulkwUS+sJr4F4AzAE+Gs73rfwUQuTMxm+vlZc+KBcVp4KxZgahCBSGzOb2giao
	ZMjVXf81Ln4LA7zQc3lb86OOiTz9VuWim3OSkSvoS6WckivYBXuEw56bcVYMDv458cPagxUfMKD/5
	uQXuu4seZOR3LOWlinST5KF22TcuT/3Xdlw6WvqF4gtJ9Sk1hu8jI4C9cLE27Ge8BuWPcy8Jhfp+M
	cgE5GStMcyLLX1XovN0yYTHVD6IZWHi/jnKNbcKfJWHiRkVzxAU8b5w7JNSEfjRS/Wn3mv1z2gJbk
	Tnw/v46Q==;
Received: from 77-249-17-89.cable.dynamic.v4.ziggo.nl ([77.249.17.89] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tUl7Z-00000007sHO-439C;
	Mon, 06 Jan 2025 11:18:10 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 2CD1D30063F; Mon,  6 Jan 2025 12:18:09 +0100 (CET)
Date: Mon, 6 Jan 2025 12:18:09 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Oleg Nesterov <oleg@redhat.com>
Cc: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>,
	"David S . Miller" <davem@davemloft.net>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Tzvetomir Stoyanov <tz.stoyanov@gmail.com>,
	Naveen N Rao <naveen@kernel.org>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Jason Baron <jbaron@akamai.com>, Ard Biesheuvel <ardb@kernel.org>,
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Subject: Re: DEFINE_FREE/CLASS && code readability (Was: [PATCH v2 2/6]
 Provide __free(argv) for argv_split() users)
Message-ID: <20250106111809.GA22191@noisy.programming.kicks-ass.net>
References: <173608125422.1253657.3732758016133408588.stgit@devnote2>
 <173608127627.1253657.12054758575695672674.stgit@devnote2>
 <20250105141422.GB23059@redhat.com>
 <20250106102647.GB20870@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250106102647.GB20870@noisy.programming.kicks-ass.net>

On Mon, Jan 06, 2025 at 11:26:48AM +0100, Peter Zijlstra wrote:
> On Sun, Jan 05, 2025 at 03:14:22PM +0100, Oleg Nesterov wrote:
> 
> > OK, so it can be used as
> > 
> > 	void func(void)
> > 	{
> > 		char **argv __free(argv) = argv_split(...);
> > 		do_something(argv);
> > 		return;
> > 	}
> > 
> > And I cry every time when I read the code like this ;)
> > 
> > Because, to understand this code, I need to do the "nontrivial" grep to find
> > "DEFINE_FREE(argv,".
> > 
> > Perhaps we can establish a simple rule that every DEFINE_FREE() or DEFINE_CLASS()
> > should add another #define? I mean something like
> > 
> > 
> > 	DEFINE_FREE(argv, char **, if (!IS_ERR_OR_NULL(_T)) argv_free(_T))
> > 	#define __FREE_ARGV	__free(argv)
> > 	
> > 	void func(void)
> > 	{
> > 		char **argv __FREE_ARGV = argv_split(...);
> > 		do_something(argv);
> > 		return;
> > 	}
> > 
> > This way I can press Ctrl-] and see what the cleanup code actually does.
> > Can save a second or two. Important when you try to read the code you are
> > not familiar with.
> 
> Right, so I've been playing with neovim and clangd (lsp), and I'm very
> disappointed to have to tell you that that also doesn't get it :-(
> 
> One thing we can and should do is something like:
> 
> diff --git a/scripts/tags.sh b/scripts/tags.sh
> index b21236377998..f01d694abe65 100755
> --- a/scripts/tags.sh
> +++ b/scripts/tags.sh
> @@ -212,6 +212,8 @@ regex_c=(
>  	'/^SEQCOUNT_LOCKTYPE(\([^,]*\),[[:space:]]*\([^,]*\),[^)]*)/seqcount_\2_init/'
>  	'/^\<DECLARE_IDTENTRY[[:alnum:]_]*([^,)]*,[[:space:]]*\([[:alnum:]_]\+\)/\1/'
>  	'/^\<DEFINE_IDTENTRY[[:alnum:]_]*([[:space:]]*\([[:alnum:]_]\+\)/\1/'
> +	'/^\<DEFINE_FREE(\([[:alnum:]_]\+\)/cleanup_\1/'
> +	'/^\<DEFINE_CLASS(\([[:alnum:]_]\+\)/class_\1/'
	/^\<EXTEND_CLASS(\([[:alnum:]_]\+\),[[:space:]]*\([[:alnum:]]\+\)/class_\1\2/'
	/^\<DEFINE_GUARD(\([[:alnum:]_]\+\)/class_\1/'
	/^\<DEFINE_GUARD_COND(\([[:alnum:]_]\+\),[[:space:]]*\([[:alnum:]]\+\)/class_\1\2/'
	/^\<DEFINE_LOCK_GUARD_[[:digit:]](\([[:alnum:]_]\+\)/class_\1/'
	/^\<DEFINE_LOCK_GUARD_[[:digit:]]_COND(\([[:alnum:]_]\+\),[[:space:]]*\([[:alnum:]]\+\)/class_\1\2/'

I suppose... not tested these
