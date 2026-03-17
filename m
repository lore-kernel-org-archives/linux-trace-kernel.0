Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6AFB3246F8
	for <linux-trace-kernel@vger.kernel.org>; Tue, 17 Mar 2026 17:19:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773767964; cv=none; b=fTy/XiQt73a9IlMBahPm5T0Sr/RPiILJV3NBUqCyWgvourbWmhvXuQHUOYgBel4wrHFdORYsZpeLZ+zCvgvi25PhxiPb/poEQAKXnFrUo3CQ6xP3iRlSCZGU9YMQnV2TGseaByT67DFg3uFkc0OSoS5MdzuHNHrSKGq73ua8qXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773767964; c=relaxed/simple;
	bh=hxD0ZKB3kpaMV/6e2PBrUyvA6SAeUMplado3z2CMNAk=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Xrp+xjCf3sKNiQUrJZn7/8k9R3OONDQQjdP7+VjCgyyJDUOGsA+1Os8YLxDxZ51O5vIje0mre2Qzlm+kpLS+/Uf4qW6UetGNEBU4Ebs1gabZwSBJN4mknrA21yzsI8JemSaw6P7AIPi/vjyrMtEO1ZRpsXLkT1PudXwXnKEAaq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NtMEsc9W; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NtMEsc9W"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-485345e1013so720265e9.1
        for <linux-trace-kernel@vger.kernel.org>; Tue, 17 Mar 2026 10:19:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773767961; x=1774372761; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=lbb5XTt3dThJFx41z6wh55MuRy4ZDVyorq+d+Ato0/Y=;
        b=NtMEsc9Wkz3X5YkfDKchsr24Z9YbQA8bGmfIugcvqnBK59AucZAPoWbXBIuAQS7dYF
         1lbPRTt+uF3Ob7VMy7N82F9EoJSmiXzC1xrK0dmMFz7SRmJxSTewgB36uyrAGUns1rMZ
         ar6KjSHPbpZPhtAfDQLVJYzVM+xJSQagV3NXOjHE2zmoYsGJfjM0VHjB9hSqM46aQeDg
         UEcruvIHqfW2vlVFhcQkPjaThRkk0TUKIVO5B0cADVh9BUTj+FRwOEp+EFxFMeIg8eNp
         QBd0+TIRF+FZ0C/yzrUG5Ubp+0927smEqSvUzVdkM7nosIJfJZjwrG+8r79Jdf4aDCzj
         PBNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773767961; x=1774372761;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lbb5XTt3dThJFx41z6wh55MuRy4ZDVyorq+d+Ato0/Y=;
        b=BDXCKQ/NGxj/UScmURGMoVqP0mZBIfLqB4tGPVghuHEllaj+4d+w71ia7ZOhNEkM86
         cw9NqYRdVR7Pb6PdrryizRoolCUbbN7DIwirMVsN1nlpft4wgbDGPHNG8jvGi96nYd7S
         JoF5SjROEKvK60QD7HQ4pej7LXJzLzaWZ4Sd2xpo1rSzLU/yVFxppmHqIjt6nDb4vtff
         dPfJME/cmSRJphUwQNnLc56ob8MXTnWKTt6s7ou14xCi8l04j6vNgDPBo0Q0HDk1nVnW
         AlLhA2aoqzQHUKaX3vgoUpspAa7/nNaW3axWaMrDiPc1H41fVWOyp69FPRvyJBc+YdO3
         s45Q==
X-Forwarded-Encrypted: i=1; AJvYcCWk0Jee3+cNd0ztx6Lk5vAY2jqGfv/6DUwo5XUykQRgM7aF5GMRD8ktdyHFvydEKBcoPtmM8Ahfq3XWGUKu+vLiyJU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw+h5IobVZ8N2xxnuSoUU4QnGHSH7vp90Dm9jts+ugfoWz6WoyO
	GLgDQczb/D2I9Gjvmqfr4AOPfeVocjRqhZR1Lf8jXivBrKB9Q7tvFJ3WprvwekSm
X-Gm-Gg: ATEYQzwikSFC60PJn5QkBWfA5mEXmPaqkZWOjNRowRixgfwa5fGr5KPHvsSJoX0UvG3
	Xu1WjDGQFGV/6oaBixrUA3iBDvXGVCRVocsLQ2FBMphpT0QiiRYolr/gPQ8scMk6hodpiMrklq1
	5yluLuJ93digCuJ5f6O7zImYqatAFBAjpZYk8krrnpK1wKx3vYzZgtfdUruyl/X7mUZN9ZYQXHy
	N7V2wpyoNRcV2Qxq0D8jpaxy2r1EPS4UGlDKm7tjLGW652hdUez/+NhNQPJNt5WJl/E1IcbZbfL
	E8TQM4UhJcM11NR9nkfETucz7RH9YBQowKHO0BW8Pes4KXOH6fCsa5XXOH264sENgGcawVqo8cW
	dj4f7uibc4EXWsIZzeBvw9zwIQ0w7yshYNdEPj16m7UboDshbwBSamMTZ7rZrWC08R4gXK5UYgi
	YV2JMap9gqAqo=
X-Received: by 2002:a05:600c:8709:b0:485:3c2e:60d5 with SMTP id 5b1f17b1804b1-486f40a0cfdmr8552185e9.2.1773767961000;
        Tue, 17 Mar 2026 10:19:21 -0700 (PDT)
