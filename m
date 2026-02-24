Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEE7D3793A1
	for <linux-trace-kernel@vger.kernel.org>; Tue, 24 Feb 2026 13:12:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771938742; cv=none; b=rku1tIdZxp7PI8JKHtudHkSJn8UwtaX/fqvkhHIJ9EJMr1brUCLqU4RIYgdjtHnKpqYVux8bKAqTNQnDZ0kpZwxI05TG1QAvAmQzHQRhFxG7kV8sT99iFPoo1BeC5t+SCm9udfP1PWOJGRBMYLAoWQvlPgpmggvMjrAIHxc1a0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771938742; c=relaxed/simple;
	bh=cdIly0vAT8ublrU8eHTrgYHCsMW1WnW9wyEyab7AKG4=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ngNYJZf+615qWwDwF6Ja0VvezJQW4FyxLJU0TthEjp6TvWmrku/0+iKvg/rTrIzeRwJMQLCxnp6UCDyG6FORQL7xkVU/Nh0KjdwXAaCHt8xljUaIXvmN2ZJO+mYlvSMMiriyRWUeH25614N9d40au04wCgfbJau6+R3oFN2OM30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ml7MZ7Za; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ml7MZ7Za"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-48069a48629so56500205e9.0
        for <linux-trace-kernel@vger.kernel.org>; Tue, 24 Feb 2026 05:12:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771938739; x=1772543539; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=+2FgcbIbzhcMcTglC96arKp5lanpIvh4ZU7tb8HuFqc=;
        b=ml7MZ7ZahM6OzDn+iT2R/hqsn0uXIhp7CiWOwmQN0enJUKXTRllSJKKyxPoFKEzNa3
         qrXt9JUsF90NN5X62Ri7FVEOAU2ZFDVk4EHHVgKF5cG2fSA+ZzrarCr/+wxej9KoXBlC
         NPq1wZXyd8rH/VgbhWpoH5RAWJaI9vg1jPOIf+TRxvBmOl8E+3Y0e4ERCIF4SjI9b3S7
         v54mCrLcicNf5iGLMmDcMHVAQ4Yo9ZhnZ/TX/KJ7+Z14SQBbGWq4YqaAzhjzXVj2Kjv7
         mTCRgrKZFShstA0XhPP9i6FoNnyRneuGNqvqjEOX01uNeXv5FmHPF25lUEelREApBQ39
         dcAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771938739; x=1772543539;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+2FgcbIbzhcMcTglC96arKp5lanpIvh4ZU7tb8HuFqc=;
        b=UMYbszw2CxtEnhJqLsS46sC1D619GsIf5qYwHkSH1zk9ZKOmOo/t1Z3LiOZ35Qy/8G
         C9h+lrLh0sMlG0d23O8wzLrlvZcUJu4eDg/s+BTHK9uv4OnNkrVxs7agGPyfbUOWCCox
         WhNqeXsOwMEsn+OjwSnTPrrZWEC07Y4kINyGoFbckf+g4Zz3HpYTT2TZ3hT9/Pk+dVg3
         0TAusiDrJUkHxUjZ0KVFLxP7nrZZi25p+B8ZWIk62dO35b34DrSwP/ptFo9z1LVBCaLc
         cr6uDwfoCdNbPZgn6hXQ59pI7rsR+q1yJ/Eu410Z0FmhQ0+ReB5vNOUKA7xHnPuDfpir
         jXyQ==
X-Forwarded-Encrypted: i=1; AJvYcCV4OH8Qx1Ml6t2AkRZpemEelabeo1aABMRvXezeQsQUejIiRC+a1IkJ8YWz79CJ3/RrdxRBk8PvSYglqLNap4hwgc0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwtD22RZDg46dK+Yz4GB3WvYEgwh3T6Iotal3xKd2ONlEC5q1rx
	LDult4nIBJW69kWUG5DPAmeUeH20f8vydGZmsKlNYZ/4FK7cbzJ41rQ6
X-Gm-Gg: AZuq6aKlAhqnTU+XRsfJ0oP/IWYsDS2LP2j71Tg1bMLAz46GqMHxmkQB5MmtaActVCq
	zpAHn3PUsIFfUDpIobzdlMUpNj8olt467jEZXFAWXHzRFnS6+nYO7a48uZj/WZywtVSQYkL0C+w
	0SdqnumLNSF0G/TSjeynqIKtnf7Q+z+9iHZ4okNdquVMRxu052WG8rdn6c8ybPCPwQfYz66eE5w
	HJowy+WN8CR2gckmxdpWKHVgIM4OJ5tpkNRLraMReBK3Wxw7/1IzS1olwipmriUWC/F7gglsQWM
	VdFnGa3HDjQRLcCrkcXu+d5matT3GVpY8M8FH3HyhDEfAmdCT5zLu44gcN3QZ1MTo4Ekgv52FBt
	vWDSmoRrNlRg4DLUZtuZkayY/oSzet+QkLFkfqibNsFgiM2F3DGXrifGdwoDjZ3rM/JFj1IR5
