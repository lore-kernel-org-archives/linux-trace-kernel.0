Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 565291E885F;
	Thu, 10 Oct 2024 19:48:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728589714; cv=none; b=iDTupoffsgggkZS87q9OdpM5bohafWkNg/bN4TSXTgr80RQD+vZ3LDAbc1ptv++iqrQplpl1ZXQLkGLUPKQK2iRT7MI8Y2uRnf8xWtWURDavKT+yQqkouhv6ucAAxIKlb6wjSdCPN6acgBNYJRf/bM5LOMuUaQmveruuyduTY/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728589714; c=relaxed/simple;
	bh=F2HPyfn7AS7sxdWUgbKoi+uuw+6C/R/lmzaG67e9Seo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aVTtzOUI8mtnLRG5zx76nVkEQ/o4Jfit1XQsYr/fCSv/Gc6c1hDPCMpYO0aaVwhveuwcxtsAe5LCyp2vQBOCqLKG1ob0159Nxzu3GIQWO46N/zOxcKK2msZYTF0LH0XgfAIDNwmOcm1EWcqpOrzWg3qKkLJ9hvtn41oJy8ODfpc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85BC2C4CED5;
	Thu, 10 Oct 2024 19:48:32 +0000 (UTC)
Date: Thu, 10 Oct 2024 15:48:40 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Josh Poimboeuf <jpoimboe@kernel.org>
Cc: "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>, Helge
 Deller <deller@gmx.de>, linux-kernel@vger.kernel.org, Sven Schnelle
 <svens@stackframe.org>, linux-trace-kernel@vger.kernel.org,
 linux-parisc@vger.kernel.org, Masami Hiramatsu <mhiramat@kernel.org>, Mark
 Rutland <mark.rutland@arm.com>, Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH] parisc/ftrace: Fix function graph tracing disablement
Message-ID: <20241010154840.6e158c78@gandalf.local.home>
In-Reply-To: <5962b9e161b2b9296509c3d65c7f16c11b07bd16.1727904678.git.jpoimboe@kernel.org>
References: <5962b9e161b2b9296509c3d65c7f16c11b07bd16.1727904678.git.jpoimboe@kernel.org>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed,  2 Oct 2024 14:32:04 -0700
Josh Poimboeuf <jpoimboe@kernel.org> wrote:

> Due to an apparent copy-paste bug, the parisc implementation of
> ftrace_disable_ftrace_graph_caller() doesn't actually do anything.  It
> enables the (already-enabled) static key rather than disabling it.
> 
> The result is that after function graph tracing has been "disabled", any
> subsequent (non-graph) function tracing will inadvertently also enable
> the slow fgraph return address hijacking.
> 
> Fixes: 98f2926171ae ("parisc/ftrace: use static key to enable/disable function graph tracer")
> Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
> ---
>  arch/parisc/kernel/ftrace.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/parisc/kernel/ftrace.c b/arch/parisc/kernel/ftrace.c
> index c91f9c2e61ed..f8d08eab7db8 100644
> --- a/arch/parisc/kernel/ftrace.c
> +++ b/arch/parisc/kernel/ftrace.c
> @@ -87,7 +87,7 @@ int ftrace_enable_ftrace_graph_caller(void)
>  
>  int ftrace_disable_ftrace_graph_caller(void)
>  {
> -	static_key_enable(&ftrace_graph_enable.key);
> +	static_key_disable(&ftrace_graph_enable.key);
>  	return 0;
>  }
>  #endif

Awfully quite :-/

I wonder if anyone cares about parisc today?

Hmm.

-- Steve
