Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F9E225D1E1;
	Mon, 24 Mar 2025 16:02:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742832123; cv=none; b=bNZoReXlVVww3wgP91h5L10hT7wmtcAjBGAq/4kxDWpyqMq4m6XFZFguOxtcqVlnHyVVjBjbydEGuaLpEHZL9+Mi4urUnxPnn8/x/8Nae8b6jFsd0paFPbW1FtTLA/0O8+4EePMpE6YH8l6VKSUNYyiOBWWQJNpkeYI1EmSa4FE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742832123; c=relaxed/simple;
	bh=5yxIP+NSmnVilJGkaHGXaV9OxZRg2bKu30jyXdvCs8M=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pUPI5kmvxk5VgQHgZG5KcnVk2uip1t/OTXDlCNg08sYJXuGsEYKOaRmP95Jy+gZRVlYH8+o5YpTQM3Bj5gvhikZjE9pJ+VjUHe+EJ5v8BsOnJtQa24ThZHD06n3qEIPb3aOU3xDYc5Svl3re6ts5veQsrtxEDk9BCg472Eb6yek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7EDFBC4CEE9;
	Mon, 24 Mar 2025 16:02:01 +0000 (UTC)
Date: Mon, 24 Mar 2025 12:02:42 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Petr Mladek <pmladek@suse.com>, Christophe JAILLET
 <christophe.jaillet@wanadoo.fr>, Kees Cook <kees@kernel.org>, "Masami
 Hiramatsu (Google)" <mhiramat@kernel.org>, linux-kernel@vger.kernel.org,
 linux-hardening@vger.kernel.org, linux-trace-kernel@vger.kernel.org, John
 Ogness <john.ogness@linutronix.de>, Sergey Senozhatsky
 <senozhatsky@chromium.org>, Andy Shevchenko <andy@kernel.org>, Mathieu
 Desnoyers <mathieu.desnoyers@efficios.com>, Andrew Morton
 <akpm@linux-foundation.org>, Rasmus Villemoes <linux@rasmusvillemoes.dk>
Subject: Re: [PATCH v1 3/6] tracing: Mark binary printing functions with
 __printf() attribute
Message-ID: <20250324120242.49253139@gandalf.local.home>
In-Reply-To: <20250320180926.4002817-4-andriy.shevchenko@linux.intel.com>
References: <20250320180926.4002817-1-andriy.shevchenko@linux.intel.com>
	<20250320180926.4002817-4-andriy.shevchenko@linux.intel.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 20 Mar 2025 20:04:24 +0200
Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:

> @@ -113,7 +113,8 @@ static inline __printf(2, 3)
>  void trace_seq_printf(struct trace_seq *s, const char *fmt, ...)
>  {
>  }
> -static inline void
> +static inline __printf(2, 0)
> +void
>  trace_seq_bprintf(struct trace_seq *s, const char *fmt, const u32 *binary)
>  {
>  }

Do we need to split the line after the __printf()? Can't the above be:

static inline __printf(2, 0) void
trace_seq_bprintf(struct trace_seq *s, const char *fmt, const u32 *binary)

Or even:

__printf(2, 0)
static inline void
trace_seq_bprintf(struct trace_seq *s, const char *fmt, const u32 *binary)

I rather not split the prefix elements of a function over two lines. I
rather not even split them from the function itself, but tend to do that if
space is needed.

-- Steve
