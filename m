Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A16F1DAC9D
	for <linux-trace-kernel@vger.kernel.org>; Wed, 15 Jan 2025 23:48:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736984901; cv=none; b=DtA3hu9B1aClSJZlhC4oZD0opYmX2siSvExEIPjIDUJmR/M5xqSIbo9rjoYtMnQdl7OeHtwCmd1OT5xHgUiy17Dl/ewlmWiQFRxQJhSpZd7/sk581LYoIyIgSCj17Bxw+EoE6nIpuRtkZFNhEkgV0bQdHsxSbIEg9pb+7ZKMpfs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736984901; c=relaxed/simple;
	bh=Q2rGf/zWTDKi2XPCNl6x+IOKShYMSRd1xBROLZdRRXs=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=Z49xx8dpmPIFH+XSNGa5XGV14jtVlpqCjOdWlzAfJK82lkJVcuqH3FugaNUp9bOSE/vIl0VydZyc924jKDMAVduLq417hmz3Kv5obH4zfbpGGE2Eii3m+cscfJcanodT6LfRWQwdomWafwL+Bri1X66HpxJmlh5A4le/zJvByU0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U4m2R4xe; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U4m2R4xe"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E5FAC4CED1;
	Wed, 15 Jan 2025 23:48:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736984901;
	bh=Q2rGf/zWTDKi2XPCNl6x+IOKShYMSRd1xBROLZdRRXs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=U4m2R4xe5zlrrDNN+IkVJkVusV9vfuiNocappJK0Fn1KynwglnbZsaVW4kfkGWqhV
	 TzaEGxcPUUOXcZDVqrzpRWb0QzRpMtCKnHEgCZ4lbI0CAHdjs7nwjptNkJFifjG1Fl
	 sf7PGAT6PUNOp+jYOR5DAErgC4ereAr9h8IKCWtpR2RooaTjGrfGcoybvIMa4lyQK2
	 nVRFvt6Km956VcTqxk/5i35Ip0Bn0fS/UPlMlw8695FHvu4s+0VRppWJ1x8uelpi2c
	 o53uTFRfy4S+Ix15RlJgLne5h98c11T/F31xmvh3ZOCniGorodqbPZbh1PplNxMUL2
	 y7ydIAyuTuWjA==
Date: Thu, 16 Jan 2025 08:48:18 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Daniel Wagner <dwagner@suse.de>
Cc: Steven Rostedt <rostedt@goodmis.org>,
 linux-trace-kernel@vger.kernel.org, Masami Hiramatsu <mhiramat@kernel.org>
Subject: Re: kprobe not always triggering
Message-Id: <20250116084818.2160d4faf29cf34c9b6e612f@kernel.org>
In-Reply-To: <e5d64ac8-5a30-4196-a5e5-b3d2743356b1@flourine.local>
References: <f91a64bf-c5cb-4d36-b50b-67cdcdccdccc@flourine.local>
	<20250115101715.12c6cce3@gandalf.local.home>
	<e5d64ac8-5a30-4196-a5e5-b3d2743356b1@flourine.local>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Hi Daniel,

On Wed, 15 Jan 2025 17:29:34 +0100
Daniel Wagner <dwagner@suse.de> wrote:

> On Wed, Jan 15, 2025 at 10:17:15AM -0500, Steven Rostedt wrote:
> > [ Adding Masami ]
> > Is it consistently the same locations being dropped?
> 
> Yes, it is very consistent.
> 
> > There's been cases of a compiler inlining some functions for the code
> > called in the same file. If that happened, then those will likely be
> > dropped. That can be tested by adding:
> > 
> > bool noinline nvme_change_ctrl_state(struct nvme_ctrl *ctrl,
> >                 enum nvme_ctrl_state new_state) 
> > 
> > You would think it shouldn't inline it, but there's nothing in the spec
> > that says it can't do so.
> 
> This did the trick, now I see the missing state transitions.

Have you tried to use `perf probe`? Even if it is inlined, you can find them
by

 perf probe -a nvme_change_ctrl_state new_state

But perhaps, some of them are inlined with constant numbers (maybe you can
find them as nvme_change_ctrl_state.constprop.XXX in kallsyms)

If my guess is correct, it is not inlined but the constant propagation
optimization[1] has been done by the compiler.

[1] https://en.wikipedia.org/wiki/Constant_folding#Constant_propagation

IIRC, commit 66f69b219716 ("perf probe: Support DW_AT_const_value constant value")
should support this case.

Thank you,

> 
> > > The system is idle, so I hope it's not just a dropped event. Any ideas
> > > what I am doing wrong?
> > 
> > I don't think it's a dropped event. It's not busy enough. But the compiler
> > making a copy of the function (by inlining or what not) can cause something
> > like this to happen.
> 
> I didn't expect that the compiler does inlining and not inlining at the
> same time. Again what learned :)
> 
> Thanks,
> Daniel


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
