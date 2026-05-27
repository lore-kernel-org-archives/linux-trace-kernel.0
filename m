Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DB0A28640B;
	Wed, 27 May 2026 03:57:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779854227; cv=none; b=Te8lCAIBx8ldIzzXIN/ljqgYoWuOP3R7o/nOuTytDvZqkJwllGIRMZN+fZArcrykXBjSsmfkP9Qp3/+LL3TU+qtH6Nabq0qKOUdQNmYxsgqDBsn2RigkcTvD7Nsa2p+lXCmaFqTTI4b9XVX+I7wheoSlJTsLpJPsRGIJnrlShbg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779854227; c=relaxed/simple;
	bh=3UOlRcmkWfS4QfA6bcOm0PzqxoNZriiLSxGmVxru9bg=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=sSwi4c1fGE7J7MFq9AfFaqpXBQj/wJ3MMwmWqxrD9JnIqwwg+CGgiTpdvwLOxRFQwHfLkBrxCaJYRGlwMwgIsFgkzSmJzAW5hxaLAFt8nnvjwj/Sw1PSi5e0xRscTWgkPLhfJk80KuHmHVRApRPZPrmKdOOSVzdyn9NTCoL+Z/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Aj7KloJM; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Aj7KloJM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 388BA1F000E9;
	Wed, 27 May 2026 03:57:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779854226;
	bh=dU3ZKCDc/uZAUOnUsDEOHI6y543Uc2EROMLiVwhBomE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=Aj7KloJM/g/e8CNCKmMJbK11TMwAEgnMnAy7WKJvplPZ72jKkJgloV4XSjnWoGw+6
	 BTYgh8atgeKI80hYm/OOfamO+7t4icORxNPxIRkKzVon2pR1NDktXJqCd6WamHsBiP
	 OW+DZFyzi7WoOSELYZQ3e2Dfwt4IrLcCn05yQ4pMH3qMumxIGEGWp6kTa7wvIafZL3
	 duid7KzRNRhp4iCwNLN2zSaKSKX0sm+W+EksjGX3X2PKHGdXiGj76kZoq2RQqBEOtD
	 s71Sowz1tCo3R51rerGCC1u/FlnwTGxVYFMGjmmtnkkiwpwHDVbEVxAjzxQQQHMrNH
	 VVB3GOs0X1QaA==
Date: Wed, 27 May 2026 12:57:03 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, Mark
 Rutland <mark.rutland@arm.com>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Andrew Morton
 <akpm@linux-foundation.org>, Ian Rogers <irogers@google.com>
Subject: Re: [PATCH v21 0/9] ring-buffer: Making persistent ring buffers
 robust
Message-Id: <20260527125703.bfb9fc075a7b61742efb3113@kernel.org>
In-Reply-To: <20260526134231.1a65aef5@gandalf.local.home>
References: <20260522170857.263969486@kernel.org>
	<20260526141746.cf0b3c0bed5db3baf8914095@kernel.org>
	<20260526134231.1a65aef5@gandalf.local.home>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 26 May 2026 13:42:31 -0400
Steven Rostedt <rostedt@kernel.org> wrote:

> On Tue, 26 May 2026 14:17:46 +0900
> Masami Hiramatsu (Google) <mhiramat@kernel.org> wrote:
> 
> > On Fri, 22 May 2026 13:08:57 -0400
> > Steven Rostedt <rostedt@kernel.org> wrote:
> > 
> > > This is to make the persistent ring buffer more robust when sub-buffers
> > > are detected to be corrupted. Instead of invalidating the entire buffer,
> > > just invalidate the individual sub-buffers.
> > > 
> > > I started with Masami's patches and modified some from Sashiko reviews.
> > > I added a few patches to display the dropped events when the persistent
> > > ring buffers validation checks found sub-buffers were dropped due to being
> > > corrupted data.  
> > 
> > It seems that Sashiko still marks it "Incompleted".
> > Maybe we need base-commit: tag in this cover mail?
> > I also guess that this series does not use "In-Reply-To:" but
> > only uses "References:" tag in the mail header. I guess
> > Sashiko's mail header parser missed it.
> 
> But this applies to mainline. I'm not sure why it's having problems.

Yeah, I confirmed this series can be applied to linus mainline tree.

I meant that the Sashiko's email header parser may failed to parse the
thread correctly. 

- The patches in this series are listed separately.
  https://sashiko.dev/#/?list=org.kernel.vger.linux-trace-kernel
- The cover mail also listed and the page has "Thread" list
  but it only has replies to the cover mail. No other patches.
  https://sashiko.dev/#/patchset/20260522170857.263969486%40kernel.org
- v18 seems correctly parsed, which has "In-Reply-To:" tag in the mail header.
  https://sashiko.dev/#/patchset/177701351903.2223789.17087009302463188638.stgit%40mhiramat.tok.corp.google.com

So I guess Sashiko's email header parser does not correctly handle
the "References:" tag for recognizing thread.

Thank you,

> 
> -- Steve


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
