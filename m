Received: from relay.hostedemail.com (smtprelay0010.hostedemail.com [216.40.44.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2E6E299A8E;
	Mon, 17 Nov 2025 16:31:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763397108; cv=none; b=VkSM8crAosZe/+bOJUw9NSGPWZB3kxJsKUKFZog/7VxSwiFxNCoX/xgzyOoNTUaee/kCHQ3mh1uwS+JHEkHfO+TAkc0S7wA5HOwBgtFCwwWsGXK98XbsYHuOGKF90mqJ1uaJyZ9+QPtG93Cv19CXr1q7Hlr0h5FU6Ic+R1lMtgw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763397108; c=relaxed/simple;
	bh=vWgq+ozhptW8Si7+L8ooNbT5mEY0Jah0jxy8qf5V9K0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=b+Db8L6muJZN4amSNKthfxp7YzQEyy571cEg0d9e8fTdrcgUG5qdhRHOtn8geOSOj9ANeNWbMTkpXn3FJlICy4u8p87HRy6GSjSRPaDSQOKkWi5SSxKtNT6VqFbZKLeGU2thceWpsAdIuwBqIapHftuZhrsu4ZPDX9jS3PeZ3EU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf01.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay05.hostedemail.com (Postfix) with ESMTP id C3F6B57119;
	Mon, 17 Nov 2025 16:31:38 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf01.hostedemail.com (Postfix) with ESMTPA id 986B060011;
	Mon, 17 Nov 2025 16:31:36 +0000 (UTC)
Date: Mon, 17 Nov 2025 11:32:01 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Steven Rostedt <rostedt@kernel.org>, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH v4 1/3] tracing: Have tracer option be instance specific
Message-ID: <20251117113201.46983cbb@gandalf.local.home>
In-Reply-To: <aRtHWXzYa8ijUIDa@black.igk.intel.com>
References: <20251111232406.183056289@kernel.org>
	<20251111232429.305317942@kernel.org>
	<aRtHWXzYa8ijUIDa@black.igk.intel.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: 8emxjs4pegm8tknxf5egbcg1ywpydxsk
X-Rspamd-Server: rspamout07
X-Rspamd-Queue-Id: 986B060011
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1/udCuBkN0rslU3g3bxnUJR9nZcsMyNZA8=
X-HE-Tag: 1763397096-610637
X-HE-Meta: U2FsdGVkX18zwTh7ZASAUSpc4xLLtJPlDHUt4zj7qrUPjlr8EUVIxkCrhiU0iWTKgtpcK7Ri8P3Wm/6aup4gaz0vzUEqyLFr/hXNR9u1+jTzFoDeNpLhItQPQnH5vf2KMQ0XtZI7veWunQvdp0Eywg/c4VXewr3kk3amK+K7w/K6UNmvsVV/C6tDDh/xZVphB9EJb79Hw7r6WjgcrbIE7Xo1YyL0DICTPudGqUDPNtqtVacQ+tW+qQTpI207qPBGNfzfM3Ts2ZUyh6C+XmgR6GIWTU3N4ttImhBI64uMllUh+Gcw0/7H7Uu5K25K7roVnfJDFe/X2oBY0CrNkAL3rqX5+lVLa6o+

On Mon, 17 Nov 2025 17:03:37 +0100
Andy Shevchenko <andriy.shevchenko@intel.com> wrote:

> > @@ -5152,12 +5180,14 @@ static int tracing_trace_options_show(struct seq_file *m, void *v)
> >  			seq_printf(m, "no%s\n", trace_options[i]);
> >  	}
> >  
> > -	trace = tr->current_trace;
> > -	if (!trace->flags || !trace->flags->opts)
> > +	flags = tr->current_trace_flags;
> > +	if (!flags || !flags->opts)
> >  		return 0;
> >  
> > -	tracer_flags = tr->current_trace->flags->val;
> > -	trace_opts = tr->current_trace->flags->opts;  
> 
> > +	trace = tr->current_trace;  
> 
> Removing it and this line fixes, but I'm not sure that's correct one, so feel
> free to fold the change or if it will be a fix,
> Reported-by: Andy Shevchenko <andriy.shevchenko@intel.com>

Thanks for the report. Yeah, that variable is no longer used and can be
removed. I'll send a patch.

-- Steve


> 
> > +	tracer_flags = flags->val;
> > +	trace_opts = flags->opts;  

