Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E1A82E1C7E;
	Thu, 10 Jul 2025 11:19:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752146344; cv=none; b=psXHN2YgD7DWmuJLCdJ9lkODamvxlmzOtguGBikcikgqEcHI3znpog7a0vL5AdEVT1XKi51nC5kd+R/gCKeAJHAaBeMNkOaRplHWe3RICbTXuyxQs+E5jIAmDbMPdR3KHUbInICi3XgtJxKve69aB8/oxu34hmO0wlw/Qyy6xSs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752146344; c=relaxed/simple;
	bh=Sk8yLEhz9dqlNlbGBfJ5O2KrY7Siu3w6E4muTh88lfg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=u7T+3iPT1xHqrmwNZ4eYiyU+9rLVhw8mBu9veqCmy/CBNnqFYzFzbBPbD1Y6N1SJ5IKC4aF/VnBjMxR3UmigpoiXiF+So3thxGVVC1uZ/vx+I4W5GG3UvT2Tlt2/jQtGJXhvlxevEc6kObqH8e4eT2M5YkP4q+YlTBihFI/R/FI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=Eu24Te9V; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Eu24Te9V"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=Ay7vtRDPj3I+842kszjez2KV8eA7wuEEs1vn3I9MIxM=; b=Eu24Te9VTZvr23LTKHnmRGMsnU
	adibSDWuOb2Sdg4zKuSF0raWaj5DbaUhrxWUT/bDGWcY9So8xrQhwJ9LGZevTiVDfQRKu4Upklvg0
	ag3XL+MZyb55cO1iMcs7exp6wpffZk10TaplEc9Fw7TuxksXQWT/FPffQ4uQq1V4DIdA461Wns+1b
	6WgbXF6NKIOAL5orOpsFzJNsSqyqOnOQdvH3ZOr0eZ1tIkHZD6rSIw8LJ46dw39AHGIXX5m/IwFUq
	xSb2/DCoSNIObGEX/TnvNbzUmyggLgpQy6r9hkPo6uX1pvghU/TmbnowzK9xLTGnyN2KJLL04c0xM
	S6FgjAog==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uZpId-000000090Dl-1hl1;
	Thu, 10 Jul 2025 11:18:47 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id ED3C1300125; Thu, 10 Jul 2025 13:18:46 +0200 (CEST)
Date: Thu, 10 Jul 2025 13:18:46 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Mike Rapoport <rppt@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Andy Lutomirski <luto@kernel.org>, Borislav Petkov <bp@alien8.de>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Daniel Gomez <da.gomez@samsung.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Ingo Molnar <mingo@redhat.com>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Luis Chamberlain <mcgrof@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	"H. Peter Anvin" <hpa@zytor.com>, Petr Pavlu <petr.pavlu@suse.com>,
	Sami Tolvanen <samitolvanen@google.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Yann Ylavic <ylavic.dev@gmail.com>, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, linux-modules@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org, x86@kernel.org
Subject: Re: [PATCH v2 0/8] x86: enable EXECMEM_ROX_CACHE for ftrace and
 kprobes
Message-ID: <20250710111846.GE542000@noisy.programming.kicks-ass.net>
References: <20250709134933.3848895-1-rppt@kernel.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250709134933.3848895-1-rppt@kernel.org>

On Wed, Jul 09, 2025 at 04:49:25PM +0300, Mike Rapoport wrote:

> Mike Rapoport (Microsoft) (8):
>   execmem: drop unused execmem_update_copy()
>   execmem: introduce execmem_alloc_rw()
>   execmem: rework execmem_cache_free()
>   execmem: move execmem_force_rw() and execmem_restore_rox() before use
>   execmem: add fallback for failures in vmalloc(VM_ALLOW_HUGE_VMAP)
>   execmem: drop writable parameter from execmem_fill_trapping_insns()
>   x86/kprobes: enable EXECMEM_ROX_CACHE for kprobes allocations
>   x86/ftrace: enable EXECMEM_ROX_CACHE for ftrace allocations

Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
