Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72A8E1C84B2;
	Tue, 25 Mar 2025 19:38:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742931524; cv=none; b=RAFdrF1Y8DzqDg19sh1ysT78Gj0d3uabOJcZyAB9tGfpDIhcfdCnhAwzZMLsSQKneFpaCfT2/y2ZZNUzuM/BPde3bdolq96K26SLRKeCKuV2Hy2qqvtIaDkNugd0Z2HiX+rlqUqbXgr90l0Yh2HDO8faGgnb0VG4mi5NRLWGKzE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742931524; c=relaxed/simple;
	bh=cCzRPZR36CeDuVFblvhPpvooqSdvmdM3hUpVjselwBM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bzpVYmkJnW6aHlkoviMxfbA5iw3SChUhV0kQ3FaO7Qu7NmB4Z+g4+K6051sicl3qirAgjyaRTo9BEdwQmSx5Bg8jIjTMTB05j8KFfTNw4ZWqeDLGmPbwvazYXPdmf7ufOm91Tu7gjdf1OJoENpCSkRwdFz8ky5zRmTypc5hx7J8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z1ssPvgD; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z1ssPvgD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DBCF6C4CEE4;
	Tue, 25 Mar 2025 19:38:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742931522;
	bh=cCzRPZR36CeDuVFblvhPpvooqSdvmdM3hUpVjselwBM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Z1ssPvgDg+h3HzcBJjbFvleIeOP8lJq+ZY+pjqpGcYRS5yLGkXFHshdEGGRQ5xjYD
	 Xh1NkxA3i+1hIa98+DDMZUPPerF36yX4bDbwdxfVCWkiS4yEup0ooeXNkUYWpFdOds
	 JWhtQQaKwYud777ZNofvnJ/EtNRIyE9S9KzA0+MobsTuQWKOt6eVd1rG/oDe6CuDV6
	 HmDVjS5eal4xyZyD4kpRjMVKOudP2TnoSudqqKcC/VwSmQLxoJ02Ed1y/4yecOJZKO
	 GJ7+U5ZTjkDdVoPyJ0/XIqPHmAUFlJrDBj4vgb9+sMXDJqWrLo7FwVZGaaCbfngHIB
	 ugJXt7g8N55qw==
Date: Tue, 25 Mar 2025 12:38:38 -0700
From: Kees Cook <kees@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	Steven Rostedt <rostedt@goodmis.org>,
	"Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	Andy Shevchenko <andy@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Petr Mladek <pmladek@suse.com>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: Re: [PATCH v2 0/6] vsprintf: Add __printf attribute to where it's
 required
Message-ID: <202503251238.4BA5CA87@keescook>
References: <20250321144822.324050-1-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250321144822.324050-1-andriy.shevchenko@linux.intel.com>

On Fri, Mar 21, 2025 at 04:40:46PM +0200, Andy Shevchenko wrote:
> This whole series started from a simple fix (see the last patch)
> to make GCC (Debian 14.2.0-17) happy when compiling with `make W=1`
> (note, that CONFIG_WERROR=y and all warnings break the build!)
> down to a rabbit hole.
> 
> However starting from v2 the last patch doesn't require the first
> part, I prefer still to have them since the functions, while being
> _binary_ printf()-like, are still printf()-like. It also puts in align
> the tracing stuff with the rest and fixes the wrong parameter value.
> 
> These first 4 patches are organised in a strict order and can't be
> reshuffled, otherwise it will produce a warnings in between.
> 
> I believe the best route for the series is printk tree with immutable
> tag or branch for the others.
> 
> Alternatively the first 4 patches can be applied first as they
> are pretty much straightforward. They also can be squashed to one
> (as the same topic behind), but it all is up to the respective
> maintainers.
> 
> In v2:
> - split out patch 5 (Rasmus)
> - rewritten the approach for the va_format() fix (Rasmus)
> - amended tracing patch (removed a blank line and a __printf() in C file)
> 
> Andy Shevchenko (6):
>   seq_buf: Mark binary printing functions with __printf() attribute
>   seq_file: Mark binary printing functions with __printf() attribute
>   tracing: Mark binary printing functions with __printf() attribute
>   vsnprintf: Mark binary printing functions with __printf() attribute
>   vsnprintf: Drop unused const char fmt * in va_format()
>   vsnprintf: Silence false positive GCC warning for va_format()
> 
>  include/linux/seq_buf.h   |  4 ++--
>  include/linux/seq_file.h  |  1 +
>  include/linux/string.h    |  4 ++--
>  include/linux/trace.h     |  4 ++--
>  include/linux/trace_seq.h |  8 ++++----
>  kernel/trace/trace.c      | 11 +++--------
>  kernel/trace/trace.h      | 16 +++++++++-------
>  lib/vsprintf.c            |  9 +++++++--
>  8 files changed, 30 insertions(+), 27 deletions(-)

Cool; it'll be nice to get these marked up.

Reviewed-by: Kees Cook <kees@kernel.org>

-- 
Kees Cook
