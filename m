Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA1CF2DCBF0;
	Mon, 26 May 2025 03:03:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748228626; cv=none; b=PXsnJ3GmvSOcroCPu3b3Vpeell2oep/iDfnntBqH9FgJG8MMbkEhqrqmHUCmZnBuOADqa42CnXLbej+Bsg7cj5HaYWAYdR9uNegs4kgE1S3yermyLxqZyzt88+OX3wy5t+F0xhhMHLhJ3IE6wEs3wGwkqn1s1DjRSLmk4ofcDSo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748228626; c=relaxed/simple;
	bh=Wv86JuCfVaaJ8z4khY3hTwzcVnR1Opi+FwW14hAOfdM=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=XogVDkB0Nvp69viKI1nEHgZOpYCRFyjmeok1nkPAjj86hralivWCHtdubIUcjcs5XnHjPQKGN2sR5/fHdXr68YhICaXCt3QK1iaouGyNVWqaQ2a13imUvQM4A58gix6iy14DchH52DHwpZD6qTUWQqnvIwrMsOygOga5POlu/hA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YOdYL3yf; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YOdYL3yf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80AE3C4CEEA;
	Mon, 26 May 2025 03:03:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748228625;
	bh=Wv86JuCfVaaJ8z4khY3hTwzcVnR1Opi+FwW14hAOfdM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=YOdYL3yfnBQBsvhZNe3bBnw5EIVCFOHgvNRwOCPIplLMqWr5pXZwI6tBz4s4IuZmK
	 q2AFU9ruTiwiDWXa89pCc5FxqhZKI5QL447FSBzpaXuMd/aaajvLDjjP13lJoDEHZq
	 qsQUnF4qM+dsy01jCeD+mTgKgLSCBllol9y2M3PIukshL5rxl3qYSaofTN6YR23f+1
	 +qSKqUBxJMBBTwQ/2mkL4Yr+TzF+LcvIWhIlkwj5bnrL2BqXLbFLPwjIwGts4uX2WR
	 dDYvmEn6ARJqB1ZRZncI8v6UHsp7y0vVYbBM+AvxTBa4EQLBt94IdmlSMgSDBzqRSq
	 oytwSmgUfHEJg==
Date: Mon, 26 May 2025 12:03:42 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/2] tracing: ring_buffer: Rewind persistent ring
 buffer when reboot
Message-Id: <20250526120342.cdcfca9ac3c2161d48c03af5@kernel.org>
In-Reply-To: <20250523172857.02ab4a75@gandalf.local.home>
References: <174792927500.496143.10668210464102033012.stgit@mhiramat.tok.corp.google.com>
	<174792928413.496143.17979267710069360561.stgit@mhiramat.tok.corp.google.com>
	<20250523165425.0275c9a1@gandalf.local.home>
	<20250523172857.02ab4a75@gandalf.local.home>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 23 May 2025 17:28:57 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> On Fri, 23 May 2025 16:54:25 -0400
> Steven Rostedt <rostedt@goodmis.org> wrote:
> 
> > I think we also need this:
> > 
> > diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
> > index 7d837963dd1e..456efebc396a 100644
> > --- a/kernel/trace/ring_buffer.c
> > +++ b/kernel/trace/ring_buffer.c
> > @@ -3638,6 +3638,9 @@ rb_move_tail(struct ring_buffer_per_cpu *cpu_buffer,
> >  
> >  	rb_reset_tail(cpu_buffer, tail, info);
> >  
> > +	/* The new page should have zero committed */
> > +	rb_init_page(next_page->page);
> > +
> >  	/* Commit what we have for now. */
> >  	rb_end_commit(cpu_buffer);
> >  	/* rb_end_commit() decs committing */
> 
> No we don't need it ;-)
> 
> I'm looking deeper into the code and we have this:
> 
> 		/*
> 		 * No need to worry about races with clearing out the commit.
> 		 * it only can increment when a commit takes place. But that
> 		 * only happens in the outer most nested commit.
> 		 */
> 		local_set(&next_page->page->commit, 0);
> 
> When the tail page gets moved.

Yeah, when the page gets written, it is cleared.

Thanks,

> 
> -- Steve


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
