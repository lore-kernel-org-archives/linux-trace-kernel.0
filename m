Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AB1B1EB36;
	Wed,  8 Jan 2025 02:03:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736301808; cv=none; b=IADWGCY2C7itWsn3GmQqVjuK8lJoMopf1Kza0sX9ennpa7YQ/gZKbRyKegVAhin+RdiR0uR+9mKiicVxJxEYK2ArymXyBwIQP8edrIYMZ8XAPqH5oHpM23Y79Lyba0Hzf6j7lFsPY4t/z/leSot/nu1oi77sKNzIVnrr54qmz34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736301808; c=relaxed/simple;
	bh=Ea0oLzMm8w1mE3HNmdehHAOEQPy95g2YMppo/MD4PCs=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=k8bqkp5ei4xavAvRVM/f8L66Qdod7RhAoWKxOtQ7wegCTdrzqQJt6w7s7DqWtZ374wB67mPaNlM6Yi5unEDV1GK63wk4d2jGvw5YvAKre78sfW9U4cl8Uci8hZcikSnjY2kAl14ttFBh7oS+3MpGXwJbpn8xahEJZYxYlusFVTY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lkoLyYtu; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lkoLyYtu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CBF26C4CED6;
	Wed,  8 Jan 2025 02:03:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736301805;
	bh=Ea0oLzMm8w1mE3HNmdehHAOEQPy95g2YMppo/MD4PCs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=lkoLyYtu+BEh9z4Y6sxjtknsNLgcReLQiX7zWmNDOa/ts4QURmrgtnt/XOlhZjDuT
	 4JXzxNds+GyODgjgivUvMc8LZh9wMJpL1F3PMjVmNuueyga7PMtFDeFyk6ZqOzyVsI
	 rXKtlUs4NS+LfTVrPx07Il6RSqiUDzTYtzg4Lm7iCjsH6dfaACKvBDmr1eY0zf/VEn
	 KLnt7pl4CH6FAD8PmLD824GEQOudqY1cfZLMdVBUKH0+OiPauifx/GPHh/Zln9q0cg
	 laxQaRr45RcXRPc3/mvJv/cazjCeb5y6e+y06ExVfbzIT84hexKD2+ihhIrokRDkUB
	 CnqKg4tAQeVVQ==
Date: Wed, 8 Jan 2025 11:03:22 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Anil S Keshavamurthy
 <anil.s.keshavamurthy@intel.com>, "David S . Miller" <davem@davemloft.net>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Oleg Nesterov
 <oleg@redhat.com>, Tzvetomir Stoyanov <tz.stoyanov@gmail.com>, Naveen N Rao
 <naveen@kernel.org>, Josh Poimboeuf <jpoimboe@kernel.org>, Jason Baron
 <jbaron@akamai.com>, Ard Biesheuvel <ardb@kernel.org>,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/5] tracing: Use __free() in trace_probe for cleanup
Message-Id: <20250108110322.46e91dd1ed354e2b146b8e5e@kernel.org>
In-Reply-To: <20250107203432.66c4778e@gandalf.local.home>
References: <173625060316.1375434.11048027439794595989.stgit@devnote2>
	<173625062518.1375434.10516553019799245668.stgit@devnote2>
	<20250107103643.37a3b002@gandalf.local.home>
	<20250108093843.dc5ea69f297a9fd99cf4c396@kernel.org>
	<20250107203432.66c4778e@gandalf.local.home>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 7 Jan 2025 20:34:32 -0500
Steven Rostedt <rostedt@goodmis.org> wrote:

> On Wed, 8 Jan 2025 09:38:43 +0900
> Masami Hiramatsu (Google) <mhiramat@kernel.org> wrote:
> 
> > > I don't get this? You are telling the compiler not to free tmp, because you
> > > decided to free it yourself? Why not just remove the kfree() here altogether?  
> > 
> > In the for-loop block, the __free() work only when we exit the loop, not
> > each iteration. In each iteration, kstrdup() is assigned to the 'tmp',
> > so we need to kfree() each time.
> 
> Really? It doesn't trigger for each iteration? That's rather unintuitive. :-/
> And sounds buggy, as wouldn't that then cause a memory leak?

Ahh, sorry, it was my misunderstood. I made a test code and confirmed that
kfree() is called in each iteration. Previously I checked but I confused the result.

----------
#include <stdio.h>

void count_func(int *p)
{
	printf("Scope out: %d\n", *p);
}

int main(void)
{
	for (int i = 0; i < 10; i++) {
		int j __attribute((cleanup(count_func))) = 0;

		j++;
	}
	return 0;
}
----------

$ ./loop_cleanup 
Scope out: 1
Scope out: 1
Scope out: 1
Scope out: 1
Scope out: 1
Scope out: 1
Scope out: 1
Scope out: 1
Scope out: 1
Scope out: 1

Let me fix that.

Thanks,

> 
> I would say not to use __free() for tmp at all. Because now it's just
> getting confusing.
> 
> -- Steve
> 
> 
> > 
> > Hmm, maybe this is a sign that I should not use __free() for the 'tmp',
> > or I should call kfree(tmp) right before kstrdup(), like below.
> > 
> >  	for (i = 0; i < argc; i++) {
> > 		char *tmp __free(kfree) = NULL;
> > 		...
> > 		kfree(tmp);
> > 		tmp = kstrdup(argv[i], GFP_KERNEL);
> > 	}
> > 
> > Does this make sense?
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
