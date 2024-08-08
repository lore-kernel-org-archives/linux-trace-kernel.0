Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB95E189BB3
	for <linux-trace-kernel@vger.kernel.org>; Thu,  8 Aug 2024 10:20:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723112461; cv=none; b=LqnWF/EfHO4/QUbUf/i5b4tA99xHr5P/CWfT55dABMapMsX12DK2ERkmMAnHdyEmZRgakMosHcLC1v4Tt9M+BRE3DPrzyJ+d0bQhV3IhvMOIgkjidkwHmDPR1yt4NHh5R37e3U5Cn8zAX9y9p0TEw72T97A8C4k+pHoG+cXUee4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723112461; c=relaxed/simple;
	bh=+QbjV7V74FmlcndIROSiCfczbHt4V/u9ib1DRriPGfA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=If43/ch7ge7yZubtQFVftDdOHSG9JpBsqi3O4LnY3zZYAKlWE0K1e5jNep840nubw6rgIIp35xBWBrzkiaU2YQT91KuHdLxXevDiIkVQX6Vq4mYyRlnjlqLYm8mBoYJw60DqUDpT94MHtZltB0Jn6PblJ1ECKIkoF73/LfZ2g2A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=Fjh8Ejxs; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="Fjh8Ejxs"
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-5af6a1afa63so878921a12.0
        for <linux-trace-kernel@vger.kernel.org>; Thu, 08 Aug 2024 03:20:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1723112458; x=1723717258; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=rjbY9LnQLbutSe6h09pQ5dRYk+5NQr/p3mX4BdB4wQY=;
        b=Fjh8EjxsViIdgozFKhYnPB51vZ259NdRJiJIn5FXKqnrK2lZW0+J/wjjYIVhLfeqUc
         Wtnh0omXdJ2LEkarWa0vZQI3mlPPJT/bupQzhRpRBZDNaouA25jtYYGvLexVrXILr7OV
         Jv01Wlr8Sfu1MQ4Pp2exFBdL1xJKAT3IrDkAdO1OEqqdxOqjJxpCjGAjBloP3cDky1of
         SXTaCaH1j86k/udXthWHDtsEOoRn/0HOOdPz8lIq2DB8Eei1AItwjeYchGqGjIUIreKU
         jc59rb95Bpdw3kfrJwfGqJ/b3cPHA6AbkvQkCC7PUMHTbFyPe/MpC0XOkatBXs2Y0XII
         vQ8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723112458; x=1723717258;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rjbY9LnQLbutSe6h09pQ5dRYk+5NQr/p3mX4BdB4wQY=;
        b=FdJRXGPxw0fE4xgfkfOMB7P46bGzzkHI/6q2XDDLTqBkj6SqwbdvqPbEc9u7j1KzOi
         dWjCwxzFj1NfK82VATY+hbEaIGk1jpg6M24toCu1TjNgh8TxUIhxEpS6mMKmDsMV4kKh
         AwUp8ru08T+BOHpYiDu8xnE5BUOF27IS77cNE6yDDBbFOw2cycniEBwDzX/pRq6JroC8
         LRCmZhGwPqvlWEMFlcfTsxIqBVo6BVunOwWmVmkPRE/2EW29wXIWArDMAwZ/LE1cP95w
         OiHtNJx/aL8IqVbOS1rpsE4fqhWuasUZyi6sHdLX367tlfJy0YKWzzTeTJuvT5NXYoDd
         oWxg==
X-Forwarded-Encrypted: i=1; AJvYcCWbaW7hQWapmqNYqIdp1+26BPh6+8/zItJ7OTpVeNrffH5QttD/I53algYS54GOaYmG08bB+VZZ+YAFDVAPsJOajzdsaG70yGdx8/pBD3Xwr7Iz
X-Gm-Message-State: AOJu0YwhbGqvld2wtgPt7pfq1FJzX+3CmiLgNANM66FmJGIFVDkbQgWJ
	IpB0f3BgtCX7MOg8rE57Oyi5jB4WmCE+BVm4CnRqb2OVoahSf1K2vkgxAm62pII=
X-Google-Smtp-Source: AGHT+IGt5emtBrWgdy8SSYZYlV0d869w/JvaLmuRfPLKVv+LBGh2tvll7OMouxkEA25eOZNenA3J3A==
X-Received: by 2002:a17:907:1b13:b0:a7a:bc34:a4c8 with SMTP id a640c23a62f3a-a8090f35272mr99329666b.69.1723112457842;
        Thu, 08 Aug 2024 03:20:57 -0700 (PDT)
