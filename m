Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.216.41
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795090429;
	b=YBnuOMDHNfJPRQDDYBzEESXG7chcfMMjbnOiQIUaIkbJx669R7a8FewIJictMLGgWpkO
	 1H+oAbMzJJi1biNo8NTGJuzlmaN7+vrZ4Rk2L5yS7a9cwfGMZ3h+OvPc+lHbhe+HMd6in
	 F4V3TEz7PyYa/K8MxHgaBEIeuBOwJx95KJquBpYXnX0hFTMXiAuxrrYVBim5kaTJJD4uD
	 t5BYaK0cOuIIINbPjM9w+jVl5gzF/UaoA4HuNcASMGxtxzwLnGvZIeJ6YR6sHhKFqAXQh
	 WzT+YGyPRLPMIhTZ8rtRND+j3uU3RhwGhkSI8aWDAUCyJbv8TmqfCZGheQIflxPcYzA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795090429;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=JbT2l0hVPosruCtl/bxiI9ZT4pAz+/Pr6yTWwpIv1+Q=;
	b=3oS83VBgAf02hs1q7OzYJvt8w2mpe8z7tjCoXG0jURNYqpX54hBLBo0P0gt97coCHqAF
	 Td/Sb6r8dwjdey/g+wFneMvmT6R1IVxKw8pe7Nl6BqDkALObrSnxKRDio9w33qM7r2kkN
	 h/dx53geKHs59BRa3aIdL3sV8vHkCZ83Bs7ym8W1LrTBHkUsuOOBdLlIaqCacL+OpfBQR
	 TDCSKub6FsYdl1x4dh3OdpUuUItMBlsXpYFOevspKsLR2HbmYmqVPmTQXEpmarsWbCPDK
	 7VIVtDS7UMrwKx7pVe9uCTQWnKdObDrPTmtIvO2Yk1SUKgRArBvqNRIhOi86vG23Kfw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=sentinelone.com;
	spf=pass smtp.mailfrom=sentinelone.com;
	dkim=pass header.d=sentinelone.com header.i=@sentinelone.com header.a=rsa-sha256 header.s=google header.b=inLLQQN6;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.216.41
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8F06606A324
	for <linux-trace-kernel@vger.kernel.org>; Thu, 19 Nov 2026 12:13:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D8F06606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sentinelone.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sentinelone.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sentinelone.com header.i=@sentinelone.com header.a=rsa-sha256 header.s=google header.b=inLLQQN6
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-3b083afebe4so282678a91.0
        for <linux-trace-kernel@vger.kernel.org>; Thu, 19 Nov 2026 04:13:48 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795090428; cv=none;
        d=google.com; s=arc-20260327;
        b=CWxDvK/6I+KXCMWuFdL5ai91PnKtqOszM7bsRVISzCnupSSdZNCKvlLTocnIlZfFK0
         hVn1MBh+ebFW8K6rECB9xJCS9gMeRbkJ0iTJDSg3iEIlYZCfqgOfrHVPloobXngsnFUL
         lpPDjcAefAj93k6mWF1LFuEv/U7RiRNgYlykH/NYPFS0S9fyftaAxgt026FDjVblbrZM
         jPuVJgnC3eekTOZ/WHPdTwSLZJlyr8fS+pcB2fj59KoOb6zlPUiOrNCdJpPuvLHy6j74
         UYShSQvEKZKBNIwVdXA+iqCrQkg2k59yG1dMh/OiJ/dmYtLNBjQnXsSc0wwCaoY9BAKC
         yQ1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=JbT2l0hVPosruCtl/bxiI9ZT4pAz+/Pr6yTWwpIv1+Q=;
        fh=vnXJCjs0krLHVFfyAskt6ZogU9to3Th0Z/qAfNONRGo=;
        b=hfOBUjEPTL6nK6uKsRx5Wdvc/3l6Visk/E9KbjDp8C1rFeo0Z0tLOaPD05GFuRkNj+
         JJNUuthm/CYHCk9cVaZ9UaTS2N5xQzWh7eZm7u2S4tPkmOdwzLhzg+W8N82Ay24crh41
         7lYBLi3s2SPwqiqTPUEzLTfB1zKYYrXjz0QLE8/PvJxh4scM4/61yMF/weDRzdMBAp32
         dmu5DQMeN+QKjTM1016WniTXMlOq5EDy+DJvJzklkMDzT57htRpLRwswS/BMuucB1Kbd
         7oJjC7ucbP8QQthM4+pwhIPmMH7F84RpqeaMEORBVCOe6QEYa9+JGMriAU4Izw5IwsV5
         B2UA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sentinelone.com; s=google; t=1795090428; x=1795695228; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=JbT2l0hVPosruCtl/bxiI9ZT4pAz+/Pr6yTWwpIv1+Q=;
        b=inLLQQN6+oyuRpEFmArfNCzpH2ozMRZGx89k/DACqwt11IvxS2uk9OtFmBLo4Vhr4J
         V04tDyjCtChQCMDg+Z0yurrLdLqxBvdkqoQ4yirXWIDrydA7i5COBE+0solb87kLt7dQ
         BamkEF9vbM8R8qAwhkfuZZHMK4QC397FjZQQNAjNa0eDoqfTF1Ax7RC8Fp6GjNu4oSx7
         1mc8awM26ZHak6n8f0rMVtyqMPKhGdWnJypjWZJXKS5VQd17VjONQ0CQfcoxeddyjYmf
         boLx2SRKNBMM/GjEMeYOtSlqhrOcgCl4AV4k7HzYNmibRCx9/H+XYfT1eASGaNsK57GH
         BwrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795090428; x=1795695228;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=JbT2l0hVPosruCtl/bxiI9ZT4pAz+/Pr6yTWwpIv1+Q=;
        b=fwJCV//0UVncI+1MrgdC4zD5J5/L6abb2F+tKrwtckwuNiJJocWAqDA23dUqql3+lH
         wEfcvEA4tiUrJjwPUdqzCR9tUhEvT3R9GjC4huZyQmAAgbzCdgzhYFKLlNXhQBYmVBRo
         06ns78JpLmQu1PBv6F8jFYGncZukHAhgjg6DBeKr77lUuN1XUryeB2x8u2ySGLC1o0GL
         DHoCiVY+k7wvBffEZ2mVFfFHgk+EOsmacyllVU0LpiNptH3vtdxSQ3jtLr2WQkS4zWL3
         RPWe3KQl6FIoQ/KqjZ/+L5j7csDTsWYaQdeGuf7LX3VOQnIemFk04iYN1h+ralUKCEiR
         uFZQ==
