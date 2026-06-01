Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 246F51FE471;
	Mon,  1 Jun 2026 14:38:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780324701; cv=none; b=ai9B53LB7Ov4gojmYUuaCojVPRfCOF53XSNmFcLjOU2iuTedHCSO51CVY+YoXO88aqqqDj6dVtBObIyFagvY13eC8HckR380B6LLHbOKULZH2hnu3cCa8682QmAcuEOcGjxePhGKe1zNG+tjxTRB/2UH71ucTGg/jU0/gvp0Gtc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780324701; c=relaxed/simple;
	bh=Ny/OOX9HzQcnK/b3fsAvm/PuUCOCG+S/MU5/EmXpjmg=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=PysghAmIFzYWD/xxmsB5mBLPSPnaTZdiXGmCexZHQueRShycdNBzrpqyb/04Y5IYSMzXKPg04jVwUZGI+nTburdqUuZUBu3251t6ZGySKfd/K9XBImkwMN/jywkZJ/1a+GQ0VITCdGN7TrmeuL393cTYomJ+5Gd4FK4eyp0lJ7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OndOcFJA; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OndOcFJA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 448771F00893;
	Mon,  1 Jun 2026 14:38:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780324699;
	bh=c3naPun3vg5bI/m/H1YZ462x3RkmMXhhnnjZQBuf1r0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=OndOcFJAdStcf4vgFntEoDK0zqVDcUBtRYk2yHBVMAr4XGUhnx9JwX79O4IQKtIec
	 Sohumbep6dyo14IBnnbnfZ8OTbui7Hzu21jEKiUAlnIJkXroSEZ6ZJh1GEhg7tnfDb
	 PWR/qfDLwjRiLa1evQkhm6fQfiZlw88pq0K9drTL5fVd9Xbr4fvQm9Q00VWiOsAjNl
	 3gYpvrGzaw/TPY+kWOCJJNI4vaouRq9K9HTO60TGoz/Bl/DFWNj087e/VSqypLCIJX
	 4xmFodLUyUibO0sg3WT79XRTKB3egbP5PUCuMN42cxrKzwkRYGUI91Gakqg8H57yml
	 0rBPlHdxPwwDA==
Date: Mon, 1 Jun 2026 23:38:10 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Linux trace kernel
 <linux-trace-kernel@vger.kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Mark Rutland <mark.rutland@arm.com>,
 Peter Zijlstra <peterz@infradead.org>, Namhyung Kim <namhyung@kernel.org>,
 Takaya Saeki <takayas@google.com>, Douglas Raillard
 <douglas.raillard@arm.com>, Tom Zanussi <zanussi@kernel.org>, Andrew Morton
 <akpm@linux-foundation.org>, Thomas Gleixner <tglx@linutronix.de>, Ian
 Rogers <irogers@google.com>, Jiri Olsa <olsajiri@gmail.com>
Subject: Re: PATCH v7] tracing/eprobes: Allow use of BTF names to
 dereference pointers
Message-Id: <20260601233810.f516ff1a46b2b871e06495dc@kernel.org>
In-Reply-To: <20260530110754.14870622@gandalf.local.home>
References: <20260529110442.0967a64c@fedora>
	<20260530231427.b079fefffc724a40082cd64b@kernel.org>
	<20260530110754.14870622@gandalf.local.home>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 30 May 2026 11:07:54 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> On Sat, 30 May 2026 23:14:27 +0900
> Masami Hiramatsu (Google) <mhiramat@kernel.org> wrote:
> 
> > Thanks, and Sashiko reviewed this. 
> > 
> > https://sashiko.dev/#/patchset/20260529110442.0967a64c%40fedora
> > 
> > I think both comments are valid, especially, second one is important.
> 
> Hmm, comment below.
> 
> > 
> > BTW, I updated probes/fixes. Could you also update this and rebase
> > on probes/fixes branch?
> > 
> > I'm working on the nesting and container_of support patches which
> > are on top of this.
> 
> OK, I'll make sure to use your probes branch. Which one should I use? your
> probes/for-next or probes/urgent?

I pushed forced-updated probes/for-next on probes/fixes.
So you can use  probes/for-next now.

Thanks,

-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
