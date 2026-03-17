Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AB993246F8
	for <linux-trace-kernel@vger.kernel.org>; Tue, 17 Mar 2026 17:19:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773767970; cv=none; b=f67LLDHxeMRcNpWn5PVxwsb3QrJHPIOKnp8XRUHJrB6uryLOklbgyAcPRl5B0z7h8bMHG4u3kgL7LxpmWCjR7jF+wX8n1RiSOPTq5rmrRjqYM6zKzeRnOxIJsaV9sfuY0uTItJcqdc/kOdNIYQ+pyinNoofBSmM406PsXyT/NyE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773767970; c=relaxed/simple;
	bh=Exi6oVCi6VhRBp7BZRhBR3L5u5FP6mix8iW2MfKA/ow=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nFFANmUA9Ett+6yIiYt0en36i/+X0PwAqp5rz1VtkNRwdfZIorJKSYMBoDboRayVr5kw1E5EE29XVN2aYm5THoWArvYTKMQ2ykOzDS91Op53hgLIqCCFT+NxOdjCGUAl7WsyB3lxFJqFrP3FeEohfwDjE6QP+wmjfP37Ie5v/5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AUhD97HI; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AUhD97HI"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-48538c5956bso1074385e9.0
        for <linux-trace-kernel@vger.kernel.org>; Tue, 17 Mar 2026 10:19:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773767967; x=1774372767; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=k+HcpT6c/Q9q2p72rs/yhYSojh0RamcA3tem6sS6eeY=;
        b=AUhD97HI5reWzkT8tKoVQuxSCN7h5fgVRjzYjtz/JV3RN8UYkWoypFtiR4k1kMxYji
         mArI5GcEHMnpaNUrmLHggpKqX1vWKEyDgx2aAB2RZb1hhe3NukxuejX43GUXH5svLMhi
         gzhf/UD/a8oCJpefy5+rV8JGvFnClk3iRzYhjaMMyTMYKyuIdoLi2MKzL9nZ1pKpA7AM
         T7XlbvkV+QapHGucckGuyQPPuquPwF5knxIS+V7S27iODEheB+ejozEd7yGuXz+LStah
         EoK/Rzd/1pDt0jCGQEGvQip83TC5Oo3GrXaAZ2BGtIVBKutcNGHPwsYLn/gJQU2D5J6z
         PRBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773767967; x=1774372767;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=k+HcpT6c/Q9q2p72rs/yhYSojh0RamcA3tem6sS6eeY=;
        b=YswX5p2NsOHRqBBr4cKba3CMvQ94xM9y3ntHtxfDgnbxbfQFQoi6ORdnX0ZrQ4F3LY
         C3b2mzHtWOF1yEQOg3CQmcrM0fbJ95EeLtSLTX9nnszqpPIfd+LQ07hodxUE0xc71vtZ
         UyVhgsuUCZ/rtjyPHcm2mZL9l/ewH1pbcjK8RkcOWabPIdYCR4W4DZqd2dwMycIWdGam
         i4pT5bwv3ltQmhchpI7BvdE2D+xDFCX3w4/nutb7ZnPpIIfPCv5/RDfFj8oJv4IJWFdM
         bTUb2/SNQnlXWJBH4DQatGwPUnaVgI1sDZsffCVv86U0qKWk7/ZD84xtdOoSfJNsLsdy
         xM3Q==
X-Forwarded-Encrypted: i=1; AJvYcCVXuIV4ft8J3cE6u8AnOGjWaQZ5sK25t9jKU7IrdFP6gqgYHJtGrcxEqAvcZhF9j+472zx+D0BpcMtcoDjYswVkIec=@vger.kernel.org
X-Gm-Message-State: AOJu0YwAQtszA5iAxnp3UkkE3v2pQMZzaAO5BPneYOO9ATJTicK6hX5A
	i8wDYaAVf8x+MvuysL4W8oJVAluenFSHFODLtwAWTNPxe1KSAaXL7W97
X-Gm-Gg: ATEYQzyLuPbpW7zeR21TuZ2/TdhfoaCiccU9Rj9RkWhnkl3IsOl12ycuhwbcVco2NUK
	Bl3dugXi29amZPSq82Sj+cAim7dTIXEI1H5R13JIXIXgHHzk3tUGMSdtn9UOASFiPiYlp5kycEC
	jver4tm/LnAAGlV1dMEeELfaltLxotNl+W9h0hhwQxQlbm4bqkM4nLfKx4kbGorUmK6UKZZcr9r
	89tMxZmEnQMG3x8MNRcUhv7y0etEdjlDtWsPLGCDF9Jb0zniRCrvHlgn1lZ5R4blLHNwJxmSLp5
	ZxUyIuICIBUF49lueoteic8pLM6lwOqDTqhiFd9tuLm6Qk10VqjQYyGLcl3T+DUyRVQv8njEfvz
	k76+VgjuZ8JBjUur+rFW1pgAKN6MiH/UCIH4yLGH/9S1zc1Dpwa4+KE6o7KZcTvIB2m0++ZYvIa
	ICMFNJ4APuNUKfmImO2NLfBg==
