Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54571DDCD;
	Wed, 26 Feb 2025 13:47:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740577641; cv=none; b=Iv0k2f1uWxNPgNMdP8i9ZWjwyOGwDTdIhnYbGFEtIDZjmEegBpPT0n2eoLe2XaEFGTB9mzCot0thG0kjMc0q3VsMTCYjHg9LD07mTtwzFySWrfM+VPoUkwATl0LiGTMioS/e604zs8hwVK/bFX8hspDkXaSryP/2HOilzkPcDnw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740577641; c=relaxed/simple;
	bh=K0Axe+STkBJ7iMP1RoIGDdvMcnCyDEQCg6LVjirLPSI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HjDTSqDTLloWWmy4IhnOTHkHFBmxI87vTFgqzKFOOO1mkggNA8iWMAlgtPaanpEQDsoMvOYbvyfiz1qi1bMAAFaMyzTGJgXxeIZHQocZJVrMiniY/tONEntCC5TDfCKpNlNwJSpyJIrVSRA1FGvjgyh28EKqbofVkO6jYdXwJMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9CDF7C4CED6;
	Wed, 26 Feb 2025 13:47:19 +0000 (UTC)
Date: Wed, 26 Feb 2025 08:47:59 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Heiko Carstens <hca@linux.ibm.com>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, Masami
 Hiramatsu <mhiramat@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Andrew Morton
 <akpm@linux-foundation.org>, Sven Schnelle <svens@linux.ibm.com>, Vasily
 Gorbik <gor@linux.ibm.com>, Alexander Gordeev <agordeev@linux.ibm.com>
Subject: Re: [PATCH v3 5/5] selftests/ftrace: Update fprobe test to check
 enabled_functions file
Message-ID: <20250226084759.05a4d573@gandalf.local.home>
In-Reply-To: <20250226105028.16208A53-hca@linux.ibm.com>
References: <20250220202009.689253424@goodmis.org>
	<20250220202055.733001756@goodmis.org>
	<20250226105028.16208A53-hca@linux.ibm.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 26 Feb 2025 11:50:28 +0100
Heiko Carstens <hca@linux.ibm.com> wrote:

> Bah.. :) this doesn't work always, since at least with Fedora 41 the
> assumption that there are zero enabled functions before this test is
> executed is not necessarily true:
> 
> # cat tracing/enabled_functions 
> free_user_ns (1) R         
> bpf_lsm_path_mkdir (1) R   D   M        tramp: ftrace_regs_caller+0x0/0x68 (call_direct_funcs+0x0/0x20)
>         direct-->bpf_trampoline_6442505669+0x0/0x148
> bpf_lsm_path_mknod (1) R   D   M        tramp: ftrace_regs_caller+0x0/0x68 (call_direct_funcs+0x0/0x20)
>         direct-->bpf_trampoline_6442505671+0x0/0x14e

After I submitted the patches, I then remembered that some user space tools
add BPF programs that attach to functions, and those will show up in the
enabled_functions table (that's a feature as it is always good to know what
is modifying your kernel!). And I figured it will break this test.

I decided to wait until someone complains about it before fixing it ;-)

> ...
> 
> I didn't stumble across this before, since I tried a monolithic kernel
> without modules when verifying your series; and then there aren't any
> enabled functions. But with modules there are.
> 
> This could be worked around for example with something like the patch
> below (against linux-next). But no idea what your preferred way to
> handle this would be.

Actually, when I thought about fixing this, your patch is pretty much what
I was thinking of doing.

-- Steve
