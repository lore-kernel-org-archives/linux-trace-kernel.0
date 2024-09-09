Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31F5319BB7;
	Mon,  9 Sep 2024 15:21:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725895291; cv=none; b=RjuibYUX0UZJgHkLcjtB8doAuiBtyx/Gb10jAZjw8W55gDM9JHYD7I63I6zyOJfvl2JewcthyvrbonjCW1unmuTapj0nn1xGgPsU1P9655g7HBDiRVqU5+FWCgqlS6ZZJtj8FVywQz/A4x/cTqbaVbMRzqFRURuLkvbiBryj/wM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725895291; c=relaxed/simple;
	bh=COzQ/oS7+1JjRZqIPqwY8OXRbgsgvP0vVffowZODf/U=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aR+jtTorBJp4hz46JTPr3nVxmnhla8NBGQNy/0a7aUnrVHWnkJshdKVPaO+XUhRjauc8iGJwmzyPZMOknpkc0Vp2bniFgXDUbtXz1rb+l6TMrvc1aYRuXN0Yk1etqVKxWonzPxNgMiNDjR0ewF3Zx2iCngdNr4idJm2SVpCKeqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7DCCDC4CEC7;
	Mon,  9 Sep 2024 15:21:29 +0000 (UTC)
Date: Mon, 9 Sep 2024 11:21:27 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Arnd Bergmann <arnd@kernel.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Linus Torvalds
 <torvalds@linux-foundation.org>, Arnd Bergmann <arnd@arndb.de>, Mathieu
 Desnoyers <mathieu.desnoyers@efficios.com>, Daniel Bristot de Oliveira
 <bristot@kernel.org>, "Luis Claudio R. Goncalves" <lgoncalv@redhat.com>,
 Neeraj Upadhyay <neeraj.upadhyay@kernel.org>, Valentin Schneider
 <vschneid@redhat.com>, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH] tracing/timerlat: move interface_lock definition up
Message-ID: <20240909112127.6f2ea6e9@gandalf.local.home>
In-Reply-To: <20240909135344.76327-1-arnd@kernel.org>
References: <20240909135344.76327-1-arnd@kernel.org>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon,  9 Sep 2024 13:53:20 +0000
Arnd Bergmann <arnd@kernel.org> wrote:

> From: Arnd Bergmann <arnd@arndb.de>
> 
> The definition was previously moved into an #ifdef block by
> accident and now causes a build failure when CONFIG_TIMERLAT_TRACER
> is disabled:
> 
> In file included from include/linux/seqlock.h:19,
>                  from kernel/trace/trace_osnoise.c:20:
> kernel/trace/trace_osnoise.c: In function 'osnoise_sleep':
> kernel/trace/trace_osnoise.c:1631:21: error: 'interface_lock' undeclared (first use in this function); did you mean 'trace_clock'?
>  1631 |         mutex_lock(&interface_lock);
>       |                     ^~~~~~~~~~~~~~
> 
> Move it up some more to be outside of that #ifdef again.

Thanks, but for some reason I never got your email. I only noticed this
from Patchwork, and I'm replying via lore.

I also fixed it due to someone else reporting the bug. I'm currently
running mine through my tests, although it is the exact same change as yours.

  https://lore.kernel.org/linux-trace-kernel/20240909103231.23a289e2@gandalf.local.home/

-- Steve


> 
> Fixes: e6a53481da29 ("tracing/timerlat: Only clear timer if a kthread exists")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
> It looks like the regression already made it into 6.11-rc7 as
> part of
> https://lore.kernel.org/lkml/20240905172827.6a64cf97@gandalf.local.home/
> so this fixup (if correct) is needed for 6.11 as well
> ---
>  kernel/trace/trace_osnoise.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/kernel/trace/trace_osnoise.c b/kernel/trace/trace_osnoise.c
> index 20c6660762a3..acfd57689af6 100644
> --- a/kernel/trace/trace_osnoise.c
> +++ b/kernel/trace/trace_osnoise.c
> @@ -228,6 +228,11 @@ static inline struct osnoise_variables *this_cpu_osn_var(void)
>  	return this_cpu_ptr(&per_cpu_osnoise_var);
>  }
>  
> +/*
> + * Protect the interface.
> + */
> +static struct mutex interface_lock;
> +
>  #ifdef CONFIG_TIMERLAT_TRACER
>  /*
>   * Runtime information for the timer mode.
> @@ -252,11 +257,6 @@ static inline struct timerlat_variables *this_cpu_tmr_var(void)
>  	return this_cpu_ptr(&per_cpu_timerlat_var);
>  }
>  
> -/*
> - * Protect the interface.
> - */
> -static struct mutex interface_lock;
> -
>  /*
>   * tlat_var_reset - Reset the values of the given timerlat_variables
>   */