X-Received: by 2002:a05:600c:a0d:b0:485:3e00:944a with SMTP id 5b1f17b1804b1-486f40c1975mr7774615e9.9.1773767967454;
        Tue, 17 Mar 2026 10:19:27 -0700 (PDT)
Received: from krava ([176.74.159.170])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48634a7ac93sm61385985e9.2.2026.03.17.10.19.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Mar 2026 10:19:27 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Tue, 17 Mar 2026 18:19:25 +0100
To: Leon Hwang <leon.hwang@linux.dev>
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org, Martin KaFai Lau <kafai@fb.com>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
	Menglong Dong <menglong8.dong@gmail.com>,
	Steven Rostedt <rostedt@kernel.org>
Subject: Re: [PATCHv3 bpf-next 24/24] selftests/bpf: Add tracing multi attach
 rollback tests
Message-ID: <abmNHWDXguqKpi1P@krava>
References: <20260316075138.465430-1-jolsa@kernel.org>
 <20260316075138.465430-25-jolsa@kernel.org>
 <d1bfc6ec-3234-4515-a68f-ff48ab9c1570@linux.dev>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d1bfc6ec-3234-4515-a68f-ff48ab9c1570@linux.dev>

On Tue, Mar 17, 2026 at 11:20:59AM +0800, Leon Hwang wrote:

SNIP

> > +static void test_rollback_unlink(void)
> > +{
> > +	LIBBPF_OPTS(bpf_tracing_multi_opts, opts);
> > +	struct tracing_multi_rollback **fillers;
> > +	struct tracing_multi_rollback *skel;
> > +	size_t cnt = FUNCS_CNT;
> > +	__u32 *ids = NULL;
> > +	int err, max;
> > +
> > +	max = get_bpf_max_tramp_links();
> > +	if (!ASSERT_GE(max, 1, "bpf_max_tramp_links"))
> > +		return;
> > +
> > +	/* Attach maximum allowed programs to bpf_fentry_test10 */
> > +	fillers = fillers_load_and_link(max);
> > +	if (!ASSERT_OK_PTR(fillers, "fillers_load_and_link"))
> > +		return;
> > +
> > +	skel = tracing_multi_rollback__open();
> > +	if (!ASSERT_OK_PTR(skel, "tracing_multi_rollback__open"))
> > +		goto cleanup;
> > +
> > +	bpf_program__set_autoload(skel->progs.test_fentry, true);
> > +	bpf_program__set_autoload(skel->progs.test_fexit, true);
> > +
> > +	/*
> > +	 * Attach tracing_multi link on bpf_fentry_test1-10, which will
> > +	 * fail on bpf_fentry_test10 function, because it already has
> > +	 * maximum allowed programs attached.
> > +	 *
> > +	 * The rollback needs to unlink already link-ed trampolines and
> > +	 * put all of them.
> > +	 */
> > +	err = tracing_multi_rollback__load(skel);
> > +	if (!ASSERT_OK(err, "tracing_multi_rollback__load"))
> > +		goto cleanup;
> > +
> > +	ids = get_ids(bpf_fentry_test, cnt, NULL);
> > +	if (!ASSERT_OK_PTR(ids, "get_ids"))
> > +		goto cleanup;
> > +
> > +	opts.ids = ids;
> > +	opts.cnt = cnt;
> > +
> > +	skel->bss->pid = getpid();
> > +
> > +	skel->links.test_fentry = bpf_program__attach_tracing_multi(skel->progs.test_fentry,
> > +						NULL, &opts);
> > +	if (!ASSERT_ERR_PTR(skel->links.test_fentry, "bpf_program__attach_tracing_multi"))
> > +		goto cleanup;
> > +
> > +	skel->links.test_fexit = bpf_program__attach_tracing_multi(skel->progs.test_fexit,
> > +						NULL, &opts);
> > +	if (!ASSERT_ERR_PTR(skel->links.test_fexit, "bpf_program__attach_tracing_multi"))
> > +		goto cleanup;
> > +
> > +	tracing_multi_rollback_run(skel);
> > +
> > +cleanup:
> 	tracing_multi_rollback__destroy(skel); is missed to destroy skel?

it is, will add, thanks

jirka
