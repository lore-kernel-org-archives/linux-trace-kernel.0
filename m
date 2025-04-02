Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF99C199FA2;
	Wed,  2 Apr 2025 17:02:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743613355; cv=none; b=cNapctv6gQajpUcpJ5/+XJcmb7myZC/x5pJsv0RyLFBWyoXTlFNeBfKg0nju/hxI/JGWRVodu/jedIdgT30RWdNYB49ekTDBETEL7zEez5EAxCqCVkRodXA0aLhLXrljpaesxphV3e25RSvOiGNMOI1f9uxzSkaznflz4jrozbE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743613355; c=relaxed/simple;
	bh=ypZ5lkdCw6hIZocAdkwLv0dHgZuinRcp9WIhOipqeZg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RsTsVm7d/x0VG/W3MNthmY1fERbKFeLyha4EIX7HPqptdbd1ZnLrueBc8gE5fRYGVUUMsR13APvZXRg/2ZFR4J6ZY6DsN0/IhQ4ZVguc2RBwbdh0BSmQpuWzIKXE+TrxshboZALcnKDp/1IFRH6JGBl19Er0+t7YX787BejjrB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74577C4CEDD;
	Wed,  2 Apr 2025 17:02:34 +0000 (UTC)
Date: Wed, 2 Apr 2025 13:03:37 -0400
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
Message-ID: <20250402130337.5de5a8cf@gandalf.local.home>
In-Reply-To: <20250402125548.02cc57d0@gandalf.local.home>
References: <20250401225811.008143218@goodmis.org>
	<20250401225842.597899085@goodmis.org>
	<CAHk-=wifCDa6FfRKzeioYuEqJFTeXnYQ1DpeuYsmmn59NWuakQ@mail.gmail.com>
	<20250402125548.02cc57d0@gandalf.local.home>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 2 Apr 2025 12:55:48 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> This patch series fixes that miscommunication and separates out a memmap'ed
> buffer from reserve_mem buffer and simplifies everything.

Since I only care about memory mapping a buffer from reserve_mem to user
space, this series makes sure that a buffer created from memmap (or any
other physical memory area) is never used for mapping to user space. It
also prevents that buffer from being freed, as it is not part of the buddy
allocator and can't be added later.

That also means all the tricks to determine where the page in the ring
buffer came from can go away.

-- Steve
