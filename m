Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A15073EFD28
	for <linux-trace-kernel@vger.kernel.org>; Thu, 28 May 2026 12:46:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779972414; cv=none; b=ZM2EKT2JR3WpyMRzTx5Av5NLZDXUgHU2egxbkbVpLjfC9ti71HlCLutqJCioB0UCIC1XqXEQs0W2XS4K5jlEkv0ZJkS50MoRC2QpEO+ZlucvKwkMZ+4nitOZfyJdxuVRG9MAFHnfQcIqNar/5sMik/l1+fWonKBzED8rXyZfTAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779972414; c=relaxed/simple;
	bh=lsS0OCRkozaOJ36O09gOUY3x9RlHdxN3D+Ip/cp6Muw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ThaBLZFI7oollJoZndNky4Epmiis9/zSazAN4O4y3vkHpGp2NEL+GbjwgSpE1wgncbYd1ANVV3a5OY07DQsQU6isHTDTNwrmZCyqwe34+x6QCaKkiqcp1inV3Iwa10kBmarxcFEP9rE8lPf9VLe2teZxt0Ai0NnkJ9uXaq1W3tY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=LsgEkMGy; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="LsgEkMGy"
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-68abd694c1fso1380993a12.2
        for <linux-trace-kernel@vger.kernel.org>; Thu, 28 May 2026 05:46:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1779972411; x=1780577211; darn=vger.kernel.org;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=N3QWq3goEbku0FKpK3b3qT/SmuAifh1Xl7rPPp2Quj8=;
        b=LsgEkMGyV/E+V2xGbOSSDgvXa2IctNGAIApuYSKlrMfRDzQt4Q/kNixjT7qYgHtsxA
         LkIYO0h7LZPPN+sVJCJxa4lDWYACkseOjqQ4IULf6HQJrdBjUzbcuFEpxSdJEMjbj+Er
         +34kliLu/AjiYRKvWg+UFZJrsJR/fW92EM/3F0qSbDqx7ey2jH610IQX7oM6kqovsGyu
         9P4NjygtxSrhS6a03J+0jiN80K3Q8cfoEWeCsH88l4iAY4OYtzYyiGIbgQ2aPvFQrm3J
         spYOisabCqp5sLFWXL94QcfytTZJkbkr053n2tokdwdu2pZ6YpKmtCUJYO0hlmBm2aqY
         DvAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779972411; x=1780577211;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=N3QWq3goEbku0FKpK3b3qT/SmuAifh1Xl7rPPp2Quj8=;
        b=CgSAQuS6P98VZUk9NU/99lAesgnyd8xn5BAs2WMVO6dcCbeHrJpn9tUunl6jN49n12
         /QCGNbK9Fwok6SEnj0fzlP0ouEi48/2JN6lxKh187mAIGKEGgM2xXpQc4PBhwjeC9qN7
         BEyN0XYpUBIv4BOlfk55RskgeYVbPxn3WQkbJX9VFGjxIig9CW3Itwcp8B9f/f1ddcTp
         5CPw/6YVDkcgx/7MKWOt4H9x3pl2anQum3CaTxY5TfgK1TZ+fjp3QNPrLvMS2apU7O2p
         8jdEyYRDXQNJ1PfKnK/R5vADYoQiZCmgs68d5zhHiFRhK1cp4lAjO4ZZ3zf4ypYt2pjv
         ikHg==
X-Forwarded-Encrypted: i=1; AFNElJ/1ZA5jp2mAIwsMEfvXJ9Wmfyl90huduEhzBuTwH+pkSZynwChw/vP3AwRBEW5B8b6DJDavrJxXCX8y1BEMkCSTwmA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwoxA7MCvsyxFuinZunJUw/VPzQ2kqzv/oWDDWOcReQJfILxyUl
	TQifbBp8exmA1irdgN7GPaB1mj6x8hPwe7Zd9lRSYXE9oSHAY1kwTPaeV/drAt+l+74tnp4xJ6W
	YkGce
X-Gm-Gg: Acq92OG3GxWYZkdbbT8AcsXy2U3Sis6wFXDvgg6RDR5QjqF0hGAIJL2o9XwD5grVjOe
	B908wGw6Bx8XrxA4k6HQUHW1u6YEff4JNjNzHjabGHI+frCil8cdJJAqomUTKfjRtBe+AJwj3u1
	U9ttLClMZdgAcc1tBTrwXrI9fjXvrV7ee8IkACiz3LW9QOII3qJ4jJZfnkq43GbCWp6DPWuKrUn
	ZW8SKtEQtw/THHaZBc/8gHSWC/rUitXHiJYK+tGePSeGgA6D4tQ9EEiiuI5thrL3JA5/404tmb8
	KgZ3Qaz0FAWGFLyoXj9h4T4iNMgKeN6VW4RTleIcYddn6DVHoPWh/WpmAJ4+ZYaebHyhk+26WNs
	fdIXWOrjHMZFP72YJ5Arr+yFZ1C9OX+6fz8tFKWqJEzk3fqYr7Nu/B5bdcdmviTfKmV48/sS4+i
	4iGL2VFT+5yZb21QPYTh6YJpJB8ue6/+1JWHZ/