Received: from pathway.suse.cz ([176.114.240.50])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a7dc9d88741sm729110666b.150.2024.08.08.03.20.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Aug 2024 03:20:57 -0700 (PDT)
Date: Thu, 8 Aug 2024 12:20:55 +0200
From: Petr Mladek <pmladek@suse.com>
To: Song Liu <song@kernel.org>
Cc: live-patching@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org, jpoimboe@kernel.org,
	jikos@kernel.org, mbenes@suse.cz, joe.lawrence@redhat.com,
	nathan@kernel.org, morbo@google.com, justinstitt@google.com,
	mcgrof@kernel.org, thunder.leizhen@huawei.com, kees@kernel.org,
	kernel-team@meta.com, mmaurer@google.com, samitolvanen@google.com,
	mhiramat@kernel.org, rostedt@goodmis.org
Subject: Re: [PATCH v2 2/3] kallsyms: Add APIs to match symbol without .XXXX
 suffix.
Message-ID: <ZrScBzRRTB--q7Y-@pathway.suse.cz>
References: <20240802210836.2210140-1-song@kernel.org>
 <20240802210836.2210140-3-song@kernel.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240802210836.2210140-3-song@kernel.org>

On Fri 2024-08-02 14:08:34, Song Liu wrote:
> With CONFIG_LTO_CLANG=y, the compiler may add suffix to function names
> to avoid duplication. This causes confusion with users of kallsyms.
> On one hand, users like livepatch are required to match the symbols
> exactly. On the other hand, users like kprobe would like to match to
> original function names.
> 
> Solve this by splitting kallsyms APIs. Specifically, existing APIs now
> should match the symbols exactly. Add two APIs that match only the part
> without .XXXX suffix. Specifically, the following two APIs are added.
> 
> 1. kallsyms_lookup_name_without_suffix()
> 2. kallsyms_on_each_match_symbol_without_suffix()
> 
> These APIs will be used by kprobe.
> 
> Also cleanup some code and update kallsyms_selftests accordingly.
> 
> --- a/kernel/kallsyms.c
> +++ b/kernel/kallsyms.c
> @@ -164,30 +164,27 @@ static void cleanup_symbol_name(char *s)
>  {
>  	char *res;
>  
> -	if (!IS_ENABLED(CONFIG_LTO_CLANG))
> -		return;
> -
>  	/*
>  	 * LLVM appends various suffixes for local functions and variables that
>  	 * must be promoted to global scope as part of LTO.  This can break
>  	 * hooking of static functions with kprobes. '.' is not a valid
> -	 * character in an identifier in C. Suffixes only in LLVM LTO observed:
> -	 * - foo.llvm.[0-9a-f]+
> +	 * character in an identifier in C, so we can just remove the
> +	 * suffix.
>  	 */
> -	res = strstr(s, ".llvm.");
> +	res = strstr(s, ".");

IMHO, we should not remove the suffixes like .constprop*, .part*,
.isra*. They implement a special optimized variant of the function.
It is not longer the original full-featured one.

>  	if (res)
>  		*res = '\0';
>  
>  	return;
>  }
>  
> -static int compare_symbol_name(const char *name, char *namebuf)
> +static int compare_symbol_name(const char *name, char *namebuf, bool exact_match)
>  {
> -	/* The kallsyms_seqs_of_names is sorted based on names after
> -	 * cleanup_symbol_name() (see scripts/kallsyms.c) if clang lto is enabled.
> -	 * To ensure correct bisection in kallsyms_lookup_names(), do
> -	 * cleanup_symbol_name(namebuf) before comparing name and namebuf.
> -	 */
> +	int ret = strcmp(name, namebuf);
> +
> +	if (exact_match || !ret)
> +		return ret;
> +
>  	cleanup_symbol_name(namebuf);
>  	return strcmp(name, namebuf);
>  }
> @@ -204,13 +201,17 @@ static unsigned int get_symbol_seq(int index)
>  
>  static int kallsyms_lookup_names(const char *name,
>  				 unsigned int *start,
> -				 unsigned int *end)
> +				 unsigned int *end,
> +				 bool exact_match)
>  {
>  	int ret;
>  	int low, mid, high;
>  	unsigned int seq, off;
>  	char namebuf[KSYM_NAME_LEN];
>  
> +	if (!IS_ENABLED(CONFIG_LTO_CLANG))
> +		exact_match = true;

IMHO, this is very a bad design. It causes that

     kallsyms_on_each_match_symbol_without_suffix(,,, false);

does not longer work as expected. It creates a hard to maintain
code. The code does not do what it looks like.

The caller should decide whether it wants to ignore the suffix or no.
And this function should always respect the @exact_match parameter value.

> +
>  	low = 0;
>  	high = kallsyms_num_syms - 1;
>  

Best Regards,
Petr
