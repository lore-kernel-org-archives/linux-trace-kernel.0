Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25E7743E061
	for <linux-trace-kernel@vger.kernel.org>; Tue, 11 Aug 2026 11:06:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786446406; cv=none; b=VqiAYU4mS7c+RksUPhLmPyALPk0+7b0dbj5ONHNkfnXV/mTKFZhaaTvWRT+uHsLqiQ9oJllMO2WrPEHmRcZykX+h1VI6VAejdfu8pTFsdOMJUn1Cf/7ufYkgk/aKkLRu1ZylYLo3cGGNcBHefmCEv12rc4wZjgvM7slNF1UtlBg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786446406; c=relaxed/simple;
	bh=tukP0gFXkGjbkkO6Sate91Hwdk6oZ5TQM06hGsQvC+U=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m+s3sxUafsSweHtS8Bb7b1pHL1ZFWAKyCWSB4dP9I8lxfr+IsNjiLlnvZr0osbGW0o6RUMB2bROTqPzF+o0eiEPd6J0s/831MDmKmuwx/CmmJt3XPx1hkOgdtL5dRuQx1lMUr7eFupSVOgSTr5YP1fvb13l9Rm7TbNqllZUf1LE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PxtFFuBV; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PxtFFuBV"
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-c15c42a45adso126713766b.0
        for <linux-trace-kernel@vger.kernel.org>; Tue, 11 Aug 2026 04:06:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786446401; x=1787051201; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:date:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ncPBKBVNM6ovNcsCic32cHugMXoIYOhz070STPXc4TY=;
        b=PxtFFuBVzA94mCJ3JJ759NJiepI34WbXGkeLbqFaW7SIkE0SYvZzAEJdTw33amsc2q
         LUxSByhQxUvt2EnFnbM4ezb89uRIwnb0fZEwO/N1bY6doD+I8hqRErZnCj4tf9Ipw1gd
         2jxWYffv+nLchU+5A15QXk4yhnseUNksra+DF7eDGzhywISBNhhjEtQhvkLEWqzgkrgW
         C8IsJl22qBLJ8TzT0hPsyoyMVjL8j0eBpLzjftMOj/yqTlzUy0b1ofTJYmnJDSwOox6N
         /TR/C5373pAFSlJ3kW+c9uHzNnVOaDWEeDX2ZBN0ChTTJc957HCZHGcYGldW8IabYuZP
         uNsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786446401; x=1787051201;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ncPBKBVNM6ovNcsCic32cHugMXoIYOhz070STPXc4TY=;
        b=nJtwHJBxs5S1ctU4VG5FV7rcFd4KMbcXJRYidxBILRsrTR5sTs+P2NZLx4b8A34TAJ
         vr2rWtNBrzfPHeIECaMdHUkZOh3r705jrneTJsYW9+vmVqxvAY/QGibPM0tDH/wBYzzi
         pps9sMxmoZAGae5DZiJWBQOeOpbaOHVZEGhO76o97fZ+zPSTo4Kb6RERZb0Nub7nE5Vr
         uWd8hvj5Wa6GfPwUk6NeMiXEcdxA+BRAwK5IMrHoOSc9htzuSvAPxfqVlnFV1FZHRSiZ
         XCheCaupXnxUUVbj0xLNdD4RWUdmlZIZ3Pqt3A/YTtlK/uaW1r9R+o3Dr0KOewENVEBl
         lvPg==
X-Forwarded-Encrypted: i=1; AHgh+Rpu8uEAAjViqsCnMMDBFfVW19CHC+vQJtKR6tjF27C6CNaCPB5r3zbBMO7rQdx4BP50WpfRvabGUkNXCbz/7fsVWGU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwMOvz+7GCK1n7upYpoZlsQyVyb1t9RZJe1wVNKHFxPs0cAJFGQ
	CydyhLt4UzaOPIqpROw9MBI49JAvF3vSldj1aC/xnDnuHzr1t1GBmmMg
