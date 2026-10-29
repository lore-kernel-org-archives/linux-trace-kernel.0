Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=91.218.175.113
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793255795;
	b=x95SpNqhPxt5bHwW6eaXw4Qm3SInKQwYtDjYsAcFPXnnCi+XblgNPgubOJTCOPn9Xejb
	 YHi5+skBqsF6JcKpUriy/OiR2VMMuZ4YvNE0F604YWro0g7QY8AB2GSwJjH4FD5ZZXRy6
	 BLuB5pXKjUKQeQdyth/N6ioUu1IS84icNSRTvbGBOH8+bkwQbKm7T5o6qiHdZxgVHPoVi
	 YbzGRRR8TMCCcbsSAm4/qcZg3mXYHT/3KzmtyoJm80wTS8HDLtylZdDmOX1BvukAV9Bci
	 +TIUaGb2XqGwRv74Ll1gYz/NWxcOxGLqYw/837LJL/50z7Jrr/QSY0xD/HFp7A0e/ug==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793255795;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding;
	bh=e9iJkXpRXYXbKJ8YCCtjeFCD9Hy6xZkuFkKL1cPOJqk=;
	b=uu6ky8L2bSGaEwUF0WvRNgxXo9pvm4sZGvWm2XC2xTksr7Y2Emw8DwJgsgKaqT5l6FNS
	 QHu8TU2VHxZH4IdobmZ/iVVRkjW3B4x6+Fuu4Kr8P+SE6NRj2lA7Q0bwfqP3llgsBM1k/
	 +VmLAibLlvIw+qwZt1V3zrCS0UKUdG8nKk2uWAzo0oIC0Kn2gGv1dEf2ooUmoxgAJjhXk
	 Yzvbt1JislxXDN6yyG1kgydGp/sBzIYBfOWzo8Ey4XH6lueTytysDJYv6jovH0enlLfq0
	 oHriawKCk1GkqJTWIZmMxcDDz6Oc9/AQLG+Ex/AFZBU0jK16CHkJuehc+znVq5R4exg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=mjhIZ7Jh;
	arc=none smtp.remote-ip=91.218.175.113
Received: from mta0.migadu.com (out-113.mta0.migadu.com [91.218.175.113])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24F10606A31E
	for <linux-trace-kernel@vger.kernel.org>; Thu, 29 Oct 2026 06:36:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 24F10606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=mjhIZ7Jh
X-Envelope-To: linux-trace-kernel@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=vfvRt1Fm/vOTY1RQFLMCd0NgP0okjDh8EthFOA7WL3k=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793255793; v=1; x=1793860593;
 b=mjhIZ7JhBxBVZdnCSTA8OZmIemi9AJUtkyTv96zkbnFwXK96rKFn4ZxP/w570Xh8B7npS1S2
 /ax9FAP1vLpT01EqPXxuDyDrgdQ3gLS1Py5clE0/sCmWusncdRasCw7k06Yv3tcUnnwDe3OflNr
 4Zz+9g9tPN0A36Ogz/uRyXqQ=
X-Envelope-To: linux-trace-kernel@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 2e800ba7b5c5cc6c;
	Thu, 29 Oct 2026 06:36:33 +0000
X-Mizu-Trace-ID: 2e800ba7b5c5cc6c
X-Migadu-Flow: FLOW_OUT
Message-ID: <99bbc23f-a3a0-4357-99d7-0f0167136432@linux.dev>
Date: Thu, 29 Oct 2026 14:36:30 +0800
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
Subject: Re: [PATCH bpf-next v5 5/6] libbpf: Add log_opts support for
 bpf_link_create
To: sashiko-reviews@lists.linux.dev, bpf@vger.kernel.org
Cc: linux-trace-kernel@vger.kernel.org
References: <20261026154948.99408-1-leon.hwang@linux.dev>
 <20261026154948.99408-6-leon.hwang@linux.dev>
 <sashiko-outbox-185491@kernel.org>
