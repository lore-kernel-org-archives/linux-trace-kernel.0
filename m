Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCD5F18A6B6;
	Wed,  2 Apr 2025 17:13:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743614009; cv=none; b=qqzNzTXdvZw68IFXawz87EDWXHHEMpvS++wNIIwfk1/6d2Ft4dCl2NClAqd187mSxCwlFl5hfEUcfc+5n/ul4jx0EuHIq0q1lPGdF6MoJvsgH6FySCm22U1/gF3W/FDvER4vEt5SJZLLXpNcB+vgPxIDMnz1Gqy06Uhj0GpAAJQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743614009; c=relaxed/simple;
	bh=R+aZ3eG6ktEORR6fQVCpW95eb4/gWMTUm8t69N02X7Y=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KrSX2PVw2vQ0rUD/yZb9FmRsH8JQU+TdAek/NslEOnuVnBK8jcuglgHM28mBZPW2Om0nkWDm5I5UekorCbiUNPBOGMCo5kuirn7ioWdbsBNIIDRdVOaex2Hf8jSq0GP+8WgQJfzWY7F044akPjfpZVSId+PKyAbJn4dyPHQ4yDE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0BC0DC4CEDD;
	Wed,  2 Apr 2025 17:13:27 +0000 (UTC)
Date: Wed, 2 Apr 2025 13:14:31 -0400
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
Message-ID: <20250402131431.218d3458@gandalf.local.home>
In-Reply-To: <20250402130337.5de5a8cf@gandalf.local.home>
References: <20250401225811.008143218@goodmis.org>
	<20250401225842.597899085@goodmis.org>
	<CAHk-=wifCDa6FfRKzeioYuEqJFTeXnYQ1DpeuYsmmn59NWuakQ@mail.gmail.com>
	<20250402125548.02cc57d0@gandalf.local.home>
	<20250402130337.5de5a8cf@gandalf.local.home>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 2 Apr 2025 13:03:37 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> That also means all the tricks to determine where the page in the ring
> buffer came from can go away.

I wonder, just to be safe, if I should add in the ring buffer mapping code:

	/* If the buffer is not part of the normal memory, do not allow mapping */
	if (!virt_addr_valid(cpu_buffer->reader_page->page))
		return -ENODEV;

?

As the buffer can come from anywhere, but we only allow a memory mapping to
user space if the buffer is from the normal memory allocator.

Currently, this patch series has the caller (the tracing code) prevent
allowing memmap to be user mapped. Perhaps the above should include a
WARN_ON_ONCE()?

-- Steve