X-Gm-Gg: AR+sD129ER7OfurlirRGBomtFL2pj6CuVeXnDYrDwNzMiwH90WJvN4lLpqdFbHtnQYK
	tgzAlAbVSIXqmyfl20RyFcR4BHqLDfi87TJluSIWtOgvmFBEQVyzc4MO1V197IucF+Tk/tmBqmb
	Z7bsXdaOI0oazTWmDj9t9uvJCfRLHYVFd6IdjbH7BXbHRw06xeJ9QGOxLT/yqeSTJFrn8k1VvJT
	u9cofP49Q1Y2o3UD9oW1aFR4wwVEhU8SAt7TVG2v73P2MRUmvw5hma1q7gI+f6jmcZ5Lcbb9X03
	XpNOv56wNtzGwZlLPyneQCJh2lAH4SogHMxB7kL9BbdpTlBsNa+R4Zbo0991djlCVvJw24tNeuU
	l/IUFAGLInrqJDyXRzvV1NQAzdKMhcd0Km5JO95RPxR3MZnlkJ9JOzGVMayfSRVD5YPP29sX4g/
	vwhos7eMA+ps6AuH/T6ECcjCbmNRjVr8z7lWx65lv6+8drrP46pv0FR1OVqg==
X-Received: by 2002:a17:907:3e0e:b0:c19:5bf1:368e with SMTP id a640c23a62f3a-c20e5ed6832mr106791266b.13.1786446401261;
        Tue, 11 Aug 2026 04:06:41 -0700 (PDT)
Received: from krava ([173.38.220.33])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c20e414ddadsm37804266b.27.2026.08.11.04.06.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Aug 2026 04:06:40 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Tue, 11 Aug 2026 13:06:39 +0200
To: Hui Zhu <hui.zhu@linux.dev>
Cc: Alexei Starovoitov <ast@kernel.org>,
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
Subject: Re: [PATCH bpf-next v5 0/2] bpf: Fix trampoline image UAF on multi
 detach failure
Message-ID: <ansCPw7KqDWQ4s5N@krava>
References: <cover.1786412280.git.zhuhui@kylinos.cn>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1786412280.git.zhuhui@kylinos.cn>

On Tue, Aug 11, 2026 at 10:46:18AM +0800, Hui Zhu wrote:
> From: Hui Zhu <zhuhui@kylinos.cn>
> 
> This series fixes a UAF in bpf_trampoline_multi_attach_free() where
> old_image is freed while ftrace still calls into it, and makes
> bpf_trampoline_multi_detach() return void as suggested by Jiri Olsa.
> 
> Patch 1 fixes the UAF.  Patch 2 is an independent cleanup that
> changes the return type to void and drops the WARN_ON_ONCE at the
> call site.
> 
> Changelog:
> v5:
> According to the comments of bot+bpf-ci, split the single patch into
> two: the bug fix and the return-type cleanup.
> v4:
> According to the comments of bot+bpf-ci, add Fixes: and update comments
> of bpf_trampoline_multi_attach_free.
> v3:
> According to the comments of Jiri Olsa, drop patches 2/3 and the
> prog-side machinery.
> keep only the simplified image-side fix in
> bpf_trampoline_multi_attach_free() and make
> bpf_trampoline_multi_detach() return void.
> v2:
> Folded v1's two detach patches into patch 1.
> According to the comments of Jiri Olsa, Pin the prog (pinned_prog) on
> cur_image so it stays alive while ftrace may still call into it.
> Make bpf_trampoline_multi_detach() return void.
> Fix the same UAF in standard (non-multi) trampolines.
> According to the comments of sashiko, Fix the prog UAF in
> bpf_trampoline_multi_attach() rollback.
> Leak the trampoline in bpf_trampoline_put() when cur_image is left
> by a rollback.
> 
> Hui Zhu (2):
>   bpf: Fix UAF in bpf_trampoline_multi_attach_free on update failure
>   bpf: Make bpf_trampoline_multi_detach return void

Acked-by: Jiri Olsa <jolsa@kernel.org>

thanks,
jirka
