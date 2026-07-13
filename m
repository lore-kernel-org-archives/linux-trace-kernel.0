Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB8531E1A17;
	Mon, 13 Jul 2026 02:56:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783911362; cv=none; b=tqNHIoSqd3PcKrshCvl3XmfNmVk8jYxedoCCoPRM2J6YVe74lVXmMLaOtVAStcU7DF4EzfOId4PBqw4IhnGDpx1XP9igdIrTJZ8JRK8M6Lb+vqiZVVZLqVeHwUjxc3ImRFs1EwhiKbw/OWRYsMxji3jAN+tKWDRJeCOGdeaU/Y8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783911362; c=relaxed/simple;
	bh=Kn08bFdJElgzTbuL8j01Kcw8xo0nI48uv4wlKgdDoME=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=SBo0NeQRHgaEyG5ejZuOpNJJu6y0y2ixPyG+v0bJh8I3Wz6/PEn7bDD87Bc25xxqBqkJooeDQN4XiwlyEHaEQlhppbCWh+An6FVUVF73dGPVKZBGH0cBNJVZnS/1VCa4ct5YEBSfPKJReM+8D/GjpUJaEghA+yDWtoQSDii0LiY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fijsoQ5F; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fijsoQ5F"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA5731F000E9;
	Mon, 13 Jul 2026 02:55:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783911361;
	bh=cjbEfi2/tDHp3TwROm1H43s711DcLVjDccZoqvrROCc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=fijsoQ5F74UBZPSM8cumQGAX5lFi+Yb/g4TibPISVuROTkrC7oVZWeJ/wPrhx3K/0
	 z5jgzUeKBgMh+jM9WirMmFr7+OOFMmh2eAGJh9cdYcYVipU9rQPHXBq3JCojh/3TQr
	 Ox0MKkQFZHubSWjHupMKSQ44S2opjYOynDFKzfuqSVRbqk2tVDiJn98E5ByITD8ZM3
	 K94bZS0woSMUWGx+nLlnoGKN1TZDvc5FLJ6d+L/7+fCdDMqtOZ9KnULzYPMPgXwEeT
	 58zBh9Qjts47iwEE9sD/4m9SwEpj+amDBW6idLYcy+iyk0+R5McOJTBp5/jLr81eY0
	 D9DPcAPUz9U0A==
Date: Mon, 13 Jul 2026 11:55:57 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Jeongho Choi <jh1012.choi@samsung.com>,
 linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org,
 ji2yoon.jo@samsung.com, minki.jang@samsung.com, hajun.sung@samsung.com
Subject: Re: [BUG] tracing: Too many tries to read user space
Message-Id: <20260713115557.0a8f1c8feb24f435f9c3fece@kernel.org>
In-Reply-To: <20260710074605.33802554@gandalf.local.home>
References: <CGME20260708123754epcas2p1f15cc305ddb09f97164491d750769ef7@epcas2p1.samsung.com>
	<20260708123753.GB1386@KORCO121415.samsungds.net>
	<20260710122231.9bc9fae3dcfc72215f4a2dcd@kernel.org>
	<20260710074605.33802554@gandalf.local.home>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 10 Jul 2026 07:46:05 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> On Fri, 10 Jul 2026 12:22:31 +0900
> Masami Hiramatsu (Google) <mhiramat@kernel.org> wrote:
> 
> > However, this seems a bit strange that we only checks the CPU-wide context
> > switching in the loop. Instead, can we introduce a per-cpu sequence counter
> > to per-cpu buffer, and check it? 
> 
> I originally tried this but found a situation that it fails:
> 
>   tbuf->sequence = 0;
> 
> 	Task 1				Task 2
> 	------				------
> 
>    tbuf->sequence++;
>    seq = tbuf->sequence; (seq = 1)
> 
>    preempt_enable();
> 
>    [schedule] ---------------------->
> 
> 				  tbuf->sequence++;
> 				  seq = tbuf->sequence; (seq = 2);
> 
> 				  preempt_enable();
> 
> 				  copy_from_user(buffer);
> 
> 	     <--------------------[schedule]
> 
>    copy_from_user(buffer);
> 
>    *** BUFFER NOW CORRUPTED ***
> 
>    [schedule] ---------------------->
> 
> 				  preempt_disable();
> 
> 				} while (tubf->sequence != seq); // tbuf->sequence == seq !!!!
> 
> 
> This is why we use a CPU wide counter.

Ah, indeed. As similar to seqlock, maybe we need to increment sequence
number after the process so that we can find the buffer is used some
other process. Or, just use a mutex to wait. But anyway, that will be
make it slower?

BTW, it is just an idea, but can we split fast path (per-cpu buffer)
and slow path (allocate an intermadiate buffer) for the page which
can cause page fault ?

Thanks,

> 
> -- Steve
>   
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