Content-Language: en-US
From: Leon Hwang <leon.hwang@linux.dev>
In-Reply-To: <sashiko-outbox-185491@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 27/10/26 00:05, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [Medium] libbpf: type confusion between iter_info and log_opts in bpf_link_create()
> --
> 
> commit b4af2771f4c0edb6656b6ddcd881019158c55a55
> Author: Leon Hwang <leon.hwang@linux.dev>
> 
> libbpf: Add log_opts support for bpf_link_create
> 
> This commit adds log_opts support to bpf_link_create() by placing log_opts in
> an anonymous union with iter_info in struct bpf_link_create_opts and passing
> it to __sys_bpf_fd().
> 
>> diff --git a/tools/lib/bpf/bpf.c b/tools/lib/bpf/bpf.c
>> index aea534764dfe2..38dcb31e8c0ed 100644
>> --- a/tools/lib/bpf/bpf.c
>> +++ b/tools/lib/bpf/bpf.c
>> @@ -794,6 +794,8 @@ int bpf_link_create(int prog_fd, int target_fd,
>>  {
>>  	const size_t attr_sz = offsetofend(union bpf_attr, link_create);
>>  	__u32 target_btf_id, iter_info_len, relative_id;
>> +	union bpf_iter_link_info *iter_info = NULL;
>> +	struct bpf_log_opts *log_opts = NULL;
>>  	int fd, err, relative_fd;
>>  	union bpf_attr attr;
>>  
>> @@ -803,6 +805,14 @@ int bpf_link_create(int prog_fd, int target_fd,
>>  	iter_info_len = OPTS_GET(opts, iter_info_len, 0);
>>  	target_btf_id = OPTS_GET(opts, target_btf_id, 0);
>>  
>> +	if (iter_info_len && attach_type != BPF_TRACE_ITER)
>> +		return libbpf_err(-EINVAL);
>> +
>> +	if (iter_info_len)
>> +		iter_info = OPTS_GET(opts, iter_info, (void *)0);
>> +	else
>> +		log_opts = OPTS_GET(opts, log_opts, (void *)0);
> 
> [Severity: Medium]
> Can overlaying iter_info and log_opts in struct bpf_link_create_opts and
> selecting between them using only iter_info_len cause type confusion when a
> caller passes a non-NULL iter_info with iter_info_len == 0?

Users must not do like this. By convention, iter_info_len==0 means no
iter_info.

> 
> For example, a caller of bpf_link_create() or bpf_program__attach_iter() in
> tools/lib/bpf/libbpf.c:
> 
> tools/lib/bpf/libbpf.c:bpf_program__attach_iter() {
> 	...
> 	link_create_opts.iter_info = OPTS_GET(opts, link_info, (void *)0);
> 	link_create_opts.iter_info_len = OPTS_GET(opts, link_info_len, 0);
> 	...
> 	return bpf_link_create(prog_fd, target_fd, BPF_TRACE_ITER, &link_create_opts);
> }
> 
> might pass a non-NULL union bpf_iter_link_info pointer while leaving
> iter_info_len (or link_info_len) set to 0.
> 
> Previously, bpf_link_create() forwarded both the non-NULL iter_info pointer
> and iter_info_len == 0 to the kernel, where bpf_iter_link_attach() rejected
> the mismatched arguments with -EINVAL:
> 
> kernel/bpf/bpf_iter.c:bpf_iter_link_attach() {
> 	...
> 	if (bpfptr_is_null(ulinfo) ^ !linfo_len)
> 		return -EINVAL;
> 	...
> }
> 
> With this change, when iter_info_len == 0, bpf_link_create() leaves iter_info
> as NULL (so attr.link_create.iter_info is 0 and the kernel check is bypassed)
> and instead assigns the union bpf_iter_link_info pointer to log_opts.
> 
> When bpf_link_create() then calls __sys_bpf_fd(), log_opts is dereferenced as
> struct bpf_log_opts:
> 
> tools/lib/bpf/bpf.c:__sys_bpf_fd() {
> 	...
> 	if (!OPTS_VALID(log_opts, bpf_log_opts))
> 		return libbpf_err(-EINVAL);
> 
> 	if (log_opts && feat_supported(NULL, FEAT_BPF_SYSCALL_COMMON_ATTRS)) {
> 		memset(&attr_common, 0, attr_common_sz);
> 		attr_common.log_buf = ptr_to_u64(OPTS_GET(log_opts, buf, NULL));
> 		attr_common.log_size = OPTS_GET(log_opts, size, 0);
> 		attr_common.log_level = OPTS_GET(log_opts, level, 0);
> 		fd = sys_bpf_ext_fd(cmd, attr, attr_sz, &attr_common, attr_common_sz);
> 		OPTS_SET(log_opts, true_size, attr_common.log_true_size);
> 	} else {
> 		fd = sys_bpf_fd(cmd, attr, attr_sz);
> 		OPTS_SET(log_opts, true_size, 0);
> 	}
> 	...
> }
> 
> Since union bpf_iter_link_info is 16 bytes while struct bpf_log_opts extends
> to offsetofend(struct bpf_log_opts, true_size) (28 bytes on 64-bit, 20 bytes
> on 32-bit), interpreting the first sizeof(size_t) bytes of iter_info (such as
> map.map_fd, task.tid, task.pid, or cgroup.cgroup_fd) as log_opts->sz can
> cause out-of-bounds reads in OPTS_VALID() and OPTS_GET(), as well as a 4-byte
> out-of-bounds write past union bpf_iter_link_info via OPTS_SET(log_opts,
> true_size, ...).
> 
> In addition, aliasing iter_info and log_opts prevents BPF_TRACE_ITER links
> from using log_opts whenever iter_info is specified. Would it be safer to
> place log_opts in its own field at the end of struct bpf_link_create_opts
> instead of sharing a union with iter_info?
> 

Not at the end of struct bpf_link_create_opts.

When adding log_opts support for iter link in the future, both iter_info
and iter_info_len will be moved to the last union.

diff --git a/tools/lib/bpf/bpf.h b/tools/lib/bpf/bpf.h
index fe3b7fd8512b..8bfada1f3ea3 100644
--- a/tools/lib/bpf/bpf.h
+++ b/tools/lib/bpf/bpf.h
@@ -478,6 +478,10 @@ struct bpf_link_create_opts {
                        const __u64 *cookies;
                        __u32 cnt;
                } tracing_multi;
+               struct {
+                       union bpf_iter_link_info *info;
+                       __u32 len;
+               } iter;
        };
        size_t :0;
 };

Afterwards, log_opts will be valid at the iter_info position for iter link.

Thanks,
Leon

