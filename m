Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1098312BE9C
	for <linux-trace-kernel@vger.kernel.org>; Tue,  9 Apr 2024 22:18:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712701129; cv=none; b=kL3BfuUxODF9ySh8a2fIVeBCAGUgo9HZOWBMuNUCIRQm1o+tqXjTh59bM8BHxP1qeJAvSxksA0Uiu6h9HCnFLx4OIKVMDN95u+5eMT0E2Yp/ABQmiGJZB/q2Om+8ZvrKVKUIS1OY3CRFgy411qkfdEZks92KVYfRDBH0YKGoFZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712701129; c=relaxed/simple;
	bh=kQp/hvyGHh1SkSZ5gklhCTfn7rhxx+OeQkDZRYp1Nug=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MXdoCzzigtftYoI5moU3hk7hImQq3k0CxHd/uxt1YCou1gBH9c2lQgxv/sd2Bd+ecGDLT6xJ3o5uOqA1gFBKcep4LwRzyDAh7mEXZyQuIOSbJsv/tv+ZCagwXKiLu7jsL9cflewHOCQrFA8pKggRh/B+axnMj/cURtvDMun0eLg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=OquFZMZg; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="OquFZMZg"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-1e2232e30f4so54076975ad.2
        for <linux-trace-kernel@vger.kernel.org>; Tue, 09 Apr 2024 15:18:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1712701127; x=1713305927; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=F+JyR7XVHoRHZc6sojXb4+4iOMxV4P55AJcvcX75Hlk=;
        b=OquFZMZgTvKCVYELZbko8eqib+KvBGjts8jqA9LaDx87nJ2YlobYqxdYlxzsKAG5ze
         8UbeUbiV8s7AIJ+n0O3HVeeBpGD+xiMDRHkXdaTIqndXq0uH3itZu1/WFBi9TfiuTv9n
         fBG9TYqEliAZDgHjxtrvoK2BzHb/P0Z5b9hI8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712701127; x=1713305927;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=F+JyR7XVHoRHZc6sojXb4+4iOMxV4P55AJcvcX75Hlk=;
        b=mlgalG7oId9pLLVMncdvPcparcJ3Q596B/KXEnwb6RroPuR8kCpC/wFH9DPHE6LXPA
         PzpvqJRsZPAM864Kq+4MczRubhJEEHnKrohRqJ0Wodg/ohEl2qDZqUWF/Yt1ZSi4acRE
         irDIili3JQoHglPHzHDsWudbQqeWUVLwLV8RQLOoQKwzutjPplnzcSietxjRwXiEgpYF
         XR+MXBJLzj2gagbu2nJ1OJj00W6FLFkEk/9Mg3niFj3Lrd+5ioyaeYLw1jg5XNe5Mdtm
         J6kxRe0LhWVtahV7xz4s90w7bphqqGziPOJr9jpF2Mj6ALX/6p0tPSWnb9STEWhnO/LO
         xWjA==
X-Forwarded-Encrypted: i=1; AJvYcCV33PY84YcngRSqXrcVknwcuDY+kA/KWBVttRgoBN/HQ8IuA/ZMdDTI8d86L2T30YlS0mw48EgJ+rlTAzCPczV5rHLf1PZ+C2W6jLJ/3+BW+CSM
X-Gm-Message-State: AOJu0YygaUWgdUNNSFkDzPZFbIEfsX19MpJk1SS/NgNnpVo1h8WBKP8L
	zLOIuMwy1wj6rsnXeTZhNnDTMbHxJ8HimHPBMsjtv5loOqd1sDt8epiiuCkBZg==
X-Google-Smtp-Source: AGHT+IENZctdg8MkUuUiVzh50tzQyi+yJOAszWlX5nLtc5XoQbPa9E+CgbKpF8Y3/gmyeJNYOs1OWw==
X-Received: by 2002:a17:902:d4c1:b0:1e4:1873:843c with SMTP id o1-20020a170902d4c100b001e41873843cmr1191665plg.62.1712701127333;
        Tue, 09 Apr 2024 15:18:47 -0700 (PDT)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id q12-20020a17090311cc00b001e223b9eb25sm9416376plh.153.2024.04.09.15.18.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Apr 2024 15:18:46 -0700 (PDT)
Date: Tue, 9 Apr 2024 15:18:45 -0700
From: Kees Cook <keescook@chromium.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	Lorenzo Stoakes <lstoakes@gmail.com>, linux-mm@kvack.org,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Tony Luck <tony.luck@intel.com>,
	"Guilherme G. Piccoli" <gpiccoli@igalia.com>,
	linux-hardening@vger.kernel.org, Guenter Roeck <linux@roeck-us.net>,
	Ross Zwisler <zwisler@google.com>, wklin@google.com,
	Vineeth Remanan Pillai <vineeth@bitbyteword.org>,
	Joel Fernandes <joel@joelfernandes.org>,
	Suleiman Souhlal <suleiman@google.com>,
	Linus Torvalds <torvalds@linuxfoundation.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>
Subject: Re: [POC][RFC][PATCH 2/2] pstore/ramoops: Add ramoops.mem_name=
 command line option
Message-ID: <202404091514.B97720B8@keescook>
References: <20240409210254.660888920@goodmis.org>
 <20240409211351.234897475@goodmis.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240409211351.234897475@goodmis.org>

On Tue, Apr 09, 2024 at 05:02:56PM -0400, Steven Rostedt wrote:
> From: "Steven Rostedt (Google)" <rostedt@goodmis.org>
> 
> Add a method to find a region specified by memmap=nn*align:name for
> ramoops. Adding a kernel command line parameter:
> 
>   memmap=12M*4096:oops ramoops.mem_name=oops
> 
> Will use the size and location defined by the memmap parameter where it
> finds the memory and labels it "oops". The "oops" in the ramoops option
> is used to search for it.
> 
> This allows for arbitrary RAM to be used for ramoops if it is known that
> the memory is not cleared on kernel crashes or soft reboots.
> 
> Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
> ---
>  fs/pstore/ram.c | 18 ++++++++++++++++++
>  1 file changed, 18 insertions(+)
> 
> diff --git a/fs/pstore/ram.c b/fs/pstore/ram.c
> index b1a455f42e93..c200388399fb 100644
> --- a/fs/pstore/ram.c
> +++ b/fs/pstore/ram.c
> @@ -50,6 +50,11 @@ module_param_hw(mem_address, ullong, other, 0400);
>  MODULE_PARM_DESC(mem_address,
>  		"start of reserved RAM used to store oops/panic logs");
>  
> +static char *mem_name;
> +module_param_named(mem_name, mem_name, charp, 0400);
> +MODULE_PARM_DESC(mem_name,
> +		"name of kernel param that holds addr (builtin only)");
> +
>  static ulong mem_size;
>  module_param(mem_size, ulong, 0400);
>  MODULE_PARM_DESC(mem_size,
> @@ -914,6 +919,19 @@ static void __init ramoops_register_dummy(void)
>  {
>  	struct ramoops_platform_data pdata;
>  
> +#ifndef MODULE
> +	/* Only allowed when builtin */

Why only when builtin?

> +	if (mem_name) {
> +		u64 start;
> +		u64 size;
> +
> +		if (memmap_named(mem_name, &start, &size)) {
> +			mem_address = start;
> +			mem_size = size;
> +		}
> +	}
> +#endif

Otherwise this looks good, though I'd prefer some comments about what's
happening here.

(And in retrospect, separately, I probably need to rename "dummy" to
"commandline" or something, since it's gathering valid settings here...)

-- 
Kees Cook
