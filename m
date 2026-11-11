Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=91.218.175.82
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794411284;
	b=sIZj+vaZvrEk1NYSLe6ojukv1ANsMnzfiy0Q4k/SDUs3KuhkLNqBfKgF7yjer672NnE8
	 YypaTmGIq51gtWi68MAwFCGblyh6skuVhdZELNer9teic796NByZtggdFgIv2kOcf1xBj
	 w9hP/wktXZi37OKJca6NrXe/eaBL+0EgQKZ6m9IkKBfk9UavIoCaYcjIUC0269AJ/vUce
	 Kyi3+L+aqWhs5QzH+yrMvaerQBtGTmCDsKjL4zpIWVHxCwtowt5M3/yXPCgNOtx7Y5QBG
	 IRcHPxtGL7gWgeG6EORuVoqkdAk5Kq5QHNpemYv6SK6UnTmuBnBOe3hZrzFJdQGykJA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794411284;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding;
	bh=WvgHQt21awwFEsX+j1alIUyCY9EcMQZLeAsaI5BvVZg=;
	b=krXeIFBRw8J0lwAgVu0iSRHjlR6q4BMKWBqfF7s9lRF9FTVGbyj4nQexyvqSerFQU1Pv
	 1M1NLKxT3ezlGYu4+16cbQOGHQLqR1jfdDXwXgaY7Cs5Vl9dm9gMFyBd04g0pQ5N7QuWT
	 1cDyTzHGsk/liff0YBCKvIgdajcK6tFTkG0cHRy+k6p4hCC73GpIZE8xX7qVUQrd4wvlO
	 L0LP+tyGCUM1SPej1X9+M//USyXIrqVzWh1gut7psZVQ5eKX8SoDn1xXipgK+YfTH90h1
	 6hdy5mr+1xP7mHVoUWqZswPPiOAH5+mIMmd7paxe86Wq9ajeJwuJ22IWDbH1CziDgtQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=npvD7XTH;
	arc=none smtp.remote-ip=91.218.175.82
Received: from mta0.migadu.com (out-82.mta0.migadu.com [91.218.175.82])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78A1B606A88F
	for <linux-trace-kernel@vger.kernel.org>; Wed, 11 Nov 2026 15:34:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 78A1B606A88F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=npvD7XTH
X-Envelope-To: linux-trace-kernel@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=7w1pPbFZvYsTAFkH0HQUA9QoTT++qjsV9aTz3PRLplM=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1794411281; v=1; x=1795016081;
 b=npvD7XTHINDR3+HhKMfH6VaRQpLApK3O34ZCiEpOsgpfF6VB+i+Ael0kkhBhy6hbgcPCr4oN
 FT0cG2KrlR8kTSBZfUQXZlZrVzUfTeLGqtiL8iTpTDx88CR1d1x/K05/H2ScCwj67C4JXFuwtBa
 dFTx44JXhtwkX70hn8Ki8CvQ=
X-Envelope-To: linux-trace-kernel@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id e9aae79e29a4cba2;
	Wed, 11 Nov 2026 15:34:41 +0000
X-Mizu-Trace-ID: e9aae79e29a4cba2
X-Migadu-Flow: FLOW_OUT
Message-ID: <8497ba87-354a-4564-a9cc-d376847e6b19@linux.dev>
Date: Wed, 11 Nov 2026 23:34:24 +0800
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Post: <mailto:linux-trace-kernel@vger.kernel.org>
List-Help: <mailto:linux-trace-kernel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-trace-kernel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next 6/9] selftests/bpf: Verify tracing link_create
 logs
To: bot+bpf-ci@kernel.org, bpf@vger.kernel.org
Cc: ast@kernel.org, daniel@iogearbox.net, john.fastabend@gmail.com,
 andrii@kernel.org, eddyz87@gmail.com, memxor@gmail.com,
 martin.lau@linux.dev, song@kernel.org, yonghong.song@linux.dev,
 jolsa@kernel.org, emil@etsalapatis.com, ihor.solodrai@linux.dev,
 rostedt@goodmis.org, mhiramat@kernel.org, mathieu.desnoyers@efficios.com,
 kpsingh@kernel.org, matt@bobrowski.net, shuah@kernel.org,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org, netdev@vger.kernel.org,
 martin.lau@kernel.org, mason@kernel.org
References: <20261109140816.5196-7-leon.hwang@linux.dev>
 <11d1648e59b112236d1add138094b2c057d19270ba45e0fc47f6342da665db95@mail.kernel.org>
Content-Language: en-US
From: Leon Hwang <leon.hwang@linux.dev>
In-Reply-To: <11d1648e59b112236d1add138094b2c057d19270ba45e0fc47f6342da665db95@mail.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2026/11/9 22:47, bot+bpf-ci@kernel.org wrote:
>> selftests/bpf: Verify tracing link_create logs
> 
> TL;DR: Test issue: the invalid attach_type subtest in tracing_link.c may fail
> earlier in the generic check, so it may not exercise the new tracing log.
> Using BPF_TRACE_FEXIT on the fentry program might fix it.
> 
>> diff --git a/tools/testing/selftests/bpf/prog_tests/tracing_link.c b/tools/testing/selftests/bpf/prog_tests/tracing_link.c
>> new file mode 100644
>> --- /dev/null
>> +++ b/tools/testing/selftests/bpf/prog_tests/tracing_link.c
> 
> [ ... ]
> 
>> +static void test_log_invalid_attach_type(void)
>> +{
>> +	const char *msg = "Invalid attach_type.\n";
>> +
>> +	test_fentry_link_create_log(0, 0, 0, BPF_XDP, false, msg);
>> +}
> 
> Does this subtest reach the tracing-specific log added by "bpf: Add log
> support for tracing link_create"?
> 
> With BPF_XDP on the fentry program, link_create() fails earlier in the
> generic check:
> 
>     ret = bpf_prog_attach_check_attach_type(prog, attr->link_create.attach_type);
>     if (ret) {
>         bpf_log(log, "Invalid attach_type.\n");
>         goto out;
>     }
> 
> For BPF_PROG_TYPE_TRACING, attach_type_to_prog_type(BPF_XDP) returns
> BPF_PROG_TYPE_XDP, so bpf_prog_attach_check_attach_type() returns -EINVAL
> and the case below is never reached:
> 
>     case BPF_PROG_TYPE_TRACING:
>         if (attr->link_create.attach_type != prog->expected_attach_type) {
>             bpf_log(log, "Invalid attach_type.\n");
> 
> Both messages are identical, so this subtest would still pass if the
> tracing-branch bpf_log() were removed.  The generic check is already
> covered by the invalid_attach_type subtest in xdp_link.c.
> 
> Would passing an attach type that maps to BPF_PROG_TYPE_TRACING but
> differs from the program's expected_attach_type, for example
> BPF_TRACE_FEXIT for this fentry program, exercise the new log instead?
> 

Agreed.

Will change the log msg to "Invalid tracing attach_type.\n", and change
BPF_XDP to BPF_TRACE_FEXIT.

Thanks,
Leon

