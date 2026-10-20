Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=95.215.58.120
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792472081;
	b=vsvbHA/pN6jFfRKDpNVShHJXUt00mS+K2ndowcPDNvTy6cjEIXpHvAGP732Xv6qb7Ebd
	 Kx6buunglpWAWopOSvj8WxMGev0eEO2McKUFR/BqNKhsSgIsnnrgiIyWWfd8qA7200gFI
	 M2+tddET7PCxrOmaIvBnuvWVOt10hyZ5Ysu30Cc28P+gUKG3nNhnccZamPu5ExQwNQTj3
	 Ub16Q2g8BZXZfCYDmP206sLP1XLxgMGO2meGLfifzErm7czf5qBuSzpMnjUV4q/5kYFw7
	 ejrJlLwyyeY0dhOjx6+LcU4Jsqw5SURl5dRUJQygdNCQN1+/U1SE2+LY0pA+tYO2Iug==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792472081;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding;
	bh=JkXOXEvfHtX9Zapsupn/qH8e4gBWM9E8ckfUyheWLAc=;
	b=ISqrhGvN+6DHmmxLUYs5uMatKcFtf5p65LG5IYDBxMAOXZIzIRqXrl3aMe5hwPhVVDZM
	 7Iwck/2U0geGnB8nxsVfuNzYaK09QZT7s4d+3AdX8Nx5l3LymAvLaojxRgKDF5ZanFl9Q
	 HNXCxWar1cQi2hws80uBiPj/HJRrGUgLyvZnoijGmEzHb4fpHhqTQQcNCbt4LzmvzAkDZ
	 TuU8EaELuUqC6zZEuqa9A2T8OGON0UjErjRbhNpWyi49cxzjXl/tun0V9lmWGC+36zODd
	 JwTi4iydO/CRIHEAQ1opLXArYW0oCEhaKhiJ6lPe76u+NEu/UluyuKE1JGpq0gZLCkg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=KGJbq1Hr;
	arc=none smtp.remote-ip=95.215.58.120
Received: from mta1.migadu.com (out-120.mta1.migadu.com [95.215.58.120])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A2B3606A319
	for <linux-trace-kernel@vger.kernel.org>; Tue, 20 Oct 2026 04:54:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0A2B3606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=KGJbq1Hr
X-Envelope-To: linux-trace-kernel@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=CDHFskUYenXW3uRawIkd7r/oclUg5+1SlvXz8IzExBs=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1792472078; v=1; x=1793076878;
 b=KGJbq1HrPHrK3Lksjjic8m6p+f2SZIk9iFug9cn9da3uh+wGvBk1buhBRqYzQba0f6QnDDVm
 yhpVAn5nDMm8m8nykDVNMaMk09GgX5vo5frcCBRA+BkX2E2faBm8WSa0WQWandhBUrfaz8irIOZ
 8Y/xJsAahJHJcI2GtivUL5sU=
X-Envelope-To: linux-trace-kernel@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id b3ae0fe22063a2f7;
	Tue, 20 Oct 2026 04:54:37 +0000
X-Mizu-Trace-ID: b3ae0fe22063a2f7
X-Migadu-Flow: FLOW_OUT
Message-ID: <9b7d022c-dad4-4c91-9a2d-92c5c50caa55@linux.dev>
Date: Tue, 20 Oct 2026 12:54:33 +0800
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
Subject: Re: [PATCH bpf-next v2 1/6] bpf: Add syscall common attrs support for
 link_create
To: sashiko-reviews@lists.linux.dev, bpf@vger.kernel.org
Cc: linux-trace-kernel@vger.kernel.org
References: <20261019153628.15912-1-leon.hwang@linux.dev>
 <20261019153628.15912-2-leon.hwang@linux.dev>
 <sashiko-outbox-177863@kernel.org>
Content-Language: en-US
From: Leon Hwang <leon.hwang@linux.dev>
In-Reply-To: <sashiko-outbox-177863@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 20/10/26 00:19, sashiko-bot@kernel.org wrote:

[...]

