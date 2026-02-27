Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62D1234B425
	for <linux-trace-kernel@vger.kernel.org>; Fri, 27 Feb 2026 17:08:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772212099; cv=none; b=KRxW8WFheBC1ReOk0zWp5/YNBGBsvM+HJU8uz/2PoBeggaPm3gbfABdK1dEip+i1+E5PXqAbrU6i23DY4EBrnqAyNY2X0sqYxrnhbDj7XqFBYDh4Wq+wuWE5vBg6xU0Xqn3D2hU7VGPIZ2ZcA1qkatxqNvkrnh87YObKm4TSD1w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772212099; c=relaxed/simple;
	bh=ZV8ItIHfWRaPrh6dHZ9ViYTfVoWeaAst/x6uOU5WHJU=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZoVwY7rRJbohs2KwB1ofC/Dkur0iddcfjaXtH480K1Ht6nV79wzxKNsoDlCnnGn3K8xfH8MD971IR5uHu6kkO1fqrin6YjxdAIQMDI1+3IlmVf975a3olwaC9rgNWn+q/3zyh9TDKKPJipysvRrTrqW6+MHnwkVk1SZbjRhAk+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Pn8FVyJq; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Pn8FVyJq"
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-4376de3f128so1583173f8f.0
        for <linux-trace-kernel@vger.kernel.org>; Fri, 27 Feb 2026 09:08:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772212097; x=1772816897; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=be9G3Ajs4Fq6jFDsmzCxnr1IbQpwR2eVW71VEsdeV+g=;
        b=Pn8FVyJqvLqEhzwIVvy3XQzV84d+8qyt5jtGC+KMuvhOcnRkb3vA5EC2mIKDWuuTHn
         CaWMldLra3Xhcsi20VUaR5UBghTlc2ayTJAZiY+XG1Q551T7x4YUJkHMbCXVF5WsY4ka
         yyf/RPla6939gRA3XAplztuWDli/0ELzCOG5BpJ9HPS0L8UhSd9cMg1m5ykOjKrwM27H
         1DwKvZiGmGcaIa+NDI7FpWXBBJ8axzcLkw/Dcy78z573w8FPW/fSTSPyY55iu0W7UMV+
         tskor4I8MPahpFnYGbMMMoHsZoowTe4f5niOCVnGW/8Amw0Io9UrPehRznJvOgbA/oEf
         3ybw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772212097; x=1772816897;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=be9G3Ajs4Fq6jFDsmzCxnr1IbQpwR2eVW71VEsdeV+g=;
        b=Y/DTUG0vx4mto16ZkU5NoN6BW6KjjUFoq/HHrDi8hr8dGaflhxESJrXp0DPzqOvljJ
         97AUHB80bg5Tp6QLBwrq8MSrJ/WyNQlcfqkmKUQI8Hp7mq3/gkzXid1j44KEcXTu84uq
         8GFGqp79EWtQNVD9Urmyp34apg8NcW3Ren+lnrPciRY00ImFdk0+sYdDWUydZIdps++0
         e4tVezJKOjHwARtBmMPb07N24i0YO5bmRvnGmNN5mkskFB+qx12nTE98V68h3TBnBKAL
         BYoifo3+rrc6QTxEzm2dART7FdFjRZDSvuZKhYPrECEkvLnLki4E/N96SGJik7dzy4tc
         tgdw==
X-Forwarded-Encrypted: i=1; AJvYcCU1pL1Vjh8Z/H9oXQrmA5VyBIAp20S/HiTqaz7Y7e9p4LdOFa70+TofptuMCJ+5VwOMAiNOyyt7plgbAUJ5OzR3P0k=@vger.kernel.org
X-Gm-Message-State: AOJu0Yww8U+gykUkOlVYXN7NckA8YRt+r0SqqdT9yEgdHtEvUKRy2W6Y
	mucSbXcc+iDF+29qxE0Nm2FOMnzRvq+NKcgn0wUU6v5OQdg8fyFIyMKi0Z35Hj8J
