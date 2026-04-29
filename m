Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB199376BF1;
	Wed, 29 Apr 2026 15:16:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777475762; cv=none; b=HLJkqhrrnQwgbMKtqsemA7N2itqyVe5ko/XTXg1IQi0Q+jOwgTx01mTkmrHlAYDepk0DX4TmQfGbeBu6Aa27gPoT+a1GdU5n09dKoHXQu+4eoKnEKRhSba0V6vFk5Jm9k+tDWaKxZIjBrk6UHpxmYP33bRRkfG2aCm/dx87HVqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777475762; c=relaxed/simple;
	bh=qJfcWNJrNFk350uexydFUPT8va/SsAcPQMsRGFeJVhY=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=DCOFIQvXbdb1RbCE8pF3MOSkZ+J757gJrV7tNOAOF08HRpSv5Vo7IW2LVTOhnj4HVodHxFc5Dj5vrK6cVKtp6ry7sFMa+geFesZlASFTSoN0pVLI5xD4mxxKb2PRUcHnSgHZIITvKS/6Mv1fZHc4m5J6Nk4q8W9f3sAKXi1uD9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Tc5DwENP; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Tc5DwENP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18244C19425;
	Wed, 29 Apr 2026 15:16:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777475762;
	bh=qJfcWNJrNFk350uexydFUPT8va/SsAcPQMsRGFeJVhY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Tc5DwENPc3RtKLrf2qoMNayifVx6jMMiFhVd7RMvq0PtT1oWmw3bwTDzNtuIxn3zp
	 GEgsINNCMj3idUyhkvg/4jZqZ+H2ZWmbgYuAKs+wH9C4eQkvA3AJC3Ini4gyxOpuiB
	 OvmO3b4v/zyUKgGriSC4oW5TJ3FFZurkoPfkr5ConHi9fMXyaS/63Z9rSSxzt10HRa
	 EvGf9fMRIrmRMtLU1oKeZdlJV8IUuiQZmWur3GjOhIeAL7wxq3akA7ihMQnmIuClos
	 ydjIDKEBJecL5a98adndKQdYdYYVlTuGsCvqMFcwbH9jHpMHuPOhY6FtpfdJ5CXEQg
	 bndC8Cx3HlhdA==
Date: Thu, 30 Apr 2026 00:15:59 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>, Will Deacon
 <will@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, Ian
 Rogers <irogers@google.com>, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v18 3/8] ring-buffer: Skip invalid sub-buffers when
 validating persistent ring buffer
Message-Id: <20260430001559.a2d0489d956c06059e13e58d@kernel.org>
In-Reply-To: <20260428155508.4f47279e@gandalf.local.home>
References: <177701351903.2223789.17087009302463188638.stgit@mhiramat.tok.corp.google.com>
	<177701354681.2223789.14633430761021638378.stgit@mhiramat.tok.corp.google.com>
	<20260428155508.4f47279e@gandalf.local.home>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 28 Apr 2026 15:55:08 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> On Fri, 24 Apr 2026 15:52:27 +0900
> "Masami Hiramatsu (Google)" <mhiramat@kernel.org> wrote:
> 
> > @@ -5648,11 +5668,12 @@ __rb_get_reader_page(struct ring_buffer_per_cpu *cpu_buffer)
> >   again:
> >  	/*
> >  	 * This should normally only loop twice. But because the
> > -	 * start of the reader inserts an empty page, it causes
> > -	 * a case where we will loop three times. There should be no
> > -	 * reason to loop four times (that I know of).
> > +	 * start of the reader inserts an empty page, it causes a
> > +	 * case where we will loop three times. There should be no
> > +	 * reason to loop four times unless the ring buffer is a
> > +	 * recovered persistent ring buffer.
> 
> Can you explain more to why this is allowed for persistent ring buffer?

Ah, that was introduced in v15.

  Changes in v15:
  - Skip reader_page loop check on persistent ring buffer because
    there can be contiguous empty(invalidated) pages. 


So, finding next reader_page, we need to skip empty pages, which is normally
not contiguous. However, if we see more than 3 invalid pages on recovering
persistent ring buffer, it will be reset and become empty.


> 
> Note, I do not like any loops that can go into an infinite loop and lock up
> the machine. If something goes wrong with a persistent ring buffer, then
> this could possibly go into an infinite loop.

Yeah, so I think we should not use goto here. OK, let me update it to
an actual loop.

> 
> I want to understand why this is allowed, and possibly add a check that
> prevents this from never ending.

It should not be a never ending loop (there are other exit conditions),
but I agreed. What about limiting with nr_subbufs?

diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
index 5326924615a4..aa89ec96e964 100644
--- a/kernel/trace/ring_buffer.c
+++ b/kernel/trace/ring_buffer.c
@@ -5630,7 +5630,8 @@ __rb_get_reader_page(struct ring_buffer_per_cpu *cpu_buffer)
 	 * a case where we will loop three times. There should be no
 	 * reason to loop four times (that I know of).
 	 */
-	if (RB_WARN_ON(cpu_buffer, ++nr_loops > 3)) {
+	if (RB_WARN_ON(cpu_buffer,
+		++nr_loops > (cpu_buffer->ring_meta ? cpu_buffer->nr_subbufs : 3))) {
 		reader = NULL;
 		goto out;
 	}

> 
> -- Steve
> 
> 
> >  	 */
> > -	if (RB_WARN_ON(cpu_buffer, ++nr_loops > 3)) {
> > +	if (RB_WARN_ON(cpu_buffer, ++nr_loops > 3 && !cpu_buffer->ring_meta)) {
> >  		reader = NULL;
> >  		goto out;
> >  	}
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
