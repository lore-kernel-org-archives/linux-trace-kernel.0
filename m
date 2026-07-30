Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C20B40860D
	for <linux-trace-kernel@vger.kernel.org>; Thu, 30 Jul 2026 10:58:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785409113; cv=none; b=o6RbDw4Uu7Aim6yZlCaGkpys6PTZX3gd1dzOdEC8nvRR5Ok0N6CqlurE8Q5HezbNSaz2sGO6nJ+grjplL73KKF4U/CXo3BLDqcnXk7VGy4eiQ+ZJzZyFkW1jZLv6ReJOz7b1AtsZDpkFrx6L5qbheUpVvnPCXNCn/PuaBsSMwCU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785409113; c=relaxed/simple;
	bh=OUZJe9ibUbTY3/iskfpej3snXo+kezysiy+SxHFR7w4=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Nqb+aDE9xnzRME5DCr9mjOcuo4WSo1bhzdHV+FDsPDtJQ302c//0pAlaAl8m5pobWXIPH2tN/ZT10nVAEkrRCzIRr109yYZrYY0tk+nwbi2Dry3aOltJNTtma1kS0OFPH1VtBWkZBk0x+iZsRHqkREVYuLMmr61nnpdueqcSLWI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=p0mjHqGu; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="p0mjHqGu"
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-69fec980a30so2175317a12.3
        for <linux-trace-kernel@vger.kernel.org>; Thu, 30 Jul 2026 03:58:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785409110; x=1786013910; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:date:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=BtmEW6LmpN3hbmzYM7Cf4iCPw5cw70uOQWik1DIJVKg=;
        b=p0mjHqGuHmE4rHDrfSwM/V0o+jJpbKJ7EJO6fvpk+LTEC1E/PoFtOUISPW/6oQIWxp
         CszJci8hAV4UeJeSWR9WG2mJ77RujcSGRnrgVYLbFNjCHBiYmQNM9CTO+si5Vs9M9YRI
         JqJBktYIKXYOQBl82moIa0O6XBc8w1X95iloT2zFsb7oe2gdkMNDw5skKO+kpbIQ8x0I
         ATSktbcUXeQdRajCoLvE5G3Kqb13U3EKsReQRc7PxFqF08BUfIJ8+qQQNQctKCIPfDzw
         9PMceRqdnZoVj3E6xXO37Zm1aqbaYgrMxG26zUDPTa23Mv/+k2oB2TYx2RpwY2havJ/e
         vV0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785409110; x=1786013910;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=BtmEW6LmpN3hbmzYM7Cf4iCPw5cw70uOQWik1DIJVKg=;
        b=gXCvlxs3nbv08La6307QuGixdCgh8YBCN7N77UIbuladcimqHf45L+dO6oB+tXezqv
         oNexBm7lJmUY8P/rEckFQyFJb715Pw+yvY3GN9340cZxQZF6ABDHObEM7pc0dfoVGYDd
         aNrq2bQ5A00G8H1K+0Oyr2FlV5qzfpTymCc1PVscq1lakLIcF1FwHpcsfnUaIy3FBwWF
         tLhK/KVqI/p+Dlat1b6wHvSeGm2tesRChf46lFePXVdz1UCuySKklH8X8rP/VNwXoEih
         8CIzDcl7JipCLBKs+XFX8jyDJF/CqFRgLIuMypoboo0Dh0UBakSGRQNsWwGY212GmCrg
         0LsA==
X-Forwarded-Encrypted: i=1; AHgh+RoRcKioZ3CPgNWI3MlB5+4vPG2u40u5ufI1DTwA9JYVQcerU9Hw1vynNN1As+t9cug0D0x3PXJ3vZdwW+0Y37uga6E=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy3SWkPfiZLxPvaHYpPkwNC5hmihQAjMUzDnOhpPtSXyVNQr7UX
	at9FWbQ1EeCl74smcmGeor9R7xCUz+gQ9qwieu7vzMMj9szhJOsr3b7Y
