Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5596E2EA17F
	for <linux-trace-kernel@vger.kernel.org>; Mon, 20 Oct 2025 08:18:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760948341; cv=none; b=aoL4vh4gyJm4SpyQxlFhHPiDZe+od9gv13O9ebP+kZh2J07dohcJ+GoUjXmsnXNImzkpy5RX37J8z/Jf0GGnXNGyn+tA14mqLmQJeaBUVavsBk7q5UyYmJ5HJahbRlplbwzgRUiGJYuZii5ohR5ggHCkFTP/9oUaqahFvN9kL3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760948341; c=relaxed/simple;
	bh=2PmmRvYRajtIcis8ZZJraSCwJD0zMekDFskxTX4rFfc=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LaCi0f64m9pLyT2gnyalrzGwVYf0J2YGEL5LgaexRs9lO8dihkzrTgILWwAIge9OcX4kTTRNmCgmQ40aEq2lkk2BRPUnvGtFZG5lma9Ud0QLvqCDeODf2ttpUUPGFCOgSitUD25c8PTus23tkF5Si+qMLSExmmRBpG52g6luIRU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bCY103Nr; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bCY103Nr"
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-3ecdf2b1751so2251034f8f.0
        for <linux-trace-kernel@vger.kernel.org>; Mon, 20 Oct 2025 01:18:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760948337; x=1761553137; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=AKDB3bTSafSdFCWyt+djoXyXMdqdqsVLBv3IKr6ipus=;
        b=bCY103NrovGWzYHvLl5zJJI6oq0koe+h8jZ4g777zH9uBonHw1XZ13AeIvVJKBU+x3
         KP5hHG7+lssxYoe6hVqdmjwHk3MtRl9nUglk/Qfi9tRu/f+K+UFbYue19KQqWHEZW9lx
         pC3OvR3edvEUTBZuSVcTUWs572oEJhUS5WNBJKnukEOe5Wo3DCOb+MWhVRhs/iFhsN+b
         7ZSPBRxWmveRBQdeAIVbfPg7DQCsbZ5r90FBdu6qKgpA6UZVKHl+lPL1MflDFYHo+3fQ
         NW6B61VLEZKN42gXJvRgbp/6kV/ccfveYA79SvD9VT0CdyPoktp61u3WhzLqjiabIEd9
         m6CQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760948337; x=1761553137;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AKDB3bTSafSdFCWyt+djoXyXMdqdqsVLBv3IKr6ipus=;
        b=YO2JnKOF1i6Axd6jgWCpXLPtfTH6dMwaMdGV2q5mpRjFgQMQIC1b0BrCnDAOI+Jopi
         PBnHD3FzsVN0c74guf8qOuf4llS3v61vKrKRPREV+4LjDXFOhr26OtWlUKRYuQneiIma
         ZU2c6zTUXw1zrE/whTtXrAz9buYGEEc0L8gjfLIn9WKrM/aApeuOK7y8Ch4qn/jLQnrJ
         d+TWOJT90x3iwVDF/DLq7nXFzzPiibzj0dv2osjFNWpZ6MCsVTQW9qYwQ/fL6+rzDVQ5
         yuaPyI8m3M5UeaBFYbvq8g5IYKrZCiXitTcWZ5Oispken5PdMC7bd5ryGu1El0hjTzyY
         xKrw==
X-Forwarded-Encrypted: i=1; AJvYcCXTHxF/EmWQK769fR9xl0nuvlIN4JYv1Gtyw95L8QTOKV4MfePFA5PgyTgqLZk93eT9OAWWCa26Qh0jRUL2wGuYSRg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzMkJdeH3fsuUJZgM0vXi+knhgMNE8R+P8WN8lIfACDrgy1ViJC
	Yq6UlQjjxxL0xSMke8gvZa+s5YX67TSLKa/jneggZZpmyfdZl6GcaNW7
X-Gm-Gg: ASbGncsKUAf10cV3han/zZCal4pbyIJH853KV4jcYSLTHrxiTqi3Xchy83B2L7YbUeJ
	YpczLuEVBPe9HepZCOwHIq9YsomUp3NZALbg20qTpQ3aPQPJfPTK1ZyrS81EWqjxmlfr+ZL10iC
	qjKDRXMweFLygj0ni09HzLblQsTtTbNL8Jvx5Ml2zjLMbgaQDhfVW47DcpEI1LenrhbZUaX6M7S
	dh4Dg2SU6bRkc/sErS84EOpf8GSh2/uWhx7YCUG/5enByYXuA6keHb2nQE+HpT7/L5PETe5bmLa
	wJSzL3VNtjWMDGeptpCVFO3ThOTHPoxjNC43kB+jBdT6PsYTpc8INoLm3c8bwzE5tZjhduzEDB0
	K8pH9XZ1SmqXlXLj3pdE8gwrfQxOM8s40hK/zlQDIVqAeapWrCnB6121AFzCQ
