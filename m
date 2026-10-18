Received: from mta1.migadu.com (out-216.mta1.migadu.com [95.215.58.216])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47EB133F8BC
	for <linux-trace-kernel@vger.kernel.org>; Sun, 18 Oct 2026 16:33:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.216
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792341243; cv=none; b=kgnkK65RfYG8UNW6gnYrTArqzh8vxWU/louKbPAvvzbwSX7l4YG14ev9v/guvPYhLCBOns8FZyaiEEECGU6xLR31zt0gn197djtjiHGG3kx7jIF38GshKJoppJeCAu1/CznDVBNTvAIDVs/bccugiAPXZOEnr+jZzU2RkaJ/EyU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792341243; c=relaxed/simple;
	bh=m7n7YIoURJCxjqzRmIhNGAzD2y+XE5DbMarExGyeOOU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GFkezFiefnEHxPTRj0Q6pxhvKL1yRz0KFbGPFMF2SXDQEDWdHhPvKvdaWu+lZVCnY2q4CPBJq+8GXS0+fxBPdfq+ILrWBgNiL458HBaWXWHN1OjTldCDqvFTsqrgEK4aDixpgoeKC8lNGTEF0PsjvoNnNaoCyCtecGq7CJSwkFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=pCEFc+sL; arc=none smtp.client-ip=95.215.58.216
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="pCEFc+sL"
X-Envelope-To: linux-trace-kernel@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=m7n7YIoURJCxjqzRmIhNGAzD2y+XE5DbMarExGyeOOU=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1792341234; v=1; x=1792946034;
 b=pCEFc+sLbBGdU6kH3TV5/lQBsNQFjEri08L5wncs61Flwclrvtmv8WzkWVxYw6SuHLdMTHBC
 WAfnJgm0yFQPHsbh1QPPv2IVXJ0Vj1G1iMACukuDizMswW/QW8NugYVMr9ccqiAEqcTWieH+DP6
 y4jmjfe5NNobM/Q/XqtunYgw=
X-Envelope-To: linux-trace-kernel@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 5af85ac1fdd41fb6;
	Sun, 18 Oct 2026 16:33:53 +0000
X-Mizu-Trace-ID: 5af85ac1fdd41fb6
X-Migadu-Flow: FLOW_OUT
Message-ID: <b97fa998-b77d-4600-8453-9bb16200409e@linux.dev>
Date: Mon, 19 Oct 2026 00:33:43 +0800
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next 6/6] selftests/bpf: Add tests to verify
 link_create logs
To: bot+bpf-ci@kernel.org, bpf@vger.kernel.org
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@kernel.org,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, ast@kernel.org,
 daniel@iogearbox.net, andrii@kernel.org, eddyz87@gmail.com,
 memxor@gmail.com, martin.lau@linux.dev, song@kernel.org,
 yonghong.song@linux.dev, jolsa@kernel.org, emil@etsalapatis.com,
 ihor.solodrai@linux.dev, hawk@kernel.org, john.fastabend@gmail.com,
 sdf@fomichev.me, rostedt@goodmis.org, mhiramat@kernel.org,
 mathieu.desnoyers@efficios.com, shuah@kernel.org, kuniyu@google.com,
 liuhangbin@gmail.com, mkarsten@uwaterloo.ca, masashi.honma@gmail.com,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
 martin.lau@kernel.org, mason@kernel.org
References: <20261017142649.51047-7-leon.hwang@linux.dev>
 <343fe8b9f06af37dde193869b694dbf908b0a0f6592a1e4cc5f5a0ac295b1b88@mail.kernel.org>
Content-Language: en-US
From: Leon Hwang <leon.hwang@linux.dev>
In-Reply-To: <343fe8b9f06af37dde193869b694dbf908b0a0f6592a1e4cc5f5a0ac295b1b88@mail.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2026/10/17 23:02, bot+bpf-ci@kernel.org wrote:
>> selftests/bpf: Add tests to verify link_create logs
> 
> TL;DR: Nits only, in the new link_create log selftests in xdp_link.c: the four
> subtests repeat the same setup and assertions and could share a helper, and
> one has a redundant true_size = 0.
> 
>> diff --git a/tools/testing/selftests/bpf/prog_tests/xdp_link.c b/tools/testing/selftests/bpf/prog_tests/xdp_link.c
>> --- a/tools/testing/selftests/bpf/prog_tests/xdp_link.c
>> +++ b/tools/testing/selftests/bpf/prog_tests/xdp_link.c
> 
> [ ... ]
> 
>> @@ -150,3 +150,135 @@ void serial_test_xdp_link(void)
>>  	test_xdp_link__destroy(skel1);
>>  	test_xdp_link__destroy(skel2);
>>  }
>> +
>> +static void test_link_create_invalid_prog_fd(void)
>> +{
>> +	const char *msg = "Invalid prog_fd.\n";
>> +	char log_buf[128] = {};
>> +	int fd;
>> +	LIBBPF_OPTS(bpf_log_opts, log_opts,
>> +		    .buf = log_buf,
>> +		    .size = sizeof(log_buf),
>> +		    .level = 1,
>> +	);
>> +
>> +	fd = bpf_link_create_log(-1, IFINDEX_LO, BPF_XDP, NULL, &log_opts);
>> +	if (!ASSERT_LT(fd, 0, "bpf_link_create_log")) {
>> +		close(fd);
>> +		return;
>> +	}
>> +
>> +	ASSERT_EQ(fd, -EBADF, "fd");
>> +	ASSERT_STREQ(log_buf, msg, "log_buf");
>> +	ASSERT_EQ(log_opts.true_size, strlen(msg) + 1, "log_size");
>> +}
> 
> This isn't a bug, but the four new test_link_create_*() functions repeat the
> same log_buf and LIBBPF_OPTS(bpf_log_opts, ...) setup, and the same trailing
> ASSERT_EQ(fd, ...) / ASSERT_STREQ(log_buf, msg) /
> ASSERT_EQ(log_opts.true_size, strlen(msg) + 1) sequence.  They differ only in
> prog fd, target, attach type, expected errno and message.

Will factor out helpers to simplify the tests code.

> 
> This looks close to test_map_create() in map_init.c.  Could the four
> link_create log tests share a small helper that takes the prog fd, target,
> attach type, opts, expected errno and message?
> 
>> +
>> +static void test_link_create_invalid_attach_type(void)
>> +{
>> +	const char *msg = "Invalid attach_type.\n";
>> +	struct test_xdp_link *skel;
>> +	char log_buf[128] = {};
>> +	int fd;
>> +	LIBBPF_OPTS(bpf_log_opts, log_opts,
>> +		    .buf = log_buf,
>> +		    .size = sizeof(log_buf),
>> +		    .level = 1,
>> +	);
>> +
>> +	skel = test_xdp_link__open_and_load();
>> +	if (!ASSERT_OK_PTR(skel, "test_xdp_link__open_and_load"))
>> +		return;
>> +
>> +	log_opts.true_size = 0;
> 
> This isn't a bug, but is the log_opts.true_size = 0; line needed here?
> LIBBPF_OPTS() already zero-initializes log_opts, true_size is only written by
> libbpf after the syscall, and the other three tests omit this line.

Good catch.

This line is unnecessary. Will drop it in the next revision.

Thanks,
Leon

