Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F09233A70A
	for <linux-trace-kernel@vger.kernel.org>; Wed, 25 Mar 2026 21:49:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774475380; cv=none; b=J4O6gkZgL736QAjCGAZ26Wevf4EdYN+spi4yyPR3wj5O/sT7af1Te++sepTjqHFVdJjTCW0bDG1Il9sx6daMN7dvODvjrAdICIbmEdEQ23LTVK17iIKR1YfANXMP6NcXri9z2vz9YvdHSPnQ6tqsBkWUv2AYs6cC0vvPx5Glooc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774475380; c=relaxed/simple;
	bh=iz1fSpZVNXeLgggcb5xsiGU0Q8slI2axIwIPVuRpvOc=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XUAMn7bzAsc/qcemwZD/qbla8LWU19bPBGnszT6oxU3IgNe3PZYNm+Frb5u6UNUFTTkM77VtVLevf2+WPfS4Xcso+EbfPkElj5xQW0L0tfMA+1lCcTHD4c/8cVf/Ty6Bk68M+fIdYDkueIEOOmD07o9u8IbDA13DjT8xHLZ8oX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ipekr+Dq; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ipekr+Dq"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-486fe2024a9so2381455e9.0
        for <linux-trace-kernel@vger.kernel.org>; Wed, 25 Mar 2026 14:49:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774475378; x=1775080178; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=mz0kcj+ndhoxRF+/ebTLeUq+YLmqb2xPLvFnCoHBQP8=;
        b=ipekr+Dqnsny0EGTmIEEO9wyP6eO14YaPLriyBCZjD9tXpPQTiAlUGawYgIgoc+8Ak
         ZNQFmRBPulAd+/A2LekW4p1NIJkCbv6/QeA/Lx+cs+unSsZ3aM05ppKnB9xlLApejlQJ
         A4xkbXA2uTJmv/LseYp/tvq87A8sKKMbPHrfgdVVxS8liPnEULn7uxelAHB+mJEpafkZ
         PxBgE3GtAIMJjJWUiNQz6g4hzxLq4IhMpATEiK0tX9O3XI1PRA7biciUXdmQGq9a1oum
         AkJ/1fnQE/bs3pluSQU0cn0Bdyp8sA/oPVa3LAceiexcjs2fYA5f1S2Y+jax86iJOOWL
         64fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774475378; x=1775080178;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mz0kcj+ndhoxRF+/ebTLeUq+YLmqb2xPLvFnCoHBQP8=;
        b=RW4Q50g877HeB1ZzVB9VRqdQA4fD7XfamYdZZh0f+XbZo6BVncHYGeHFxO2h5fnSug
         ww8kbkIDP3Hr9tgE4YK/1xPCZIIpGDdCsE7loMYtXi+qzvt6RcaJkvJdgIxNnEA0mPOY
         moEbyy5QPIV7lYv1anCfwdGr+LaBMTTngoDF/XyanWWzbI2sZsqCqQBSF4h2gSa8I07L
         aW4bQv9nHn2bsbD3Hbis1oGRDcootvyN3XH2h/+RUjiltfTv3f2js3ZxmXWSB1UoFgUx
         kVzdWVv5bFfPOS3fXiqQA+jObO6Ttw75rxm8vH5lQBJup/BpLwp6Fox5UWEAKVXi/t4y
         KhPw==
X-Forwarded-Encrypted: i=1; AJvYcCUeniuWXlwJGl0e/Hp2/n80nefbU/p8P1gEG36BSQGWk//eWU6dIRPq/ZP+Oe4chSbyTtjt5jxCPKbGssJ1d+z6bk4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw1OqO8L5W+uXb8TcTPldeTlpgN6ViePg9MX/kly/jPOy7LfAqu
	Nzr/C/3E7XUoW0ssQ2QwgIU3zRxcUPXSgAfg29oYwy/zcmT7fksSl5s+
X-Gm-Gg: ATEYQzyC9RExlQJpTt9XwyKKZU8L7zOeCS1qZRjueeWvCcKKqX2DLkQJEfg3AzbaP3t
	7ZOtWdHTnhm750kHbvooTjVgkETUim9h2Tf6wuT+YYqXLRBFanZFQ3dbwJU7tCHt5R1EXfzC0rI
	4tZMiOrfEoT75LkDwFkHF1bxDe5d77XEw/qIXNZvGgQ61/jHOvDpsxCrI7pgGwEA24cAyBf/yij
	zTfIqQSKj4MxKehGWR2GuPiVMjLpJNtaku/fsRvk9bsZKAdFDZED4sSOfxXkzhsWoB01k8t1bb6
	RQijCP3at0LG1x5C09RLF5oaV6CcixQcLQt15kzGYlk2+/5i4mlTq633dw8jj9uUW0PJMnHN1Mh
	xulsROQn8aeDjhpF4L/KYrT/v8oLZhbg8g2kpj3unJboBBgJgDagEt9PiXI5QkFH+zqMqqSmxDY
	igoruuRG86440mOR7VLgz2h4n1wPJEVtercmDvsm6qBw==
X-Received: by 2002:a05:600c:a4f:b0:486:fbd1:9dc0 with SMTP id 5b1f17b1804b1-487160350d6mr70549235e9.22.1774475377407;
        Wed, 25 Mar 2026 14:49:37 -0700 (PDT)
Received: from krava (h082218179122.host.wavenet.at. [82.218.179.122])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4871fb38086sm11724845e9.4.2026.03.25.14.49.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Mar 2026 14:49:35 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Wed, 25 Mar 2026 22:49:33 +0100
To: Leon Hwang <leon.hwang@linux.dev>
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org, Martin KaFai Lau <kafai@fb.com>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
	Menglong Dong <menglong8.dong@gmail.com>,
	Steven Rostedt <rostedt@kernel.org>
Subject: Re: [PATCHv4 bpf-next 25/25] selftests/bpf: Add tracing multi attach
 rollback tests
Message-ID: <acRYbQkfgTWqJAAT@krava>
References: <20260324081846.2334094-1-jolsa@kernel.org>
 <20260324081846.2334094-26-jolsa@kernel.org>
 <f222748c-69ce-4c63-826b-4f2d67fd4ec9@linux.dev>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f222748c-69ce-4c63-826b-4f2d67fd4ec9@linux.dev>

On Wed, Mar 25, 2026 at 02:45:59PM +0800, Leon Hwang wrote:

SNIP

> > +static void test_rollback_unlink(void)
> > +{
> > +	struct tracing_multi_rollback *skel, *extra;
> > +	LIBBPF_OPTS(bpf_tracing_multi_opts, opts);
> > +	struct tracing_multi_rollback **fillers;
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
> > +	extra = extra_load_and_link();
> > +	if (!ASSERT_OK_PTR(extra, "extra_load_and_link"))
> 
> Should cleanup fillers here?

yep, should jump to cleanup, thanks

jirka