X-Received: by 2002:a05:6402:1f86:b0:689:971b:7439 with SMTP id 4fb4d7f45d1cf-689971b76c2mr9771553a12.12.1779972411025;
        Thu, 28 May 2026 05:46:51 -0700 (PDT)
Received: from cloudflare.com ([104.28.21.182])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-68a6faad61esm1847899a12.2.2026.05.28.05.46.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 May 2026 05:46:50 -0700 (PDT)
From: Jakub Sitnicki <jakub@cloudflare.com>
To: Jiri Olsa <jolsa@kernel.org>
Cc: Oleg Nesterov <oleg@redhat.com>,  Peter Zijlstra <peterz@infradead.org>,
  Ingo Molnar <mingo@kernel.org>,  Masami Hiramatsu <mhiramat@kernel.org>,
  Andrii Nakryiko <andrii@kernel.org>,  bpf@vger.kernel.org,
  linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCHv4 12/13] selftests/bpf: Add tests for uprobe nop10 red
 zone clobbering
In-Reply-To: <20260526205840.173790-13-jolsa@kernel.org> (Jiri Olsa's message
	of "Tue, 26 May 2026 22:58:39 +0200")
References: <20260526205840.173790-1-jolsa@kernel.org>
	<20260526205840.173790-13-jolsa@kernel.org>
Date: Thu, 28 May 2026 14:46:48 +0200
Message-ID: <87pl2f66rr.fsf@cloudflare.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Tue, May 26, 2026 at 10:58 PM +02, Jiri Olsa wrote:
> From: Andrii Nakryiko <andrii@kernel.org>
>
> The uprobe nop5 optimization used to replace a 5-byte NOP with a 5-byte
> CALL to a trampoline. The CALL pushes a return address onto the stack at
> [rsp-8], clobbering whatever was stored there.
>
> On x86-64, the red zone is the 128 bytes below rsp that user code may use
> for temporary storage without adjusting rsp. Compilers can place USDT
> argument operands there, generating specs like "8@-8(%rbp)" when rbp ==
> rsp. With the CALL-based optimization, the return address overwrites that
> argument before the BPF-side USDT argument fetch runs.
>
> Add two tests for this case. The uprobe_syscall subtest stores known values
> at -8(%rsp), -16(%rsp), and -24(%rsp), executes an optimized nop10 uprobe,
> and verifies the red-zone data is still intact. The USDT subtest triggers a
> probe in a function where the compiler places three USDT operands in the
> red zone and verifies that all 10 optimized invocations deliver the expected
> argument values to BPF.
>
> On an unfixed kernel, the first hit goes through the INT3 path and later
> hits use the optimized CALL path, so the red-zone checks fail after
> optimization.
>
> Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
> [ updates to use nop10 ]
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> ---
>  .../selftests/bpf/prog_tests/uprobe_syscall.c | 75 +++++++++++++++++++
>  tools/testing/selftests/bpf/prog_tests/usdt.c | 49 ++++++++++++
>  tools/testing/selftests/bpf/progs/test_usdt.c | 25 +++++++
>  tools/testing/selftests/bpf/usdt_2.c          | 13 ++++
>  4 files changed, 162 insertions(+)
>
> diff --git a/tools/testing/selftests/bpf/prog_tests/uprobe_syscall.c b/tools/testing/selftests/bpf/prog_tests/uprobe_syscall.c
> index 969f4deba9fd..efff0c515184 100644
> --- a/tools/testing/selftests/bpf/prog_tests/uprobe_syscall.c
> +++ b/tools/testing/selftests/bpf/prog_tests/uprobe_syscall.c

[...]

> @@ -855,6 +897,37 @@ static void test_uprobe_race(void)
>  #define __NR_uprobe 336
>  #endif
>  
> +static void test_uprobe_red_zone(void)
> +{
> +	struct uprobe_syscall_executed *skel;
> +	struct bpf_link *link;
> +	void *nop10_addr;
> +	size_t offset;
> +	int i;
> +
> +	nop10_addr = find_nop10(uprobe_red_zone_test);
> +	if (!ASSERT_NEQ(nop10_addr, NULL, "find_nop10"))

Nit: ASSERT_OK_PTR would have worked as well. Dealer's choice.

> +		return;
> +
> +	skel = uprobe_syscall_executed__open_and_load();
> +	if (!ASSERT_OK_PTR(skel, "open_and_load"))
> +		return;
> +
> +	offset = get_uprobe_offset(nop10_addr);
> +	link = bpf_program__attach_uprobe_opts(skel->progs.test_uprobe,
> +			0, "/proc/self/exe", offset, NULL);
> +	if (!ASSERT_OK_PTR(link, "attach_uprobe"))
> +		goto cleanup;
> +
> +	for (i = 0; i < 10; i++)
> +		ASSERT_EQ(uprobe_red_zone_test(), 0, "red_zone_intact");
> +
> +	bpf_link__destroy(link);
> +
> +cleanup:
> +	uprobe_syscall_executed__destroy(skel);
> +}
> +
>  static void test_uprobe_error(void)
>  {
>  	long err = syscall(__NR_uprobe);

[...]

Reviewed-by: Jakub Sitnicki <jakub@cloudflare.com>
