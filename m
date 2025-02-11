Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 273C5253B78;
	Tue, 11 Feb 2025 15:49:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739288999; cv=none; b=fB54Igb9HqYsRvk4GXwqQiabaqbBzKgrE1TNtFFmRlH4xg4M2fw4+ENLxCJtC+y3Rd2rbxbb1aSmP6fTCvZf0MTWHGDLQs6p6ktu2uDu/YJ+R40mXQV8f+UUbcg8pwwlbiTDqnPAlBvUrbMySGZcSfb7nrFFbiHfVpA576d92EI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739288999; c=relaxed/simple;
	bh=WH6M6M02Yrw5Vf7oinZl3vqvT5eLFg3LKVqdyJx/LQg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=D9QW7IFPFP/XthfBCOTxwVqtsUxCDGuTSUD2MEoDdYS4KS7Wm2FJYKrUsipaLZb6Cnw3+U9wpyymqcwJIkFbuP9TRpbkYReOqRHJPELrLIpl7jbUjJF/3RHx9IqFcANERaf+swCwF6Ra9zzCH5BokLj8QpfZ0JCBh0R8FVcy7KY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25DABC4CEE6;
	Tue, 11 Feb 2025 15:49:57 +0000 (UTC)
Date: Tue, 11 Feb 2025 10:50:02 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>, Gabriel de Perthuis
 <g2p.code@gmail.com>, Haiyue Wang <haiyuewa@163.com>, Sami Tolvanen
 <samitolvanen@google.com>, Mark Rutland <mark.rutland@arm.com>, Thomas
 Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav
 Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, "H .
 Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
 linux-trace-kernel@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] ftrace: x86: Fix a compile error about
 get_kernel_nofault()
Message-ID: <20250211105002.31b5a517@gandalf.local.home>
In-Reply-To: <20250211100914.GA29593@noisy.programming.kicks-ass.net>
References: <173881156244.211648.1242168038709680511.stgit@devnote2>
	<20250206081225.GI7145@noisy.programming.kicks-ass.net>
	<20250206205449.5f83a585945ae6eb0cc15483@kernel.org>
	<20250206121328.GN7145@noisy.programming.kicks-ass.net>
	<20250206123307.GO7145@noisy.programming.kicks-ass.net>
	<20250207085959.b3e9d922eab33edf885368e3@kernel.org>
	<20250210173016.0ce79bc8@gandalf.local.home>
	<20250211100914.GA29593@noisy.programming.kicks-ass.net>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 11 Feb 2025 11:09:14 +0100
Peter Zijlstra <peterz@infradead.org> wrote:

> I was aiming my patch for x86/core, but if there's a reason to expedite
> them, I can stick it in x86/urgent I suppose.
> 
> Just need a reason -- what's this compile error nonsense about, my
> kernels build just fine?

Masami,

Do you have a config that fails to build without this fix? If so, can you
please reply with it, and then this can go in as a quick fix.

Thanks,

-- Steve
