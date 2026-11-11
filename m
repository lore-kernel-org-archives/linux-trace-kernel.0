Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=95.215.58.47
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794411186;
	b=rVQlvKMPkHdj5weaGJoHUhYTrb4AOIP1X6DTkqtuEM4f5joHaznN4WmQXnS/PFm/DArN
	 I7UqlmdV5xfDfujh1j1FF7VeFk4jGwEtsPuBXmvatMhb1veGe/027pn2wKHT0ongHgCR7
	 khpf1pZMgDOTZ7rIUxSQktC66GMXyNfGA6tlIkVNghlQgCH0lLCRJOhdw7CixD6et8JxS
	 t7uqfATPZJnLSESaGRL21u8tp+FeG//grbMNgHhTOB1IcZke9G73assyv2YeAVNbSGGU0
	 +IgeYo2OWvsdTq7uQAki8yv+78S+CMFs1v8hVMV3z4zmKCnnQRE+erof1solUHzREag==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794411186;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding;
	bh=EGBcdLyH+qWtPFF9G1WLyu068WqshojAGB+pBC2wncc=;
	b=M85hNhhJ6Qg0Tv12ILScyuaa6vAZzJgASGVuXvVt/UMW1woMX9TvhhjZmWIo5oleoun6
	 8u59RVUCtFVEKrkeMb1BiAgg0l1KM54Th66338vWFtQaQ74oJ+uNDRQuGzvY7Q70qZI2/
	 9zdaUUwMODiyMxMqz4D4wZDpl3KG1fdK0aC6DeUGz+GiYxP3l674nmVuAol4kPsAQLUMg
	 fjcx+pexdEEjLgEFvC/FOApjfzoGK2tih/vQ1DLmwfZJ9NT5bRqg4SvG4l6f8TxvLGLC4
	 PRadYTIF7popozYdmECJhnsle20sD0aXlUv+WZMlmGW6q+Sevi11gieDGcITV7JlpJQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=fU0WQK3T;
	arc=none smtp.remote-ip=95.215.58.47
Received: from mta1.migadu.com (out-47.mta1.migadu.com [95.215.58.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BB5A606A326
	for <linux-trace-kernel@vger.kernel.org>; Wed, 11 Nov 2026 15:33:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4BB5A606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=fU0WQK3T
X-Envelope-To: linux-trace-kernel@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=FYJ5fe5bszWYbPmBUf7pMhzfw1+piK655vw2zkho3KU=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1794411183; v=1; x=1795015983;
 b=fU0WQK3TlyT/bMe+6X8gJE8piiEwBp+qMghoBptDNTz0q5iWaaHpEOkjV6eI8sKdavNcRvay
 fT6z3ZByUvQQ3mvS9nHCbxnH5C5RJz0loaFPjS+a4TyiF0E1ul1kPTEoNFDPSwifCmifz+6PE+V
 iwLZeNeNcl50T2eBrkew/rrU=
X-Envelope-To: linux-trace-kernel@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id e7ccb356486f714d;
	Wed, 11 Nov 2026 15:33:02 +0000
X-Mizu-Trace-ID: e7ccb356486f714d
X-Migadu-Flow: FLOW_OUT
Message-ID: <ab4e5c29-b835-4ea8-853b-57ae7ad2eafe@linux.dev>
Date: Wed, 11 Nov 2026 23:32:50 +0800
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
Subject: Re: [PATCH bpf-next 5/9] libbpf: Add log_opts support for
 BPF_TRACE_ITER
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
References: <20261109140816.5196-6-leon.hwang@linux.dev>
 <8b9e5217cbe9c192e678ce5c8d59f573c80a659d72211f5b91c905ed00ebb799@mail.kernel.org>
Content-Language: en-US
From: Leon Hwang <leon.hwang@linux.dev>
In-Reply-To: <8b9e5217cbe9c192e678ce5c8d59f573c80a659d72211f5b91c905ed00ebb799@mail.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2026/11/9 22:47, bot+bpf-ci@kernel.org wrote:
>> libbpf: Add log_opts support for BPF_TRACE_ITER
> 
> TL;DR:
> - libbpf BPF_TRACE_ITER case may not reject stray bytes after iter.len
>   (missing OPTS_ZEROED check), so unknown fields could be silently ignored
> - Nit: iter.len test in the legacy branch looks like dead code
> 
>> diff --git a/tools/lib/bpf/bpf.c b/tools/lib/bpf/bpf.c
>> --- a/tools/lib/bpf/bpf.c
>> +++ b/tools/lib/bpf/bpf.c
> 
> [ ... ]
> 
>> @@ -821,6 +816,16 @@ int bpf_link_create(int prog_fd, int target_fd,
>>  			return libbpf_err(-EINVAL);
>>  	}
>>  
>> +	if (iter_info_len) {
>> +		if (OPTS_GET(opts, iter.len, 0))
>> +			return libbpf_err(-EINVAL);
>> +		iter_info = OPTS_GET(opts, iter_info, (void *)0);
>> +	} else {
>> +		log_opts = OPTS_GET(opts, log_opts, (void *)0);
>> +		iter_info = OPTS_GET(opts, iter.info, (void *)0);
>> +		iter_info_len = OPTS_GET(opts, iter.len, 0);
>> +	}
>> +
> 
> When the legacy iter_info_len is non-zero, the check above already requires
> OPTS_ZEROED(opts, target_btf_id), which covers every byte from that offset
> up to sz, including iter.info and iter.len.  Can this OPTS_GET(opts,
> iter.len, 0) test ever be true?  It looks like dead code.
> 

Will drop the iter.len check.

> [ ... ]
> 
>>  	switch (attach_type) {
>>  	case BPF_TRACE_ITER:
>>  		attr.link_create.iter_info = ptr_to_u64(iter_info);
>>  		attr.link_create.iter_info_len = iter_info_len;
>>  		break;
> 
> Every other union member's case ends with a check such as:
> 
>     if (!OPTS_ZEROED(opts, tracing_multi))
>             return libbpf_err(-EINVAL);
> 
> Should the BPF_TRACE_ITER case do the same with OPTS_ZEROED(opts, iter)?

Will add OPTS_ZEROED(opts, iter) check.

Thanks,
Leon

> 
> On the new iter.info/iter.len path, nothing checks the bytes after iter.len.
> A caller that sets opts.iter.info, opts.iter.len and opts.tracing_multi.cnt
> gets the stray field silently ignored instead of -EINVAL.  Likewise, a
> later field added to the iter struct after len, built against newer
> headers, would be silently dropped by this libbpf because sz still equals
> sizeof() and OPTS_VALID() cannot see it.
> 
> Legacy callers would be unaffected, since their union is already zero, and
> the iter.len test in the legacy branch could then be dropped.  The later
> commits in this series only touch selftests and do not address this.
> 
> 
> ---
> AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
> See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md
> 
> CI run summary: https://github.com/kernel-patches/bpf/actions/runs/42633880300

