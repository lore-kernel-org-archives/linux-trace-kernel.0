Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C2883E00BC
	for <linux-trace-kernel@vger.kernel.org>; Mon, 18 May 2026 07:30:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779089426; cv=none; b=n3Rx/eC+oTlYCbZcSFsc6yQysaSJzwnMRMYQXFxaM6uwD1PQ6WrjbHHsDmMtVz6q6yuR3K4Tv7Ext3PnIMUBVyI53kTgvxVUcnMob592clc3MvVKZx5UW+2hhiqSKQWJOCfek8vHjRv1Cx3RGkwrHXECgdoJZu807oMeLk//Cvk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779089426; c=relaxed/simple;
	bh=mbadVLZ6bL0J+sZop3+3uY+JWy25lmu6eAlB9b9yT5s=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fOcAKn5jLnweB86ln6fpXVE8W5SKFGMlzs+IDkbubgXmoGqoA2zVEFtCFr4k304LG5Ihan00gxarG6s4soxmvt78TMPZbNzWvxOnT0/NqSoiJ+Uk9aK6DZHB5s8bCSo5GrrM3Je4MWx8IRone9uoZ/peJHf02+kprNVIdJb7ts0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Dlt0m/QI; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Dlt0m/QI"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-48e6db3ff7eso8702185e9.0
        for <linux-trace-kernel@vger.kernel.org>; Mon, 18 May 2026 00:30:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779089422; x=1779694222; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=xh/AxLf471cnVpc03r7l2vpXef4hntdNPKHO+t5c94Q=;
        b=Dlt0m/QI03JED5CqzNLKjw/g+6PibRK1Kz8WmoiwcocTbvBqMUsNvFQJrUHi5pE/Cu
         io5dtfBFiFFeLWLCXB/9LR4IfodXX3GHfDMzgLyCBFJRVPNFKb4NC8uh8PnGRDzZLyWv
         gkTWC5zFJrWwvxBt2ZJgC8g2czPKjkLg56X2wS59ZHjqPFMUmQVxpBbK4ap+PWsZIKRa
         ai/0gjnfmE1auTcGlrxNJmueYRZvK5C6KiHTeVdMIlRJQkixAEI3pQ0p2DWq3O+INyFV
         VFGLIydfF4Ntc5sfNBHSOOBPLFFt9FxxxkNeGMLH4Hv+kL2eh0qNErzUssAaxzlEx2C5
         3xug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779089422; x=1779694222;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xh/AxLf471cnVpc03r7l2vpXef4hntdNPKHO+t5c94Q=;
        b=jNMPZDPKgzaVljE541Om0i1V0wk6d2knj0rDllt+rt7MeMW75y2yTkyh2ZnPk/A8nZ
         3fsHbQhvlDtY5sEehhMG5flPbCj11JnbYdqvurR1NnMQcOaMDq7U4O99eYZByHuWtu9/
         mCaNd+BYPOAHCzRVbNTrU28ieaOndJDmbbMLb/N6iNiOQIT+d55GL+NuPjaVwaJC5Ahd
         xfHMlh+U+Rw6u+gZUjWd72KIkajB9LZ/BPBFt65s7VC8Tw15rbaM9tLBFOwE3qPCYpC6
         KQqRJvDlScXZ4AO+bHtOF2JHkQGs5HCIBRbZt6dDOGiaSETBtx2XO4dhErUwOR/x9uFZ
         j63A==
X-Forwarded-Encrypted: i=1; AFNElJ9Ap2Jr+s2E0Dk58Hg9MU0fg0pMVpmydYwhamFdErANld/UmwU0mf1ig/sNxh6N/hC5kA5rKbdfOmu+9S4smNQ7LlU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx05pkE//MMd37DAwBxCppvg1tgsIn8MCtfv3Z3imydvB2YNyDg
	NiaSlnGVBe/QUwcx/8v4HjULxBKKA4hHpHabRTHCfuJ8wBsOSBGQs1ss
X-Gm-Gg: Acq92OE7BZ6cwbLLOy476ClJAX9TljCOXpnWEQ8953Vn9X3FTQipVTuPJJ+m0wiL7xe
	jln829egkuTZZyymOwbFVG3NWm8aJsiPim931kVXxeEFGxvorFdewULK2cANm/OPZYusYwE+kJu
	9h3mYz6xRKz9zeBJVycLX1wtnk3VMRJS2exgbIq9GWInVdwrqQTVC4dYViseZo2MiqygenNS9ZJ
	5UVEOLJJ5GsIqt0MYdNQ8V0nzLjqw+9MckH0zRiFKjFN9/iTpVvs7WmyGbxPHwX/1dWOpGq3T8P
	sQ+t3h0u6RQ6y3BdbA6+zeTZNtwPaxCtQfIL7gUU9hEbutzT2FJRDFc7LYLN3qBof1y/yM/5nS3
	HObCIp0WOHhgVJwwqYumrC5czxTciz14fCsCv6Uwj0d/jKdDC0mg5a8HDy4t2rgzOgBRvb+kKSr
	v2mjewDgR8nsC3/HU=
