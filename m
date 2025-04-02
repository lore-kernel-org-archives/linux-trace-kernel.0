Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F356139D0A;
	Wed,  2 Apr 2025 16:54:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743612887; cv=none; b=YXjMp4a/as6wFFqFbDnNTyPVDyJ+q8FEQvZp6IlpEN09q/Pvh0WSn4LGaFNE0Wo8GAJHduQWpPNUYPkqQ5tI65ptU6SEn2zkp6pPSNIstZZBlG6IDf+ao6ZPyN7qJH0zbgNQbtIfFsBYGdyEv4TR0BYu7gWNCkPxCjOtXQfDNp8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743612887; c=relaxed/simple;
	bh=MR3fDU+b7gYBrk9ZeJO0EsLoCaz0qFw+vgE7GtJtipc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TpY+YcxnXE+GHk+2WBt7XNoiYbmKkRqsDa3ArwJcfKBDU96mEZvwNFzraGKRrAzjA2KrA/KvADIJDHF9W1n0EpHN+ekX5mNYLhTXUIFOoVDhTbGcxUwqipDKchUSA8xRe9ywMED80AcmTi/S2I6HCIux0S7Nesjr6Bd4jnrbxBM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A47FAC4CEDD;
	Wed,  2 Apr 2025 16:54:45 +0000 (UTC)
Date: Wed, 2 Apr 2025 12:55:48 -0400
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
Message-ID: <20250402125548.02cc57d0@gandalf.local.home>
In-Reply-To: <CAHk-=wifCDa6FfRKzeioYuEqJFTeXnYQ1DpeuYsmmn59NWuakQ@mail.gmail.com>
References: <20250401225811.008143218@goodmis.org>
	<20250401225842.597899085@goodmis.org>
	<CAHk-=wifCDa6FfRKzeioYuEqJFTeXnYQ1DpeuYsmmn59NWuakQ@mail.gmail.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 2 Apr 2025 09:42:00 -0700
Linus Torvalds <torvalds@linux-foundation.org> wrote:

> Wait, what?
> 
> Didn't you just say that you can just use page_address() for the kernel mapping?

Correct. I misunderstood Mike when he created the reserve_mem and had it
return physical addresses. I didn't realize he had it already mapped via
the normal virtual mappings.

> 
> So the whole vmap thing is entirely unnecessary in the first place.
> 
> Including the simpler vmap_page_range().

Not entirely. The original code only used memmap=, which does require the
vmap_page_range(). The reserve_mem came later, and thinking it was just
physical address space (not a mapping), I just had it use the memmap code.

That is, the persistent memory buffer was originally created on top of the
memmap feature (and only for x86). I talked with Mike about making it more
generic and he and I worked out the reserve_mem option. Having the memmap
code already doing the vmap() I just had the reserve_mem version use the
same, not knowing that it could just use phys_to_virt().

This patch series fixes that miscommunication and separates out a memmap'ed
buffer from reserve_mem buffer and simplifies everything.

-- Steve
