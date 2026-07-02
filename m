Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67AF510F1;
	Thu,  2 Jul 2026 01:15:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782954948; cv=none; b=KvwcmVRc9+wODAlJkhsQTS9+18uh7cBflhdHy7yNCOA/tmUFt/2IWW9RvqXWiSa0h7kDzmrRtMXB3naPGZf8V7WVG0iJaLtyNHF6jug6QoBfWmebwuZsPqzzZP399OvVQkDraa9Y+u/2qvomDNUbplY6VggeDhv08eDEmEPpUCE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782954948; c=relaxed/simple;
	bh=NBKNdAYuE0odx78pG/3i0vLnXqdd7I2SwEL4LB1OkDk=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=Gb/3cAp+4usdKcJcJ/VxcVRDItcpi5yBj08IF+cblMFTuBOWWc/0dHCund3uVT/m+Syf+KAAZ4hwKFXC8p5mHMG9nNMCbKE8xWbhRa74dY7PwfUQuc9Fr/31dqMYZ5I3DO8jGEOa/wYXEFwHdMadiGspCBMwUpk6Z0OptHmN0XI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=okV1Tz5a; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="okV1Tz5a"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4DEA81F000E9;
	Thu,  2 Jul 2026 01:15:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782954946;
	bh=kpkwTSlW5KK/zUlaknG/+M3f+Jc9aWbyO11t0Gu6KKU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=okV1Tz5agCW+eVgjFYnxC6V0id6fTUo25mnz0GfmuVZzLfaLqEWu8H3wJBC9JwOh8
	 pAhfniwdyYV/DfsH7oRsSrMHHdu2cmZ5eKcLRNKda6lT+QcUkRQ1DuQLYI6dlC3PuA
	 cpiUo08Wf+dLj1+/0uFZGLHYkIVKaGr3YM5FhZBwTHOrIfHY9z6kU3roq/HVjmor3m
	 jNf0q9W4+8g3ApwiZYf2MwkQAW6i1B7ojuToJcKav/UqmMlwx9i6B228ZSMxAU/Ebg
	 jVjLRLDRuAzdsbLZdaleslAf49KrYJiPKK22hR7pMdT5eEaFVNME5PWfUYqVpJfj62
	 V3Z4K9vnZDZYA==
Date: Thu, 2 Jul 2026 10:15:42 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Ren Wei <n05ec@lzu.edu.cn>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 rostedt@goodmis.org, mhiramat@kernel.org, mathieu.desnoyers@efficios.com,
 akpm@linux-foundation.org, namhyung@kernel.org, yuantan098@gmail.com,
 yifanwucs@gmail.com, tomapufckgml@gmail.com, zcliangcn@gmail.com,
 bird@lzu.edu.cn, hhhuang@smu.edu.sg
Subject: Re: [PATCH 1/1] tracing: Prevent out-of-bounds read in glob
 matching
Message-Id: <20260702101542.2b636bb4d9d9c3ad46dba9d4@kernel.org>
In-Reply-To: <da1aaf125fc3b63320b0c540fd6afa7c3d5b4f1a.1782836943.git.hhhuang@smu.edu.sg>
References: <cover.1782836943.git.hhhuang@smu.edu.sg>
	<da1aaf125fc3b63320b0c540fd6afa7c3d5b4f1a.1782836943.git.hhhuang@smu.edu.sg>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed,  1 Jul 2026 18:28:46 +0800
Ren Wei <n05ec@lzu.edu.cn> wrote:

> From: Huihui Huang <hhhuang@smu.edu.sg>
> 
> String event fields are not necessarily NUL-terminated, so the filter
> predicate functions (filter_pred_string(), filter_pred_strloc() and
> filter_pred_strrelloc()) pass the field length to the regex match
> callbacks, and the length-aware matchers honour it.
> 
> regex_match_glob() was the exception: it ignored the length and called
> glob_match(), which scans the string until it hits a NUL byte. Some
> string fields are not NUL-terminated. One example is the dynamic char
> array of the xfs_* namespace tracepoints, which is copied without a
> trailing NUL. For such a field, glob matching reads past the end of
> the event field, causing a KASAN slab-out-of-bounds read in
> glob_match(), reached via regex_match_glob() and filter_match_preds()
> from the xfs_lookup tracepoint.
> 
> Add a length-bounded glob_match_len() and use it from regex_match_glob()
> so glob matching always stops at the field boundary. The matching loop
> is factored into a shared helper so glob_match() keeps its behaviour.
> 

Looks good to me.

Acked-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>

Thank you,

