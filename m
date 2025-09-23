Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73144313D48;
	Tue, 23 Sep 2025 12:16:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758629803; cv=none; b=DqX6+MKGUUB+XV1Mf0j/qS3AkO3IqEksVoyd0jW1yzWPN97PeOfkh+FUxZvHSsBAEJxbFX23ypJNEuzAOtyBRDrDSkb+eq9HoVqPsplmM+bOzb19onU61/51IMpxIjr0QULWXhcUESWwq8bqWu9PVleG9OESq4YYz3ufxhf4c+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758629803; c=relaxed/simple;
	bh=LpPwgkPOFFj4f6p46yUHv3+NqbNrx5FI55W7uiJ7e3s=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Pe4LJw3VUdMsbKfwp14vIQSbyGIQRnCCUrUMdScCae5yZFUYnw7H5Am0t+rQFpxuy5YatGNxncVZkeSMdTzJA7FNoVW06kMCGXdhtwcKVO/h6tiYLbO4ne3T+Ld0ADX/NejaaYfdqPMyP9wQaDxgkN+Sh3MOzkxHGAYL1AdFt18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YaY54zQw; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YaY54zQw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E23F0C4CEF5;
	Tue, 23 Sep 2025 12:16:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758629803;
	bh=LpPwgkPOFFj4f6p46yUHv3+NqbNrx5FI55W7uiJ7e3s=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=YaY54zQwHVs+wWZOk4fmHWhRWqXMCJSxicNnD+pdINd2vl2XOOgqkxA1ZzeUexF7m
	 LBPvqPCnbrSB2bdCakQHumwGVp3npdw9eISfjQ6ZvtnhfUq3XeVpcU9oLYrA2iZNWX
	 Haty5AiIuOTXdpqDafSRyWpI/391FYAWEYCL8JrEqrVFwIxe0DtgUycBYxsvx+8+1G
	 yhewcwMk9o3ourwOAm4sFl65oM30KGcBL8PQ7WnSwnvtiJAPg5nQOB1rWJ0LrEZpZK
	 OQiT+azwPA6rI7GzTiIY6hcIsEK1DVe1QyBsVoripFZDQPEPoq1VaADo9N1gTbUtRB
	 vzp0EzgrG58bA==
Date: Tue, 23 Sep 2025 08:16:34 -0400
From: Steven Rostedt <rostedt@kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 x86@kernel.org, Masami Hiramatsu <mhiramat@kernel.org>, Mark Rutland
 <mark.rutland@arm.com>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>, Thomas Gleixner
 <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov
 <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, Linus Torvalds
 <torvalds@linux-foundation.org>, Josh Poimboeuf <jpoimboe@kernel.org>
Subject: Re: [PATCH v2 2/2] unwind deferred/x86: Do not defer stack tracing
 for compat tasks
Message-ID: <20250923081634.24ef8132@batman.local.home>
In-Reply-To: <20250923104515.GF3419281@noisy.programming.kicks-ass.net>
References: <20250827193644.527334838@kernel.org>
	<20250827193828.514833400@kernel.org>
	<20250923104515.GF3419281@noisy.programming.kicks-ass.net>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 23 Sep 2025 12:45:15 +0200
Peter Zijlstra <peterz@infradead.org> wrote:

> Changelog seems to forget mentioning *why* we can't unwind compat.
> 
> I'm sure I've seen compat FP unwind support at some point in this
> series. Did that go missing somewhere?
> 
> Also, these two patches are in the wrong order, first you enable things,
> including compat tasks, and then you go 'whoopsie, no compats'.

Sure, we can swap it. Yes, we had patches to support it, but they
were a bit complicated and when I tested them, they didn't work. But
then I also noticed that the current stack tracing didn't work on
compat either. Instead of adding complicated code that wasn't working
on my machine, I decided to remove the patches. But after I did that, I
realized I needed to make sure it wasn't even tried, which is this
patch.

I'm not sure who needs profiling on compat code, and I figured we can
not add the new deferred work to it if it's not needed. If in the
future we need it, we can add it then.

-- Steve
