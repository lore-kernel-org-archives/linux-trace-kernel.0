Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 401E841760;
	Fri, 18 Apr 2025 21:40:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745012407; cv=none; b=BfsS+z2wpJLW72b/btZFHkEnUTUY0VdQdbXIz6awXobmEKkNoOdMdesWhFrHMkOJx1PbNsIRtqsKZOAFZa4Wk503vpi3vlORGGyArT7fsaj0hYiaFeo41SvUaKswulrJ7NoFmY4aUNWMgkP6Aaz2zQPcHR64xlXNyeZQvpWk7Ag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745012407; c=relaxed/simple;
	bh=sQEx6WpaCkvi5Us7tJM0a9nl3EWEOVwUYkXrEEL6APA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gTSPri5M4JEqwTnPHUw0a4qLwIwUjVD2Dp/I6IrLyqxoypY6lnPbYVcxIJp7FoO2LLhjyR0XtIxSBQFU08n2ZVcGxFvn9IlsIh41larf8Z7PZA+Dry+GRJt6do3Pkxzj7s6vhe7uDzcfnqEU504FSqChWrIFDtG+RT/DdnhvVwc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=jcn++Xx+; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="jcn++Xx+"
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id CB61840E0214;
	Fri, 18 Apr 2025 21:40:02 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id ZQKSbkzc1mB7; Fri, 18 Apr 2025 21:39:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1745012398; bh=v7R7rbBwsqRL92iwFhFa621dkOiszs3z49cg4ID99vc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jcn++Xx+48DhLijziurjXTK5hrKPIUEK5a1xIC9z1nL7wqe9VrwPdIQNcArRhSjBG
	 fuQ+UA9NLJmNaAvPbj4L1lvX61v1c4bPImdLkQVo2BgEsfa5IXC8ozcK67iQ81Abbj
	 ONQd4ISB+PQii5tgcWFKFCgWTOjo8um2pGb2C6R1ydEv9CAE9AVC/gELfo6XDq2JOt
	 2fIC9qia/rfZUiu7vp8WNaOpO0+4PDCAbnXZjmivkdgQ3/ZLnOqO57YnQGBvhSBd8I
	 CRGHI822G1+5xSeYXLUrd3MgNdNpt4nUJ/ezf3/8eMdcimHp3NuKDLHiVPGrgd+S4A
	 v2qmWWQwx5NnM/ZzcYo97s7C2xLoK+UrlBBwH7Ns1ObfXkk/e+3fZzBDNbCKXIW0gi
	 U6ulRGLEgCtGZgUxHsNANRQ0b6GmWTp4WSgNfrkSc+i2k1+Gt0HgnDq30NqJxaFFfQ
	 Cp3vsx9GOe8qYln+6KzhFqhcj3Qxm48UNt6tz+niYsgOAD65F5VLoALvluaNI2s0wp
	 ac8HJ2igVLk61yc/GV/Y/Qks6eCUxRo0t7/oRKG5T9GCcVFj93/g4z0byWyylgMuPK
	 ZF9eILscrj2vghM8j1Q+LuUULutm4cKeDVnFBz3xvwKL23lU7GZ/LUWEkVbMNwhs/r
	 KcFQv7MbwDG4phxqBpmwqixk=
Received: from zn.tnic (p579690ee.dip0.t-ipconnect.de [87.150.144.238])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id AE43040E023A;
	Fri, 18 Apr 2025 21:39:46 +0000 (UTC)
Date: Fri, 18 Apr 2025 23:39:45 +0200
From: Borislav Petkov <bp@alien8.de>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Junxuan Liao <ljx@cs.wisc.edu>, linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org, x86@kernel.org,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	"Paul E. McKenney" <paulmck@kernel.org>
Subject: Re: [PATCH] x86/tracing: introduce enter/exit tracepoint pairs for
 page faults
Message-ID: <20250418213945.GJaALGod4-j86Squ43@fat_crate.local>
References: <e7d4cd81-c0a5-446c-95d2-6142d660c15b@cs.wisc.edu>
 <20250414205441.GGZ_12Eew18bGcPTG0@fat_crate.local>
 <20250414182050.213480aa@gandalf.local.home>
 <20250416174714.GGZ__tIi3yNzNKoKFE@fat_crate.local>
 <20250416140115.5b836b33@gandalf.local.home>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250416140115.5b836b33@gandalf.local.home>

On Wed, Apr 16, 2025 at 02:01:15PM -0400, Steven Rostedt wrote:
> The above was created by:
> 
>  # trace-cmd sqlhist -e -n user_faults SELECT TIMESTAMP_DELTA_USECS as delta FROM page_fault_user_enter as start JOIN \
>      page_fault_user_exit as end ON start.common_pid = end.common_pid

Pfff, that's SQL.

You're too old fashioned - you need an AI thing now :-P

So tell me: I as a silly user, how do I figure out how to use trace-cmd?
I guess it has docs somewhere...

And apparently I need trace-cmd now - I can't type all that into sysfs... Or
I guess I can use trace-cmd to generate the commands and then I can echo them
into the target machine.

I.e., ftrace still doesn't need a special tool to be used...

> This was just a simple example. I rather see where in the kernel it happens.
> I can still use the synthetic events and user stack trace to find where the
> big faults occur.

Right, so it would be great to have the actual use case in a patch's commit
message... i.e., why is a patch important.

> > Now if only that info were in the commit message along with the usage scenario
> > so that people can *actually* do what you guys are bragging about...
> 
> I plan on adding things like this to Documentation/trace/debugging.rst
> 
> I need to get time out to add a bunch of helpful tricks there.

Yap, please.

I have to admit I was able to catch a trace for tglx using only the ftrace
documentation we have so it must be good. But moar is better. :-P

Thx man!

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
