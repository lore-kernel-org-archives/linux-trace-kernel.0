Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.181
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792637852;
	b=qD3bAgZfLgvK51aM8wqj1LdDnQypz5PLcpjIILb5Q+UPMEfnj1PeaYQsK1gcZPm4218K
	 res6GuFwSCuuEbX3ZVneMyurWYh1lmzPcb7aYa9rwGEIsZ4QeLiLkjm+lQ8w8NPEvNaWy
	 Fa4z7rlOAJ0jJ2goxj+DJSZfIvQIAwSw9sbaz0hY4JkFNCrRFhyn9uRrFJydN78pS6TIs
	 JJ6iPzR+8qlB5bh2GXSVJpjxWQQKEmfBl06G6Cj/cy9EHTJiPX49iHQyhTHtWo2dGC0bQ
	 lyPeg7NtQQlnMHgG6P0q5rh0WXxV/ZFDoUzyozVznGE5OQZEKs31GXyZDR2Z7QAdOkw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792637852;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Subject:From:To:
	 Cc:In-Reply-To:References:Date:Message-Id:X-Mailer;
	bh=jbCDllRU5wYbKPFOhnGrl1xB/avA24qTnso9VdtaQCs=;
	b=0IMoIIQS7dQL/M2PAU2Ig/OulX1rOryNgQEChTHJr8ddbMSAc9BI1k/lHQ9FvYiQshr5
	 X74LKJnZVh98QUqpcbyoNMdaavd3RYNHKBpbSYyZeYIdUWKhDu2QY6WJxZZDzBPf4rNlv
	 YJ+jeLKE42ZE2LW+ucMyhCmnOUZlyaOY0qm5Azg7cWLpq3jmsxfhWL6PxDref6b/B2Dgs
	 qRDVkCCu0+FuSsmyX3CyulyNdSOvyltq/SvYPxh+TPk2tpiRyLKiGqWw/i8ffPI5jMyLX
	 n74ZLbr2ONHYXIqwLoutanOPCN9KNnmzBMwZhRTCNCqIvr+EXIg6s+U8/FgqfScoOkQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=gourry.net;
	spf=pass smtp.mailfrom=gourry.net;
	dkim=pass header.d=gourry.net header.i=@gourry.net header.a=rsa-sha256 header.s=google header.b="koa/V6Uj";
	arc=none smtp.remote-ip=209.85.222.181
Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E017606A319
	for <linux-trace-kernel@vger.kernel.org>; Thu, 22 Oct 2026 02:57:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5E017606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gourry.net header.i=@gourry.net header.a=rsa-sha256 header.s=google header.b=koa/V6Uj
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-93e63ee7b4cso160238085a.2
        for <linux-trace-kernel@vger.kernel.org>; Wed, 21 Oct 2026 19:57:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1792637850; x=1793242650; darn=vger.kernel.org;
        h=message-id:date:references:in-reply-to:cc:to:from:subject
         :content-transfer-encoding:content-type:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=jbCDllRU5wYbKPFOhnGrl1xB/avA24qTnso9VdtaQCs=;
        b=koa/V6UjBswa4FuSyaK1aj7mCWWDpckd3P8cm34TWWyRP4wzh2NLGZFSH6Q4M4DXu3
         qzvnXX9HeaVR6rcKzXOZbL4uzEnVmqZL+MMzzyWUGBG2X6ItbpmKYvjiIE7ZPOD6pDdX
         PykgPTns0Qtfo8nduMQ1sHSyApXHEviCMbeUO00ZvHROPMI86Ykmx6SQl+abfVMyiKWf
         CvkbnJxDfiv3XJxFjZ82pcIdZyeNVZqTP/ETC6T9H+76M973HmqPv2qbgfT+YBQjViJJ
         TAOrklU+ENqV10WidZ/pbmFlwYkvtftj2K/YJxpRPZem9Bu3acDn5HeG7eCd8A/aUPfS
         BT4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792637850; x=1793242650;
        h=message-id:date:references:in-reply-to:cc:to:from:subject
         :content-transfer-encoding:content-type:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=jbCDllRU5wYbKPFOhnGrl1xB/avA24qTnso9VdtaQCs=;
        b=YuNYd/MfVy/xrXoBRX5fwHaWOx3vf5B1nI0moKkfsGdPruAQIvmfggh0IjzzlTDc7z
         mxELGwaOqF1YfRbYOSgIf9d5eXLSmKgiqEiXWUlFFQuBqMfnOZO6iEV5KuReEGooIVk2
         jaOyPz419SXlhgyr8jEa3EXYtu2cEDdkUzKQtjWQ7U7QPsip2tlhmYI3Jt6lJzIS/C5+
         +aSHosFCPYhxI7jEjpMYgPRxQ7f+iINP1K4wIBOGoLQRB4YwZgrOYJRtYPP0vH0kfjqo
         1VUy4B/6oUqN/cuZXxCvnw8wsxDp7swC+cl2PAuYw17rnGZDbk7VmymKquaw+kQcmd4F
         vvJA==
X-Forwarded-Encrypted: i=1; AKwUvBw/w6lRZ4l4vvFwDADDBR/GFIkiR/UxN6l1kuzSDwh0Qcdr4cCOSYzcbpC6BsAd5Aky5SbAClWpvP81v4x7d4guG2w=@vger.kernel.org
X-Gm-Message-State: AFq9FYJhZH9opyRS8c5PCz4nx9inNfJ/LrTBmTFHUZgE8YzPlKExAGgo
	aPD0orXr/KDXA7J2hG8QRttW9TYehtQavPajY4N7IQmD1OiJBzVfPznLLzfVI5k5d3s=
