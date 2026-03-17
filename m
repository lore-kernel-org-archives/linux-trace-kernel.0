Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A277A2DF132
	for <linux-trace-kernel@vger.kernel.org>; Tue, 17 Mar 2026 17:18:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773767928; cv=none; b=jqrxkalgrrWTC2LED34uDuIsmXw1Ks4PNiDeZk5x5HgWPvtR1xrXXyK0XS3Cbig1C3l4UXiFCATY+t2sM2jF5Hrpq77oKkDmTO1iY3Lb7CReJw4ZZEhEPhcgxuo25J58tXrZ4zB1kLmlkGm5GnCSLLTwZxZg+DopJzn4B4f+fMs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773767928; c=relaxed/simple;
	bh=jSTOBk0QchOGhgQ9fPNgvyzaWz53LGuahLTQNnHNAiw=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=au0sUiDuEJtCuhWnR15+thUEVk8sNGZZ3IvSCHLHqq0MRYN3ZHyGf2WFCdQ0374LmcQuVKe+fbqeU187lvptyUNLrO4pp5VK5gb+kAvBHBmzjCtogtFX9bho7XrB7fTU+e5kQaLMXATBnTSZYRRQEOf7Bvy/bvCioaDtsLXgJoQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y1mnl9Rt; arc=none smtp.client-ip=209.85.219.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y1mnl9Rt"
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-899a5db525cso69123766d6.3
        for <linux-trace-kernel@vger.kernel.org>; Tue, 17 Mar 2026 10:18:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773767927; x=1774372727; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=FaaFcjOrcgiRK0kqbKsrAvjcKayVzBLU1SPmKnUc9iU=;
        b=Y1mnl9Rt86jddtZQKqyhespKO6Jbqe2GxUNUs57jaW7fBxuvLsq2Ps5WdUT6qHJ1hP
         lnI77KCwW9hZ3Bj1zTI3Kz/6vBlHWGX37Ol90aGRHFX4qtHGeTtzvhYaSDbe/8M5sQ7o
         hbmgMjSZg0d3VibGx6YvKAgK7kDszXUwpyxGZtbfgRan8a876tKPQBx4yVMzWwzGunT/
         kwOuTsAJ/3ZroD0I/250IQYBoHS33h8MvqVavmXjqxwuQSEwbU87sQfBYMM+wuzTPuAz
         9LaB+2t2qmULE5fVQtkg7THsbLkSXZf5QcgV12JAHi2Eukw/q1p1VAi+7dbs2T82lg6D
         g+Wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773767927; x=1774372727;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FaaFcjOrcgiRK0kqbKsrAvjcKayVzBLU1SPmKnUc9iU=;
        b=RmTy0A05j8Z0f3a/afYz0Wk7oUx8UXccQGGatOUUK2TgbeTaGl6c8nx6logMV6H/JI
         CCtj+55bznqrYFa6hCP9Mc45akmt0QrMOnWQmYA36oa17ig6VwE0Q8Ps3ygBS4WtILfS
         wOCliqsN48pqMV48jd56hM2LvDWUTT39Z8G6VN2b+Zw3F3JyWwr5RszOdYTeQsMI1qfG
         HJj633fe4kWJIYR+ynFpkUr9WQQ1GRv4gMjpqOQ5I0dVnmHMqW8PZl9J8Cl3tKPDZ19v
         YANHxXbfcD0QL9cVVdhl5mDu5PPMmMeT7fRgWZDG0rtkF09DA4BTwhmJ2H4vI9LuMWIw
         32rg==
X-Forwarded-Encrypted: i=1; AJvYcCUNiEVDUwsZUkK/2UteO2btX/E4V5MMRZg2pUqcT+61qLaIEEIhWpI2jdjkenAYS9TsyI0B54qv/vHJ4LWeS9oDksg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwXC4W+wb075LiqQ6QH7GwDapiMiSMYLjRxEuvZfPjQH3GlpPrc
	CxuTSrjMmBB69RDB2POe61BPxiu+E2rOZY9i+wG0C3Zk+PQJk6UWxCiz
X-Gm-Gg: ATEYQzxtf+C/RGEKnYV8rPohNoBveLLxOx0cWdOP+hBtQnc/U0ETR+qUmokVRk2XgJI
	0tau+Y7NkfGvf5Z6AnNN5hLtegvumMwhZ/mU/uPzKNYr+igB8utetctLqYcnKpCHTMTsBK4EVLY
	PTpw8OGSbJQzXQadWO7Qd3ytgjKpU3QCFCsc6QL50Bxdvgv3WekWPFZ4GGvD1Wic0xd5Bno58yS
	bc3rA9RbAw/+vTf97JfD1jfmOpdUdUV+CGg03AfCPSAh3k+s8C9R2qi6sLMXEmV3Ju4y1DrAq6A
	/m76epessoB9KpIVxvllXEeNpQMBZCvp7n4jK/p7PKJM5oT3vqAadVGOlKxTFz/fFg0sgiDYHcD
	qpfHnVukl+8BNlYsVNExU6I/sLODkfXzMETj3EcizQoGJc/X/bXKSuUmlBdfYFbhEiusmmm39eR
	zTMVaVGVVHjTA=
