Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0BB98C10
	for <linux-trace-kernel@vger.kernel.org>; Thu, 12 Oct 2023 10:40:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="AKzwN74b"
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D6E3CA
	for <linux-trace-kernel@vger.kernel.org>; Thu, 12 Oct 2023 03:40:09 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id 5b1f17b1804b1-405505b07dfso12315865e9.0
        for <linux-trace-kernel@vger.kernel.org>; Thu, 12 Oct 2023 03:40:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1697107208; x=1697712008; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=6fBGv66jYc2kP0EhTg6b4IeqJJdAfPC3InwDkFeTIyA=;
        b=AKzwN74bLWFYfSbHpcwoInEIDR7BGv9cWxDz2cIurqZYRCSUWjyjlYcBzMMr+BJAIU
         jO872G/bFm9/p7/p/13tuJZQQPaJLnnFvJDXYEB10CT5zPSVMRCpH7JNgqswslovxsh3
         lB5zQ+DdOElErZxffy/oyetPq4Z1vZeRkf8gUjc/4RM0PVgQd3vkSg+HICoPNla8LRKy
         cJbaYc26AbXcEQIrWtCIdanVNAGsk2WA4GPOZ/fchJmzCvL1WJglTbMsaG2IHYj2jeKV
         CJxh2uOyx4pexgHhX5faDltt7DpQGfucUGKWB5OiAgSraJnZXbiOtOD44NjuoV1yNXjv
         /hIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697107208; x=1697712008;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6fBGv66jYc2kP0EhTg6b4IeqJJdAfPC3InwDkFeTIyA=;
        b=qr9dDEwjL6H5l1WBE/oQ1U0d1rOl99mwSTfAwWEWqT4a44+nNg4DSNmzs4HS24VYcU
         cQZLdlqzokeztBzvFSM8CGfqvJ3uHeTtGC8XkLhtwHSolth0At16XGHrjvxF+SoyoNhC
         kTA+y5OJhQ0EGVSmlqJdedTYtQAEweP1pUKgUOEJQNLkvaXUaiuQkYOBW31FT4h6PfZH
         F6OovzmhTcaLZYflV0TiXCS23uE8wOywMVNZV4kHpNg4RPwHWRN4WoLlKPsd+1pgSV//
         mv2r3Olmtjwnf8f36PqTFiJvT03xe+yA3h+nH+uhvxNl1LgJwCTASPAGdG8ztR0sh8eB
         RGZA==
X-Gm-Message-State: AOJu0YzA78C2bSFn+boZPh/519e3GYBqoWD3kropcPY6dtLiBmB5eBk5
	7kG+2UvPO+/QQpWbiyXpat/BOg==
X-Google-Smtp-Source: AGHT+IF8V6MtmrGJXfoKWdkMTLSXJ0Shox2IXfQr1G5ZzSCY11ydmvnI2OuBxMZRARrCQZrzayKNqw==
X-Received: by 2002:a7b:c457:0:b0:401:c8b9:4b86 with SMTP id l23-20020a7bc457000000b00401c8b94b86mr19040636wmi.9.1697107207598;
        Thu, 12 Oct 2023 03:40:07 -0700 (PDT)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id a12-20020adff7cc000000b0031423a8f4f7sm18050789wrq.56.2023.10.12.03.40.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Oct 2023 03:40:07 -0700 (PDT)
Date: Thu, 12 Oct 2023 13:40:04 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Julia Lawall <julia.lawall@inria.fr>,
	Steven Rostedt <rostedt@goodmis.org>,
	kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH] tracing/eprobe: drop unneeded breaks
Message-ID: <ef43db1c-c50f-479e-8747-3f3a0915eb70@kadam.mountain>
References: <20230928104334.41215-1-Julia.Lawall@inria.fr>
 <20230929203259.74d4ba263b3455172ef37f06@kernel.org>
 <alpine.DEB.2.22.394.2309291336260.3137@hadrien>
 <20230930181902.eb1d089243deca0017046437@kernel.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230930181902.eb1d089243deca0017046437@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Sat, Sep 30, 2023 at 06:19:02PM +0900, Masami Hiramatsu wrote:
> On Fri, 29 Sep 2023 13:37:08 +0200 (CEST)
> Julia Lawall <julia.lawall@inria.fr> wrote:
> 
> > 
> > 
> > On Fri, 29 Sep 2023, Masami Hiramatsu  wrote:
> > 
> > > On Thu, 28 Sep 2023 12:43:34 +0200
> > > Julia Lawall <Julia.Lawall@inria.fr> wrote:
> > >
> > > > Drop break after return.
> > > >
> > >
> > > Good catch! This looks good to me.
> > >
> > > Acked-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> > >
> > > And
> > >
> > > Fixes: 7491e2c44278 ("tracing: Add a probe that attaches to trace events")
> > 
> > Thanks.  I didn't include that because it's not a bug.  But it does break
> > Coccinelle, which is how I noticed it.
> 
> OK, I got it. I thought it may cause a compiler warning because the
> 'break' never be executed. (maybe it is just a flow-control word,
> so it may not need to be warned, but a bit storange.)

I don't think GCC warns about unreachable code, but yeah, in Smatch
unreachable break statements do not trigger a warning.  People like
to add extra break statements to switch statements.

regards,
dan carpenter

