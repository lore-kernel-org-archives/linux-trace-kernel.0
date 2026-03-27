Received: from relay.hostedemail.com (smtprelay0014.hostedemail.com [216.40.44.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 149982116F4;
	Fri, 27 Mar 2026 14:25:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774621543; cv=none; b=OF4Gj8Q294SLykzMxm3gY935pXnIMgaSESez4qcZLbtq21/WBVmPZFVCxXMycK6UgBjmtkITgkRHH2+y8xDvVPIAZ834wR6Wt8X3H5KpiBlXce8PNz51LKJSQxkd/bRkUn7JQB7BG7bl8XeKLaG13HqpqLju5VRUHCNqV4HPqGg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774621543; c=relaxed/simple;
	bh=v7eFs7f8RR17bY7R3Xr/RaIA3FnUkeQ7eW2kf2i1YE0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MCJLhm+z3v9kF1aU5ueiMIpWudP/AiPxoVruyRW1mPulv/ITwim/r8FiJnmS+EZBgpM0JdDwAdo6RwTGuPSuhnSgyUIsw7SkkA4ZoGnjorFYa+HRitvgeAa3SsYj+zsmApx7C/V4NnSZTYqjO3tZroFDqJCCfb4mj6o77Kf5C1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf11.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay05.hostedemail.com (Postfix) with ESMTP id 48D425E9EF;
	Fri, 27 Mar 2026 14:25:39 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf11.hostedemail.com (Postfix) with ESMTPA id C801420033;
	Fri, 27 Mar 2026 14:25:36 +0000 (UTC)
Date: Fri, 27 Mar 2026 10:26:25 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Petr Mladek <pmladek@suse.com>
Cc: david.laight.linux@gmail.com, Masami Hiramatsu <mhiramat@kernel.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, Aaron
 Tomlin <atomlin@atomlin.com>, Rasmus Villemoes <linux@rasmusvillemoes.dk>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Sergey Senozhatsky
 <senozhatsky@chromium.org>, Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH next] tracing: Remove spurious default precision from
 show_event_trigger/filter formats
Message-ID: <20260327102625.32fdc4c2@gandalf.local.home>
In-Reply-To: <acZKpXQDTEPCU813@pathway.suse.cz>
References: <20260326201824.3919-1-david.laight.linux@gmail.com>
	<acZKpXQDTEPCU813@pathway.suse.cz>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: 6wq59ksqd4xrtgrgnpmwnyjrrka1ssji
X-Rspamd-Server: rspamout01
X-Rspamd-Queue-Id: C801420033
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX182QUnXprzicX3f9ct579LMOpK2P9FrNaY=
X-HE-Tag: 1774621536-894845
X-HE-Meta: U2FsdGVkX1/LH6XIUA4vBu2pFK2hdu2fKHNRLClQdeC9agpk5YTJ+8EsG2QsvjwdloLB8tYAR4Ptcwh5kdf/Z2v6M6aFRXcAV7GqKKB1d4aYJ40rszjRRo6HfOHYn5RWiAM5UOFxn/TtTmODsbKvDEk5VDQwwoNa38NW+vNla0Vanbwt3G5CuXl+oGxuWNEocu8mxiAmuhqwjSZcFyNwgYVG3mtOpX/Gbi/d34pbLYIMomBLqorHcmrGL7VW8gidf6uRlGxp4Pb7WkERr7mLdzy02vUfUKZKai8HpTltBrscwZou99qvswIilPFp+Frd2zs8RH1/nyM2C6wzBvcveNhkohr+EXwp6FrPF4gZGgJxtD0ML595SwORcbnDCoIsYOF3DlEGIt1hmr0k4/eRNA==

On Fri, 27 Mar 2026 10:15:17 +0100
Petr Mladek <pmladek@suse.com> wrote:

> On Thu 2026-03-26 20:18:24, david.laight.linux@gmail.com wrote:
> > From: David Laight <david.laight.linux@gmail.com>
> > 
> > Change 2d8b7f9bf8e6e ("tracing: Have show_event_trigger/filter format a bit more in columns")
> > added space padding to align the output.
> > However it used ("%*.s", len, "") which requests the default precision.
> > It doesn't matter here whether the userspace default (0) or kernel
> > default (no precision) is used, but the format should be "%*s".
> > 
> > Signed-off-by: David Laight <david.laight.linux@gmail.com>  
> 
> Makes sense. It does not change the output because it printed
> an empty string "" so the precision did not matter.

Right. I use this in user space all the time, and add "%*.s" a lot.

I tested it and it doesn't change the output so I'm happy to take it
through my tree.

-- Steve
 

> 
> Reviewed-by: Petr Mladek <pmladek@suse.com>
> 
> Best Regards,
> Petr