X-Gm-Gg: ATEYQzzlVxgo2Uwm/4WVqXtJ8QbkaxvC8UaTVUK+U7BE1yXCcd/oivOQYBYyQKVF3Fy
	A5cTImFYNz+nO8KiqyP4FZgbuQCzwzR8mVWGFnIMmz21KUyv9iW6lZVMrP3eQ/HNZab83vUaPhK
	7rDAQ5PvMbzpYkJNeCN6xSMqMC2RVvDYQkrS35cQqecJcoR9UFETeQd4XFETj+X5eNjM//Q8qc3
	S+77SGU71sPWQ8JkFPXDOKNVSeSvRax4Icv32KoAHDR2GFj60Zkaw3TKZ8QG/gqUapqld3NuNFr
	oMRCuJG4U/IEjy4vFj7+a+h/N2Rjuvsg0//04LK+18V1eIF5ZDYjiDszBFy/3QCQrgyR+Zsoej6
	aR7eqzBS1Mr3gVUqGLu10lH5vdzCJxZHvMxKVRw+d6KLh4aETsao0D8V8ZUGb7BeNK6838RS9cF
	gYCTJAaLq8+JQQgTO7Z9o2Qz/IALY=
X-Received: by 2002:a05:6000:3111:b0:439:8a4f:524f with SMTP id ffacd0b85a97d-4399ddebb52mr6406062f8f.13.1772212096537;
        Fri, 27 Feb 2026 09:08:16 -0800 (PST)
Received: from krava ([2a00:102a:5009:b4a6:a10f:2f8b:3309:3fcd])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4399c76b40esm7664588f8f.36.2026.02.27.09.08.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Feb 2026 09:08:16 -0800 (PST)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Fri, 27 Feb 2026 18:08:13 +0100
To: Andrey Grodzovsky <andrey.grodzovsky@crowdstrike.com>
Cc: bpf@vger.kernel.org, linux-open-source@crowdstrike.com, ast@kernel.org,
	daniel@iogearbox.net, andrii@kernel.org, rostedt@goodmis.org,
	linux-trace-kernel@vger.kernel.org
Subject: Re: [RFC PATCH bpf-next v2 1/3] libbpf: Optimize kprobe.session
 attachment for exact function names
Message-ID: <aaHPfR_cOwKIm-lU@krava>
References: <20260226173342.3565919-1-andrey.grodzovsky@crowdstrike.com>
 <20260226173342.3565919-2-andrey.grodzovsky@crowdstrike.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260226173342.3565919-2-andrey.grodzovsky@crowdstrike.com>