Received: from krava ([176.74.159.170])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4856eae3322sm68363695e9.10.2026.03.17.10.19.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Mar 2026 10:19:20 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Tue, 17 Mar 2026 18:19:18 +0100
To: Leon Hwang <leon.hwang@linux.dev>
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org, Martin KaFai Lau <kafai@fb.com>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
	Menglong Dong <menglong8.dong@gmail.com>,
	Steven Rostedt <rostedt@kernel.org>
Subject: Re: [PATCHv3 bpf-next 23/24] selftests/bpf: Add tracing multi attach
 benchmark test
Message-ID: <abmNFhube7-tNuHP@krava>
References: <20260316075138.465430-1-jolsa@kernel.org>
 <20260316075138.465430-24-jolsa@kernel.org>
 <ed557f33-7f5b-4af2-aa4b-8afe22b55a57@linux.dev>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ed557f33-7f5b-4af2-aa4b-8afe22b55a57@linux.dev>

On Tue, Mar 17, 2026 at 11:09:26AM +0800, Leon Hwang wrote:
> On 16/3/26 15:51, Jiri Olsa wrote:
> > Adding benchmark test that attaches to (almost) all allowed tracing
> > functions and display attach/detach times.
> > 
> >   # ./test_progs -t tracing_multi_bench_attach -v
> >   bpf_testmod.ko is already unloaded.
> >   Loading bpf_testmod.ko...
> >   Successfully loaded bpf_testmod.ko.
> >   serial_test_tracing_multi_bench_attach:PASS:btf__load_vmlinux_btf 0 nsec
> >   serial_test_tracing_multi_bench_attach:PASS:tracing_multi_bench__open_and_load 0 nsec
> >   serial_test_tracing_multi_bench_attach:PASS:get_syms 0 nsec
> >   serial_test_tracing_multi_bench_attach:PASS:bpf_program__attach_tracing_multi 0 nsec
> >   serial_test_tracing_multi_bench_attach: found 51186 functions
> >   serial_test_tracing_multi_bench_attach: attached in   1.295s
> >   serial_test_tracing_multi_bench_attach: detached in   0.243s
> >   #507     tracing_multi_bench_attach:OK
> >   Summary: 1/0 PASSED, 0 SKIPPED, 0 FAILED
> >   Successfully unloaded bpf_testmod.ko.
> > 
> > Exporting skip_entry as is_unsafe_function and usign it in the test.
>                                                  ^ using

yes

SNIP

> > +void serial_test_tracing_multi_bench_attach(void)
> > +{
> > +	LIBBPF_OPTS(bpf_tracing_multi_opts, opts);
> > +	struct tracing_multi_bench *skel = NULL;
> > +	long attach_start_ns, attach_end_ns;
> > +	long detach_start_ns, detach_end_ns;
> > +	double attach_delta, detach_delta;
> > +	struct bpf_link *link = NULL;
> > +	size_t i, cap = 0, cnt = 0;
> > +	struct ksyms *ksyms = NULL;
> > +	void *root = NULL;
> > +	__u32 *ids = NULL;
> > +	__u32 nr, type_id;
> > +	struct btf *btf;
> > +	int err;
> > +
> > +#ifndef __x86_64__
> > +	test__skip();
> > +	return;
> > +#endif
> > +
> > +	btf = btf__load_vmlinux_btf();
> > +	if (!ASSERT_OK_PTR(btf, "btf__load_vmlinux_btf"))
> > +		return;
> > +
> > +	skel = tracing_multi_bench__open_and_load();
> > +	if (!ASSERT_OK_PTR(skel, "tracing_multi_bench__open_and_load"))
> > +		goto cleanup;
> > +
> > +	if (!ASSERT_OK(bpf_get_ksyms(&ksyms, true), "get_syms"))
> > +		goto cleanup;
> > +
> > +	/* Get all ftrace 'safe' symbols.. */
> > +	for (i = 0; i < ksyms->filtered_cnt; i++) {
> > +		if (is_unsafe_function(ksyms->filtered_syms[i]))
> > +			continue;
> > +		tsearch(&ksyms->filtered_syms[i], &root, compare);
>                 ^ missing tdestroy() to free tree nodes?

right, will add

SNIP

> >  void test_tracing_multi_test(void)
> >  {
> >  #ifndef __x86_64__
> > diff --git a/tools/testing/selftests/bpf/progs/tracing_multi_bench.c b/tools/testing/selftests/bpf/progs/tracing_multi_bench.c
> > new file mode 100644
> > index 000000000000..067ba668489b
> > --- /dev/null
> > +++ b/tools/testing/selftests/bpf/progs/tracing_multi_bench.c
> > @@ -0,0 +1,13 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +#include <stdbool.h>
> > +#include <linux/bpf.h>
> > +#include <bpf/bpf_helpers.h>
> > +#include <bpf/bpf_tracing.h>
> > +
> > +char _license[] SEC("license") = "GPL";
> > +
> > +SEC("fentry.multi")
> > +int BPF_PROG(bench)
> > +{
> > +	return 0;
> > +}
> > diff --git a/tools/testing/selftests/bpf/trace_helpers.c b/tools/testing/selftests/bpf/trace_helpers.c
> > index 0e63daf83ed5..3bf600f3271b 100644
> > --- a/tools/testing/selftests/bpf/trace_helpers.c
> > +++ b/tools/testing/selftests/bpf/trace_helpers.c
> > @@ -548,7 +548,7 @@ static const char * const trace_blacklist[] = {
> >  	"bpf_get_numa_node_id",
> >  };
> >  
> > -static bool skip_entry(char *name)
> > +bool is_unsafe_function(char *name)
> NIT:                       ^ should const char * ?

sure, will change, thanks

jirka
