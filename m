Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=95.215.58.2
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794814254;
	b=LzO9KZUAZJDwvj1O0XD2jdl/fXTj9urDDMf/Ph61Yo2Oki50TilcPej3iKhtGeqd1P0I
	 nGGgbF/yLEaOlCteMNIoPFi1x8HCMrlSiKkie2y50aamhiUm+lhVd34Pdbn+A5pHxQbqL
	 VFP12zXnJker4ZJ+2drl5O7DoZiywgILwf/xBNK0A2ZrYQTtuoGvC9yD9PGNrutYnNyzG
	 mOva1wbrpqNaSnaPEy2aE/c21QKQtlg4podPADL9DjvQTsOhdHrRwaoT8rQfJeEPfjoL2
	 TRivP8ku/LKpjFZaR4a5O8dGnNCfP9iWqKK6EBgrMFL8IlaxnQyzRPQvhd5d+jrBPjg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794814254;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding;
	bh=RsZWTmj3iECRzeLYzMxjiBI7jRR7JOFGd0yktvO+2WE=;
	b=Zrkl+wjLa7EjqSRTif3m/393bC6IpRC7I3ynxh020BtjsTQ0rV79ZQKpoGi3FjhXbjoy
	 O9qbxuLxP/TzaDAjpazCeisIuo8YjLYN66FwE53UGveLfwm8Iolsmenl5d7GxwAUZJCdE
	 e6OPKjnBJix4r38JSzL00ufJcaNgHSgvz7HZJCdJPNq5QxN4vZbsO256zGV8oiLDHcqoo
	 ZMYPoNUAzgGQAY3FK0d1LiF9YH8wYldUIHxFKWkAZGr06x48DRrfoTpbh8c+QMLCJv8i1
	 FSpK0sS/PZdtroPclLBTeCI/zUQTVhDdRv9vkQbH2t6QxhSrWKTZJTDfQN+wkG+og+w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=MOPFCDsf;
	arc=none smtp.remote-ip=95.215.58.2
Received: from mta1.migadu.com (out-2.mta1.migadu.com [95.215.58.2])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 076BB606A32C
	for <linux-trace-kernel@vger.kernel.org>; Mon, 16 Nov 2026 07:30:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 076BB606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=MOPFCDsf
X-Envelope-To: linux-trace-kernel@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=Ry9yBMCBwp3nSnzP3KHOZ1Uq3e0bH9SyWtuodwQExwE=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1794814252; v=1; x=1795419052;
 b=MOPFCDsfS4DjoRebt4WMbecTiAUgRSoknL/MLxxULJR+x97yFJYLB9CEFsdjmljd51OlTQhY
 98gzlW4mQtyUMJQLJm3QUQJqlFkD5+Iu2UwLJocojp8bGh5DXgbRWgT0GVUEtnk7uy0PJL8GAeA
 m/P9UkZAsGZLJJkayvNIayB8=
X-Envelope-To: linux-trace-kernel@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id da558d5e7fa220f7;
	Mon, 16 Nov 2026 07:30:51 +0000
X-Mizu-Trace-ID: da558d5e7fa220f7
X-Migadu-Flow: FLOW_OUT
Message-ID: <f2c69ae2-4da6-4203-8201-04fd4a1c2742@linux.dev>
Date: Mon, 16 Nov 2026 15:30:43 +0800
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
Subject: Re: [PATCH bpf-next v2 8/9] selftests/bpf: Verify iter link_create
 logs
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>,
 John Fastabend <john.fastabend@gmail.com>,
 Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>,
 Kumar Kartikeya Dwivedi <memxor@gmail.com>,
 Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>,
 Emil Tsalapatis <emil@etsalapatis.com>,
 Ihor Solodrai <ihor.solodrai@linux.dev>, Steven Rostedt
 <rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 KP Singh <kpsingh@kernel.org>, Matt Bobrowski <matt@bobrowski.net>,
 Shuah Khan <shuah@kernel.org>, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
 netdev@vger.kernel.org
References: <20261114150610.84507-1-leon.hwang@linux.dev>
 <20261114150610.84507-9-leon.hwang@linux.dev>
Content-Language: en-US
From: Leon Hwang <leon.hwang@linux.dev>
In-Reply-To: <20261114150610.84507-9-leon.hwang@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 14/11/26 23:06, Leon Hwang wrote:

[...]

> +
> +static void test_log_invalid_iter_info(void)

As sashiko pointed out, the function name should be
test_log_invalid_iter_info_len.

Please update the function name when applying.

> +{
> +	unsigned char info[sizeof(union bpf_iter_link_info) + 1] = {};
> +	const char *msg = "Invalid iter_info_len.\n";

[...]

> +out:
> +	bpf_iter_bpf_map__destroy(skel);
> +}
> +
> +static void test_log_invalid_iter_info_len(void)


As sashiko pointed out, the function name should be
test_log_invalid_iter_info.

Please update the function name when applying.

Thanks,
Leon

> +{
> +	const char *msg = "Invalid iter_info.\n";
> +	LIBBPF_OPTS(bpf_link_create_opts, opts,
> +		    .iter.info = (union bpf_iter_link_info *)1,
> +		    .iter.len = sizeof(union bpf_iter_link_info),
> +	);
> +
> +	test_iter_link_create_log(0, &opts, 0, -EFAULT, msg);
> +}
> +
[...]

