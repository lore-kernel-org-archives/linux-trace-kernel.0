Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B2051DFDE;
	Wed, 14 May 2025 04:33:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747197210; cv=none; b=nV60xmCwekeQuUvhg3e1Aa96i4LILObo9tWeuPWO/LEmqrcxBi8CAR5OMGBFWfvZQVvWHYkfODFFacGjl1JOCsI7HizadCAGlUOZFRdTpvAdS7bEPxQ6/z8IoikcE8eaRrezw/iq5YosTfsfMEOMuNKMcOOGvIEfK3yMCAdyNmc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747197210; c=relaxed/simple;
	bh=rN85irsQW9HlYsGJzv0G1rv1gmgbe7VjR8v/qSXPP+U=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=Sy9MYFPIZTUg0lC3sMMDIFU26p0R1nwAqbKdHd/NtCCkKTdd9vj9Zds9+r/VPkDzleVbtXeslU3y2jxVVshO0LnbZe9UWoac3YFxEqfC1kFfx/qYG0+iRsz6aQwjCtX5hUWPWLWu8Iag3/PexjpnCelFGMQhqrYz3nVcgyQr75M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hJhNeF/u; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hJhNeF/u"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16EE1C4CEED;
	Wed, 14 May 2025 04:33:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747197209;
	bh=rN85irsQW9HlYsGJzv0G1rv1gmgbe7VjR8v/qSXPP+U=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=hJhNeF/udnWhVaxBgXSG5/Wz8VTHPuQkci3zz2w2BVsSF+QaEDmQEaRb/8aBxhzeR
	 ismZtWtMjoEFQ/V93QrIooirl62b2iePYy0xA7pBENBncS0tQTAW28OhNxYtm4CFgk
	 0OquqEiTOrVbKIsifS9s/IxA0pF0bKMWDBFkZWEb/wglNlsyy6x6x4aqAj7PPuGgi+
	 kKJOKxxAQnR5oKdjp4vABI9F6VAdCPfVIE2aks8NvP+NNCwGV4oI600FJZnnbfWluN
	 ujWKKRxe2D3K9TH9l53ko9jgmuTKNEmZl3W+2odQEidaZBNV0M8oCHNLMjKxNkCx9s
	 cZ2eoY6ttaoAA==
Date: Wed, 14 May 2025 13:33:27 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Subject: Re: [RFC PATCH] tracing: ring_buffer: Rewind persistent ring buffer
 when reboot
Message-Id: <20250514133327.3a6382e5aa0e9d5533fe690c@kernel.org>
In-Reply-To: <20250513203647.524b1331@gandalf.local.home>
References: <174709742769.1964496.18203163435305117893.stgit@mhiramat.tok.corp.google.com>
	<20250513203237.0e7ff662@gandalf.local.home>
	<20250513203647.524b1331@gandalf.local.home>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 13 May 2025 20:36:47 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> On Tue, 13 May 2025 20:32:37 -0400
> Steven Rostedt <rostedt@goodmis.org> wrote:
> 
> > @@ -9628,6 +9636,14 @@ static void setup_trace_scratch(struct trace_array *tr,
> >  
> >  	/* Scan modules to make text delta for modules. */
> >  	module_for_each_mod(make_mod_delta, tr);
> > +
> > +	/* Set trace_clock as the same of the previous boot. */
> > +	if (tscratch->clock_id != tr->clock_id) {
> > +		if (tracing_set_clock(tr, trace_clocks[tscratch->clock_id].name) < 0) {
> > +			pr_info("the previous trace_clock info is not valid.");
> > +			goto reset;
> > +		}
> > +	}
> >  	return;
> >   reset:
> >  	/* Invalid trace modules */
> 
> 
> Hmm, somehow I got your other patch in here :-D

Oops, good catch! I mixed other patch there :-(


> 
> -- Steve


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