X-Google-Smtp-Source: AGHT+IGcKsvs8EC9CVcjztRsgVVptFDcPyIrDjjr7wNCEk7lfeN5+5SrMh0QtnBC5ZQSI/xWIyuXMA==
X-Received: by 2002:a05:6000:2507:b0:427:370:20a3 with SMTP id ffacd0b85a97d-42704d96174mr9137492f8f.38.1760948336476;
        Mon, 20 Oct 2025 01:18:56 -0700 (PDT)
Received: from krava ([2a02:8308:a00c:e200::31e0])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-427ea5b3dabsm14612066f8f.16.2025.10.20.01.18.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Oct 2025 01:18:56 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Mon, 20 Oct 2025 10:18:53 +0200
To: Menglong Dong <menglong8.dong@gmail.com>
Cc: ast@kernel.org, daniel@iogearbox.net, john.fastabend@gmail.com,
	andrii@kernel.org, martin.lau@linux.dev, eddyz87@gmail.com,
	song@kernel.org, yonghong.song@linux.dev, kpsingh@kernel.org,
	sdf@fomichev.me, haoluo@google.com, mattbobrowski@google.com,
	rostedt@goodmis.org, mhiramat@kernel.org,
	mathieu.desnoyers@efficios.com, leon.hwang@linux.dev,
	bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH RFC bpf-next 0/5] bpf: tracing session supporting
Message-ID: <aPXwbQgGOqAQfxbq@krava>
References: <20251018142124.783206-1-dongml2@chinatelecom.cn>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251018142124.783206-1-dongml2@chinatelecom.cn>

On Sat, Oct 18, 2025 at 10:21:19PM +0800, Menglong Dong wrote:
> Sometimes, we need to hook both the entry and exit of a function with
> TRACING. Therefore, we need define a FENTRY and a FEXIT for the target
> function, which is not convenient.
> 
> Therefore, we add a tracing session support for TRACING. Generally
> speaking, it's similar to kprobe session, which can hook both the entry
> and exit of a function with a single BPF program. Meanwhile, it can also
> control the execution of the fexit with the return value of the fentry.
> session cookie is not supported yet, and I'm not sure if it's necessary.

hi,
I think it'd be useful to have support for cookie, people that use kprobe
session because of multi attach, could easily migrate to trampolines once
we have fast multi attach for trampolines

jirka


> 
> For now, only x86_64 is supported. Other architectures will be supported
> later.
> 
> Menglong Dong (5):
>   bpf: add tracing session support
>   bpf: add kfunc bpf_tracing_is_exit for TRACE_SESSION
>   bpf,x86: add tracing session supporting for x86_64
>   libbpf: add support for tracing session
>   selftests/bpf: add testcases for tracing session
> 
>  arch/arm64/net/bpf_jit_comp.c                 |   3 +
>  arch/loongarch/net/bpf_jit.c                  |   3 +
>  arch/powerpc/net/bpf_jit_comp.c               |   3 +
>  arch/riscv/net/bpf_jit_comp64.c               |   3 +
>  arch/s390/net/bpf_jit_comp.c                  |   3 +
>  arch/x86/net/bpf_jit_comp.c                   | 115 ++++++++++-
>  include/linux/bpf.h                           |   1 +
>  include/uapi/linux/bpf.h                      |   1 +
>  kernel/bpf/btf.c                              |   2 +
>  kernel/bpf/syscall.c                          |   2 +
>  kernel/bpf/trampoline.c                       |   5 +-
>  kernel/bpf/verifier.c                         |  17 +-
>  kernel/trace/bpf_trace.c                      |  43 ++++-
>  net/bpf/test_run.c                            |   1 +
>  net/core/bpf_sk_storage.c                     |   1 +
>  tools/bpf/bpftool/common.c                    |   1 +
>  tools/include/uapi/linux/bpf.h                |   1 +
>  tools/lib/bpf/bpf.c                           |   2 +
>  tools/lib/bpf/libbpf.c                        |   3 +
>  .../selftests/bpf/prog_tests/fsession_test.c  | 132 +++++++++++++
>  .../selftests/bpf/progs/fsession_test.c       | 178 ++++++++++++++++++
>  21 files changed, 511 insertions(+), 9 deletions(-)
>  create mode 100644 tools/testing/selftests/bpf/prog_tests/fsession_test.c
>  create mode 100644 tools/testing/selftests/bpf/progs/fsession_test.c
> 
> -- 
> 2.51.0
> 
