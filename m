Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2550F4ED;
	Tue,  1 Apr 2025 01:35:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743471320; cv=none; b=NbGP1u0j2vZ7tEldmCG1uNs62ivGXt4SsTJMdehUCb/1lgkdOlfYUAUF5457LCLjusmVXcpJPFR5TnR66JPAnbSD87jz5kI/8NsBimEyXPauRwMhK2noT2CNarktgLn2Qsbd7IPYUsLxTv5qaTpLKclQcNoLAq1r5NuFygai0uM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743471320; c=relaxed/simple;
	bh=9YJUmMItkjc6e8Co0ECsn/RUHcvJEzzH2+M6buQrj9I=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GqIxyBg6Ia+Kfs3Ov2t3XJsJ6nAAn7Syf3IxgrajLh4bK9bDhy7g1PTBwkE9mt5VusI08e3Eexben/7Mk70QQI+YTWABN6hqXEm/xJhh87j87+DdizJKIzC5CqmfURSR6uxQA/bWoeMII6Fpw0uDp7CppoFybf6sL46c6x0XRkI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B005CC4CEE3;
	Tue,  1 Apr 2025 01:35:17 +0000 (UTC)
Date: Mon, 31 Mar 2025 21:36:16 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, Masami
 Hiramatsu <mhiramat@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Andrew Morton
 <akpm@linux-foundation.org>, Vincent Donnefort <vdonnefort@google.com>,
 Vlastimil Babka <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>, Kees
 Cook <kees@kernel.org>, Tony Luck <tony.luck@intel.com>, "Guilherme G.
 Piccoli" <gpiccoli@igalia.com>, linux-hardening@vger.kernel.org, Matthew
 Wilcox <willy@infradead.org>
Subject: Re: [PATCH v2 1/2] tracing: ring-buffer: Have the ring buffer code
 do the vmap of physical memory
Message-ID: <20250331213616.18ccfa37@gandalf.local.home>
In-Reply-To: <CAHk-=wh4b8hNT5XRDj9M4damUmij2bJGaRamqQ_icEkVUv8svg@mail.gmail.com>
References: <20250331143426.947281958@goodmis.org>
	<20250331143532.459810712@goodmis.org>
	<CAHk-=whUOfVucfJRt7E0AH+GV41ELmS4wJqxHDnui6Giddfkzw@mail.gmail.com>
	<20250331133906.48e115f5@gandalf.local.home>
	<CAHk-=wi5pLoe3szxLREQGGJuWU0w_POK9Sv6717UH3b7OvvfjQ@mail.gmail.com>
	<20250331165801.715aba48@gandalf.local.home>
	<CAHk-=whRNxdkLC6Z91g-_RbrRsUo6K6+nvRWqccjsOycwUe_JQ@mail.gmail.com>
	<20250331194251.02a4c238@gandalf.local.home>
	<CAHk-=wiDQpOeXi_GjKB7Mrh93Zbd__4k+FF_vJd+-prbaacEug@mail.gmail.com>
	<20250331203014.5108200c@gandalf.local.home>
	<CAHk-=wg0wQb+CbUk2GY0CeVuTQvq67-oYR0nL8wGgySia3ce7g@mail.gmail.com>
	<CAHk-=wh4b8hNT5XRDj9M4damUmij2bJGaRamqQ_icEkVUv8svg@mail.gmail.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 31 Mar 2025 17:49:07 -0700
Linus Torvalds <torvalds@linux-foundation.org> wrote:

> For example, just adding flush_dcache_range() into
> include/asm-generic/cacheflush.h should be more-or-less trivial, with
> the same kinds of "architectures can make clear they have their own
> optimized version".

Just so I'm clear. Are you suggesting to add flush_dcache_range() to
cacheflush.h and using that?

Looks like some of the code would be able to remove the ifdefs:

 #ifdef CONFIG_PPC
	flush_dcache_range(...);
 #endif

if that's the case.

-- Steve
