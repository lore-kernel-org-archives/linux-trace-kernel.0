Received: from relay.hostedemail.com (smtprelay0016.hostedemail.com [216.40.44.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18C2C4949F1;
	Wed,  1 Jul 2026 12:23:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782908624; cv=none; b=mP+g+QtuySUbNVEEAyAyX+B2MX9k55d/kOH2VTjTMbVcZkQifx7jAIeHsdHB3uweUN9mc7wxMRSlDBaoo1a8Haqof5baih8ofUjtCHeK1gAk1KDfYB4P+Njl7jFv8AnqoBR+M0X66Hu+vpTHgo/Blt4LKwiedbTjNe3cjAjw0Tg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782908624; c=relaxed/simple;
	bh=+snDGEFgt6Ur8iaiUBJ59k5p66Qx/xHWZ81F3TT73r4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fqP4ZvWI6k+x227PZbEXzWPyL1Z8hIhyj5S0+BY5GrsGmQzSLLe/J/YnCvucxfejTlEFm8hZaiVuvwGlpuXfMw2ixv22esCiVIHYupQZmZ9yvpCGGEuxrEWV8CBgyztvVFZg0hRj+mu1gBRpBBpg6l5cFoJeGBkvb8MVKmI10fI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf09.hostedemail.com (lb01a-stub [10.200.18.249])
	by unirelay10.hostedemail.com (Postfix) with ESMTP id ADAF4C1480;
	Wed,  1 Jul 2026 12:23:41 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf09.hostedemail.com (Postfix) with ESMTPA id ED4BA20028;
	Wed,  1 Jul 2026 12:23:39 +0000 (UTC)
Date: Wed, 1 Jul 2026 08:23:40 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: David Laight <david.laight.linux@gmail.com>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, Michal =?UTF-8?B?S291dG7DvQ==?=
 <mkoutny@suse.com>
Subject: Re: [PATCH 2/2] tracing: Keep pid and comm[] in the same structure
Message-ID: <20260701082340.5b0bd4e7@gandalf.local.home>
In-Reply-To: <20260701130404.3887c0e5@pumpkin>
References: <20260626212356.64150-1-david.laight.linux@gmail.com>
	<20260626212356.64150-3-david.laight.linux@gmail.com>
	<20260629164912.4c1c2855@robin>
	<20260630110156.5314e2e6@pumpkin>
	<20260630150348.149e318c@gandalf.local.home>
	<20260701110407.31f7b6ca@pumpkin>
	<20260701063822.3af87520@gandalf.local.home>
	<20260701130404.3887c0e5@pumpkin>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: ED4BA20028
X-Stat-Signature: 9sr4motkg59rtgnq8ehuajnkhneb4d4z
X-Rspamd-Server: rspamout07
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1/qQYBAznhP/ietZBw2Bc2mWHqJJuGKSBM=
X-HE-Tag: 1782908619-407842
X-HE-Meta: U2FsdGVkX19h6e6O33DbY15jqEAPkh587PqD1gH+7M2p55Saponp8WMNTStKz/fXMfAEKeJ1UX9C5rmsJKrne4r0NW4SpSCoIUMYoomuPFAoEKEJm0e1ug/8Zq8iFOe5FtNeHldbeyY8+wD8wFa1qIkcvv0PeL2+akOoNgzChrsL/WIr2S1GkPkNhvR0jMx7E1LoN/PbP9JYzCGl/W4Q5RcbRukCR9xgWKbLSST5gqdF8EjIluYeCjo8nTGdP6YIVKHmNZrNQBdqphR0csTXB6L6WuhjVGKyFh4d+ViPti/w703mJmVw18VAi15340WHYEiz2TmXcRNZZMmFDkzVZYXS3GObNVre

On Wed, 1 Jul 2026 13:04:04 +0100
David Laight <david.laight.linux@gmail.com> wrote:


> > Well, that would break trace-cmd. As reading the raw buffers clears the
> > trace, and trace-cmd reads the saved_cmdlines file *after* it reads the
> > trace, as during the trace it gets populated.  
> 
> So you'd need to clear it when tracing is enabled after the buffer is cleared.
> Just a matter of getting the timing right.

Why? Note, saved_cmdlines is for *all* instances. You can have multiple
instances tracing different things and they still all use the one
saved_cmdlines file. It's not tied to any specific buffer. It's a cache. It
gets populated at the next schedule switch after an event occurs.

> 
> If trace-cmd is currently given all 6000 entries (if you've run tracing for
> long enough), then giving it all the active processes isn't going to be any
> more of a problem.

I'm much more concerned about losing processes that were traced! A lot of
tracing happens to tasks while running hackbench. Hackbench isn't being
traced, but if we record it, it will blow away all the cache and we lose
the task names we care about.

> So you could just save comm[] in the process exit path when the trace buffer
> is non-empty, or better those started before tracing was last stopped.

Again, which tracer? You can have multiple instances.

> You'd need to give trace-cmd the active ones first and delete the entry
> from the cache because the pid might have been reused.
> 
> All just needs some coding, testing, and fixing of corner cases.

What exactly are you trying to solve? This hasn't been perfect, but it's
been good enough since 2009.

-- Steve
