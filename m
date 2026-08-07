Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0A9941D110
	for <linux-trace-kernel@vger.kernel.org>; Fri,  7 Aug 2026 08:19:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786090783; cv=none; b=H2AXkuoLKlIuJG0C9gK4BkMasBS9tPsi55xMnxfEj2xmC1o5mxVLzWFj3VCtUR7V9Hf7/2MO0mLHb4wN+d0Ef996MTPlBwBKIVuMIx5jvV/xyifibu7OabUyNvMlUnc0uJ1Vs4Bjg5cuckPqsqbhsGuXZzm61Hg/8ystftBbR38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786090783; c=relaxed/simple;
	bh=8lyBm9Wm93qDz42hxXXkdlccFQmsPzGQYDQhxrJxKW8=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lTfUvHsAW1Mtk78XM4nePAJOfYbRH9Sd9dK7oyKw8HmtJ7mkuiK10DFwsxE9+tpXTB1pkIWvfRXMGfdUqhZ+D75jZOEwvm+bCitgattambv3ich8ii/3/Ca2h8Bh2u0OH18WIAuwy+UVUXoQ5bta91JxYWPCU3TjR9iKZSPK4YE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C4Q6zPW0; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C4Q6zPW0"
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-47f633e6058so2606749f8f.0
        for <linux-trace-kernel@vger.kernel.org>; Fri, 07 Aug 2026 01:19:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786090780; x=1786695580; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:date:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=qieJb84NY/DGIyJFPREzT33jCTD11yTCdeI153UvP3Y=;
        b=C4Q6zPW0imL8i+4ZlJv8dhtubAV51gfBrV2vd706K2DAbnOsomN0GtqGFA4s/FceEw
         sHlSirW4x+NQfKSx0mZEL/yd73PSEQNRVrwF9vUZTECVdrryZNkK8q8KVbQai6SWE2/+
         YwMU+vFWdhnEjQagl5OitKNjq7qyOPX2wJhg3aK1TT65cc0BN1BDKsmlSgMWXZtTpVH/
         HUmS++JlBE/iYeGSprKPHGrkOsLHx/TjRwYPGnmm8aCI8d0W/Dj+mb8loWvzhQ5PLUa0
         ZW33++s3IVnxYW28T9nEYgXIB1sYl7cdG6wutO2pUpsgalH0XapHR68jL3lasTDHzzTB
         Lr2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786090780; x=1786695580;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=qieJb84NY/DGIyJFPREzT33jCTD11yTCdeI153UvP3Y=;
        b=TN7UPjBbi9AOGssxyPOl3WzlMvk82UOUdW9tMhTa5Aa7CKOzSboqvOgqZJzlEMfcFB
         4Gf0XqyWmpVELTXfnwOhYPKi0wwQC/mKGOi2EijhBpiIYVpJWGUOd/Yc4V3MDopH/Q+Y
         5JGDO/uUphJPkBrC5EYqoK6S3b1CSonxqsoqSs1xbi9UetUuYhZ/5Nq5QuSBqkv4AjvT
         6sSL6rA2S5jHGyEPWxM5NrLc5SHU/NZqJIRn9sOACLX4aVTmBEqn/WincbE1AaEK32u4
         QF8L+TxE9md2CIUBogyyIBlqZPcJcpBMU2o2TYww4Co9jIQYZxPvog/15pBLKt79UpGY
         lOBg==
X-Forwarded-Encrypted: i=1; AHgh+RpDRHru4Oo9+jQatB5eV7ofg3XLEFFSHaxFYK86My4vw8r23a2Knm5dGMLasrqBfdC5rmoBnsRSI7Se3WRUbZ1Ri1o=@vger.kernel.org
X-Gm-Message-State: AOJu0YyjsV+HrUOo7YiD8TRzVWOvy+xgOPI7dtGHovt2KKGUAP40bqsH
	avRAI/ijSZ1/8YniZtx6adJsTulWSaCp2Bb6yvqCbRhu+3qiM/zZxyh0
