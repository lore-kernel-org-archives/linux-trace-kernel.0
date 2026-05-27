Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCC7E3E63B9
	for <linux-trace-kernel@vger.kernel.org>; Wed, 27 May 2026 10:26:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779877621; cv=none; b=Ew04TBigAgalkrmVjk4X7uLeHUPEqcFXFCjZRTVd/5XmtyHRxLRzkcHial+L5rrLj0uwRB7isxqYthedxnoAKKZPfh2b1AITKPDIsyozkW/lGKZ2FeaEdgvpKi7qP2gHmxoQLuSlZs2C/kxi1OwxzTIwiOtrAsqdSAaXpg6vqmI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779877621; c=relaxed/simple;
	bh=5JrKNF+0hgx30EUykrmbuowZ47eifIDFQqV5G7LOLYA=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sUgS+sL0SjFXNM0cSYP6o8nD0NyyesULzLK7jloSX8UDCfxcDmFAhSL5O+KwW64BGfeDvr5+iwr3VIc7lDKM2OWbR/2KXYHy4Q3J/tzKsGTcndKB9EcUaZvo4rWnjLagkxbyx+8qIQsQ+CL16/RugHnN+rANox/R80N1Vc1s0X4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jD23Loy5; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jD23Loy5"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-49056b9f04aso52190145e9.0
        for <linux-trace-kernel@vger.kernel.org>; Wed, 27 May 2026 03:26:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779877618; x=1780482418; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Vv0kW+/+dU0DMQODvUulSzjxITYx5OTCXT8hkFS6DFo=;
        b=jD23Loy598HoeBXWy13t7LlJJz1/dazEUh/ihnoVkifX6y/SBTLvphMeyUk5AczgEU
         Gx8xVzEOGAdK71Gx3AnbwudkDQ8nkfGuB7xHglA6cXfWYNYBKGICCaZSZ1a3uh/QkTl0
         X4VJ3zgkuitJWr7rhLcw+JA4IZe+OsiHA/1B5jhnhtNJoJh5gBeDbZPxXlUNHeHklVQD
         umqtMCpW1DO2rJiBWbDAinu7YzWnpwDMe/PpHJBpGsa7dj0F74p9YJnEfPd0Dkc/E+4G
         MStorQcfMlA0K+RXcVJ+PlLlPNmhkb5kacjK0CvCUgGCrvnNSx7xgrR5lLzAbsyd+ncJ
         ebIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779877618; x=1780482418;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Vv0kW+/+dU0DMQODvUulSzjxITYx5OTCXT8hkFS6DFo=;
        b=kpbyvZDH1ZusjJCEjg2QSDEo9APw/dPvNefrjK0IiRYScd9pR8sJPs2y+LD2xPvWeV
         SXzXbWUpbIvpR+gFRfnSQNToQZcado+DMe60A+4GuJvHTz44wxhOa8RkdgVdrC/fQa7p
         jcdAVW8F0yF4qAH8aLqonAzj/a8CA228BwqWLTe2p9X6oMhcrlfZAfdVz9uJV7OkFIqF
         e/dC1li+AZ+2GztPiBP7tY8Nsm7Xe+jVye/fa4i3a1EOP5/4V1m5F9eTsibE03zCgCg5
         ZHTHgpVOaUriV2MyGVZt8uVoA+ylDa6HYzlF486R90L8pKQOTx3o7g4b3OoKo79nXn2o
         kGlA==
X-Forwarded-Encrypted: i=1; AFNElJ8BtPL6/i0SOhE0M/fIW2luLelRoRJmLzltUr6W3mkq6+FoQSj/hjwyJB65BQTDiqoufpqpDATyJ8KfHrTTadnBqwE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzJYmxDMvrYEtVSp7Kc3RkUeupZCEnXQnAzKHj6c4y5pHOdlHVS
	CKFVm6aDgrOQtbJ4fm3WNzTkw4po3faj1J43oraiA/wi11aSvfGOUijj
X-Gm-Gg: Acq92OF61qeQsAfxThfvYmyxOk5ZfCQjj8ZzWnY8D5DLvMiDah3zVQOxrGTn1HkCnVo
	32DG3x2k792uZQmKqzb+KNotxUSEvBDwhIkA5KHHjhx75HyjHr/E4zrfsD/FvuGOAg0K5aynmAN
	i4jFkGzxIuhQYx4NmY3Vth7ynZSarzLNiJgpz/C9N4/mPM/6eh2pmYRFnSMDJ55jnDQQ2hKOOS7
	8pPl4mQ0+O/hHVMxitCRNqtpTSH/owenZenu09h+vjGB28e2FmfSmlaGGWVSepING1pqmmumc/h
	lkT3Ey3Co75ghRNpu7ptNfToV2B+lot/o4hlqB3RObHhbAVnah/DwzyJhtS50Hn4KOpgE5DWskF
	uBrQXO1lQCejvmb+CuGgfofbR7uyURvclBn5j2xm6SDQFI3dPMuJdnTc38JazRvYYzme5hrEU4G
	selp45ZluEkCjRR6BSuHLH2eWD3w==
X-Received: by 2002:a05:600c:8217:b0:490:5215:e9a4 with SMTP id 5b1f17b1804b1-4905215ebd3mr297282795e9.6.1779877617908;
        Wed, 27 May 2026 03:26:57 -0700 (PDT)
