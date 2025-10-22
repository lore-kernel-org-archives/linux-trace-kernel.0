Received: from out-177.mta1.migadu.com (out-177.mta1.migadu.com [95.215.58.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 573DC34887B
	for <linux-trace-kernel@vger.kernel.org>; Wed, 22 Oct 2025 14:11:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761142312; cv=none; b=YpQkKP5C3O7qDwxngzwC9P5AY8UxgWJzcSSlgU6MN8P7BDE6sNmYY8gFFCkaYtYh0YJXqjg4lOocEeyhrWq17xmlUbUM/FuV/IwgFbfMUBoJ/wiGd1WUwSlMOl4Fig2nuugsFplV9gH3lOl5SYmiqQCu1A4G+11Bz8ptBimE1xo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761142312; c=relaxed/simple;
	bh=HKERCs0/X58PIAEuo0fOh8DefQnZ03wa8TS06sVQNqo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SaKANXAqHNuLpLdXabe84Lf/5YCoNsNNd1X8h0GZdo8baTJ+NhwDPiICjuEzdrtL+pjg4e6Nh4F/2U3oj2gnhSiCD0dc+/ZeXN4DIkA+Nkg7snARmyCtgp7R1d1nrDxF7uumwoG6xwwhWHuXj0FLcwGIhN9tW5XouL+EiEB6oXI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=HlHWlNEj; arc=none smtp.client-ip=95.215.58.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="HlHWlNEj"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1761142306;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=r/kbH6CnWKj5FbZWIMHjiro5IcUf/Mw/d63e1Fq2vhU=;
	b=HlHWlNEjfmh9Wzf3BZjk5wPRNIiFQ+8SHLNzbf/Ejsptz70t88kp9ildu+PiiMuSeHPNWY
	G7ARw4JIiS4a0jsq8SoycH1AN6rnUtWvcMh2gQP4twF309wJiBQguoIlNFMAeravBaIFrr
	mtowp5d9Tnz/WcZzpCihDQSfSYZebns=
From: Menglong Dong <menglong.dong@linux.dev>
To: ast@kernel.org, jolsa@kernel.org, Menglong Dong <menglong8.dong@gmail.com>
Cc: daniel@iogearbox.net, john.fastabend@gmail.com, andrii@kernel.org,
 martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org,
 yonghong.song@linux.dev, kpsingh@kernel.org, sdf@fomichev.me,
 haoluo@google.com, mattbobrowski@google.com, rostedt@goodmis.org,
 mhiramat@kernel.org, mathieu.desnoyers@efficios.com, leon.hwang@linux.dev,
 jiang.biao@linux.dev, bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org
Subject:
 Re: [PATCH bpf-next v2 07/10] selftests/bpf: test get_func_ip for fsession
Date: Wed, 22 Oct 2025 22:11:23 +0800
Message-ID: <5933395.DvuYhMxLoT@7950hx>
In-Reply-To: <20251022080159.553805-8-dongml2@chinatelecom.cn>
References:
 <20251022080159.553805-1-dongml2@chinatelecom.cn>
 <20251022080159.553805-8-dongml2@chinatelecom.cn>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"
X-Migadu-Flow: FLOW_OUT

On 2025/10/22 16:01, Menglong Dong wrote:
> As the layout of the stack changed for fsession, we'd better test
> bpf_get_func_ip() for it.
> 
> Signed-off-by: Menglong Dong <dongml2@chinatelecom.cn>
> ---
>  .../selftests/bpf/prog_tests/get_func_ip_test.c    |  2 ++
>  .../testing/selftests/bpf/progs/get_func_ip_test.c | 14 ++++++++++++++
>  2 files changed, 16 insertions(+)
> 
> diff --git a/tools/testing/selftests/bpf/prog_tests/get_func_ip_test.c b/tools/testing/selftests/bpf/prog_tests/get_func_ip_test.c
> index c40242dfa8fb..a9078a1dbb07 100644
> --- a/tools/testing/selftests/bpf/prog_tests/get_func_ip_test.c
> +++ b/tools/testing/selftests/bpf/prog_tests/get_func_ip_test.c
> @@ -46,6 +46,8 @@ static void test_function_entry(void)
>  	ASSERT_EQ(skel->bss->test5_result, 1, "test5_result");
>  	ASSERT_EQ(skel->bss->test7_result, 1, "test7_result");
>  	ASSERT_EQ(skel->bss->test8_result, 1, "test8_result");
> +	ASSERT_EQ(skel->bss->test9_result1, 1, "test9_result1");
> +	ASSERT_EQ(skel->bss->test9_result2, 1, "test9_result2");

Oops, the fsession part should be factor out, and be skipped
if not X86_64, which failed the CI for !X86_64 arch :(

I'll fix it in the next version.

>  
>  cleanup:
>  	get_func_ip_test__destroy(skel);
> diff --git a/tools/testing/selftests/bpf/progs/get_func_ip_test.c b/tools/testing/selftests/bpf/progs/get_func_ip_test.c
> index 2011cacdeb18..9acb79fc7537 100644
> --- a/tools/testing/selftests/bpf/progs/get_func_ip_test.c
> +++ b/tools/testing/selftests/bpf/progs/get_func_ip_test.c
> @@ -103,3 +103,17 @@ int BPF_URETPROBE(test8, int ret)
>  	test8_result = (const void *) addr == (const void *) uprobe_trigger;
>  	return 0;
>  }
> +
> +__u64 test9_result1 = 0;
> +__u64 test9_result2 = 0;
> +SEC("fsession/bpf_fentry_test1")
> +int BPF_PROG(test9, int a)
> +{
> +	__u64 addr = bpf_get_func_ip(ctx);
> +
> +	if (bpf_tracing_is_exit(ctx))
> +		test9_result1 = (const void *) addr == &bpf_fentry_test1;
> +	else
> +		test9_result2 = (const void *) addr == &bpf_fentry_test1;
> +	return 0;
> +}
> 




