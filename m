Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BF791AAE2E;
	Wed,  2 Apr 2025 17:39:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743615569; cv=none; b=UKt5A2OzQj3BuYic3Y9JIA/0nKBIYNzyMHWZ2idGifF/w/bnaRTnT5hth9Z+IXp0lWa0PV5pIhzqDtiuDpsuFKtsgU6T0vHF2qLbXlbkPJkcsZOgBaZQxQVoKoBiXaU1kDUM52F4IxujZlh2CaHbvVvgXieCoUPK/JgGGmqKHh8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743615569; c=relaxed/simple;
	bh=T/M1oTnlfLgHDNNa9JJTluIXHs7D5y6ziqiRpkUvPPA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WwQsrpbDH4nFWLq4W4xisqpXGzmOBEZG+Szj+vutYS/LwHqwV/tcpcJjeEmeXvodsH7qxu77VxLGO8cvm6Z2LAMgtyJXnoNBagv5Cy/VJHFuWN0cuaph/MuzkrgPFUMd03nNmXGs6o5T3j+4w9uLA9sKq279VvQI9r7tlv3bIi4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49F4EC4CEDD;
	Wed,  2 Apr 2025 17:39:27 +0000 (UTC)
Date: Wed, 2 Apr 2025 13:40:30 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, Masami
 Hiramatsu <mhiramat@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Andrew Morton
 <akpm@linux-foundation.org>, Vincent Donnefort <vdonnefort@google.com>,
 Vlastimil Babka <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>, Jann
 Horn <jannh@google.com>
Subject: Re: [PATCH v5 3/4] tracing: Use vmap_page_range() to map memmap
 ring buffer
Message-ID: <20250402134030.26a9b141@gandalf.local.home>
In-Reply-To: <CAHk-=wh8=QAC0jjcjDRnmsmd2xDf97j8h25=aSFGeh9x+1X8UA@mail.gmail.com>
References: <20250401225811.008143218@goodmis.org>
	<20250401225842.597899085@goodmis.org>
	<CAHk-=wifCDa6FfRKzeioYuEqJFTeXnYQ1DpeuYsmmn59NWuakQ@mail.gmail.com>
	<20250402125548.02cc57d0@gandalf.local.home>
	<20250402130337.5de5a8cf@gandalf.local.home>
	<20250402131431.218d3458@gandalf.local.home>
	<CAHk-=wh8=QAC0jjcjDRnmsmd2xDf97j8h25=aSFGeh9x+1X8UA@mail.gmail.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 2 Apr 2025 10:20:58 -0700
Linus Torvalds <torvalds@linux-foundation.org> wrote:

> You should damn well keep track of where the memory comes from.

And it does.

> 
> You can't just say "I'll take random shit, and then I'll ask the VM what it is".
> 
> Stop it.
> 
> If the address came from something you consider trustworthy, then just
> trust it. If some admin person gave you garbage, it's better to just
> get a random oops than to have random bogus code.

This has nothing to do with admins. This would only occur if the kernel
itself created a buffer from some random physical address and then tried to
mmap it to user space (which would be a bug).

My early career came from the military industry (I worked on the C17 engine
control systems in the early '90s). It was drilled in my head to have
safety checks throughout the code, in case something buggy happened, it
would be caught quickly later on.

The virt_addr_valid() would only be a debugging feature, hence the
added "WARN_ON()" for it.

But I'm fine to not do that.

-- Steve

