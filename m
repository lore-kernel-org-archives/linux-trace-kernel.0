Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E7A13F65E0
	for <linux-trace-kernel@vger.kernel.org>; Thu,  6 Aug 2026 08:25:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786004735; cv=none; b=SNB61rYYCFb3agUwF6Mpy/IW09lxx3LP4FYeezbjSskTsEsN1HOnSFYccQ0hMUvBvtRMouXQUTpwlNkh91PhrnlOYTQSgkUGhs9tBjxQ0zzJ1r0gkUVnVf5DeVyqXHGvYMVq/tj9i46lJZR7K4VZbNBoJg9o0KSV8929cbSD4lo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786004735; c=relaxed/simple;
	bh=u35Fy/c9miFYfgIAMw9Zs68VFVkBNddOXa7Gm6zG6Qs=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YatGfKWxY+vIuo6f9JdIbGlygdbc0ASGWl71lL6ef2AtgMJvCXgoWltA0FYAAGXFjpRLYhM0j3+hXgIepTmZ84+kZnMa3nySEAS6NCi+f4UXmO5cheFz0BDFEcaF3mXy8uoqadjbhmQ0aW6IPkdkBzt+Cv4nD5C2F+zcWk6x7v8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A/SgNqn5; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A/SgNqn5"
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-472326ca506so1291109f8f.2
        for <linux-trace-kernel@vger.kernel.org>; Thu, 06 Aug 2026 01:25:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786004727; x=1786609527; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:date:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=mvEGOYhp2CQZEcmymy9RcBUGgQ1zyWQcWI1QHnYNDi4=;
        b=A/SgNqn5MrMnrzwkQmrGmIqBHX6pOS5ZTHVuTDX7cSam+mSSrFw9ftKQ/GeoLsjvw4
         kKUjwh+jOqnYlUOQaVmGQsA2SmCOZtzCn2wyR//zp3Axb+/sbYTQMfR2tmWLW5VoruHh
         bhQVuIDur72gPuwR0aL1r0AY8AfvQnhKYxKkX0aev+kvD7vtqzGDTIFJcKAzWKMLJU+1
         CuNUCFqr+Do50uQSlD0QkgUkjhA0ueMUvQVCQ6p3+WZSiLN4CR+Dx75N6HNly31QQDNU
         oWTTA1waAMAOUVCCCHZQEqXUMc45pWHOXvo+yb4dBIlAw4QDP/QZwcQMCVkshgXYsGlv
         P/bA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786004727; x=1786609527;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=mvEGOYhp2CQZEcmymy9RcBUGgQ1zyWQcWI1QHnYNDi4=;
        b=EmWHEt6uPp3aD2Cn6YKLRUIU7ogCWComa63DWIXur85upR1iPBfvkPj9ERivZQnBPG
         RxEzxsOb/rZw/Iyu6CtDaq4dHW0Aiig5cTGbMuDPFOhrZLt3bw5+9zHbL/jgQ6GLish4
         e9RNYGOL5qr4iXgh6Mi6LCBwO8y4O84mXmCIiO8iWZ/FDxIW46xLniwyQt4KOasgOC6J
         ReBdY0OL4NJm+rgerTm/c2x1w1D0RnVHomzhnYEDQB0+If/BaP1yPqvSOdHjjW+ICFP3
         VgK/kBSkiPvdSydyfTdpvecVr929bXMQ9TRUMZEzSDIHbni5lWG55afy8GxzW6v/8lOV
         dhGg==
X-Forwarded-Encrypted: i=1; AHgh+Ro1tFTZhVI5gu1mdOsBBIMKwQcyx9wwT98DEwBGk5e87jxJNe6Ujdy/Eq7Eh9whpcolLrGXpQmxHxdR+iodJnNoQeI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxdZc7d6HBVvD/kh7wEVit9MgncM9+offGL7yXTmIQrsU4puSGF
	2UJHrUn/GjNzcuJFNV6AEgKU8cOQ0ZpAP0S+NkEOLE6raj63R517rYJ2