On Thu, Feb 26, 2026 at 12:33:40PM -0500, Andrey Grodzovsky wrote:
> Implement dual-path optimization in attach_kprobe_session():
> - Fast path: Use syms[] array for exact function names
>   (no kallsyms parsing)
> - Slow path: Use pattern matching with kallsyms only for
>   wildcards
> 
> This avoids expensive kallsyms file parsing (~150ms) when function names
> are specified exactly, improving attachment time 50x (~3-5ms).
> 
> Error code normalization: The fast path returns ESRCH from kernel's
> ftrace_lookup_symbols(), while slow path returns ENOENT from userspace
> kallsyms parsing. Convert ESRCH to ENOENT in fast path to maintain API
> consistency - both paths now return identical error codes for "symbol
> not found".
> 
> Signed-off-by: Andrey Grodzovsky <andrey.grodzovsky@crowdstrike.com>
> ---
>  tools/lib/bpf/libbpf.c | 34 ++++++++++++++++++++++++++++------
>  1 file changed, 28 insertions(+), 6 deletions(-)
> 
> diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> index 0be7017800fe..0ba8aa2c5fd2 100644
> --- a/tools/lib/bpf/libbpf.c
> +++ b/tools/lib/bpf/libbpf.c
> @@ -12042,6 +12042,20 @@ bpf_program__attach_kprobe_multi_opts(const struct bpf_program *prog,
>  		return libbpf_err_ptr(-EINVAL);
>  
>  	if (pattern) {
> +		/*
> +		 * Exact function name (no wildcards): bypass kallsyms parsing
> +		 * and pass the symbol directly to the kernel via syms[] array.
> +		 * The kernel's ftrace_lookup_symbols() resolves it efficiently.
> +		 */
> +		if (!strpbrk(pattern, "*?")) {
> +			const char *sym = pattern;
> +
> +			syms = &sym;

why not use pattern ndirectly?

> +			cnt = 1;
> +			pattern = NULL;

not sure why we need this

> +			goto attach;
> +		}

I wonder we could just another if path and avoid the goto, like:


-	if (pattern) {
+	/*
+	 * Exact function name (no wildcards): bypass kallsyms parsing
+	 * and pass the symbol directly to the kernel via syms[] array.
+	 * The kernel's ftrace_lookup_symbols() resolves it efficiently.
+	 */
+	if (pattern && !strpbrk(pattern, "*?")) {
+		syms = &pattern;
+		cnt = 1;
+	} else if (pattern) {
 		if (has_available_filter_functions_addrs())
 			err = libbpf_available_kprobes_parse(&res);


wdyt?

> +
>  		if (has_available_filter_functions_addrs())
>  			err = libbpf_available_kprobes_parse(&res);
>  		else
> @@ -12060,6 +12074,7 @@ bpf_program__attach_kprobe_multi_opts(const struct bpf_program *prog,
>  		cnt = res.cnt;
>  	}
>  
> +attach:
>  	retprobe = OPTS_GET(opts, retprobe, false);
>  	session  = OPTS_GET(opts, session, false);
>  
> @@ -12067,7 +12082,6 @@ bpf_program__attach_kprobe_multi_opts(const struct bpf_program *prog,
>  		return libbpf_err_ptr(-EINVAL);
>  
>  	attach_type = session ? BPF_TRACE_KPROBE_SESSION : BPF_TRACE_KPROBE_MULTI;
> -

not needed

>  	lopts.kprobe_multi.syms = syms;
>  	lopts.kprobe_multi.addrs = addrs;
>  	lopts.kprobe_multi.cookies = cookies;
> @@ -12084,6 +12098,14 @@ bpf_program__attach_kprobe_multi_opts(const struct bpf_program *prog,
>  	link_fd = bpf_link_create(prog_fd, 0, attach_type, &lopts);
>  	if (link_fd < 0) {
>  		err = -errno;
> +		/*
> +		 * Normalize error code: when exact name bypasses kallsyms
> +		 * parsing, kernel returns ESRCH from ftrace_lookup_symbols().
> +		 * Convert to ENOENT for API consistency with the pattern
> +		 * matching path which returns ENOENT from userspace.
> +		 */
> +		if (err == -ESRCH)
> +			err = -ENOENT;
>  		pr_warn("prog '%s': failed to attach: %s\n",
>  			prog->name, errstr(err));
>  		goto error;
> @@ -12192,7 +12214,7 @@ static int attach_kprobe_session(const struct bpf_program *prog, long cookie,
>  {
>  	LIBBPF_OPTS(bpf_kprobe_multi_opts, opts, .session = true);
>  	const char *spec;
> -	char *pattern;
> +	char *func_name;

I don't think we need the change, it's jus for the different pr_warn
below right? let's keep pattern

thanks,
jirka

>  	int n;
>  
>  	*link = NULL;
> @@ -12202,14 +12224,14 @@ static int attach_kprobe_session(const struct bpf_program *prog, long cookie,
>  		return 0;
>  
>  	spec = prog->sec_name + sizeof("kprobe.session/") - 1;
> -	n = sscanf(spec, "%m[a-zA-Z0-9_.*?]", &pattern);
> +	n = sscanf(spec, "%m[a-zA-Z0-9_.*?]", &func_name);
>  	if (n < 1) {
> -		pr_warn("kprobe session pattern is invalid: %s\n", spec);
> +		pr_warn("kprobe session function name is invalid: %s\n", spec);
>  		return -EINVAL;
>  	}
>  
> -	*link = bpf_program__attach_kprobe_multi_opts(prog, pattern, &opts);
> -	free(pattern);
> +	*link = bpf_program__attach_kprobe_multi_opts(prog, func_name, &opts);
> +	free(func_name);
>  	return *link ? 0 : -errno;
>  }
>  
> -- 
> 2.34.1
> 
