Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=91.218.175.73
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795501597;
	b=2IecgM9nHTybfiS100fFketLlcuZduSFhqLga8WHad5f+qJPRF/XqsATOfpD41OhNfbb
	 mms7Vf7Huqu9IBHGoVXSDOd0HVvn2ZHpZoe0gNQAVsVGKNe4z/H4TsTxY56nQ6ON7tq7a
	 OKXXlyWqxPpHAyzFYhsQhWtZRwakHaG6HnblepNUiVEN5NGs6gvve8xO98EAer93iw7zv
	 mSabYlK3M1r5w5TWtUEZMkRHYNX8vE2EGOH8fuDYSwiDSb8Dt5vTXDU89I6tJBBs98TTX
	 J5wKisnud7cwyflm4vU7uuNN4h/6udJXdg7/szTcdCfbEvJsyK0VatPvUahMV60irFQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795501597;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding;
	bh=mpZM/PApUCXYk+waULQ6V1zgWo4rHEBgYCIeZURGF+E=;
	b=k+xGdh8VFZsCsVulcCq3c4mO5vnd9tPRItEvhpHZY6DnjBJ5dxanAYNj0PqcG8HgN4hI
	 hyn2WmY8jLuuCjhfR51skDwXKL2nOoqvyJbmsFvJQycyVGuBNO03gm5NzIi2CPEh1ItAH
	 oJRSoKcnQdSVpxvt3AMhZaznnIKYtJk+t95BjmH0nuQdVnrDM8Z5pMTQRMCBofGyMr62p
	 72N2IU61ABIhLhYFh4adoPhTMHhk6h1e9kb4abODxU8EiBMFK6DUvLANWpSw41i8mJHjo
	 pAM8d7kVgxhODaCbTiqLp9lX5RzZ03XBHZjax5R9FS2voe7WM0VsbktdHm0FqhgJOTw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=YmGBDj8l;
	arc=none smtp.remote-ip=91.218.175.73
Received: from mta0.migadu.com (out-73.mta0.migadu.com [91.218.175.73])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D096F606A335
	for <linux-trace-kernel@vger.kernel.org>; Tue, 24 Nov 2026 06:26:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D096F606A335
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=YmGBDj8l
X-Envelope-To: linux-trace-kernel@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=DGfdq0OFqBVtrTdkcH+vMb5rQtWobPUwx2DZTPEMh9M=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1795501595; v=1; x=1796106395;
 b=YmGBDj8lInFrOZ8biCXiQ+G4lZAhpA2vel7x0klHTOB8oz98hZw0jNFE+G2DTnwZ6WuGbQKb
 AcrTzTvnlW/iaDc04Epy6bmDZ2T+K2g8vx4SsTlySSpu7bPF3yJShkm0ceMlZGMGChqxZhdo0iq
 OMn/IUNCABo+6tL6TZ+mxXVA=
X-Envelope-To: linux-trace-kernel@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id bce02c2e5679289a;
	Tue, 24 Nov 2026 06:26:34 +0000
X-Mizu-Trace-ID: bce02c2e5679289a
X-Migadu-Flow: FLOW_OUT
Message-ID: <36c2f179-1bbd-46b8-9d67-f2726f959cf6@linux.dev>
Date: Tue, 24 Nov 2026 14:26:31 +0800
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
Subject: Re: [PATCH bpf-next v3 1/9] bpf: Add log support for tracing
 link_create
To: Jiri Olsa <olsajiri@gmail.com>, sashiko-reviews@lists.linux.dev
Cc: bpf@vger.kernel.org, linux-trace-kernel@vger.kernel.org
References: <20261123152743.19629-1-leon.hwang@linux.dev>
 <20261123152743.19629-2-leon.hwang@linux.dev>
 <sashiko-outbox-229589@kernel.org> <awS5qgoIeSAheK-w@krava>
Content-Language: en-US
From: Leon Hwang <leon.hwang@linux.dev>
In-Reply-To: <awS5qgoIeSAheK-w@krava>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 24/11/26 06:09, Jiri Olsa wrote:
> On Mon, Nov 23, 2026 at 03:38:47PM +0000, sashiko-bot@kernel.org wrote:
[...]
>>>  		tgt_prog = bpf_prog_get(tgt_prog_fd);
>>>  		if (IS_ERR(tgt_prog)) {
>>> +			bpf_log(log, "Invalid tgt_fd.\n");
>>
>> [Severity: Low]
>> As reported by Alexei Starovoitov on v2 [1], should this log "Invalid
>> target_fd.\n" to match the link_create.target_fd UAPI field name used by
>> the other log messages in bpf_tracing_prog_attach()?

Will update it to "target_fd.\n".

> 
> with this fixed, the tracing_multi changes lgtm
> 
> Acked-by: Jiri Olsa <jolsa@kernel.org>

Thanks for your review.

Leon

