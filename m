Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5176B38655B;
	Wed, 18 Mar 2026 15:29:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773847761; cv=none; b=e5L3XIIEYpvfrDbH/FVOOsf8OFV9pW9dLrPWvGGTfp8Hp4FG7Lb28OIfjzbakJ24+H+SWiddlVPBaOBLeBXtmyiD1srREmsk0l9cUEsF9BqQLOgfe7XqgyV9gFSr0oSlrjFJXdRf7399Rf0fnuHc6mBbFgLIMXHFKe5sB/eGBos=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773847761; c=relaxed/simple;
	bh=06Fq4gORZM1xYV0H1J7LDVH/t7xjq13eQuYnJza8jWc=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=dJNMx8ReeUAKMXO97ghQRxkRSuLNmY9pIQ90VzlzNJW9rr5K504sVBQKe1cc33Wr+eCrSS2jkUVw0fRVicPCdiU1uUP6vt+vD6Hv8l0/kbHesS06xZpu/5H3ilDzTZDBVx8naTxNp0y8M7lySUg70QGKRWthLFaN5E2jjzzEDbE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Bq7KQciR; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Bq7KQciR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0390CC19421;
	Wed, 18 Mar 2026 15:29:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773847760;
	bh=06Fq4gORZM1xYV0H1J7LDVH/t7xjq13eQuYnJza8jWc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Bq7KQciRST/Uwjx0unXzxGROxmjuju4PmpUDDsrHz7VC4TUAk8/ZSt/n2Bq55yz8K
	 +s4jtQMkMxSLvFtH5MkR/h2FfZtGyzsL+u93F6fLrqU1xQ7xDBIFqFXHhLkY5LI3se
	 d1cOu46SXbk3s5p+1E8kTVZXvdGbs+GrRkI25v8l6QJG+SUf9pTGRVvJIjJB8KWt/w
	 jDwTkQoM6mzQhmdpu06/sxfW1AL3lRYEt/q6pts2lwK1+xq2GJ8dC5a+sBKB1ViuA4
	 kf9/MgBOdhBQqHvu7VatgEefA2CE03JDQfYOZrNmULi8r4k3NMeORix5rTiTMhuuvA
	 J7OqxAnZAHSag==
Date: Thu, 19 Mar 2026 00:29:18 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Steven Rostedt <rostedt@goodmis.org>, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, Ian Rogers <irogers@google.com>
Subject: Re: [PATCH v9 2/4] ring-buffer: Flush and stop persistent ring
 buffer on panic
Message-Id: <20260319002918.5768a8ee053dd35373e215f2@kernel.org>
In-Reply-To: <c91f37bf-97e9-4752-99a9-3d534ce9d2f0@efficios.com>
References: <177319273059.130641.10882692460536780093.stgit@mhiramat.tok.corp.google.com>
	<177319274904.130641.3303707869402603363.stgit@mhiramat.tok.corp.google.com>
	<20260318231959.717f07ec491a731941aee1d9@kernel.org>
	<c91f37bf-97e9-4752-99a9-3d534ce9d2f0@efficios.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 18 Mar 2026 10:53:26 -0400
Mathieu Desnoyers <mathieu.desnoyers@efficios.com> wrote:

> On 2026-03-18 10:19, Masami Hiramatsu (Google) wrote:
> > On Wed, 11 Mar 2026 10:32:29 +0900
> > "Masami Hiramatsu (Google)" <mhiramat@kernel.org> wrote:
> > 
> >> From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> >>
> >> On real hardware, panic and machine reboot may not flush hardware cache
> >> to memory. This means the persistent ring buffer, which relies on a
> >> coherent state of memory, may not have its events written to the buffer
> >> and they may be lost. Moreover, there may be inconsistency with the
> >> counters which are used for validation of the integrity of the
> >> persistent ring buffer which may cause all data to be discarded.
> >>
> >> To avoid this issue, stop recording of the ring buffer on panic and
> >> flush the cache of the ring buffer's memory.
> > 
> > Hmm, on some architectures, flush_cache_vmap() is implemented using
> > on_each_cpu() which waits IPI. But that does not safe in panic notifier
> > because it is called after smp_send_stop().
> > 
> > Since this cache flush issue is currently only confirmed on arm64,
> > I would like to make it doing nothing (do { } while (0)) by default.
> 
> FWIW, I've sent a related series a while ago about flushing pmem
> areas to memory on panic:
> 
> https://lore.kernel.org/lkml/20240618154157.334602-3-mathieu.desnoyers@efficios.com/
> 

Ah, nice!

> When reading your patch, I feel like I'm missing something, so please bear with
> me for a few questions:
> 
> - What exactly are you trying to flush ? By "flush" do you mean
>    evince cache lines or write back cache lines ? (I expect you aim
>    at the second option)

Yes, I need to write back cache lines, at least it can be
read after hot reboot. (not evict cache)

> 
> - AFAIU, you are not trying to evince cache lines after creation
>    of a new virtual mapping (which is the documented intent of
>    flush_cache_vmap).

Ah, OK. That's a good point!
(anyway I will replace it with do { } while (0) in the next version.)

>    
> - AFAIU flush_cache_vmap maps to no-code on arm64 (asm-generic), what am
>    I missing ? It makes sense to be a no-op because AFAIR arm64 does not
>    have to deal with virtually aliasing caches.

Yeah, so my patch also introduces arm64 specific implementation.

> 
> see commit 8690bbcf3b7 ("Introduce cpu_dcache_is_aliasing() across all architectures")

OK, let me check.

> 
> The arch_wb_cache_pmem is specific to pmem, which is not exactly what you want
> to use, but on arm64 it's implemented as:
> 
>          /* Ensure order against any prior non-cacheable writes */
>          dmb(osh);
>          dcache_clean_pop((unsigned long)addr, (unsigned long)addr + size);
> 
> Which I think has the writeback semantic you are looking for, and AFAIU should no
> require IPIs (at least on arm64) to flush cache lines across the entire system.

Yes, that's what I need.

Thank you!


> 
> Cheers,
> 
> Mathieu
> 
> -- 
> Mathieu Desnoyers
> EfficiOS Inc.
> https://www.efficios.com


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