X-Gm-Gg: AR+sD11CknvBRWrht9YaX7Dx2eNu3fwJ9c1KhNQPrqGX9GM5vMnticrEc2xBfqJd7Cc
	EoS4Q2rEP2T79FFtW1cnMO3fltww/mQ/Y6FpS4en5RdEx3zNL8mycYlNrvyBQN4hRFpDmsaBdJU
	EX6j4p7C2W1KTm0CFA6iRp5Z/JzxJx/jLEDGtsUZqo6ygqzZiJq3g07YSM1hduOU25SQBW18vQC
	hQWBXv+LS+OCgYb8siaG0ff6pMNb8bXcmZH781K6GX+CBtPzJbz98+OmMqze4I5QGOUAdEbVP5T
	zMgbOxRhb3dJUiybQI+AVuTiOnD2vEgCpph0Rp5fup9pCrodFCwnQoYDetGCUQ1kv4qzxyFtROH
	EvMsSOqKd7BWJ9fh4epGff02mxvcrJztj1YFJvhEkAejJS3DkaLYile+AfXr7/lmjnsFUcEL1t6
	eU4BzYepGlE8jWgtmgewXwn0LUo1fND/QqOu04Imjqdgjw5hXzHnR7ICuxU2wfE2usOj7VmYs=
X-Received: by 2002:a05:600c:a45:b0:495:6478:2dbc with SMTP id 5b1f17b1804b1-4994e73cc5cmr165920225e9.6.1786004727128;
        Thu, 06 Aug 2026 01:25:27 -0700 (PDT)
Received: from krava ([176.74.159.170])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4995421934asm45858475e9.5.2026.08.06.01.25.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Aug 2026 01:25:26 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Thu, 6 Aug 2026 10:25:24 +0200
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
Subject: Re: [PATCH bpf-next v2 0/3] bpf: Fix UAF in
 bpf_trampoline_multi_attach/detach on update failure
Message-ID: <anRE9L9HgOIYVCtj@krava>
References: <cover.1785902527.git.zhuhui@kylinos.cn>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1785902527.git.zhuhui@kylinos.cn>

On Wed, Aug 05, 2026 at 12:04:05PM +0800, Hui Zhu wrote:
> From: Hui Zhu <zhuhui@kylinos.cn>
> 
> This series fixes several use-after-free issues in the BPF trampoline
> multi-attach/detach error paths, where ftrace direct-call updates can
> fail and leave ftrace pointing at freed memory.

hi,
I need to stare at it bit more, but tbh I'm not sure the benefit of
preventing hypothetical crash is worth the extra complexity on the
detach side

IIUC we can't reproduce this error without instrumenting the code, right?

jirka


> 
> Patch 1 addresses two UAF scenarios in bpf_trampoline_multi_detach():
> the single-point unlink failure path (old_image == cur_image) and the
> batch ftrace update failure path. A new pinned_prog field in struct
> bpf_tramp_image keeps the bpf_prog alive while ftrace may still
> reference its image. bpf_trampoline_multi_detach() is made to return
> void, since callers cannot usefully react to failures, and
> bpf_trampoline_put() is taught to leak the trampoline when cur_image
> was left behind by a rollback, so ftrace keeps a valid target.
> 
> Patch 2 fixes a similar UAF in bpf_trampoline_multi_attach() rollback:
> when the register-path undo fails, ftrace still calls into cur_image,
> so the prog is pinned on cur_image instead of being rolled back.
> 
> Patch 3 fixes the common __bpf_trampoline_unlink_prog() path, covering
> both multi (bpf_trampoline_multi_detach) and non-multi
> (bpf_tracing_link_release, bpf_shim_tramp_link_release) callers.
> 
> Hui Zhu (3):
>   bpf: Fix UAF in bpf_trampoline_multi_detach on update failure
>   bpf: Fix prog UAF in bpf_trampoline_multi_attach() register-path
>     rollback
>   bpf: Fix prog UAF in __bpf_trampoline_unlink_prog() on update failure
> 
>  include/linux/bpf.h      |  20 +++--
>  kernel/bpf/trampoline.c  | 183 +++++++++++++++++++++++++++++++++++----
>  kernel/trace/bpf_trace.c |   2 +-
>  3 files changed, 183 insertions(+), 22 deletions(-)
> 
> Changelog:
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
> -- 
> 2.53.0
> 
