Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D8C12376EF;
	Wed,  2 Apr 2025 14:27:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743604061; cv=none; b=MgaN8sXhPpWdBPraT1pLYRf70iBQBKVsuCHG8jDEdYV399ClomrRTAhV5koWsAO+Mf7BUFR4VAPJLeEWCx4/gs0xOYj/01GndOSQs0yNm7nBVHsfcgD+pk8JZwja8NK2njTM6sujKZlxcPvEteCjk8mNUr/p99tRYEaAu+CrKPQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743604061; c=relaxed/simple;
	bh=w2Ej/Fj6cJGcsF2YR/K4bf7FmbvNDM3IPvVHx/lhqIQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NZK5oGYoXf2XvoaPhTR69DyR9jvnDn5WNs57Rl3nW/2RvS3p8E/Bbq+WwPO08QYsAcrpaL4Dt5IiUt6zGwoMXkwlGG4vNoRg1j8eFA7MC31gOPXDXEQpb2mMlIVzr6rClfoXE9IoRvt5fLKbv/R988IOA3JATQIoTvDzSPt3KJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6781C4CEDD;
	Wed,  2 Apr 2025 14:27:39 +0000 (UTC)
Date: Wed, 2 Apr 2025 10:28:42 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Mike Rapoport <rppt@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, Linus
 Torvalds <torvalds@linux-foundation.org>, Masami Hiramatsu
 <mhiramat@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Mathieu
 Desnoyers <mathieu.desnoyers@efficios.com>, Andrew Morton
 <akpm@linux-foundation.org>, Vincent Donnefort <vdonnefort@google.com>,
 Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>
Subject: Re: [PATCH v5 2/4] tracing: Have reserve_mem use phys_to_virt() and
 separate from memmap buffer
Message-ID: <20250402102842.238a03f3@gandalf.local.home>
In-Reply-To: <Z-0CPFGDqcUt-fMp@kernel.org>
References: <20250401225811.008143218@goodmis.org>
	<20250401225842.429332654@goodmis.org>
	<Z-0CPFGDqcUt-fMp@kernel.org>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 2 Apr 2025 12:24:12 +0300
Mike Rapoport <rppt@kernel.org> wrote:

> > The reserve_mem kernel command line option may pass back a physical
> > address, but the memory is still part of the normal memory just like
> > using memblock_reserve() would be. This means that the physical memory  
> 
> ... using memblock_alloc() would be

Heh, I looked for examples of code that used free_reserved_area() and found
initramfs.c which uses memblock_reserve(), which is why I picked that.

I'll update.

Thanks for reviewing Mike!

-- Steve