X-Received: by 2002:a05:6214:6003:b0:89c:5385:3476 with SMTP id 6a1803df08f44-89c6b56f9e2mr4975846d6.39.1773767926377;
        Tue, 17 Mar 2026 10:18:46 -0700 (PDT)
Received: from krava ([176.74.159.170])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-89c6b8e0275sm1329206d6.7.2026.03.17.10.18.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Mar 2026 10:18:45 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Tue, 17 Mar 2026 18:18:41 +0100
To: Leon Hwang <leon.hwang@linux.dev>
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org, Martin KaFai Lau <kafai@fb.com>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
	Menglong Dong <menglong8.dong@gmail.com>,
	Steven Rostedt <rostedt@kernel.org>
Subject: Re: [PATCHv3 bpf-next 19/24] selftests/bpf: Add tracing multi
 intersect tests
Message-ID: <abmM8XHYfhd9qiAz@krava>
References: <20260316075138.465430-1-jolsa@kernel.org>
 <20260316075138.465430-20-jolsa@kernel.org>
 <63fa6255-8682-495d-abe1-d30d72a7ece9@linux.dev>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <63fa6255-8682-495d-abe1-d30d72a7ece9@linux.dev>

On Tue, Mar 17, 2026 at 11:05:29AM +0800, Leon Hwang wrote:

SNIP

> > diff --git a/tools/testing/selftests/bpf/prog_tests/tracing_multi.c b/tools/testing/selftests/bpf/prog_tests/tracing_multi.c
> > index e9042d8d4760..b7818f438d6e 100644
> > --- a/tools/testing/selftests/bpf/prog_tests/tracing_multi.c
> > +++ b/tools/testing/selftests/bpf/prog_tests/tracing_multi.c
> > @@ -6,6 +6,7 @@
> >  #include "bpf/libbpf_internal.h"
> >  #include "tracing_multi.skel.h"
> >  #include "tracing_multi_module.skel.h"
> > +#include "tracing_multi_intersect.skel.h"
> >  #include "trace_helpers.h"
> >  
> >  static const char * const bpf_fentry_test[] = {
> > @@ -31,6 +32,20 @@ static const char * const bpf_testmod_fentry_test[] = {
> >  
> >  #define FUNCS_CNT (ARRAY_SIZE(bpf_fentry_test))
> >  
> > +static int get_random_funcs(const char **funcs)
> > +{
> > +	int i, cnt = 0;
> > +
> > +	for (i = 0; i < FUNCS_CNT; i++) {
> > +		if (rand() % 2)
>                     ^ srand() is missing for rand() ?

it's in test_progs main

> > +static void test_intersect(void)
> > +{
> > +	struct tracing_multi_intersect *skel;
> > +	const struct bpf_program *progs[4];
> > +	__u64 *test_results[4];
> > +	__u32 i;
> > +
> > +	skel = tracing_multi_intersect__open_and_load();
> > +	if (!ASSERT_OK_PTR(skel, "tracing_multi_intersect__open_and_load"))
> > +		return;
> > +
> > +	skel->bss->pid = getpid();
> > +
> > +	progs[0] = skel->progs.fentry_1;
> > +	progs[1] = skel->progs.fexit_1;
> > +	progs[2] = skel->progs.fentry_2;
> > +	progs[3] = skel->progs.fexit_2;
> > +
> > +	test_results[0] = &skel->bss->test_result_fentry_1;
> > +	test_results[1] = &skel->bss->test_result_fexit_1;
> > +	test_results[2] = &skel->bss->test_result_fentry_2;
> > +	test_results[3] = &skel->bss->test_result_fexit_2;
> > +
> > +	for (i = 1; i < 16; i++)
> > +		__test_intersect(i, progs, test_results);
> > +
> > +	tracing_multi_intersect__destroy(skel);
> > +}
> > +
> >  void test_tracing_multi_test(void)
> >  {
> >  #ifndef __x86_64__
> > @@ -347,4 +444,6 @@ void test_tracing_multi_test(void)
> >  		test_module_link_api_pattern();
> >  	if (test__start_subtest("module_link_api_ids"))
> >  		test_module_link_api_ids();
> > +	if (test__start_subtest("intersect"))
> > +		test_intersect();
> >  }
> > diff --git a/tools/testing/selftests/bpf/progs/tracing_multi_intersect_attach.c b/tools/testing/selftests/bpf/progs/tracing_multi_intersect_attach.c
> > new file mode 100644
> > index 000000000000..b8aecbf44093
> > --- /dev/null
> > +++ b/tools/testing/selftests/bpf/progs/tracing_multi_intersect_attach.c
> > @@ -0,0 +1,42 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +#include <stdbool.h>
> > +#include <linux/bpf.h>
> NIT:         ^ vmlinux.h is better than stdbool.h + bpf.h.

ok, thanks

jirka
