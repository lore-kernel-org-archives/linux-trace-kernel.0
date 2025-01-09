Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C564BFC0B;
	Thu,  9 Jan 2025 01:41:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736386891; cv=none; b=Tz3/GxNMFghFCO+nhSk7Pa7mccW6JvGThQry3TIbWf+vHeZTCoAUlF3To6x3FG4jCq4F/3fztBg+2tMTPod94v3NS+wcy3jX9My5IT3Oi9E9PAVKiA6ghIjFQCf0vzYAlkdPKib5bxL7WEOipCOTVBRc3b2CBI6sKzp8FS7PBTE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736386891; c=relaxed/simple;
	bh=LoD5F/hZAi1B2r64jO8j55ST+we/iZgiOfHeGxoqtdM=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=DaeWArzSsTUhI5WXOSqLPph7bFxMNo/Lv+4qBzN9GErw6BSkjCSmgKm7p6MEdR9BxOPvyWvRM9ELkFxirVXS4SiYYwnjdQw/V3KT5sKevzK/Vd8R2CsVMrkldWCipt2nqzSxEiQZ+n9z2H7/eyKeUDLr2BevLn8oKKcx1O5KjV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ho6muxm7; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ho6muxm7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 696CEC4CED3;
	Thu,  9 Jan 2025 01:41:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736386891;
	bh=LoD5F/hZAi1B2r64jO8j55ST+we/iZgiOfHeGxoqtdM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ho6muxm7Z7C1JQFtNITUZ1urot0Iwf/KmvwHjQMAuv50qdhTIQCK7IOkzhNR2x8Vy
	 cKcMSJTFzxxYr38ex8tASt6/Z5LPPDOMpBUiZZhh1pTG5FW6MbXJCEE39ixJu35S4D
	 zpRvrtKHaR5H5L3fiaD+te8527ZK0DmvcXZ+FoyL0OtUimrOffcMYqdY1TLJGfHEQe
	 W5ngL/OOHCuw3og6hQ+c5iU4TBDbc2/EeueXui/8uGPhVV17sFilEbH6MAolhe1OAy
	 cJkR60yDjv4Cml6bLGGl7SrbqYy/1+eJOAHPGPKjDfxowlWR07hi7u5gZV8DgF0JJ9
	 xxVvVUqEHYmDg==
Date: Thu, 9 Jan 2025 10:41:27 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Anil S Keshavamurthy
 <anil.s.keshavamurthy@intel.com>, "David S . Miller" <davem@davemloft.net>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Oleg Nesterov
 <oleg@redhat.com>, Tzvetomir Stoyanov <tz.stoyanov@gmail.com>, Naveen N Rao
 <naveen@kernel.org>, Josh Poimboeuf <jpoimboe@kernel.org>, Jason Baron
 <jbaron@akamai.com>, Ard Biesheuvel <ardb@kernel.org>,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH v5 4/5] tracing/kprobes: Simplify
 __trace_kprobe_create() by removing gotos
Message-Id: <20250109104127.f8ee0879730a47f5988de7e4@kernel.org>
In-Reply-To: <20250108101111.11dd98d8@gandalf.local.home>
References: <173630223453.1453474.6442447279377996686.stgit@devnote2>
	<173630227845.1453474.6513848165385480817.stgit@devnote2>
	<20250108101111.11dd98d8@gandalf.local.home>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 8 Jan 2025 10:11:11 -0500
Steven Rostedt <rostedt@goodmis.org> wrote:

> On Wed,  8 Jan 2025 11:11:18 +0900
> "Masami Hiramatsu (Google)" <mhiramat@kernel.org> wrote:
> 
> > -static int __trace_kprobe_create(int argc, const char *argv[])
> > +static int ___trace_kprobe_create(int argc, const char *argv[],
> > +				  struct traceprobe_parse_context *ctx)
> >  {
> 
> I'm not sure I care about all the underscores. It just adds to confusion.
> 
> Maybe just:
> 
> static int __create_trace_kprobe(..)

Ok. Or __trace_kprobe_create_internal()?

Then it will be

trace_kprobe_create()
 -> __trace_kprobe_create()
   -> __trace_kprobe_create_internal()

Thanks,

> 
> ?
> 
> -- Steve


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