X-Gm-Gg: AR+sD13KY6/OA0uAv8o1n0cxf4eWBMy0pj8o345NXMt8FUT7OcYpffkg7LPABJq2uYI
	UzylnWbZJduQrwZZ8E9WUOxqdixM9Qoo8uwwr9LehqTbQd28UK4di8LB6dY8U005ZJJg2dDUXNG
	7qRE391m47odhvEQw7tKGuaattKsORT1Wtb6jrEg7j6VaQJO0UnC167+1fhVpGdrYLjzbRwfUOC
	IyNodrMgh0gYyItrUI3B/wqX+OnLjBu+pDwXb08fs6NE4bBBq7U8Z2/YbXWVWUNa0/jTiQLNYoG
	adV1syPOwHjdLoSWObkVdH8tBBDSr997vwCZXeZqCXt3vNYUQRkr/s2XPIjXljd5A8fxEePmhDS
	rO1HyH3RNfM/Wh12eezDX8Z9W5DUi5HbAM6vhprysC2XbFxkCd8beHDHLnVaUDDY9EIf+zItRsM
	aCoXbb2NcHm3xQAgINkDbDx145oU17sR2YSw==
X-Received: by 2002:adf:e001:0:20b0:47f:e721:1f77 with SMTP id ffacd0b85a97d-47fec51f260mr26165338f8f.13.1786090779619;
        Fri, 07 Aug 2026 01:19:39 -0700 (PDT)
Received: from krava ([2a02:8308:a00c:e200::cded])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48002150952sm3057648f8f.15.2026.08.07.01.19.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Aug 2026 01:19:39 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Fri, 7 Aug 2026 10:19:37 +0200
To: Hui Zhu <hui.zhu@linux.dev>
Cc: Jiri Olsa <olsajiri@gmail.com>, Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	John Fastabend <john.fastabend@gmail.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Ihor Solodrai <ihor.solodrai@linux.dev>,
	KP Singh <kpsingh@kernel.org>, Matt Bobrowski <matt@bobrowski.net>,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org, Hui Zhu <zhuhui@kylinos.cn>
Subject: Re: [PATCH bpf-next v2 0/3] bpf: Fix UAF in
 bpf_trampoline_multi_attach/detach on update failure
Message-ID: <anWVGT_M1H49a0HX@krava>
References: <cover.1785902527.git.zhuhui@kylinos.cn>
 <anRE9L9HgOIYVCtj@krava>
 <4a6ee31b46b732eaad76b955d95c8cc261941894@linux.dev>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4a6ee31b46b732eaad76b955d95c8cc261941894@linux.dev>

On Fri, Aug 07, 2026 at 02:00:11AM +0000, Hui Zhu wrote:
> > 
> > On Wed, Aug 05, 2026 at 12:04:05PM +0800, Hui Zhu wrote:
> > 
> > > 
> > > From: Hui Zhu <zhuhui@kylinos.cn>
> > >  
> > >  This series fixes several use-after-free issues in the BPF trampoline
> > >  multi-attach/detach error paths, where ftrace direct-call updates can
> > >  fail and leave ftrace pointing at freed memory.
> > > 
> > hi,
> > I need to stare at it bit more, but tbh I'm not sure the benefit of
> > preventing hypothetical crash is worth the extra complexity on the
> > detach side
> > 
> > IIUC we can't reproduce this error without instrumenting the code, right?
> > 
> > jirka
> 
> Hi Jiri,
> 
> You're right. I went through the failure paths and the realistic
> triggers basically don't exist for a normal user:
> 
> The allocations are all GFP_KERNEL (reclaim + OOM handle them),
> and bpf_jit_charge_modmem() lets CAP_BPF callers exceed the JIT
> limit, so ENOMEM doesn't get there.
> -E2BIG is attach-time, before cur_image is set, so no UAF.
> SHARE_IPMODIFY -EAGAIN needs livepatch on the same function and
> is retried in bpf_trampoline_update(); the multi path where it
> could escape needs a second failure on the undo del, which doesn't
> do ipmodify negotiation, so it doesn't reach the UAF either.
> The rest is bugs or not user-driven.
> 
> So this is fault-injection territory, and I won't claim it's
> a customer bug.
> 
> I'd like to drop patches 2 and 3 and the prog-side machinery
> (pinned_prog + rollback + the trampoline leak).
> And keep only the one-line image-side fix in patch 1: only free
> old_image when it differs from cur_image.

right, that one looks good

> It's obviously correct: if cur_image == old_image, ftrace is still
> calling into it, so freeing it is wrong. And it costs almost nothing.
> 
> Would you prefer I proceed with just this single patch,
> or drop the entire series instead?

also we can change bpf_trampoline_multi_detach to return void
and drop the WARN_ON_ONCE on that call

thanks,
jirka