X-Gm-Gg: AR+sD11SdFkvlb1QeE0Ou4m5MNZWGmLhxciftZyt3EuRgk07NyB4yjS5+Cm7clE4jb6
	haCccqXKXBxmCxo09VTkhI2ERLsYjBTNw47YS/rO4kqtVN6tXZJnD3+E40hN9leuM4PIFbpafFJ
	2rov8GsxidKKiF4w1435N5mh10BqncPS+DJ7RstSVn3w8JsKABnxz8KLd88pz5s01YUZXBtPVxm
	j/Kj0ZGb1vaGtYtJforeiW/quUCo873nUcaMXJGO5SCdrarczjAWAqSwFJHGKvxwVuj2rNIvYt3
	EXkbLTI5Vr2aFydnDSrX4rZYQVJQCKDK6vzZno82/SBLSRo83cF3dFbQk1OSO5xelq0+zyAfLXi
	LDYHbQpXhPRFtUX+D+87a1qhqbzK4mkyXTJBzFAIX8QXl7AagY/x7E2WHwKc0cgs7SeGJojrEaX
	3s/3wlFeSi38CE/SSf1MttxFbVVZ7VFmcn+j70N6/Gas99NlE=
X-Received: by 2002:a17:907:9443:b0:c1c:4afd:8d8c with SMTP id a640c23a62f3a-c1fa558e48emr104613966b.14.1785409110114;
        Thu, 30 Jul 2026 03:58:30 -0700 (PDT)
Received: from krava ([173.38.220.35])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c1fa8578015sm55934266b.18.2026.07.30.03.58.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jul 2026 03:58:29 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Thu, 30 Jul 2026 12:58:27 +0200
To: Leon Hwang <leon.hwang@linux.dev>
Cc: Jiri Olsa <olsajiri@gmail.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Shuah Khan <shuah@kernel.org>, bpf@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH 1/2] arm64: ftrace: enable single ftrace_ops for direct
 calls
Message-ID: <amsuU7eXuoziObdh@krava>
References: <20260727142844.21212-1-leon.hwang@linux.dev>
 <20260727142844.21212-2-leon.hwang@linux.dev>
 <amnqXeC6D4mjcAe_@krava>
 <d745ca80-6516-4c61-8107-88c6a2d9cea4@linux.dev>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d745ca80-6516-4c61-8107-88c6a2d9cea4@linux.dev>

On Thu, Jul 30, 2026 at 11:05:42AM +0800, Leon Hwang wrote:
> On 29/7/26 19:56, Jiri Olsa wrote:
> > On Mon, Jul 27, 2026 at 10:28:43PM +0800, Leon Hwang wrote:
> >> The BPF tracing multi link updates several direct-call sites through one
> >> ftrace_ops. Its implementation is therefore gated by
> >> HAVE_SINGLE_FTRACE_DIRECT_OPS in addition to
> >> DYNAMIC_FTRACE_WITH_DIRECT_CALLS.
> >>
> >> Select HAVE_SINGLE_FTRACE_DIRECT_OPS whenever arm64 enables dynamic ftrace
> >> direct calls. This enables BPF tracing multi links on arm64. Also
> >> generalize the unreachable-trampoline comment because the single-ops path
> >> does not use ops->direct_call.
> > 
> > hi,
> > iirc arm needs ops->direct_call for trampolines to work properly,
> > that's the reason we enabled single ftrace_ops on x86 only:
> > 
> >   424f6a361096 bpf,x86: Use single ftrace_ops for direct calls
> > 
> > I don't understand the arm usage of op->direct_call, but it looks like
> > (codex thinks) that the fast path won't always work without op->direct_call
> > being set
> 
> 
> In theory, op->direct_call is the fallback for the case:
> HAVE_DYNAMIC_FTRACE_WITH_CALL_OPS=y, out-of-range target, and non-BPF
> direct ops. This is what Codex thinks about.
> 
> However, after searching the call sites of
> register_ftrace_direct()/__modify_ftrace_direct() in kernel, which would
> set ops->direct_call, the actual callers are in bpf/trampoline.c, which
> have been gated with HAVE_SINGLE_FTRACE_DIRECT_OPS. That said, for
> normal usage of HAVE_SINGLE_FTRACE_DIRECT_OPS=y, op->direct_call is unused.
> 
> If someone uses register_ftrace_direct() or
> modify_ftrace_direct/_nolock() outside BPF in the future,
> op->direct_call will be used.

so any 2nd user on the same function triggers the slow path,
and that's fine, the single_ops handles slow path correctly

but IIUC the out-of-range target will now always go through slow path,
which in current code it doesn't, right?

jirka
