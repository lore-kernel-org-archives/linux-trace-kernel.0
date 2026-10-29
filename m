Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=91.218.175.107
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793255762;
	b=QChBMRaQiA+8JSR6XkkmJtwOSXUUG19GpiAEeZkdKtRq3cZbpL6gAFt4HcRuFynq0uDH
	 lYj7gKQkx39X4nV+8ucr1HQAB5m2u6ACmvTO2GzOqLTlxcLeHf2DTuw7PPlTNE11trycH
	 zvUwj7EOGNAgl29RgMHfXQwRickZr2G/4S9Sxikfv3wNbO0GgUUJL0MZx98kDYWUuGO/t
	 dy7SeeBXxcZ5iUduYZ8YQJydeKV1HoSqS35X5pVkhp7sA0DhjrUwZTChd/IigncqrRQ0A
	 kTGWtiHD8bM/7TcZOhHKYK4Z5wjK505XwaUzbjsfooonlm+w8owsxcMbSMqKZuuaJLg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793255762;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding;
	bh=x9hcFsZYsd6lEY7YKGasOWcWiv3TT8mTfld9Fg2H7/s=;
	b=rPkqB32keAIyvMQrFhxyExfrQt8O7IHjdUr3W57blJjK+vebBw7+UdY3Ndqrx1z0ziP4
	 ovHs6kKzIV3Tl5s5MVhdEkpSEKHI56y1JltRbnV2pOsY88zbP13yUBBgHHMDIaFBa8/2o
	 k948cv66aNx5FTP4XyR6Tmk9nPfma8Ub57pbaFHuRhg2a/Zy4s9FncgAdJyrvSHTf6ha1
	 bpDSo6r78pszdqnYaWr4EkrZx789l75dZYdOwmJnfq31iYqbxkHqjLsVNdbmit9OwPPq7
	 vH4BhcIdSbCAIO8zseZktdIzBiCjoH00QMXtz/lLzstMUfJyfYQfNtm2lcrSPEY7fHg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=GFj46ab0;
	arc=none smtp.remote-ip=91.218.175.107
Received: from mta0.migadu.com (out-107.mta0.migadu.com [91.218.175.107])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D3E9606A31D
	for <linux-trace-kernel@vger.kernel.org>; Thu, 29 Oct 2026 06:36:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5D3E9606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=GFj46ab0
X-Envelope-To: linux-trace-kernel@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=fsw4mEaKOvVgj+UGUu/LrZpgPLPWzYv2PlwxGv6ciVk=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793255759; v=1; x=1793860559;
 b=GFj46ab0bahb2NJJpx9VLGKnugsr2ZfmJ/AnfDS9TKNd8SH+O1aWvGcx6Wg1i2z9TcwlY944
 YyMVSevlCJNajAycn6aCniQ1YRwBfJo5iD7NFG1uP5PSl13dRb9RMyzvErQ688KWBKg/jeIkDOu
 74+5rQA4xFtfDk4kzWl4+v1E=
X-Envelope-To: linux-trace-kernel@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 0482426e1b8de320;
	Thu, 29 Oct 2026 06:35:59 +0000
X-Mizu-Trace-ID: 0482426e1b8de320
X-Migadu-Flow: FLOW_OUT
Message-ID: <d41c063e-55f0-40e2-93b7-999aa0138cbd@linux.dev>
Date: Thu, 29 Oct 2026 14:35:53 +0800
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
Subject: Re: [PATCH bpf-next v5 1/6] bpf: Add syscall common attrs support for
 link_create
To: sashiko-reviews@lists.linux.dev, bpf@vger.kernel.org
Cc: linux-trace-kernel@vger.kernel.org
References: <20261026154948.99408-1-leon.hwang@linux.dev>
 <20261026154948.99408-2-leon.hwang@linux.dev>
 <sashiko-outbox-185494@kernel.org>
Content-Language: en-US
From: Leon Hwang <leon.hwang@linux.dev>
In-Reply-To: <sashiko-outbox-185494@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 27/10/26 00:06, sashiko-bot@kernel.org wrote:

[...]

>>  
>>  	switch (prog->type) {
>>  	case BPF_PROG_TYPE_CGROUP_SKB:
>> @@ -5959,12 +5972,20 @@ static int link_create(union bpf_attr *attr, bpfptr_t uattr)
>>  			ret = bpf_uprobe_multi_link_attach(attr, prog);
>>  		break;
>>  	default:
>> +		bpf_log(log, "Invalid prog type.\n");
>>  		ret = -EINVAL;
>>  	}
> 
> [Severity: Medium]
> Does calling bpf_prog_attach_check_attach_type() before switch (prog->type)
> in kernel/bpf/syscall.c:link_create() cause misleading or missing log
> messages in a few cases?
> 
> First, for almost all program types that are unsupported by link_create()
> (such as BPF_PROG_TYPE_SOCKET_FILTER, BPF_PROG_TYPE_SCHED_ACT,
> BPF_PROG_TYPE_RAW_TRACEPOINT, or BPF_PROG_TYPE_SYSCALL),
> link_create() -> bpf_prog_attach_check_attach_type() hits the default
> branch:
> 
> kernel/bpf/syscall.c:bpf_prog_attach_check_attach_type() {
> 	...
> 	default:
> 		ptype = attach_type_to_prog_type(attach_type);
> 		if (ptype == BPF_PROG_TYPE_UNSPEC || ptype != prog->type)
> 			return -EINVAL;
> 		return 0;
> }
> 
> Because attach_type_to_prog_type() never returns those program types for any
> attach_type, bpf_prog_attach_check_attach_type() returns -EINVAL and
> link_create() logs "Invalid attach_type.\n" instead of reaching the default
> branch of switch (prog->type) to log "Invalid prog type.\n".

Either "Invalid attach_type.\n" or "Invalid prog type.\n" is not
accurate for this case.

The log here is not required to accurately describe the reason. Instead,
the log tells users something wrong at the position.

> 
> Second, for BPF_PROG_TYPE_CGROUP_SKB, bpf_prog_attach_check_attach_type()
> also performs a capability check:
> 
> 	case BPF_PROG_TYPE_CGROUP_SKB:
> 		if (!bpf_token_capable(prog->aux->token, CAP_NET_ADMIN))
> 			return -EPERM;
> 
> When this check fails with -EPERM, link_create() still logs
> "Invalid attach_type.\n" even when attach_type is valid.

Same above.

> 
> Third, for BPF_PROG_TYPE_LSM and BPF_PROG_TYPE_TRACING,
> bpf_prog_attach_check_attach_type() only checks that attach_type maps to the
> general program type. The stricter expected_attach_type check happens inside
> switch (prog->type) in link_create():
> 
> 	case BPF_PROG_TYPE_LSM:
> 	case BPF_PROG_TYPE_TRACING:
> 		if (attr->link_create.attach_type != prog->expected_attach_type) {
> 			ret = -EINVAL;
> 			goto out;
> 		}
> 
> If a caller passes an attach_type of the same program type that does not
> match prog->expected_attach_type, link_create() jumps to out without logging
> "Invalid attach_type.\n".

Will add a log here when adding log support for tracing link_create in
the future.

Thanks,
Leon

> 
> Should the program type validation and attach_type logging be ordered so
> that unsupported program types, -EPERM failures, and expected_attach_type
> mismatches report accurate messages?
> 

