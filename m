Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52F032A1BF;
	Mon, 30 Mar 2026 01:42:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774834978; cv=none; b=TOV0hnAxL05XKGdkozIox+4A64up/4FDY8ArYb2/lzEUTAenC/E4uejCTr+0l6iSw+bjRqy+ieNqZdp/46+bx++mMscJ8mOivAs80T8fEkuNchmYOdFiDGHww1eNllCJCgkro0Ovz5rfcM0u8fWBUviGwlSZfUZtk+FzjdlhWJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774834978; c=relaxed/simple;
	bh=tqb7ltlGwzjHp6X6k6F/D9bBhVcpo9tKovOOYNnaAXA=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=PWXCaj3YNPDerR0RzvlSVLmN2EHplq6g9DuwbDgToxOumtcffZG4fxYUuNrhRJaco83OOHf3YVr6v7Q69D6xBwdP4A/jTSMQfa3bEZR7dRQShRvbRMZR7j3pMb9LauTP+Bv0kTAKatnMl15ZXJ7n74wNkO78qvFg7KahSqYiQ04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GlC7kziI; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GlC7kziI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D42F4C116C6;
	Mon, 30 Mar 2026 01:42:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774834977;
	bh=tqb7ltlGwzjHp6X6k6F/D9bBhVcpo9tKovOOYNnaAXA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=GlC7kziI4FFri3f0Wq+k49u8WAR9P1qGVBmKwxx4rH+fkkPIT7LgeKAKRZWz9pruK
	 5aFYOzszOmeQiFLncXk5H7N2FvwQeQQSgOIGgBecMts7yksPNSyIYdNTP2YEIlC/VA
	 TVPYS/TiKpphLYOF8Nu0VOqmfxhRwvMDU7vmXrhlPmXzw7iINhjlnXxL39LV18DrIL
	 QENi7E63C1suV7O3PpF1BQj9LOCjBImU3NAbUercEsaVSnfhlRyb4Eucu3rc67meUo
	 Q+DVehgA2xjG/GkueEvWaE4Qm5G5JoZtD7ZJJA8fal5Dw+L79yBwBZG5gwOgaZ2hJL
	 K6mdhvHF0n+dA==
Date: Mon, 30 Mar 2026 10:42:52 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, Ian
 Rogers <irogers@google.com>
Subject: Re: [PATCH v13 4/4] ring-buffer: Add persistent ring buffer
 selftest
Message-Id: <20260330104252.2dd5b8a96120996fdec69fe8@kernel.org>
In-Reply-To: <20260327162508.6cac690c@gandalf.local.home>
References: <177440549083.1529621.15486836623498328967.stgit@mhiramat.tok.corp.google.com>
	<177440552560.1529621.1405976992959650354.stgit@mhiramat.tok.corp.google.com>
	<20260327162508.6cac690c@gandalf.local.home>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 27 Mar 2026 16:25:08 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> On Wed, 25 Mar 2026 11:25:25 +0900
> "Masami Hiramatsu (Google)" <mhiramat@kernel.org> wrote:
> 
> > From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> > 
> > Add a self-destractive test for the persistent ring buffer. This
> > will invalidate some sub-buffer pages in the persistent ring buffer
> > when kernel gets panic, and check whether the number of detected
> > invalid pages and the total entry_bytes are the same as record
> > after reboot.
> > 
> > This can ensure the kernel correctly recover partially corrupted
> > persistent ring buffer when boot.
> > 
> > The test only runs on the persistent ring buffer whose name is
> > "ptracingtest". And user has to fill it up with events before
> > kernel panics.
> > 
> > To run the test, enable CONFIG_RING_BUFFER_PERSISTENT_SELFTEST
> 
> I think a more appropriate config name would be:
> 
>   CONFIG_PERSISTENT_RING_BUFFER_ERROR_INJECT
> 
> as that's what it is doing as it is only testing error injection and not
> the persistent ring buffer.

OK, selftest will be another implementation.

(preparing buffer with test data and check recovery process?)

> 
> > and you have to setup the kernel cmdline;
> > 
> >  reserve_mem=20M:2M:trace trace_instance=ptracingtest^traceoff@trace
> >  panic=1
> > 
> > And run following commands after the 1st boot;
> > 
> >  cd /sys/kernel/tracing/instances/ptracingtest
> >  echo 1 > tracing_on
> >  echo 1 > events/enable
> >  sleep 3
> >  echo c > /proc/sysrq-trigger
> 
> These instructions should probably be in the CONFIG help message.

OK. I'll add it.

> 
> > 
> > After panic message, the kernel will reboot and run the verification
> > on the persistent ring buffer, e.g.
> > 
> >  Ring buffer meta [2] invalid buffer page detected
> >  Ring buffer meta [2] is from previous boot! (318 pages discarded)
> >  Ring buffer testing [2] invalid pages: PASSED (318/318)
> >  Ring buffer testing [2] entry_bytes: PASSED (1300476/1300476)
> 
> BTW, when I tested this, I got the above on the first boot, but if I
> rebooted normally without re-enabling the persistent ring buffer, I would
> get on the next boot:

Hmm, since it is already recovered (rewound) the 2nd rewound process
may not work correctly. Let me fix it.
> 
> 
> [    0.966510] Ring buffer meta [2] is from previous boot! (0 pages discarded)
> [    0.971338]  #2
> [    1.003431] Ring buffer meta [3] is from previous boot! (0 pages discarded)
> [    1.007737]  #3
> [    1.039091] Ring buffer meta [4] is from previous boot! (0 pages discarded)
> [    1.043181] Ring buffer testing [4] invalid pages: FAILED (0/1597)
> [    1.044660] Ring buffer testing [4] entry_bytes: PASSED (6512464/6512464)
> [    1.047829]  #4
> [    1.079811] Ring buffer meta [5] is from previous boot! (0 pages discarded)
> [    1.083728]  #5
> [    1.116764] Ring buffer meta [6] is from previous boot! (0 pages discarded)
> [    1.120846]  #6
> [    1.156502] Ring buffer meta [7] is from previous boot! (0 pages discarded)
> [    1.160857]  #7
> 
> I'll start testing the previous 3 patches and may add them to next.

Thanks,

> 
> Also, I noticed that there's nothing that reads the RB_MISSING as I thought
> it might. I'll have to look into how to pass that info to the trace output.
> 
> -- Steve
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
