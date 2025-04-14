Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9178185260;
	Mon, 14 Apr 2025 23:42:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744674136; cv=none; b=ST5oZpMQUzk+RDY/SDBTtaCZTwtIvFTa4+XoI15y058JD36IMehkh9N540vrn9YZNKZ+bj70DfAep3tTwi0LLC1uqn9zVedBEXfPnHPWzOv1FdsI9PDh0jHZN10/+K6vyjiSeeEzdBABCPAn3eqndKwfmlydjkyYz29qPsT6LCY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744674136; c=relaxed/simple;
	bh=24Ez7NwKTbJPPhlgSQ7VmP1wM1mGec1z7GcqdMf68WA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Yz9n4bLnFBVSKaAAmQg5e41MftfIr0R8CRWTOYzVCuwyaK2n/otzW95wGaq6qgGGlOGLd7wCQPuB/Ymw2i5xlq5l/FT3fipZ1QQPxL6x02xFr+XXtCQHxK7C9lmWhmCEvYlkCw8Zy2ObM46ONU1h4g58g0O4gsHi6ZjZfUSyPl0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8835AC4CEE2;
	Mon, 14 Apr 2025 23:42:14 +0000 (UTC)
Date: Mon, 14 Apr 2025 19:43:46 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Dave Hansen <dave.hansen@intel.com>
Cc: Junxuan Liao <ljx@cs.wisc.edu>, linux-trace-kernel@vger.kernel.org,
 linux-kernel@vger.kernel.org, x86@kernel.org, Thomas Gleixner
 <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov
 <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, "H. Peter Anvin"
 <hpa@zytor.com>, Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, "Paul E. McKenney" <paulmck@kernel.org>
Subject: Re: [PATCH] x86/tracing: introduce enter/exit tracepoint pairs for
 page faults
Message-ID: <20250414194346.060f96c6@gandalf.local.home>
In-Reply-To: <d64ec287-c85e-4b50-beac-4517462882f6@intel.com>
References: <e7d4cd81-c0a5-446c-95d2-6142d660c15b@cs.wisc.edu>
	<214abd94-7fb3-4515-a1ae-a60abe81af88@intel.com>
	<a40a1add-00a5-49bd-887a-5fc722c9814a@cs.wisc.edu>
	<41e7d947-d59f-41a9-a540-d3c07e4678c4@cs.wisc.edu>
	<d64ec287-c85e-4b50-beac-4517462882f6@intel.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 14 Apr 2025 16:37:19 -0700
Dave Hansen <dave.hansen@intel.com> wrote:

> On 4/14/25 16:22, Junxuan Liao wrote:
> > On 4/14/25 6:14 PM, Junxuan Liao wrote:  
> >> Do people find separate user/kernel tracepoints useful? For me, I can
> >> check regs in eBPF tracing code instead.  
> > I think it might be good to add a field to the tracepoints to indicate
> > whether it's in user space or not.  
> 
> Sounds sane to me.  Doing something like this:
> 
>         TP_STRUCT__entry(
>                 __field(                unsigned long, address  )
>                 __field(                unsigned long, ip       )
> +               __field(                bool	     , user_mode)
>                 __field(                unsigned long, error_code )
>         ),
> 
>         TP_fast_assign(
>                  __entry->address = address;
>                  __entry->ip         = regs->ip;
> +                __entry->user_mode  = user_mode(regs);
>                  __entry->error_code = error_code;
>         ),
> 
> seems highly superior to having two sets of tracepoints and static keys.

I agree.

Acked-by: Steven Rostedt (Google) <rostedt@goodmis.org>

-- Steve
