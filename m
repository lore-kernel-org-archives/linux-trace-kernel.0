Received: from relay.hostedemail.com (smtprelay0015.hostedemail.com [216.40.44.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F302E3C76A1;
	Tue,  2 Jun 2026 12:59:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780405182; cv=none; b=J1WleZkf1pc5htCFSDfVtRmkjrkevpmzt/m2HVcpsCOhcLeTauCc9t+3epx7ySLdyi3xHXEzCUfTht6M3DfnqbhNUKPKbB383e1BwhmE7HInPtpJ7Z0mWqM9Jxh1crQHJJJ70VxfN1WDrawKQCcuEHsWY0yKWU/hM3EAEqLplc8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780405182; c=relaxed/simple;
	bh=py5tLaQSYb9JZbqJUayCssJnobYn5bDTlWzya9rtS6o=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=a6njnelARIohHjwwQUhh3iUleubwE+7Rn6efn0mq/Sfn6d7NqL5j2v9nO/XCWfnP6LrP1Zo9ISaj8juc0k2dPtgJ+tBuSDOB5HK7nJ/KusM70y2+MMo2Kc75CXE99N61JF1/L0AySoBFAnYRDC0OXncJxViRNdyeXf2eM38dye0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf03.hostedemail.com (lb01a-stub [10.200.18.249])
	by unirelay09.hostedemail.com (Postfix) with ESMTP id 964AD9284C;
	Tue,  2 Jun 2026 12:59:39 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf03.hostedemail.com (Postfix) with ESMTPA id AC1CA6000E;
	Tue,  2 Jun 2026 12:59:37 +0000 (UTC)
Date: Tue, 2 Jun 2026 09:00:25 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Manjunath Patil <manjunath.b.patil@oracle.com>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH] tracing/events: Expand ring buffer for in-kernel event
 enables
Message-ID: <20260602090025.06ae761f@gandalf.local.home>
In-Reply-To: <20260601233716.2517987-1-manjunath.b.patil@oracle.com>
References: <20260601233716.2517987-1-manjunath.b.patil@oracle.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: AC1CA6000E
X-Rspamd-Server: rspamout01
X-Stat-Signature: r87hn5xyyqsga3r4gwjyhrqt8tseq5zj
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX19bVGgR4DYQZbMkKraM5/SbPwfcjVpRTMc=
X-HE-Tag: 1780405177-212352
X-HE-Meta: U2FsdGVkX18wZ8H+m7fjnNE9vnxVeD5LP/aePBIgRSa9C+elFGurecD4oKABUJyyK1CQ1f2dF5NqHTpeVx/iFZLOsaQE0alV1iU/G9GmPSbpJAKWrCVySglJ/KUYfou4Qcp8Jt4BGTVhAzU5fH19PjumwZ0mt3dyGhw0ygIngFfImiWZba2TGao+nRWCQS8R8yAKN8KgEbh+hHfRRsieVZEPTmJLCbl7F+zkGvZNgXKs8m/ob5JZK6+/3fn3TsXGacgW9gdpfC1psdrxWP3hmIJ3fm2qTCPIPHfJOp7JHu/j8MT5YAGJa6wP9WnpkDh4lmPUD7YlQjip3uvwWCduAICdj8CgdwNe

On Mon,  1 Jun 2026 16:24:43 -0700
Manjunath Patil <manjunath.b.patil@oracle.com> wrote:

> Ftrace keeps trace arrays at a boot-minimum ring-buffer size until
> tracing is used. Tracefs event-enable paths already call
> tracing_update_buffers() before enabling events, but the exported
> in-kernel helpers trace_set_clr_event() and trace_array_set_clr_event()
> directly enable events through __ftrace_set_clr_event().
> 
> This can leave events enabled by in-kernel users recording into the tiny
> boot-minimum buffer instead of the configured default-sized buffer. Any
> caller that enables events through these exported helpers observes
> different buffer-expansion behavior than a userspace tracefs event enable.
> 
> Expand the relevant trace array before enabling events through the
> exported in-kernel helpers, matching the tracefs event-enable behavior.
> Disabling events remains unchanged.

The above explains everything correctly, but you left out what needs this?

Internal code should not be using the main ring buffer except for
debugging, in which case you can use trace_printk(), which will cause the
tracing buffers to be expanded by default.

Other areas of the kernel should create their own trace array which will be
created expanded by default too.

-- Steve
