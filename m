Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B4BC3F8EB2
	for <linux-trace-kernel@vger.kernel.org>; Wed, 27 May 2026 11:32:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779881584; cv=none; b=OZ3UIV7UCZoe4oXzgVIA6siKCi9ss6ozzS8ir2YGkld8T+B9fVC2jajVKwbPH1gzXY5di7DAI4AqoDSFaROiVEmrbFPh2Bh/0wOpAxmq35k/n86vwGzSg3mNbNYpjjLN0rIFEBS/nbwt+g7B96HUE+K7X4dk+X7bKQPcT+8W4QA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779881584; c=relaxed/simple;
	bh=zdDEQw3POEcBNK1m+nnHV4Ups4oqCj8UqbP2vlgbI9E=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=vE6w5ZdXkM2qq/bjbBKiauGFnM9QxQPUY8PoJKGrmzbsQq1htfSh1EqjspTbpd2woMMmNucqJfd+YaBQc+l49R/s/ebCYl1vigJ2VGDzNvRDvO8AGaGJcQLd1rltsgDbIeMpaZSf+zqmi3s3r1wkKEUqtLkodwr2soq+Bec6oB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=VPFWg5wI; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="VPFWg5wI"
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-bcd0111ea98so1598186966b.1
        for <linux-trace-kernel@vger.kernel.org>; Wed, 27 May 2026 04:32:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1779881570; x=1780486370; darn=vger.kernel.org;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=v7gvLdv/Bq5CbEznwFrU/dQuDdRJJpw/RX9SjzX/Pdc=;
        b=VPFWg5wIGvZcJ+2xiZR11Ydl0OCsjGE816K2a2VUtUbb+ilmLSKYKUTo6NkSJWHUJs
         U4mUG9b1NCbHM3LKXkN3C29GEgQthz7fYTCD6BYeuxQkiVkj8a9rXqg3wk4wNeqc2s3U
         3+1EF/iwhuxbqHW1dSabBM8hWsCiDcMoXBrLRHE6YDHmoVm7ycvDyYDS5lM6Pnpnk88V
         t2USY0RnzTCTDFME646HiL+qYcBJjNt5se+u85Mws3C5WyL+03fxiveBKmcMbomnG1cj
         AAhmvVxM5wnGf6zmfMKsbkmeDRUDkaDhfpBu3Iq6D2HSzZvqPRNge+0cWcGN5YA+ccIC
         0Ccg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779881570; x=1780486370;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=v7gvLdv/Bq5CbEznwFrU/dQuDdRJJpw/RX9SjzX/Pdc=;
        b=MoOvH1nQOE6vZPZYgK8dOyTYdZfwCIXNvnI3bghgp7x6s2hH+YkhZEdQBYqeZX3aRf
         gmRnOI1PwPDSwT5lX65ghvOaHdeiNPaWdAC7VMlGnXWwQKW3I8pI2/J6b77js+GFrmTF
         MKGQ70+EArwsMj+Tre2WE1JpRkvQDqZVIKtn+ore4OmLo3kHEBK0VoGBwH9QYqnvNMHq
         CFHmkLvV76gew+bTKkHjW5Yog0NCskUT96+/AH0qXQHo2MXeJRyEQxseFDMXKcvk3r6b
         Q7ww765FGk2XxCALEKuFLlPircKWEfXFBxXQMjGNMjqcH5CeVhgplBnv0nLlCPCiPWjd
         w8hA==
X-Forwarded-Encrypted: i=1; AFNElJ8ztNEKQmT7bBvLR/e4D416GvDHcOn5Qn5Sy61wqsoatuXixUvsAPbvL7/Y/HQN4J/QSAOZpQ/Me7V2Ife6sdzu20E=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywv20Dms9H3Ea4lhTIUSTejNL0OCRVElyVTh+SsCPOzB7c2wxu4
	HqCgyCI8suy98srGMax8COsH67tY5ycZ6jR8zdd/9tU8gLxivVjaxNjHZbNOtBfOZCo=
X-Gm-Gg: Acq92OGiL3GmMpC8OEeGiuP83GO40wH63HY+pRKbt+taDTNT2clp69HDMeXrNwvGXBm
	vcuXqqc9lhSTVhq7QhYWnL4bL4kLvSS38JMrjt3+TTaBP9s4I6FV5he5iTt9rSB63sKYHyJDvRq
	Xnzfc3+rHVLcBg5Vij7panf66rv0m4QESeXtMgmw92sr1Bh8o1ZV6L3FPyJ3fWpZAA1YKjMKqVO
	tBNQQ5srKBbIN3R+qt/rwXJ3kMlRGkwTfPhNCsFp10GNyLGa6MHolESnD1/Mblxkz3SXp2/f/RU
	MLeWHsLlat+lWKq/sNPkK42HEuZ1vxgwKDX7JgxfOcVCcNQOSliLDHBHTuXBp75eQEC/IlEpIBN
	wjefu5mvTI2TKRDGJ+iCw5dfvcAbiRit8ydoycP3AYxlH2qaXW6liFUfuTKnkOhtWKy/u8/I4pM
	1LYi2YAaGtTlxGFDhp7g/TVbE1eg==
X-Received: by 2002:a17:907:d22:b0:bd5:7a3:a596 with SMTP id a640c23a62f3a-bdd2b2f40cbmr1286972666b.49.1779881569751;
        Wed, 27 May 2026 04:32:49 -0700 (PDT)