X-Gm-Gg: AYBFou3O3P2bIsIS+ykjUxUBh71dZzivnHA0S+sEXxSkQRKTpKsGCIsAPgJqvLC5Gx2
	OTl+2yLMazlG4BYnhH3Y1F+cOSH+chb2d7Cyo9el6D5WLTTr6nunqpi/wupr1t5PGCsZ6bhwbNm
	Y5aNzZkih9bCFp04v2fe6eCkCneAYHTnG5ey9y1rwWszoawqo0bP5Zkcyhh6dW/5IdsyjaNlKuF
	TMZwIsuB2bNN3TtjHE29Wrk9cPGAkBcb5au/aV0VDUzgxocX8GiQXvaLPDorBHxlj3rMgqIOGFR
	aIh1zFFi0ZLA1QTK7ZB0Q/p6O7I4crRQfAxyj+HNOt77LE8JLbdjOcmvHScwW7sym8MFcyyi3Yl
	Y7IjNT77m3wLejw/QQ1BOuhi4+H0cVTFe+9HcGqL6FjNfrM28h4sBI7ZB8hCYOTt2Bn6LoFtbBr
	O3dH1hmsncwlSlHY3H8OHYspzO2usRXWAPcIq81llIPzZqv8WjGiXp5lm5DP8WRIlyq4V1Xasj9
	ZiiTHVPM71sICDWifSXejWsMREfS1pS21DLLdXABNU6ahuJjm9nrkRBmfLVjxSfeoBIjcPlbzSH
	V6QaQ5O2lZMHBZ5+nj5NTbQd+uc=
X-Received: by 2002:a05:620a:2415:10b0:93f:5cc0:5978 with SMTP id af79cd13be357-93f5cc05b2cmr353949485a.37.1792637850409;
        Wed, 21 Oct 2026 19:57:30 -0700 (PDT)
Received: from [192.168.86.58] (pool-173-79-60-52.washdc.fios.verizon.net. [173.79.60.52])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-93f56e30610sm406637385a.43.2026.10.21.19.57.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Oct 2026 19:57:28 -0700 (PDT)
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Post: <mailto:linux-trace-kernel@vger.kernel.org>
List-Help: <mailto:linux-trace-kernel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-trace-kernel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH bpf-next 3/9] uprobes/x86: Finish an unoptimization
 which failed half-way
From: "Gregory Price (Meta)" <gourry@gourry.net>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf@vger.kernel.org, daniel@iogearbox.net, andrii@kernel.org, 
 eddyz87@gmail.com, memxor@gmail.com, oleg@redhat.com, peterz@infradead.org, 
 mhiramat@kernel.org, jolsa@kernel.org, akpm@linux-foundation.org, 
 liam@infradead.org, ljs@kernel.org, surenb@google.com, david@kernel.org, 
 vbabka@kernel.org, jannh@google.com, hughd@google.com, kees@kernel.org, 
 mingo@redhat.com, tglx@kernel.org, x86@kernel.org, 
 linux-trace-kernel@vger.kernel.org, linux-mm@kvack.org, 
 linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20261022015712.1297331-4-alexei.starovoitov@gmail.com>
References: <20261022015712.1297331-1-alexei.starovoitov@gmail.com>
 <20261022015712.1297331-4-alexei.starovoitov@gmail.com>
Date: Wed, 21 Oct 2026 22:57:26 -0400
Message-Id: <179263784614.2549665.557126403507804820.b4-reply@b4>
X-Mailer: b4 0.17-dev

On 2026-10-22 01:57 +0000, Alexei Starovoitov wrote:
> From: Alexei Starovoitov <ast@kernel.org>
> 
> int3_update_unoptimize() restores optimized nop10 in three writes:
> 
>   48 8d 64 24 80 e8 d0 d1 d2 d3    lea -0x80(%rsp),%rsp; call tramp
>   cc 8d 64 24 80 e8 d0 d1 d2 d3    1. trap new entries
>   cc 2e 0f 1f 84 e8 d0 d1 d2 d3    2. restore bytes 1..4
>   66 2e 0f 1f 84 e8 d0 d1 d2 d3    3. restore byte 0
> 
> uprobe_write() can fail with -ENOMEM, or with -EINTR when the task is being
> killed. When the 2nd write fails the result of the 1st one stays. Byte 0 is
> a breakpoint and it works. But the next set_orig_insn() doesn't find lea in
> byte 0, takes it for a plain breakpoint and restores one byte:
> 
>   66 8d 64 24 80 e8 d0 d1 d2 d3    lea -0x80(%rsp),%sp; call tramp
> 
> Nothing recognizes these bytes anymore. The process keeps the call into
> uprobe trampoline, which can be unmapped already.
> 
> Teach is_optimized() to recognize the half-way state, and let the 1st write
> of int3_update_unoptimize() skip what is already done.
> 
> The failure wasn't reproduced, but the state can be made by hand. Attach to
> nop10, call it to get it optimized, write 0xcc over byte 0, detach.
> 
> "uprobes: Don't sleep on mmap_lock under dup_mmap_sem" needs this. There
> fork() removes the breakpoint from its mm. When fork() is killed in
> the middle register_for_each_vma() removes it for the second time.
> 
> Fixes: 554ba38456da ("uprobes/x86: Move optimized uprobe from nop5 to nop10")
> Signed-off-by: Alexei Starovoitov <ast@kernel.org>

This was a nice read.

Reviewed-by: Gregory Price (Meta) <gourry@gourry.net>

-- 
Gregory Price (Meta) <gourry@gourry.net>
