Received: from relay.hostedemail.com (smtprelay0015.hostedemail.com [216.40.44.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEFDD245005;
	Thu, 21 May 2026 01:28:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779326920; cv=none; b=cJ/Ap942yjk1WODnWSTq0RRiuL/wLQyD34jwFUictuO7JznYD2/vpLhg7sAuM9HbYBOCwofJY3wvt+XWGWNdHLQsOCtoxaYpXupjPlfvGGPaybHrOdnGksB5ju1Sx8oSlvNWbBrv0+IuNCzUBltZ4TCJvN/zD582zy0prm68tFI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779326920; c=relaxed/simple;
	bh=Ng6YLN7/9EK2Hk78DwtUOjU+p0fkuR/dSyxhOZGnHuk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZpXEQHvj0Gy5iPFWjqT8jlafSwzpKI3GCbV2GGh7WTGMHNFEhwgF7Mpag4rKcaVKdEIzS8NLWmkN8rJU8K08Rmk8aO+y3W+vKCdxDjLVaysm/wkPe5ZF7+YzcXbEO1sCBxTYFMkDKB1o3wExFyuXQGH83qYiXo58kbwrX56UuuM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf08.hostedemail.com (lb01a-stub [10.200.18.249])
	by unirelay04.hostedemail.com (Postfix) with ESMTP id 231991A047E;
	Thu, 21 May 2026 01:28:32 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf08.hostedemail.com (Postfix) with ESMTPA id 200D920029;
	Thu, 21 May 2026 01:28:30 +0000 (UTC)
Date: Wed, 20 May 2026 21:28:29 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Rosen Penev <rosenp@gmail.com>
Cc: linux-trace-kernel@vger.kernel.org, Masami Hiramatsu
 <mhiramat@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Mathieu
 Desnoyers <mathieu.desnoyers@efficios.com>, linux-kernel@vger.kernel.org
 (open list:FUNCTION HOOKS (FTRACE)), sashiko-bot@kernel.org,
 sashiko-reviews@lists.linux.dev
Subject: Re: [PATCH] ftrace: Use flexible array for hash buckets
Message-ID: <20260520212829.7734bad4@fedora>
In-Reply-To: <20260520220030.16887-1-rosenp@gmail.com>
References: <20260520220030.16887-1-rosenp@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: 66c1dh6ewimhoo74b381d7i3k74xih3b
X-Rspamd-Server: rspamout02
X-Rspamd-Queue-Id: 200D920029
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1939DSu3X+F/R6SI5UJOKGH24A7XYOr+Iw=
X-HE-Tag: 1779326910-127973
X-HE-Meta: U2FsdGVkX19Ndon8t6NubPJO92siBq5ifZS2S1HF+QhmerJ9VReFiQDNd/MGuzN3dLRnYzi62jJqP19qgFhGqY/PBEFCrpCnvfR++/99eD+/tcZY1O+3c1h4pwyDhGmoInyJzK48Z6TDxY25l9KjGw38d8lexEpXW+0xhFWR+J9Feb0rBCT9z4GgvU/w5peV/SS3jQ7D0CPdTIYt3SLYv1cEUoJSvvxi6sB6kbKrdOTkfNAdDWdE4+JapX9bacOQqDw5rXjRU0WdtaGm1SdtWZEMAvHmH5LUHksdXr7HPOet5jUAm4qYjDzQUXReRfQ9dBfsivWMIezj1cv/SnDPKM0R/Tb1UxzjxdAki+PTXTzx3rlvVCdQXhyxGtycmrg90Fzlrb5k4/706p4dGG9ydQ==

On Wed, 20 May 2026 15:00:30 -0700
Rosen Penev <rosenp@gmail.com> wrote:

> Store ftrace hash buckets in the ftrace_hash allocation instead of
> allocating the bucket array separately.
> 
> This keeps the bucket storage tied to the hash lifetime and simplifies
> the allocation and cleanup paths.
> 
> Assisted-by: Codex:GPT-5.5

I'll let the AI's duke it out!

> Signed-off-by: Rosen Penev <rosenp@gmail.com>
> ---
>  kernel/trace/ftrace.c | 17 ++---------------
>  kernel/trace/trace.h  |  2 +-
>  2 files changed, 3 insertions(+), 16 deletions(-)
> 
> diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
> index b2611de3f594..25a9dca290dd 100644
> --- a/kernel/trace/ftrace.c
> +++ b/kernel/trace/ftrace.c
> @@ -1082,10 +1082,7 @@ struct ftrace_func_probe {
>   * it all the time. These are in a read only section such that if
>   * anyone does try to modify it, it will cause an exception.
>   */
> -static const struct hlist_head empty_buckets[1];
> -static const struct ftrace_hash empty_hash = {
> -	.buckets = (struct hlist_head *)empty_buckets,
> -};
> +static const struct ftrace_hash empty_hash = {};
>  #define EMPTY_HASH	((struct ftrace_hash *)&empty_hash)


According to Sashiko: https://sashiko.dev/#/patchset/20260520220030.16887-1-rosenp%40gmail.com

   Could this conversion to a flexible array member cause an
   out-of-bounds read when iterating over the empty hash? Because
   empty_hash is now initialized as an empty struct, its flexible array
   member buckets has a size of 0. However, empty_hash.size_bits is 0,
   which means loop limits computing '1 << hash->size_bits' will
   evaluate to 1. If functions like
   prepare_direct_functions_for_ipmodify() iterate over a default
   EMPTY_HASH without checking ftrace_hash_empty(), they will attempt
   to read EMPTY_HASH->buckets[0]. This reads past the end of the
   struct into adjacent memory in the .rodata section. If that adjacent
   memory happens to be non-zero, the linked list loop could
   dereference it and cause a kernel panic. Prior to this patch,
   empty_buckets provided a safely zeroed array of size 1 to handle
   this single iteration.

-- Steve
