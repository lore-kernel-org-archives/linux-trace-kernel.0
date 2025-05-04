Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4AB24C7C;
	Sun,  4 May 2025 09:37:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746351479; cv=none; b=GGb4waOF5G7gO6164MdcEPhzJguWdbESwfrFiheMa/kfi6lbQradVlehU9zMQeoh/ATyM9/y3mPr4hR9D9clVhaisMww1SjvUwjd+kNLFN/P7zxUbg+uwyWK5Wv4xfgrPxcmzNzick1MqGzfez/4zgZJRAH5ZM6lPODlghf3QIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746351479; c=relaxed/simple;
	bh=fgKzmmsmUWQZ6ltCcrOUxmqtyf58VpafDND09pDOJYw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ssPPCmO5+1QHHeHz19HxN2pcEAY2YM24FvF8vFYbBtSLsoDWILeXAz6YmINFb+Cons5dYbGImqyyuYGcvcM8tWnnCmZX1Y7liYZFS61s8rYgt8KoNOpuM5FClcMOfn1TYd81NwkeakFHaYPnzmTObVkuaMcwSdIswxLOg+c94B4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GPlNZ0IG; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GPlNZ0IG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F4A2C4CEE7;
	Sun,  4 May 2025 09:37:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746351479;
	bh=fgKzmmsmUWQZ6ltCcrOUxmqtyf58VpafDND09pDOJYw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GPlNZ0IGpOQdST/uAmRDZOCpqtEYBFIioX7lIwFS9WSbpxYSoyk4WUepQFLyFvqhj
	 zfDn1cjNOcFsTq0uQTIOpkSsPEM5gPIL7gtO2hwjSDTZYQBl1vPsvbT0y9wWXKz+Nu
	 nxZ90NrK06ER52KQ0tq0LJo5u7iw550EDvK1EsTGDn0Y7J4GaRJSyVhBMuEYwIn3ZL
	 AH0qS+nCP9CmPtLor7GSgNmB6Y9OrfQz9+jQZ9ye3/qjcuV05ZzjujHXJb4rtl4pGl
	 +igA1Of0jPPVfbPvwMXzK0w0GstmBN7La0h/OSVwDLbCUgcZipWnIwC8uByyZGL6S0
	 E1LBH2IhrgbOg==
Date: Sun, 4 May 2025 11:37:54 +0200
From: Ingo Molnar <mingo@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>, x86@kernel.org,
	Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>
Subject: Re: [PATCH v7 08/17] unwind_user/deferred: Add unwind cache
Message-ID: <aBc1cqWcTJmeqg3X@gmail.com>
References: <20250502164746.178864972@goodmis.org>
 <20250502165008.734340489@goodmis.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250502165008.734340489@goodmis.org>


* Steven Rostedt <rostedt@goodmis.org> wrote:

> -struct unwind_task_info {
> +struct unwind_cache {
>  	unsigned long		*entries;
> +	unsigned int		nr_entries;
> +};
> +
> +struct unwind_task_info {
> +	struct unwind_cache	cache;
>  };

> @@ -19,17 +20,29 @@ int unwind_deferred_trace(struct unwind_stacktrace *trace)
>  	if (current->flags & PF_EXITING)
>  		return -EINVAL;
>  
> -       if (!info->entries) {
> -               info->entries = kmalloc_array(UNWIND_MAX_ENTRIES, sizeof(long),
> -                                             GFP_KERNEL);
> -               if (!info->entries)
> -		       return -ENOMEM;
> +	if (!cache->entries) {
> +		cache->entries = kmalloc_array(UNWIND_MAX_ENTRIES, sizeof(long),
> +					       GFP_KERNEL);
> +		if (!cache->entries)
> +			return -ENOMEM;
> +        }

That's just sloppy: why isn't the unwind_cache a pointer to begin with, 
with the dynamically allocated object containing ::nr_entries?

Also, the code has whitespace damage.

> +
> +	trace->entries = cache->entries;
> +
> +	if (cache->nr_entries) {
> +               /*
> +                * The user stack has already been previously unwound in this
> +                * entry context.  Skip the unwind and use the cache.
> +                */
> +               trace->nr = cache->nr_entries;
> +               return 0;

Whitespace damage here too. Maybe in other patches as well.

Please don't rush this series without first reviewing it carefully ...

Thanks,

	Ingo