X-Received: by 2002:a05:600c:1d0d:b0:48f:da34:ec4e with SMTP id 5b1f17b1804b1-48fe632343dmr195664805e9.19.1779089421682;
        Mon, 18 May 2026 00:30:21 -0700 (PDT)
Received: from krava ([2a02:8308:a00c:e200:b655:ff13:e355:16a3])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48fe5694fcasm218214925e9.5.2026.05.18.00.30.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 May 2026 00:30:21 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Mon, 18 May 2026 09:30:19 +0200
To: bot+bpf-ci@kernel.org
Cc: oleg@redhat.com, peterz@infradead.org, mingo@kernel.org,
	mhiramat@kernel.org, andrii@kernel.org, bpf@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org, ast@kernel.org,
	daniel@iogearbox.net, martin.lau@kernel.org, eddyz87@gmail.com,
	yonghong.song@linux.dev, clm@meta.com, ihor.solodrai@linux.dev
Subject: Re: [PATCH 7/7] selftests/bpf: Add tests for uprobe nop10 red zone
 clobbering
Message-ID: <agrAC8ytVy5aOEU4@krava>
References: <20260514135342.22130-8-jolsa@kernel.org>
 <e91d31e0c1378fe970db6385c7af419e97af0c2acd37b3b8775a2fac02ea2361@mail.kernel.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e91d31e0c1378fe970db6385c7af419e97af0c2acd37b3b8775a2fac02ea2361@mail.kernel.org>

On Thu, May 14, 2026 at 02:55:27PM +0000, bot+bpf-ci@kernel.org wrote:
> > diff --git a/tools/testing/selftests/bpf/prog_tests/uprobe_syscall.c b/tools/testing/selftests/bpf/prog_tests/uprobe_syscall.c
> > index 82b3c0ce9253..d553485e7db5 100644
> > --- a/tools/testing/selftests/bpf/prog_tests/uprobe_syscall.c
> > +++ b/tools/testing/selftests/bpf/prog_tests/uprobe_syscall.c
> 
> [ ... ]
> 
> > diff --git a/tools/testing/selftests/bpf/prog_tests/usdt.c b/tools/testing/selftests/bpf/prog_tests/usdt.c
> > index be34c4087ff5..606601ccdc42 100644
> > --- a/tools/testing/selftests/bpf/prog_tests/usdt.c
> > +++ b/tools/testing/selftests/bpf/prog_tests/usdt.c
> 
> [ ... ]
> 
> > diff --git a/tools/testing/selftests/bpf/progs/test_usdt.c b/tools/testing/selftests/bpf/progs/test_usdt.c
> > index f00cb52874e0..0ee78fb050a1 100644
> > --- a/tools/testing/selftests/bpf/progs/test_usdt.c
> > +++ b/tools/testing/selftests/bpf/progs/test_usdt.c
> 
> [ ... ]
> 
> > diff --git a/tools/testing/selftests/bpf/usdt_2.c b/tools/testing/selftests/bpf/usdt_2.c
> > index b359b389f6c0..5e38f8605b02 100644
> > --- a/tools/testing/selftests/bpf/usdt_2.c
> > +++ b/tools/testing/selftests/bpf/usdt_2.c
> > @@ -13,4 +13,17 @@ void usdt_2(void)
> >  	USDT(optimized_attach, usdt_2);
> >  }
> >
> > +static volatile unsigned long usdt_red_zone_arg1 = 0xDEADBEEF;
> > +static volatile unsigned long usdt_red_zone_arg2 = 0xCAFEBABE;
> > +static volatile unsigned long usdt_red_zone_arg3 = 0xFEEDFACE;
> > +
> > +void __attribute__((noinline)) usdt_red_zone_trigger(void)
> > +{
> > +	unsigned long a1 = usdt_red_zone_arg1;
> > +	unsigned long a2 = usdt_red_zone_arg2;
> > +	unsigned long a3 = usdt_red_zone_arg3;
> > +
> > +	USDT(optimized_attach, usdt_red_zone, a1, a2, a3);
> > +}
> > +
> >  #endif
> 
> Is this test reliable across different compiler versions and optimizations?
> 
> The USDT macro uses the "nor" inline assembly constraint, which allows the
> compiler to allocate these operands to CPU registers. Because there is no
> register pressure in usdt_red_zone_trigger(), modern compilers might allocate
> a1, a2, and a3 directly to registers rather than the stack's red zone.
> 
> If the operands are placed in registers, the uprobe CALL optimization
> clobbering [rsp-8] will not corrupt them. This could cause the test to pass
> even on buggy kernels, creating a false positive.
> 
> Would it be safer to explicitly force these operands into the red zone using
> inline assembly constraints, rather than depending on the compiler's register
> allocator?

answered by Andrii in:
  https://lore.kernel.org/bpf/CAEf4BzZ-nASpoF+-vLYZ1D8eWRVd5JWAuhrwx8XZNrX7ZPY5_Q@mail.gmail.com/

jirka