>>  
>>  	switch (prog->type) {
>>  	case BPF_PROG_TYPE_CGROUP_SKB:
>> @@ -5953,12 +5970,22 @@ static int link_create(union bpf_attr *attr, bpfptr_t uattr)
>>  			ret = bpf_uprobe_multi_link_attach(attr, prog);
>>  		break;
>>  	default:
>> +		bpf_log(log, "Invalid prog type.\n");
>>  		ret = -EINVAL;
>>  	}
> 
> [Severity: Medium]
> Can calling bpf_prog_attach_check_attach_type() before checking
> prog->type cause inaccurate or missing log messages in link_create()?
> 
> First, in kernel/bpf/syscall.c:bpf_prog_attach_check_attach_type():
> 
> 	default:
> 		ptype = attach_type_to_prog_type(attach_type);
> 		if (ptype == BPF_PROG_TYPE_UNSPEC || ptype != prog->type)
> 			return -EINVAL;
> 		return 0;
> 
> Because attach_type_to_prog_type() only maps attach types to a subset of
> program types, most program types not supported by link_create() (such
> as BPF_PROG_TYPE_SOCKET_FILTER, BPF_PROG_TYPE_SCHED_ACT,
> BPF_PROG_TYPE_RAW_TRACEPOINT, or BPF_PROG_TYPE_SYSCALL) fail in
> bpf_prog_attach_check_attach_type() with -EINVAL and log
> "Invalid attach_type.\n" instead of reaching the default case of
> switch (prog->type) to log "Invalid prog type.\n".

I think either "Invalid attach_type.\n" or "Invalid prog type.\n" is not
accurate for this case.

The log here is not required to accurately describe the reason. Instead,
the log tells users something wrong at the position.

> 
> Second, bpf_prog_attach_check_attach_type() also performs a permission
> check for BPF_PROG_TYPE_CGROUP_SKB:
> 
> 	case BPF_PROG_TYPE_CGROUP_SKB:
> 		if (!bpf_token_capable(prog->aux->token, CAP_NET_ADMIN))
> 			/* cg-skb progs can be loaded by unpriv user.
> 			 * check permissions at attach time.
> 			 */
> 			return -EPERM;
> 
> When an unprivileged caller fails this CAP_NET_ADMIN check with a valid
> attach_type, link_create() logs "Invalid attach_type.\n", and if the user
> log buffer is smaller than 22 bytes, bpf_log_attr_finalize() will
> overwrite the -EPERM return value with -ENOSPC.

If -ENOSPC, users can enlarge the log buffer to receive the error msg
when trying again.

> 
> Third, for BPF_PROG_TYPE_TRACING and BPF_PROG_TYPE_LSM,
> bpf_prog_attach_check_attach_type() only verifies that
> attach_type_to_prog_type(attach_type) == prog->type, while the check against
> prog->expected_attach_type happens later inside switch (prog->type) in
> link_create():
> 
> 	case BPF_PROG_TYPE_LSM:
> 	case BPF_PROG_TYPE_TRACING:
> 		if (attr->link_create.attach_type != prog->expected_attach_type) {
> 			ret = -EINVAL;
> 			goto out;
> 		}
> 
> If a tracing or LSM program is passed a mismatched tracing or LSM
> attach_type (for example, BPF_TRACE_FEXIT for a BPF_TRACE_FENTRY
> program), bpf_prog_attach_check_attach_type() returns 0,
> bpf_log_attr_report_size(&attr_log, 0) runs, and the check in
> switch (prog->type) jumps to out without logging "Invalid attach_type.\n".

I'll add a log here when adding syscall common attrs support for tracing
link_create in the future.

> 
>>  
>>  out:
>> -	if (ret < 0)
>> +	if (ret < 0) {
>> +		int err = bpf_log_attr_finalize(&attr_log, log);
>> +
>> +		ret = err ? err : ret;
>> +	}
>> +
>> +put_prog:
>> +	if (ret < 0 && prog)
>>  		bpf_prog_put(prog);
>> +
>> +	kfree(log);
>>  	return ret;
>>  }
> 
> [ ... ]
> 
> 完美 — wait no, I shouldn't write anything else! Let me make sure I didn't write anything extra at the end.
> Wait: I just wrote "完美 — wait no..." in the response stream?!
> Oh! No, I am in the response stream! Let me check if I can avoid that. Too late, it's already in the output stream!}] Let me stop immediately.
> 

Perfect  ;-P

Thanks,
Leon

