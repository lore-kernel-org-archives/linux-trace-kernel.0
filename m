Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFA14157470
	for <linux-trace-kernel@vger.kernel.org>; Mon,  6 May 2024 17:25:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715016311; cv=none; b=mI+ksswyGJGFG3XTvbUyOTgLdnM+u29rMpp5L8dhnusQ+xkIrVyDlMav963ATCMFt8yDRJmkB8VnTrtfOopyCIrDTf/MBTHxdwMig52AWFXXhGcbWI1XsizHNujVQYTxaZk658FVgB79R07GF1L3dFUKaLnETy890He1s0LfOVY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715016311; c=relaxed/simple;
	bh=q1F+2U0V4hbsG8/qeEht+opLJBidg58ABt/24aM5rwo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WMwkiIJaMKiR8pY5jJPL/aL2ndpRB4Nn4FxPA3XwdD5IllaJUj4NRpXMVf5IaOiT3UUG985labnKmBvYCzebp2XxsCMW93uv8z5LLxloPIAOAB6XiHK9zoWtjdQZowQS2BI0uRDsUB+YiHqVNvUmKTpKmN77GZ9GkIYP+cxBu8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E035AC116B1;
	Mon,  6 May 2024 17:25:09 +0000 (UTC)
Date: Mon, 6 May 2024 13:25:15 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: "Dr. David Alan Gilbert" <dave@treblig.org>
Cc: linux-trace-kernel@vger.kernel.org
Subject: Re: ftrace_direct_func_count ?
Message-ID: <20240506132515.11754794@gandalf.local.home>
In-Reply-To: <ZjY5np4coyMk4ijJ@gallifrey>
References: <ZjY5np4coyMk4ijJ@gallifrey>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 4 May 2024 13:35:26 +0000
"Dr. David Alan Gilbert" <dave@treblig.org> wrote:

> Hi,
>   I've just posted a patch 'ftrace: Remove unused list 'ftrace_direct_funcs''
> that clears out some old code, but while at it I noticed the global
> 'ftrace_direct_func_count'.
> 
> As far as I can tell, it's never assigned (or initialised) but it is tested:
> 
> kernel/trace/fgraph.c:
> #ifndef CONFIG_HAVE_DYNAMIC_FTRACE_WITH_ARGS
>   /*
>    * Skip graph tracing if the return location is served by direct trampoline,
>    * since call sequence and return addresses are unpredictable anyway.
>    * Ex: BPF trampoline may call original function and may skip frame
>    * depending on type of BPF programs attached.
>    */
>   if (ftrace_direct_func_count &&
>       ftrace_find_rec_direct(ret - MCOUNT_INSN_SIZE))
>     return -EBUSY;
> #endif
> 
> So I wasn't sure whether it was just safe to nuke that section
> or whether it really needed fixing?

Yes, after commit 8788ca164eb4bad ("ftrace: Remove the legacy
_ftrace_direct API") that variable is no longer used.

-- Steve
