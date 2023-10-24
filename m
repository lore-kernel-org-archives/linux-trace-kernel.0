Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F1B42D601
	for <linux-trace-kernel@vger.kernel.org>; Tue, 24 Oct 2023 21:50:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ecZEhEWN"
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A49ED7D
	for <linux-trace-kernel@vger.kernel.org>; Tue, 24 Oct 2023 14:50:08 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id d9443c01a7336-1ca74e77aecso1675985ad.1
        for <linux-trace-kernel@vger.kernel.org>; Tue, 24 Oct 2023 14:50:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1698184208; x=1698789008; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=kUk/3FUrTP2O4nxINnBvX1NoZwU7c4mrwIneHTDtXz8=;
        b=ecZEhEWNeFWjXXZhmpUQxqgQXST3Pc9zkLw3mrVneHts2vbd/VahNRRr8KbUiSEN4g
         zsrzSYlJvaUxjgdvNncP533jdFysu9Uv1t2Mqt7/V+ysQmbSghDEKQA+0qXpSz1FV1Yw
         U4EKIt+Hk7tBzbH9Bw8fEYCpv7y2cxaWN5tQY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698184208; x=1698789008;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kUk/3FUrTP2O4nxINnBvX1NoZwU7c4mrwIneHTDtXz8=;
        b=BD+Uxdo6WzuDto6EHD7XFlz7+sRBy2zFvTMJgjCZUa8GPTLRaYAkas7dtqavVyJiB5
         Q5USLJjlXDu4k9T5QOCyIifNzs8H5emvMxPtedG3wu51/dkDxVlsHxuuUYIF6R3r9nOL
         oxXxzOspGnzhcwefBKG4fkB0K0m2jtaKH200TC58mHnZESl7zcYd+HtyK9ocdHaDlVqT
         ohQtSXjbUpO6YTtgAJqYgpNIYtuJAV2H2qXaYYEHyZBEpqh87W9372+EB+RPSDhzeROD
         2GU5kr+W03sWA0YRMzdAmw0558ttPyQU1r3jrfi9g66omelaPm8bISek6k+3cjWidDfX
         /54w==
X-Gm-Message-State: AOJu0YwSWKZQIu7FH0kYrpg8NAfmwu9+GYaFWcK1VCOEhPTyl4iW1hbV
	8Y76DNsBlOAEyODh/8HOeFMP9A==
X-Google-Smtp-Source: AGHT+IF9lyQ5nSycCSb10w5BnVo03pMKn2LFjJp83sLHplgq6hXesFpem/RWipRfu7bv0jUOjIuR1w==
X-Received: by 2002:a17:902:e54e:b0:1c9:ddd8:9950 with SMTP id n14-20020a170902e54e00b001c9ddd89950mr17532154plf.21.1698184208126;
        Tue, 24 Oct 2023 14:50:08 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id k20-20020a170902ba9400b001b891259eddsm7867560pls.197.2023.10.24.14.50.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Oct 2023 14:50:07 -0700 (PDT)
Date: Tue, 24 Oct 2023 14:50:07 -0700
From: Kees Cook <keescook@chromium.org>
To: "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc: Steven Rostedt <rostedt@goodmis.org>, Christoph Hellwig <hch@lst.de>,
	Justin Stitt <justinstitt@google.com>,
	linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	Kent Overstreet <kent.overstreet@linux.dev>,
	Petr Mladek <pmladek@suse.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: [PATCH] powerpc: Remove initialisation of readpos
Message-ID: <202310241449.7E91697@keescook>
References: <20231024145600.739451-1-willy@infradead.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231024145600.739451-1-willy@infradead.org>

On Tue, Oct 24, 2023 at 03:55:59PM +0100, Matthew Wilcox (Oracle) wrote:
> While powerpc doesn't use the seq_buf readpos, it did explicitly
> initialise it for no good reason.
> 
> Fixes: d0ed46b60396 ("tracing: Move readpos from seq_buf to trace_seq")
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>

Yeah, looks right -- it'd even be right if the member still existed. :)

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
