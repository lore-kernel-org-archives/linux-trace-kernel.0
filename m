Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58BDC1DA4C;
	Tue, 28 May 2024 16:46:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716914804; cv=none; b=coXfFdlbjSB1U/yFUqXPB/pIrYs+4T1jbXTTLXbwm6FDPHZYvcSePFrHEtxwiNfi/p8CUJBNslxjlCJoL6L/4hGLc0OsxgB5fdFThtBSu4gqx+1NXarccDyLWZdDz1QtMoZMRTSwWY6UPKTTpFJSZZuetOF9XP9clngnqW05UGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716914804; c=relaxed/simple;
	bh=nsvyyJAp9vAJQn1XGCoxQf6q+s/VlUohL8DTuvuEicQ=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=V6ZQW7b8ywbXMCcS0w7jw/WABMONtQcvqryTKSg3mpBcz+rsgRTWLXxtiAINuwWdhPlClofbRJ2j4V1qbpLInQXLTG8CBckDq6U79UvbHb+2vGHbXWK/6uzDHmoVtaxTMYClkgo4MLfEigTaLv2PivDEtu1nN9Toqmzd2TIKxUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KuG0ynIS; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KuG0ynIS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82F8DC3277B;
	Tue, 28 May 2024 16:46:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716914803;
	bh=nsvyyJAp9vAJQn1XGCoxQf6q+s/VlUohL8DTuvuEicQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=KuG0ynISXL13kFGjuQ/XtWx4rVnMgfg0lyUDEbdwErjPPnMMgBGt/5pDROc9VzTne
	 q1qlb91xkCCSOlAfYzLA4KeERBymuo5i3KI+uUbjHWdrl9QX18kat468151JeYwUX2
	 bC3gyx4SzCzkdg15wc4O72uDgEdjMyqCiOpkV21PoNrUU+Bvh3s+hkUDjkbWg+9Ka6
	 EQhxShHzmsYXJeIYCzOP/n6A5pbbapxA3jU3Mm7jfO7QZLgo23SqjlE6m7Dag0vN6J
	 /WZEbYYgZusttVdISWTBTStGq+OZ0/Z6RfsMirE38eC/osIzpfcjqpfi32JH7OJAvU
	 aJNOCNqLHODUg==
Date: Wed, 29 May 2024 01:46:40 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Linux Trace Kernel
 <linux-trace-kernel@vger.kernel.org>, Tom Zanussi <zanussi@kernel.org>
Subject: Re: [PATCH 0/3] tracing: Fix some selftest issues
Message-Id: <20240529014640.3a04f7301f12eb44738f9f2d@kernel.org>
In-Reply-To: <20240527192907.49c9220f@rorschach.local.home>
References: <171671825710.39694.6859036369216249956.stgit@devnote2>
	<20240527192907.49c9220f@rorschach.local.home>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 27 May 2024 19:29:07 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> On Sun, 26 May 2024 19:10:57 +0900
> "Masami Hiramatsu (Google)" <mhiramat@kernel.org> wrote:
> 
> > Hi,
> > 
> > Here is a series of some fixes/improvements for the test modules and boot
> > time selftest of kprobe events. I found a WARNING message with some boot 
> > time selftest configuration, which came from the combination of embedded
> > kprobe generate API tests module and ftrace boot-time selftest. So the main
> > problem is that the test module should not be built-in. But I also think
> > this WARNING message is useless (because there are warning messages already)
> > and the cleanup code is redundant. This series fixes those issues.
> 
> Note, when I enable trace tests as builtin instead of modules, I just
> disable the bootup self tests when it detects this. This helps with
> doing tests via config options than having to add user space code that
> loads modules.
> 
> Could you do something similar?

OK, in that case, I would like to move the test cleanup code in
module_exit function into the end of module_init function. 
It looks there is no reason to split those into 2 parts.

Thank you,

> 
> -- Steve
> 
> 
> > 
> > Thank you,
> > 
> > ---
> > 
> > Masami Hiramatsu (Google) (3):
> >       tracing: Build event generation tests only as modules
> >       tracing/kprobe: Remove unneeded WARN_ON_ONCE() in selftests
> >       tracing/kprobe: Remove cleanup code unrelated to selftest
> > 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