X-Received: by 2002:a05:600c:a418:b0:483:b3d7:2e80 with SMTP id 5b1f17b1804b1-483b3d72f30mr83552035e9.33.1771938739030;
        Tue, 24 Feb 2026 05:12:19 -0800 (PST)
Received: from krava ([2a02:8308:a00c:e200::b44f])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-483a8df83bcsm290470575e9.13.2026.02.24.05.12.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Feb 2026 05:12:18 -0800 (PST)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Tue, 24 Feb 2026 14:12:16 +0100
To: Andrey Grodzovsky <andrey.grodzovsky@crowdstrike.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
	andrii@kernel.org, rostedt@goodmis.org,
	linux-trace-kernel@vger.kernel.org,
	linux-open-source@crowdstrike.com
Subject: Re: [RFC PATCH bpf-next 2/3] ftrace: Use kallsyms binary search for
 single-symbol lookup
Message-ID: <aZ2jsL0Tzdno_ZvD@krava>
References: <20260223215113.924599-1-andrey.grodzovsky@crowdstrike.com>
 <20260223215113.924599-3-andrey.grodzovsky@crowdstrike.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260223215113.924599-3-andrey.grodzovsky@crowdstrike.com>

On Mon, Feb 23, 2026 at 04:51:12PM -0500, Andrey Grodzovsky wrote:
> When ftrace_lookup_symbols() is called with a single symbol (cnt == 1),
> use kallsyms_lookup_name() for O(log N) binary search instead of the
> full linear scan via kallsyms_on_each_symbol().
> 
> ftrace_lookup_symbols() was designed for batch resolution of many
> symbols in a single pass.  For large cnt this is efficient: a single
> O(N) walk over all symbols with O(log cnt) binary search into the
> sorted input array.  But for cnt == 1 it still decompresses all ~200K
> kernel symbols only to match one.
> 
> kallsyms_lookup_name() uses the sorted kallsyms index and needs only
> ~17 decompressions for a single lookup.
> 
> This is the common path for kprobe.session with exact function names,
> where libbpf sends one symbol per BPF_LINK_CREATE syscall.
> 
> If binary lookup fails (duplicate symbol names where the first match
> is not ftrace-instrumented, or module symbols), the function falls
> through to the existing linear scan path.
> 
> Before (cnt=1, 50 kprobe.session programs):
>   Attach: 858 ms  (kallsyms_expand_symbol 25% of CPU)
> 
> After:
>   Attach:  52 ms  (16x faster)
> 
> Signed-off-by: Andrey Grodzovsky <andrey.grodzovsky@crowdstrike.com>
> ---
>  kernel/trace/ftrace.c | 28 ++++++++++++++++++++++++++++
>  1 file changed, 28 insertions(+)
> 
> diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
> index 827fb9a0bf0d..bfd7670669c2 100644
> --- a/kernel/trace/ftrace.c
> +++ b/kernel/trace/ftrace.c
> @@ -9263,6 +9263,19 @@ static int kallsyms_callback(void *data, const char *name, unsigned long addr)
>   * @addrs array, which needs to be big enough to store at least @cnt
>   * addresses.
>   *
> + * For a single symbol (cnt == 1), uses kallsyms_lookup_name() which
> + * performs an O(log N) binary search via the sorted kallsyms index.
> + * This avoids the full O(N) linear scan over all kernel symbols that
> + * the multi-symbol path requires.
> + *
> + * For multiple symbols, uses a single-pass linear scan via
> + * kallsyms_on_each_symbol() with binary search into the sorted input
> + * array.  While individual lookups are O(log N), doing K lookups
> + * totals O(K * log N) which loses to a single sequential O(N) pass
> + * at scale due to cache-friendly memory access patterns of the linear
> + * walk.  Empirical testing shows the linear scan is faster for batch
> + * lookups even well below 10K symbols.
> + *
>   * Returns: 0 if all provided symbols are found, -ESRCH otherwise.
>   */
>  int ftrace_lookup_symbols(const char **sorted_syms, size_t cnt, unsigned long *addrs)
> @@ -9270,6 +9283,21 @@ int ftrace_lookup_symbols(const char **sorted_syms, size_t cnt, unsigned long *a
>  	struct kallsyms_data args;
>  	int found_all;
>  
> +	/* Fast path: single symbol uses O(log N) binary search */
> +	if (cnt == 1) {
> +		addrs[0] = kallsyms_lookup_name(sorted_syms[0]);
> +		if (addrs[0])
> +			addrs[0] = ftrace_location(addrs[0]);

the kallsyms_callback callback code does not take the address
from ftrace_location, just checks it exists .. I think it is
done later in the fprobe layer .. let's keep it the same

jirka

> +		if (addrs[0])
> +			return 0;
> +		/*
> +		 * Binary lookup can fail for duplicate symbol names
> +		 * where the first match is not ftrace-instrumented,
> +		 * or for module symbols.  Retry with linear scan.
> +		 */
> +	}
> +
> +	/* Batch path: single-pass O(N) linear scan */
>  	memset(addrs, 0, sizeof(*addrs) * cnt);
>  	args.addrs = addrs;
>  	args.syms = sorted_syms;
> -- 
> 2.34.1
> 