Received: from cloudflare.com ([104.28.21.182])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-bddc264e424sm599288466b.6.2026.05.27.04.32.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 May 2026 04:32:49 -0700 (PDT)
From: Jakub Sitnicki <jakub@cloudflare.com>
To: Jiri Olsa <jolsa@kernel.org>
Cc: Oleg Nesterov <oleg@redhat.com>,  Peter Zijlstra <peterz@infradead.org>,
  Ingo Molnar <mingo@kernel.org>,  Masami Hiramatsu <mhiramat@kernel.org>,
  Andrii Nakryiko <andrii@kernel.org>,  bpf@vger.kernel.org,
  linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCHv4 11/13] selftests/bpf: Add reattach tests for uprobe
 syscall
In-Reply-To: <20260526205840.173790-12-jolsa@kernel.org> (Jiri Olsa's message
	of "Tue, 26 May 2026 22:58:38 +0200")
References: <20260526205840.173790-1-jolsa@kernel.org>
	<20260526205840.173790-12-jolsa@kernel.org>
Date: Wed, 27 May 2026 13:32:48 +0200
Message-ID: <87tsrt5bq7.fsf@cloudflare.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Tue, May 26, 2026 at 10:58 PM +02, Jiri Olsa wrote:
> Adding reattach tests for uprobe syscall tests to make sure
> we can re-attach and optimize same uprobe multiple times.
>
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> ---
>  .../selftests/bpf/prog_tests/uprobe_syscall.c | 114 ++++++++++++++++--
>  1 file changed, 104 insertions(+), 10 deletions(-)
>
> diff --git a/tools/testing/selftests/bpf/prog_tests/uprobe_syscall.c b/tools/testing/selftests/bpf/prog_tests/uprobe_syscall.c
> index 0868fb9793e0..969f4deba9fd 100644
> --- a/tools/testing/selftests/bpf/prog_tests/uprobe_syscall.c
> +++ b/tools/testing/selftests/bpf/prog_tests/uprobe_syscall.c
> @@ -430,23 +430,28 @@ static void *check_attach(struct uprobe_syscall_executed *skel, trigger_t trigge
>  	return tramp;
>  }
>  
> -static void check_detach(void *addr, void *tramp)
> +static bool check_detach(void *addr, void *tramp)
>  {
>  	static const char nop10_prefix[] = { 0x66, 0x2e, 0x0f, 0x1f, 0x84 };
> +	bool ok = true;
>  
>  	/* [uprobes_trampoline] stays after detach */
> -	ASSERT_OK(find_uprobes_trampoline(tramp), "uprobes_trampoline");
> -	ASSERT_OK(memcmp(addr, nop10_prefix, 5), "nop10_prefix");
> +	if (!ASSERT_OK(find_uprobes_trampoline(tramp), "uprobes_trampoline"))
> +		ok = false;
> +	if (!ASSERT_OK(memcmp(addr, nop10_prefix, 5), "nop10_prefix"))
> +		ok = false;
> +	return ok;
>  }

Nit: Maybe apply the same pattern you used in
progs/get_func_args_test.c?

ok &= ASSERT_OK(...)
ok &= ASSERT_OK(...)

>  
> -static void check(struct uprobe_syscall_executed *skel, struct bpf_link *link,
> -		  trigger_t trigger, void *addr, int executed)
> +static void *check(struct uprobe_syscall_executed *skel, struct bpf_link *link,
> +		   trigger_t trigger, void *addr, int executed)

Nit: Kinda wish that was called check_attach_detach().

>  {
>  	void *tramp;
>  
>  	tramp = check_attach(skel, trigger, addr, executed);
>  	bpf_link__destroy(link);
>  	check_detach(addr, tramp);
> +	return tramp;
>  }
>  
>  static void test_uprobe_legacy(void)
> @@ -457,6 +462,7 @@ static void test_uprobe_legacy(void)
>  	);
>  	struct bpf_link *link;
>  	unsigned long offset;
> +	void *tramp;
>  
>  	offset = get_uprobe_offset(&uprobe_test);
>  	if (!ASSERT_GE(offset, 0, "get_uprobe_offset"))
> @@ -474,7 +480,28 @@ static void test_uprobe_legacy(void)
>  	if (!ASSERT_OK_PTR(link, "bpf_program__attach_uprobe_opts"))
>  		goto cleanup;
>  
> -	check(skel, link, uprobe_test, uprobe_test, 2);
> +	tramp = check(skel, link, uprobe_test, uprobe_test, 2);
> +
> +	/* reattach and detach without triggering optimization */
> +	link = bpf_program__attach_uprobe_opts(skel->progs.test_uprobe,
> +					       0, "/proc/self/exe", offset, NULL);
> +	if (!ASSERT_OK_PTR(link, "bpf_program__attach_uprobe_opts"))
> +		goto cleanup;
> +

In theory we're missing a check here that an unoptimized uprobe was
installed. If nothing happened at all between the last check() and
check_destroy() below, the test would still pass.

Applies to the three similar changes after that one as well.

> +	bpf_link__destroy(link);
> +	if (!check_detach(uprobe_test, tramp))
> +		goto cleanup;
> +
> +	uprobe_test();
> +	ASSERT_EQ(skel->bss->executed, 2, "executed_no_probe");
> +
> +	/* reattach with triggering optimization */
> +	link = bpf_program__attach_uprobe_opts(skel->progs.test_uprobe,
> +				0, "/proc/self/exe", offset, NULL);
> +	if (!ASSERT_OK_PTR(link, "bpf_program__attach_uprobe_opts"))
> +		goto cleanup;
> +
> +	check(skel, link, uprobe_test, uprobe_test, 4);
>  
>  	/* uretprobe */
>  	skel->bss->executed = 0;

[...]
