Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73C7D175A66
	for <linux-trace-kernel@vger.kernel.org>; Sun,  3 May 2026 19:52:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777837923; cv=pass; b=qB7TUM3IVEOeqQPnEdy8uYc7QoqWFIAog9UcmelZIXPo/8Ts65jccQQFIGh0izG4F7xlniyU6ozQEQcjYUVN7elsARbEeX8rz01YYE6puIDVFw+tmubQ5RD+u2xXhuGLBeqOAx8gTbm3KH+ZcZLlwdwC/GgJ7uJ/XgVdnDMz5mc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777837923; c=relaxed/simple;
	bh=DltqfY2DnqkS5mXlCZEDd0aLOzaByEF9OWsh8VyUvms=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lRV4p8Dm0OLVhTtULbAjyo9e0WS7/K4q4eRRGxcCBdaJmM2fT5M2twmctKor8qz9xRE4rxjwRXYcdjFUFw87iczYnxcFick6Ww3AGH/6/zc/aHgl5A5t41vMz+PNwGJHUEoLc7AwvrfpHXtfmweKNnbkcz6FyaaT42zTs5L48DY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mnYzhCxg; arc=pass smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mnYzhCxg"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-48a7fe4f40bso35566795e9.0
        for <linux-trace-kernel@vger.kernel.org>; Sun, 03 May 2026 12:52:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777837921; cv=none;
        d=google.com; s=arc-20240605;
        b=HjSNad1gWAMRJhyY4Ywh0tminIyFpxlaAgNZstg2tfOAX2d+mD7rVc8B8GFwM63MNL
         pxLQHDSxHoTdZ7tZi+ptHNVbdL1PhWc5Cnr101v6GebAZl+ByKy1ZZrrE04M6Vd44DFD
         5K/7eAqlvh48QMiHtwZrrO49uYfge+S9dyPwSJLXgHxKlb770TobvVn8nX1vprRfdNuL
         IJ2MwblZg/vJ5BGpJWCHh7wTV69YQuyO1+087dcx4t/JAqH58txQ4g0PeZd2828MLFgR
         o4FARAWSWI/ynp0xMZ5X7ZeHhQogf+Qwoh7Bx8a1v0W2hAIAo1pey19anb3lsr3/ml6E
         umyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=MO9uxptEOBu74fEJnlr1X6LfcN1QpYq+iJ0FUEQHje0=;
        fh=LDgTSqFsR/5skCV5E/oWwerU9QoJ7c/n3rcVCrtUSfc=;
        b=YuvmOM+v/6qy0EFt2okHP4G73IOeK5JEF9855n7LzVYzy3NUSUI9Rn7gS2m7htRo1v
         pD6WkOuwXlvzdGWfB0KlFv/Ip6S3HE6BxabJOWMnKzqnhXzS9RkelCL+l4TGgA/3BoGd
         1XvfvHcKQUGHPzZ8WAeLrBerQ4KaoN2exE6p6QSxZoguTuiOqHxDFiFrTQLgxGXKgx0u
         lyK4lM1nEyu8exFgj3czExnLupXm7XVoUnKFWKEp49Rw+1fHpFJS4q+Aq1mk+fm53vUi
         CbAHla+kavISwrZ4jmN/bUaUQ4QkQW5jeToh/QJ1jVHOejODW6+sLRenkcBx8WhZRorF
         RAaQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777837921; x=1778442721; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MO9uxptEOBu74fEJnlr1X6LfcN1QpYq+iJ0FUEQHje0=;
        b=mnYzhCxg9ZE5p69V7X/lqJEUe2kCAhwAxQJ1giuRnRKVz+DiN8OId20cXjYE5M/iCe
         3V5/gesbbRDyF2VY7+UPLRXGNOw44Z3zAW4r/ieaY/MrLxjrnryc6StEr8+yEtG1Pzp5
         zQaWntW0ecnxt//PTRNA0SIXUyjIQfvsiLQ8LLBuFG65V0v1wuHbB2ZVXv8LLDqxFx6A
         UqafEtQWKq7gykbs4uA9Z5l04KDIHhHtyaZZkZXpt5NUuwMIZ95fUuXunE33pEm2cOvy
         RrxB9abW/lm6zPjBIb99VdA32PcZZoFfvu2iob7bkJs0FLpVAgbXuyHmo2snCjs2vN5A
         ej/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777837921; x=1778442721;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=MO9uxptEOBu74fEJnlr1X6LfcN1QpYq+iJ0FUEQHje0=;
        b=GDtQkXteSaZtt6+MCGJCRLn7tl3ACkViE+FnkfS4kRUUbX/NEeIjN+aB9KnM5Z9p8C
         /Q2AQ5IXVYaK5+6sAG+ew4kQxduu093/M+tX3mZb4e2Ggt+dJpPvrtY8niYAW6S2rvEd
         KHIgNy4ZG0H5SAkLnTFpzW23jZZdWaAnlFizGQZ0945U+WDA/MkV/QsydPiJ/TFk0kzG
         BuCwCDFXtAB+QFAqVfYVPblbAQVZkNWcoxNbTmET7UBnyxhe9GvR8SRastkNJhs7ab88
         U7uVqx9CXr3bufpC46qmf3tydru+CTupeR91tnNLCcNVxkoOdnigEpYbUUr9WGm4vcr4
         kBcw==