> Fixes: 60f1d5e3bac4 ("ftrace: Support full glob matching")
> Cc: stable@vger.kernel.org
> Reported-by: Yuan Tan <yuantan098@gmail.com>
> Reported-by: Yifan Wu <yifanwucs@gmail.com>
> Reported-by: Juefei Pu <tomapufckgml@gmail.com>
> Reported-by: Zhengchuan Liang <zcliangcn@gmail.com>
> Reported-by: Xin Liu <bird@lzu.edu.cn>
> Assisted-by: Codex:GPT-5.4
> Signed-off-by: Huihui Huang <hhhuang@smu.edu.sg>
> Signed-off-by: Ren Wei <n05ec@lzu.edu.cn>
> ---
>  include/linux/glob.h               |  1 +
>  kernel/trace/trace_events_filter.c |  6 ++----
>  lib/glob.c                         | 31 ++++++++++++++++++++++++++++--
>  3 files changed, 32 insertions(+), 6 deletions(-)
> 
> diff --git a/include/linux/glob.h b/include/linux/glob.h
> index 861327b33e..91595e7509 100644
> --- a/include/linux/glob.h
> +++ b/include/linux/glob.h
> @@ -6,5 +6,6 @@
>  #include <linux/compiler.h>	/* For __pure */
>  
>  bool __pure glob_match(char const *pat, char const *str);
> +bool __pure glob_match_len(char const *pat, char const *str, size_t len);
>  
>  #endif	/* _LINUX_GLOB_H */
> diff --git a/kernel/trace/trace_events_filter.c b/kernel/trace/trace_events_filter.c
> index 609325f579..6385cd662d 100644
> --- a/kernel/trace/trace_events_filter.c
> +++ b/kernel/trace/trace_events_filter.c
> @@ -1056,11 +1056,9 @@ static int regex_match_end(char *str, struct regex *r, int len)
>  	return 0;
>  }
>  
> -static int regex_match_glob(char *str, struct regex *r, int len __maybe_unused)
> +static int regex_match_glob(char *str, struct regex *r, int len)
>  {
> -	if (glob_match(r->pattern, str))
> -		return 1;
> -	return 0;
> +	return glob_match_len(r->pattern, str, len) ? 1 : 0;
>  }
>  
>  /**
> diff --git a/lib/glob.c b/lib/glob.c
> index 7aca76c25b..c80d9dd736 100644
> --- a/lib/glob.c
> +++ b/lib/glob.c
> @@ -11,6 +11,9 @@
>  MODULE_DESCRIPTION("glob(7) matching");
>  MODULE_LICENSE("Dual MIT/GPL");
>  
> +static bool __pure glob_match_str(char const *pat, char const *str,
> +				  char const *str_end);
> +
>  /**
>   * glob_match - Shell-style pattern matching, like !fnmatch(pat, str, 0)
>   * @pat: Shell-style pattern to match, e.g. "*.[ch]".
> @@ -40,6 +43,29 @@ MODULE_LICENSE("Dual MIT/GPL");
>   * An opening bracket without a matching close is matched literally.
>   */
>  bool __pure glob_match(char const *pat, char const *str)
> +{
> +	return glob_match_str(pat, str, NULL);
> +}
> +EXPORT_SYMBOL(glob_match);
> +
> +/**
> + * glob_match_len - glob match against a length-bounded string
> + * @pat: Shell-style pattern to match.
> + * @str: String to match.  Need not be NUL-terminated.
> + * @len: Number of bytes of @str that may be read.
> + *
> + * Like glob_match(), but @str is only read up to @len bytes, so it can be
> + * used on buffers that are not NUL-terminated (e.g. trace event fields).
> + * A NUL byte within @len still terminates the string.
> + */
> +bool __pure glob_match_len(char const *pat, char const *str, size_t len)
> +{
> +	return glob_match_str(pat, str, str + len);
> +}
> +EXPORT_SYMBOL(glob_match_len);
> +
> +static bool __pure glob_match_str(char const *pat, char const *str,
> +				  char const *str_end)
>  {
>  	/*
>  	 * Backtrack to previous * on mismatch and retry starting one
> @@ -55,9 +81,11 @@ bool __pure glob_match(char const *pat, char const *str)
>  	 * on mismatch, or true after matching the trailing nul bytes.
>  	 */
>  	for (;;) {
> -		unsigned char c = *str++;
> +		unsigned char c = (str_end && str >= str_end) ? '\0' : *str;
>  		unsigned char d = *pat++;
>  
> +		str++;
> +
>  		switch (d) {
>  		case '?':	/* Wildcard: anything but nul */
>  			if (c == '\0')
> @@ -125,4 +153,3 @@ bool __pure glob_match(char const *pat, char const *str)
>  		}
>  	}
>  }
> -EXPORT_SYMBOL(glob_match);
> -- 
> 2.50.1
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