X-Forwarded-Encrypted: i=1; AL+hErHwW1amlfGBWDpZcjneRc0ZMT9IW2mjBbpTwbwjia2D9QugfTPxK2pl5KCGlNDAl+B9dI4sXnEXqEaoQIr/lAvd+xo=@vger.kernel.org
X-Gm-Message-State: APuU4Z8DfkUrW8Ss6upJW1216jRtRuiy2AjykrNZMxgGUYlWz0yT+9v6
	d63WrghjonvAhkIiRXRdPwvTZeXEYqDYPTQkCZJ8DOkYq071T8KQQb9qZ0i/a89gOwfX8dUUBl0
	6e+DuOuB5pfioV2LNUk5a/3uNjrUj4F+0SQ5R5CYuKQ==
X-Gm-Gg: AZFdTZfr++b1Bpuoig2IIh+op2fsoqJDp3ZUGaOP7/R9sCXuPKg/czCSeFlQ+h+IGex
	8EHBpv1wlzYo9kAZCII2xRerXFIi6Su68hS14O1KE6TUttA9UV5ylpOfwXiT5ABkkq8LtGUrCKD
	ciwBr64ztZoJ0q8caJgcItM4xzFjhr+LAZP9gd8wAhPaLkyAUrDcIz4YwwkFdHOs4uRv1Zdxkm1
	EtgwwGrSlhldZNTYsARQ2E/NcIUkTkrStSlMhsR/c2WScy37xLhY43S0MLpjtZHss87H/zxpT+t
	w/PqvJ8RMoH6TL6MHIFLG582PHaVYvJeAVUbeKdNTiHI76jjtaMGLWtb7NBxUYlh9OZYAHljGVK
	+ylcUr4FBlqumIMRMcWOLr4iGLCEjNc2hcQ==
X-Received: by 2002:a17:90b:4a84:b0:3b3:c107:8458 with SMTP id
 98e67ed59e1d1-3b3d07d54b3mr9810306a91.5.1795090428106; Thu, 19 Nov 2026
 04:13:48 -0800 (PST)
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Post: <mailto:linux-trace-kernel@vger.kernel.org>
List-Help: <mailto:linux-trace-kernel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-trace-kernel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261117-bpf-preempt-v2-r2-v3-0-586376ec3672@sentinelone.com>
 <20261117-bpf-preempt-v2-r2-v3-4-586376ec3672@sentinelone.com> <e3ed9b2d-7778-481b-ba85-2ac3ac5de877@linux.dev>
In-Reply-To: <e3ed9b2d-7778-481b-ba85-2ac3ac5de877@linux.dev>
From: Mike Bazov <mikeba@sentinelone.com>
Date: Thu, 19 Nov 2026 14:13:50 +0200
X-Gm-Features: AclHuK-Tue_GiMxMNcBIIEZsjERmHRrqNIXs1mIZQ207vV9T_xJnd-gwW1o_iI4
Message-ID: <CAPnbwjq7TDed+f6dTDfQcdLSZtV=AwDiLVpBK2t7ke6vpngSpw@mail.gmail.com>
Subject: Re: [EXT.MSG] Re: [PATCH bpf-next v3 4/4] selftests/bpf: Add
 preemption recursion test for tracing programs
To: "JP Kobryn (CrowdStrike)" <jp.kobryn@linux.dev>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
	John Fastabend <john.fastabend@gmail.com>, Emil Tsalapatis <emil@etsalapatis.com>, 
	Ihor Solodrai <ihor.solodrai@linux.dev>, Steven Rostedt <rostedt@goodmis.org>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

> > +   return is_jit_enabled();
>
> Any better precedent for checking this?

I found none. Unfortunately user space can't ask the kernel for it.

> > +   { "fentry_s_percpu",    "on_fentry_s",          PERCPU_MAP,     B_DROPPED },
>
> Is it worth covering fexit, fmod_ret?

They enter through the same __bpf_prog_enter_recur() as fentry, but it
is two rows each, so adding them is minor.