X-Forwarded-Encrypted: i=1; AFNElJ8LsYjCL2iO+ZKm57EIaSg4iuG+4RSPtZlrmztJWwgbcySrSnqPrtphFsYnmCvZRLMXkjKrkXaJYp8QK585VPqf5wU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzSkVgMB5UAcG5gERw3OZ3Rj/17A6yToUJSdEOYVImnE+vPB5x1
	mf/Jp7tNX/smwJ42u+HlcT3FYW89TbamcSGhnVcIZEfTclhYVhI3WLjMsAXlVD+RZ8gOWNT7LGb
	QfORUMQRBBCY3ssT/1S1SXW227tkjmvQ=
X-Gm-Gg: AeBDiespZbX7c63JG8xwjBeEC8nKFTlR18YiX2mOE+ILffxp5fnQf/+znY/d5CXMMjS
	UAX8mTrcdP/meZ6Rx7dL1/tKn0SKe2IqyKS4rZvXP2S9FjVJkwfeo+P7xxRSQFjxXxuNS8WyEUM
	ADFfDHTm3QKr4T83/h7KGfGJ83BftPskWCEzeziQjlG66EGWXTGO4OTVZCqBlG6yUWLWbHJzTgI
	lIhGuXBWbsj3BK8hxcuLJqydUYKJ2pD842cYDi4PQQXZxPoGHfLNPLHKJ2u+lopV98ya3O3n5gX
	JyZJTUOwoVxY+tSSmiRJnpXyuCq1xy3W0t/97nx0V5uU8VE2ZiRSQJY1VPCvYBSdV15OnxOj+Yy
	ildNg6MpPhDIKUw==
X-Received: by 2002:a05:600c:a402:b0:486:fba7:b150 with SMTP id
 5b1f17b1804b1-48a9865f7c3mr85772745e9.15.1777837920657; Sun, 03 May 2026
 12:52:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260503164700.548164-1-atomlin@atomlin.com>
In-Reply-To: <20260503164700.548164-1-atomlin@atomlin.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Sun, 3 May 2026 21:51:49 +0200
X-Gm-Features: AVHnY4KCwOHSaSmah7QMZOP4tTai9ZqkBy8y44nUZiuECcF2WDS_Y4gkXYfZBao
Message-ID: <CAADnVQJ5fatNF4auH+a8E39zWMfja3rm4BM_xGcTnLX8uuCQ9Q@mail.gmail.com>
Subject: Re: [RFC PATCH v3] bpf: introduce TAINT_UNSAFE_BPF for mutating helpers
To: Aaron Tomlin <atomlin@atomlin.com>
Cc: Jonathan Corbet <corbet@lwn.net>, Song Liu <song@kernel.org>, KP Singh <kpsingh@kernel.org>, 
	Matt Bobrowski <mattbobrowski@google.com>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, Eduard <eddyz87@gmail.com>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Steven Rostedt <rostedt@goodmis.org>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Shuah Khan <skhan@linuxfoundation.org>, 
	Jiri Olsa <jolsa@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Yonghong Song <yonghong.song@linux.dev>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Randy Dunlap <rdunlap@infradead.org>, neelx@suse.com, 
	sean@ashe.io, chjohnst@gmail.com, steve@abita.co, mproche@gmail.com, 
	nick.lange@gmail.com, "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, bpf <bpf@vger.kernel.org>, 
	linux-trace-kernel <linux-trace-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, May 3, 2026 at 6:47=E2=80=AFPM Aaron Tomlin <atomlin@atomlin.com> w=
rote:
>
>  struct taint_flag {
> diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
> index a3c0214ca934..34b25609e72b 100644
> --- a/kernel/bpf/syscall.c
> +++ b/kernel/bpf/syscall.c
> @@ -3083,6 +3083,13 @@ static int bpf_prog_load(union bpf_attr *attr, bpf=
ptr_t uattr, u32 uattr_size)
>         if (err < 0)
>                 goto free_used_maps;
>
> +       /*
> +        * The program has passed the verifier. If it utilises unsafe
> +        * helpers, formally taint the kernel now.
> +        */
> +       if (prog->aux->taints_kernel)
> +               add_taint(TAINT_UNSAFE_BPF, LOCKDEP_STILL_OK);
> +
>         err =3D bpf_prog_mark_insn_arrays_ready(prog);
>         if (err < 0)
>                 goto free_used_maps;
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 69d75515ed3f..9d56082a2ac1 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -10287,6 +10287,14 @@ static int check_helper_call(struct bpf_verifier=
_env *env, struct bpf_insn *insn
>                 return err;
>         }
>
> +       /*
> +        * Flag the program if it attempts to use mutating helpers.
> +        * The actual taint is deferred until successful verification.
> +        */
> +       if (func_id =3D=3D BPF_FUNC_probe_write_user ||
> +           func_id =3D=3D BPF_FUNC_override_return)
> +               env->prog->aux->taints_kernel =3D true;

Nack.

Please stop this spam.
We're not doing it. These helpers have been around for a long time.
There was no need to taint then. There is no need to taint now.

pw-bot: cr
