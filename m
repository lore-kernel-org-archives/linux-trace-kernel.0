Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2DE63C4B79;
	Mon, 27 Jul 2026 23:58:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785196688; cv=none; b=RTBlt5dnjng/9msRVvmauY3N8C3tI3c4kzLfc/VMnA5kD5RU3dlASeFKvj69ZUVmZdIE/3odgMdaufnELU1dEl26OLeUuvHJpgnbAjLn2c/kt4vu2MW9zVzn/oPUHrIw/5Ua1vB7uei7PHUO3pZ6g/5vpYTHfh5u3sxUOEZB5Ok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785196688; c=relaxed/simple;
	bh=hVMN677+O6uQNNKVHkBX1eahrZKJbrbsynbQfKoV9ak=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=daGQYVcdlww4247QUTM8bNNIuXrokmLR+HckNb8aam3wwWrKG2zQuwv6lPyzdCIouNAJRbNMbejyNYsx6mnJzYmwcvof8Hi5cXTe7o7JEJrhfr01GMSo3Pv7nw+UmMF7/sZWDaBdoMV3lPyfO3AwHYisOLDkbSbPycKvcPuIAVU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XvZyDnCi; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XvZyDnCi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 558C61F000E9;
	Mon, 27 Jul 2026 23:58:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785196687;
	bh=GSUEwA8DxGTVwWrWOajToAHEB/JTqlNiZjDNq8cDJYw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=XvZyDnCiKiXqW9gM+BrcSj1Z/j69DU1exIRIzmYL54LXRrQB/s1/UIUePIVHMkaFR
	 EfJUZOdg8OqjKWrcbMiJmOlxJoBC5R9sKBuq1vL+a+e1lH7fZRtnQtUVkQfnwdjC1n
	 8TBKhrtCCzI9j+1DvUmzWdq0QB9JGga1iQ/cz2sEYXw5EzMXzjGxavQsBMOr8l2sk9
	 hUYbfSIZ0O0e0NX9+sT1hbE5HHi+TMS/ylu5aPBPHrNaloy3i3HcnoEVkTXM0ZKJ7A
	 nQ6Iez2ijjpH1bM/VU9UTaUS3SQ9Kl6j1NLF2X33pUHMEq8u16rDWIIfOZwbt2lnLP
	 A57/EMk7WeM8g==
Date: Tue, 28 Jul 2026 08:58:02 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Zhan Xusheng <zhanxusheng1024@gmail.com>
Cc: Steven Rostedt <rostedt@goodmis.org>, Shuah Khan <shuah@kernel.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v3 4/5] tracing/probes: Extend max length of argument
 string
Message-Id: <20260728085802.9882193694a680809f888800@kernel.org>
In-Reply-To: <20260724023317.624074-1-zhanxusheng@xiaomi.com>
References: <178399140457.27810.11387684872148824707.stgit@devnote2>
	<20260724023317.624074-1-zhanxusheng@xiaomi.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 24 Jul 2026 10:33:17 +0800
Zhan Xusheng <zhanxusheng1024@gmail.com> wrote:

> On Tue, Jul 14, 2026 at 10:10:04AM +0900, Masami Hiramatsu (Google) wrote:
> > -	char buf[MAX_ARGSTR_LEN + 1];
> > +	char buf[MAX_COMMON_HEAD_LEN + 1];
> > ...
> > +#define MAX_ARGSTR_LEN		255
> > +#define MAX_COMMON_HEAD_LEN	63
> 
> Keeping the head buffer at 63 avoids growing it to 256, but it also
> preserves a pre-existing truncation of the kprobe/fprobe head: both
> trace_kprobe_match_command_head() and trace_fprobe_match_command_head()
> snprintf() the symbol / function name into this buffer ("%s" or "%s+%u").
> Kernel symbols can be far longer than 63 -- Rust-mangled names are
> routinely 150-200+ chars (KSYM_NAME_LEN is 512); I see 199-char symbols
> in /proc/kallsyms here.

Hmm, good catch! OK, it seems trace_*probe_match_command_head() need
to be updated. Let me fix it!

> 
> This is the same delete-/match-by-command path you just fixed for the
> args matcher in commit 15f197856d68 ("tracing/probes: Avoid temporary
> buffer truncation in trace_probe_match_command_args()"):
> dyn_event_release() passes the symbol as argv[0] to
> *_match_command_head(), which then calls trace_probe_match_command_args().
> The head runs first, so for a probe on a long symbol the head strcmp()
> already fails and the probe cannot be matched/deleted by full command --
> before the args fix is even reached.
> 
> Would it make sense to give the head matchers the same direct-comparison
> treatment instead of a fixed buffer -- compare the symbol (and optional
> "+offset") against argv[0] directly? uprobe already compares its filename
> directly, so mainly kprobe and fprobe would need it, and
> MAX_COMMON_HEAD_LEN could then be dropped.

Yeah, that is the best way to solve this issue.

Thanks for pointing it out!

> 
> Thanks,
> Xusheng


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