Received: from krava ([2a02:8308:a00c:e200:b655:ff13:e355:16a3])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4904561a198sm378916395e9.10.2026.05.27.03.26.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 May 2026 03:26:57 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Wed, 27 May 2026 12:26:55 +0200
To: bot+bpf-ci@kernel.org
Cc: oleg@redhat.com, peterz@infradead.org, mingo@kernel.org,
	mhiramat@kernel.org, andrii@kernel.org, bpf@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org, ast@kernel.org,
	daniel@iogearbox.net, martin.lau@kernel.org, eddyz87@gmail.com,
	yonghong.song@linux.dev, clm@meta.com, ihor.solodrai@linux.dev
Subject: Re: [PATCHv4 12/13] selftests/bpf: Add tests for uprobe nop10 red
 zone clobbering
Message-ID: <ahbG7xmj8wI-gS4k@krava>
References: <20260526205840.173790-13-jolsa@kernel.org>
 <623e280bfab376da047f79dd9ef8f646c26f38fdb0348fce7f8f8108a1261ee4@mail.kernel.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <623e280bfab376da047f79dd9ef8f646c26f38fdb0348fce7f8f8108a1261ee4@mail.kernel.org>

On Tue, May 26, 2026 at 09:46:42PM +0000, bot+bpf-ci@kernel.org wrote:
> > diff --git a/tools/testing/selftests/bpf/prog_tests/uprobe_syscall.c b/tools/testing/selftests/bpf/prog_tests/uprobe_syscall.c
> > index 969f4deba9fd..efff0c515184 100644
> > --- a/tools/testing/selftests/bpf/prog_tests/uprobe_syscall.c
> > +++ b/tools/testing/selftests/bpf/prog_tests/uprobe_syscall.c
> 
> [ ... ]
> 
> > @@ -855,6 +897,37 @@ static void test_uprobe_race(void)
> >  #define __NR_uprobe 336
> >  #endif
> >
> > +static void test_uprobe_red_zone(void)
> > +{
> > +	struct uprobe_syscall_executed *skel;
> > +	struct bpf_link *link;
> > +	void *nop10_addr;
> > +	size_t offset;
> > +	int i;
> > +
> > +	nop10_addr = find_nop10(uprobe_red_zone_test);
> > +	if (!ASSERT_NEQ(nop10_addr, NULL, "find_nop10"))
> > +		return;
> > +
> > +	skel = uprobe_syscall_executed__open_and_load();
> > +	if (!ASSERT_OK_PTR(skel, "open_and_load"))
> > +		return;
> > +
> > +	offset = get_uprobe_offset(nop10_addr);
> > +	link = bpf_program__attach_uprobe_opts(skel->progs.test_uprobe,
> > +			0, "/proc/self/exe", offset, NULL);
> > +	if (!ASSERT_OK_PTR(link, "attach_uprobe"))
> > +		goto cleanup;
> > +
> > +	for (i = 0; i < 10; i++)
> > +		ASSERT_EQ(uprobe_red_zone_test(), 0, "red_zone_intact");
> 
> Does this loop execute too quickly to guarantee the uprobe optimization has
> completed?
> 
> Uprobe optimization is performed asynchronously by a worker thread. Since this
> is a tight loop with no delays or blocking, the 10 iterations might finish
> before the background worker patches the code.

uprobe is optimized synchronously whithin its first hit

> 
> If all hits execute on the unoptimized INT3 path, the test could falsely pass
> on kernels where the CALL-based optimization bug is present.
> 
> (This concern was raised by sashiko-bot@kernel.org in v1 and remains
> unaddressed:
> https://lore.kernel.org/bpf/20260514212219.BF1F3C2BCB3@smtp.kernel.org/)
> 
> > +
> > +	bpf_link__destroy(link);
> > +
> > +cleanup:
> > +	uprobe_syscall_executed__destroy(skel);
> > +}
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
> 
> Is this test reliable across different compiler versions and optimizations?
> 
> The USDT macro uses the "nor" inline assembly constraint, which allows the
> compiler to allocate these operands to CPU registers.
> 
> Because there is no register pressure in usdt_red_zone_trigger(), modern
> compilers might allocate a1, a2, and a3 directly to registers rather than the
> stack's red zone.
> 
> If the operands are placed in registers, the uprobe CALL optimization
> clobbering [rsp-8] will not corrupt them. This could cause the test to pass
> even on buggy kernels, creating a false positive.
> 
> Would it be safer to explicitly force these operands into the red zone using
> inline assembly constraints, rather than depending on the compiler's register
> allocator?

I think it's ok the way it is, usdt_red_zone_trigger uses redzone on x86_64 build:

0000000000830d02 <usdt_red_zone_trigger>:
  830d02:       55                      push   %rbp
  830d03:       48 89 e5                mov    %rsp,%rbp
  830d06:       48 8b 05 6b f3 44 03    mov    0x344f36b(%rip),%rax        # 3c80078 <usdt_red_zone_arg1>
  830d0d:       48 89 45 f8             mov    %rax,-0x8(%rbp)
  830d11:       48 8b 05 68 f3 44 03    mov    0x344f368(%rip),%rax        # 3c80080 <usdt_red_zone_arg2>
  830d18:       48 89 45 f0             mov    %rax,-0x10(%rbp)
  830d1c:       48 8b 05 65 f3 44 03    mov    0x344f365(%rip),%rax        # 3c80088 <usdt_red_zone_arg3>
  830d23:       48 89 45 e8             mov    %rax,-0x18(%rbp)

...

jirka
