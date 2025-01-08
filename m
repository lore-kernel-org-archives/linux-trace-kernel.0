Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C2932AD22;
	Wed,  8 Jan 2025 01:33:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736299985; cv=none; b=VH+P+etJ8HU7BQpRpzUowimOMqQzW7gn9LW7WQgEYFnfu2uPqclOrB3riCM2pbbXCzJSsvwG6KWheuzE4nGoErchkqWEESjQF9wmJJfSYhaYSc9GFH76gzQOW62VhYdPUmRIxsHrWbtm5MgpPrmGib/+n7VvIjk/28waS/f3wZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736299985; c=relaxed/simple;
	bh=bBktlYyCGzZaf706LNRyGn1ToVY4NIDekGqV7dB1/Mw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TGf1k/ERP813chL+r3SargZhiRE1/gtlLDzVwZqrs3Bfq2J8hrgWjU1UG+dgzGVwe8d19b7mspTS3PdS3WNjxj2Fppsb6BRQxtwquvh2ZXA1neQxvjI8owotog5Eo+cyRM6KuU2EXq1ac8e8iTHrTfE6P77gxaXFCHUFJ1OzMJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A88C0C4CED6;
	Wed,  8 Jan 2025 01:33:03 +0000 (UTC)
Date: Tue, 7 Jan 2025 20:34:32 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Anil S Keshavamurthy
 <anil.s.keshavamurthy@intel.com>, "David S . Miller" <davem@davemloft.net>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Oleg Nesterov
 <oleg@redhat.com>, Tzvetomir Stoyanov <tz.stoyanov@gmail.com>, Naveen N Rao
 <naveen@kernel.org>, Josh Poimboeuf <jpoimboe@kernel.org>, Jason Baron
 <jbaron@akamai.com>, Ard Biesheuvel <ardb@kernel.org>,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/5] tracing: Use __free() in trace_probe for cleanup
Message-ID: <20250107203432.66c4778e@gandalf.local.home>
In-Reply-To: <20250108093843.dc5ea69f297a9fd99cf4c396@kernel.org>
References: <173625060316.1375434.11048027439794595989.stgit@devnote2>
	<173625062518.1375434.10516553019799245668.stgit@devnote2>
	<20250107103643.37a3b002@gandalf.local.home>
	<20250108093843.dc5ea69f297a9fd99cf4c396@kernel.org>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 8 Jan 2025 09:38:43 +0900
Masami Hiramatsu (Google) <mhiramat@kernel.org> wrote:

> > I don't get this? You are telling the compiler not to free tmp, because you
> > decided to free it yourself? Why not just remove the kfree() here altogether?  
> 
> In the for-loop block, the __free() work only when we exit the loop, not
> each iteration. In each iteration, kstrdup() is assigned to the 'tmp',
> so we need to kfree() each time.

Really? It doesn't trigger for each iteration? That's rather unintuitive. :-/
And sounds buggy, as wouldn't that then cause a memory leak?

I would say not to use __free() for tmp at all. Because now it's just
getting confusing.

-- Steve


> 
> Hmm, maybe this is a sign that I should not use __free() for the 'tmp',
> or I should call kfree(tmp) right before kstrdup(), like below.
> 
>  	for (i = 0; i < argc; i++) {
> 		char *tmp __free(kfree) = NULL;
> 		...
> 		kfree(tmp);
> 		tmp = kstrdup(argv[i], GFP_KERNEL);
> 	}
> 
> Does this make sense?

