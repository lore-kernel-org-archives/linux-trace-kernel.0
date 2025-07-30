Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D5882D9EF8;
	Wed, 30 Jul 2025 13:57:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753883848; cv=none; b=YwgLO9CiyVl//n8ry9Yh5qcuv2O6rkEs+wC8jAY0lPC/jcVqYCiM1TR0mX2seXY7stUe8OShniQCYipljR3bRUhrLdAFMbbPinsQlLcdODLW9P2UkMB19y7+lMRBuBFu8f/iNUBf/4IFKHgDjucTv00WIT2BvVzV8DaUQ7cicjk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753883848; c=relaxed/simple;
	bh=JA07ZI7KstV+Tv5KxzbLM2UL0i9UfNUTw3ZAdpaDeHE=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=Z2vYx12RtT/jSnGWzZI+xO5A+3lAEAZPnccCDmjbaPymaiNc91rPD9E36Z0dwlvOVvkNuGkaRl5Ofa9vK+mEzHGlQAb0gkuuZmRm+WGKgg+F+fQOyGkn6jHpBCeN+GvQEtBEizeKs6fpnh1VYnoC/ZJXXoSyDJEv9d5MbQahVJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IlcCrv2I; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IlcCrv2I"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 680CAC4CEE3;
	Wed, 30 Jul 2025 13:57:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753883848;
	bh=JA07ZI7KstV+Tv5KxzbLM2UL0i9UfNUTw3ZAdpaDeHE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=IlcCrv2IwsieOCCkD0nyxBFZTqN8qBdFPnXa36F9WnZopnckl2WvGCoEiiDhS2ryY
	 hYRyqomh352HnUtEUQsWSZI9YKJGw4xlR+q2NhzKU/0RWOUuMdllNjgK+3v6OtXVB4
	 QQwYmLneRmQp/iionec/qXW6TFheSEA3S8YGlSE8vxG0kdLQeBHPE0icTmc+OHG3gJ
	 vLwhMgQ2paCpyxbQ9bc5E2viSDAaRpbrm9NeB/hN0wHjgnqtwGmJeLtHDO9MczebED
	 eA+r1/RJ1uGbGsm4tYR9f1VHAJ1HyOLTB3BHyQM+95bjEhCwTr1peZ0GrwLxUuOTnP
	 VODxAkHvqe/Gg==
Date: Wed, 30 Jul 2025 22:57:22 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: kernel test robot <lkp@intel.com>, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
 oe-kbuild-all@lists.linux.dev, Mark Rutland <mark.rutland@arm.com>, Mathieu
 Desnoyers <mathieu.desnoyers@efficios.com>, Andrew Morton
 <akpm@linux-foundation.org>, Linux Memory Management List
 <linux-mm@kvack.org>, Namhyung Kim <namhyung@kernel.org>, Jonathan Corbet
 <corbet@lwn.net>, Randy Dunlap <rdunlap@infradead.org>
Subject: Re: [PATCH v2 1/2] tracing: Have eprobes have their own config
 option
Message-Id: <20250730225722.c88d2dbd3dfa07310de7edd4@kernel.org>
In-Reply-To: <20250730091727.7b3a8b96@gandalf.local.home>
References: <20250729161912.056641407@kernel.org>
	<202507301452.JPAcMvT0-lkp@intel.com>
	<20250730191101.7e6203f21b94c3f932fa8348@kernel.org>
	<20250730091727.7b3a8b96@gandalf.local.home>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 30 Jul 2025 09:17:27 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> On Wed, 30 Jul 2025 19:11:01 +0900
> Masami Hiramatsu (Google) <mhiramat@kernel.org> wrote:
> 
> > Interesting, this find another issue. Since this is provided by
> > CONFIG_PROBE_EVENTS, we need to fix CONFIG_PROBE_EVENTS depending
> > on HAVE_REGS_AND_STACK_ACCESS_API.
> > 
> > diff --git a/kernel/trace/Kconfig b/kernel/trace/Kconfig
> > index a3f35c7d83b6..cd239240b0ef 100644
> > --- a/kernel/trace/Kconfig
> > +++ b/kernel/trace/Kconfig
> > @@ -792,6 +792,7 @@ config DYNAMIC_EVENTS
> >         def_bool n
> >  
> >  config PROBE_EVENTS
> > +       depends on HAVE_REGS_AND_STACK_ACCESS_API
> >         def_bool n
> >  
> >  config BPF_KPROBE_OVERRIDE
> 
> OK, I'll send a v2.
> 
> Did you want to take this in the tracing pull request?
> 
> I see you already did the probe pull request.

Ah, I thought this was for the next one... (but I think it is a kind of bugfix?)

Thank you,

> 
> -- Steve


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
