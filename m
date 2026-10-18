Received: from mta0.migadu.com (out-5.mta0.migadu.com [91.218.175.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2148E3D6CB4
	for <linux-trace-kernel@vger.kernel.org>; Sun, 18 Oct 2026 16:30:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792341048; cv=none; b=q2DSeI3ZSgCKho3fOwuri2l99trBPRz3757yU6Au87kQX3+PYWGFxfajNLv6aUEw69b70CvVj7ouvZQh6NlS+v2eRDendzH+B+PRgN1H42ttVyyPUHuucJWrPSP2CsltpUVOOEFpwgEWUbaDk/21ONeUHjXFS3Uqo4JF7P00gtg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792341048; c=relaxed/simple;
	bh=wVl7PEAQy4n1gX78hW+uwNN+//utyJr1zIHPEuth3iM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oP+bKUsGb/uQ8GuIGtEch1O/c+0hGoBHzK+C4t11bA03C3DG6OdAE29iHyyAuw3jhG+5nFDSZfzKMBqg8y/y29L1PizdrOfbfapb+jgn9NvzFjTKwQDNriBCnUdBOSwUZ6Sw/hVz3T2PgZcXCpuJ8+LfwybhrLCMwkFMYHL6xSs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=KnLUAAl9; arc=none smtp.client-ip=91.218.175.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="KnLUAAl9"
X-Envelope-To: linux-trace-kernel@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=wVl7PEAQy4n1gX78hW+uwNN+//utyJr1zIHPEuth3iM=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1792341045; v=1; x=1792945845;
 b=KnLUAAl9Se0bKYxf0/eyNDbaOQYG/uSgWNgwHDkPm8lRhwsTMXngARjnsxh6QJATTknqYttT
 8PEVx6Wpe4PNprCmk9Qrzp8uYuVa5TWwjMCv7O/IHTsVYue/MMsZvcdGDK3dLpsfGKXLWzHHK3r
 Uvc/jvuEY4QK9TDrJcharwjA=
X-Envelope-To: linux-trace-kernel@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id b268277504964426;
	Sun, 18 Oct 2026 16:30:44 +0000
X-Mizu-Trace-ID: b268277504964426
X-Migadu-Flow: FLOW_OUT
Message-ID: <96dd8e4e-2783-4616-8c68-9d89151a0cad@linux.dev>
Date: Mon, 19 Oct 2026 00:30:33 +0800
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next 2/6] bpf: Add syscall common attrs support for
 xdp link_create
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
References: <20261017142649.51047-3-leon.hwang@linux.dev>
 <41c7d03fa06bd4e9439560fac5b3cf4d170b96b5c23946da8a3449e05c482b38@mail.kernel.org>
Content-Language: en-US
From: Leon Hwang <leon.hwang@linux.dev>
In-Reply-To: <41c7d03fa06bd4e9439560fac5b3cf4d170b96b5c23946da8a3449e05c482b38@mail.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2026/10/17 23:03, bot+bpf-ci@kernel.org wrote:
>> bpf: Add syscall common attrs support for xdp link_create
> 
> TL;DR:
> - bpf_log(log, extack._msg) in bpf_xdp_link_attach() may dereference NULL when
>   no extack message is set
> - bpf_log() may be an undefined reference when CONFIG_BPF_SYSCALL=n
> 
>> diff --git a/net/core/dev.c b/net/core/dev.c
>> index 18dc88990510..fdc1de21f358 100644
>> --- a/net/core/dev.c
>> +++ b/net/core/dev.c
> 
> [ ... ]
> 
>> @@ -10784,6 +10786,7 @@ int bpf_xdp_link_attach(const union bpf_attr *attr, struct bpf_prog *prog)
>>  	dev = dev_get_by_index(net, attr->link_create.target_ifindex);
>>  	if (!dev) {
>>  		rtnl_unlock();
>> +		bpf_log(log, "Invalid target_ifindex.\n");
>>  		return -EINVAL;
>>  	}
>>
> 
> Can this fail to link when CONFIG_BPF_SYSCALL is not set?
> 
> bpf_xdp_link_attach() is built whenever CONFIG_NET=y, but bpf_log() lives in
> kernel/bpf/log.c, which kernel/bpf/Makefile only builds under
> CONFIG_BPF_SYSCALL:
> 
>   obj-$(CONFIG_BPF_SYSCALL) += syscall.o verifier.o ... log.o ...
> 
> include/linux/bpf_verifier.h declares bpf_log() with no stub for the
> !CONFIG_BPF_SYSCALL case, and CONFIG_NET only does "select BPF".  A config
> with CONFIG_NET=y and CONFIG_BPF_SYSCALL=n looks like it would end with an
> undefined reference to bpf_log from both of the new calls in this function.
> 
> include/linux/bpf.h provides static inline stubs for bpf_link_init(),
> bpf_link_prime(), bpf_link_settle() and bpf_link_cleanup() so that this
> function builds without the bpf() syscall.
> 
> Should bpf_log() get a similar stub, or should the calls be guarded with
> IS_ENABLED(CONFIG_BPF_SYSCALL)?  None of the later patches in the series add
> a stub or change the Makefile.

Will add a stub bpf_log() when CONFIG_BPF_SYSCALL is not set.>
> [ ... ]
> 
>> @@ -10812,6 +10815,7 @@ int bpf_xdp_link_attach(const union bpf_attr *attr, struct bpf_prog *prog)
>>  	if (err) {
>>  		link->dev = NULL;
>>  		bpf_link_cleanup(&link_primer);
>> +		bpf_log(log, extack._msg);
>>  		trace_bpf_xdp_link_attach_failed(extack._msg);
>>  		goto out_put_dev;
>>  	}
> 
> Can extack._msg be NULL here?
> 
> extack is zero-initialised (struct netlink_ext_ack extack = {};), and _msg
> stays NULL whenever dev_xdp_attach_link() fails without anyone calling
> NL_SET_ERR_MSG().  Many ndo_bpf implementations do exactly that.  For
> example, ixgbe_xdp() -> ixgbe_xdp_setup() has several -EINVAL and -ENOMEM
> returns that don't set an extack message, and mlx5e_xdp_set() ->
> mlx5e_xdp_allowed() returns -EINVAL with only a netdev_warn().
> 
> If the caller passed BPF_COMMON_ATTRS with log_level != 0
> (bpf_verifier_log_attr_valid() accepts log_level=1 even with a NULL log_buf
> and a log_size of 0), bpf_verifier_log_needed() is true and the call chain
> becomes:
> 
>   bpf_log(log, NULL)
>     -> bpf_verifier_vlog(log, NULL, args)
>       -> vscnprintf(log->kbuf, BPF_VERIFIER_TMP_LOG_SIZE, NULL, args)
>         -> vsnprintf()    /* while (*fmt.str) with fmt.str == NULL */
> 
> which dereferences NULL.  The tracepoint on the next line copes with NULL
> because __assign_str() substitutes a placeholder string, and the netlink ack
> path also checks extack->_msg, so this new bpf_log() call looks like the only
> consumer without a NULL check.
> 
> Passing the message as the format string also means a '%' in an extack
> message would be interpreted as a conversion, and unlike the other bpf_log()
> messages in link_create(), this one has no trailing newline.  Would
> something like this be better?
> 
>   if (extack._msg)
>           bpf_log(log, "%s\n", extack._msg);

Will change to this.

Thanks,
Leon

> [...]
