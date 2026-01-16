Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B71A11FE44A
	for <linux-trace-kernel@vger.kernel.org>; Fri, 16 Jan 2026 23:32:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768606362; cv=none; b=jA7JoDYwGGSXCQ0/q3r9H76LdLt/M8cT/V6Tb0UYYgUP1fizqMJpVoY7eQT9ii6cjJtPBoJ3lJnfA11DeZMZOGFPTdyo7/H1O3Y2urmPuGq9Bh2sKc7g5ywEcFt8tiqgWgT6Soui8g0powCzmghCD0tk+UGhqZNL/LiEh9zzF4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768606362; c=relaxed/simple;
	bh=rbU0Ec3qolqeBsR3hF2aJMN1Q9BuTISIrNELLPer1N4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dvJPQ9wkPURI3N8KfQJtMIUkEffJ7KIzFIb9jVSq4fHBqAkDScN88ccYnalqMXvd8zIkgwf4BI2FXXY7/9xgm+U/ZMVrI3n0poL/7QEdKJdWx3j5rpA+/DlNq5BkUO1/zzseE8ds9EIW0Ky+Y02CtmBL+nBdAKg8NACjwZz9RoY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ca9X1np0; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ca9X1np0"
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-81f3b4ae67bso1433764b3a.1
        for <linux-trace-kernel@vger.kernel.org>; Fri, 16 Jan 2026 15:32:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768606359; x=1769211159; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hxwaLDTifIMkxC3a8V9Jl/ujC0CmnleZHGaCm/O5euY=;
        b=ca9X1np0bmOQ/ThpxnDlsVjLK2guo04mOP5nnizwwVAwlo94guktxXhj/gW+40rCo9
         3fAUdhjuwN7mmxP04FHHfuHDExSQqjJYUuHi1eCOkeTS0Nb8h/zWShzLGYNHJLczWjX2
         Kyi17b4eVMpoXClYt+u95TGLGzIVqDeDrNaqICZa0Q2XuDodgYWlAoPp5H78pByccX04
         /yds7pzLpT/a3rWK8GxMHqaO3OXF8MXmXnKlLVUEebz+ESw1UDlERshF5SUxls2ZPUin
         GEvZ6iI0d1qVSwOTHls79Bsqdye/lnSgUSka9a+sf84M8LnSpeUH1yGH3reDjAvfF118
         /W0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768606359; x=1769211159;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=hxwaLDTifIMkxC3a8V9Jl/ujC0CmnleZHGaCm/O5euY=;
        b=jjXXo9NsUnl3ki8qRtOobHRpZAZNqQP7h5k4Y44Vqs5KUIqtLOjbHGOub2S7dhDrJH
         yUWAv1E9EiVhBCWAVpvHSifdX7J6IdAM1b8ilD5aa6oDrJpYJ0WzaP6bfJuzqoAGl7dm
         RaT+U1jTdJCdshrhpRe5Jv3C+AVmyRi9wPSFAZUXEqL0CHGmU10v2HFcElywk9UvbhqX
         Ku/golk1K6h09iApmqVWTkcw+X+jBLbL8CdmE+GrZUSEWeNRX+vlRrcsQpbldgeeIJ9w
         iO6lrj7mmfs11JuN/4rZNqS0J3Vz+ckFxhWVmTihVzmOlxHdPoHPNoa4Ot5JVzg1ySEb
         MJfA==
X-Forwarded-Encrypted: i=1; AJvYcCUyKNeeaILsydsUwmdM0kXdyWn2j/uwZbhvwFO78zvRhqs7J005qDKiUcwam3G/IyFrA3+d0/uWcB2joOqZ0dDlZj0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzzbajprJuu9Zu4E7QA2HlSn0ODuk0SSjio8t3hMlJBTi6JC/AW
	kt5u9K2iO3aoiDzZ9BRr5xhI51hewHTy1Bps1oJhpEVDHm0Jdi/XIkbHkzviY8dKBaHbcGyZrXE
	c9KuyrKM4qkUtCLMGMi4ODl2KljisK0o=
X-Gm-Gg: AY/fxX7znHd4SWY+JrjSt3mMuQFu/GAjckLJtof0qdGFIWEjktcxPgeC+e0Bbu0JPVD
	C5Ctzes22O1MM2xBIvS11yWlKcnhP8iLaF22nj/l+p9RH2b06heXrRWroE+aiiZrklc3DwiZqRp
	k3sVMlqY++nfUIUFgDwyUN3m2WyBTOvTbKGJJoFuJMBujX/GQs+vgO2BbTEKGV18OOI+2AMs7p1
	4FWGerVkcfw9L0zWrvAPJZpzEnVDOuB2gDTYkVnDsWKwfK8DGA2N91umCZA/nNFNzEyQh1ZqWaG
	NECVwYbYXeg=
X-Received: by 2002:a05:6a20:2450:b0:366:584c:62ef with SMTP id
 adf61e73a8af0-38dfe7d602cmr4683917637.65.1768606359122; Fri, 16 Jan 2026
 15:32:39 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260116071739.121182-1-dongml2@chinatelecom.cn> <20260116071739.121182-2-dongml2@chinatelecom.cn>
In-Reply-To: <20260116071739.121182-2-dongml2@chinatelecom.cn>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 16 Jan 2026 15:32:26 -0800
X-Gm-Features: AZwV_Qi5xMILd7AmhFW-B7lhQbG7DhtbslRYqmhbrnR6u-Ay4k1SgXWUfLoKSPE
Message-ID: <CAEf4BzazwvaLVy+4SByCt0cvkOm6eNSmDmGBfUM8u9scFseGCw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 1/2] bpf: support bpf_get_func_arg() for BPF_TRACE_RAW_TP
To: Menglong Dong <menglong8.dong@gmail.com>
Cc: ast@kernel.org, daniel@iogearbox.net, john.fastabend@gmail.com, 
	andrii@kernel.org, martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org, 
	yonghong.song@linux.dev, kpsingh@kernel.org, sdf@fomichev.me, 
	haoluo@google.com, jolsa@kernel.org, mattbobrowski@google.com, 
	rostedt@goodmis.org, mhiramat@kernel.org, mathieu.desnoyers@efficios.com, 
	bpf@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 15, 2026 at 11:18=E2=80=AFPM Menglong Dong <menglong8.dong@gmai=
l.com> wrote:
>
> For now, bpf_get_func_arg() and bpf_get_func_arg_cnt() is not supported b=
y
> the BPF_TRACE_RAW_TP, which is not convenient to get the argument of the
> tracepoint, especially for the case that the position of the arguments in
> a tracepoint can change.
>
> The target tracepoint BTF type id is specified during loading time,
> therefore we can get the function argument count from the function
> prototype instead of the stack.
>
> Signed-off-by: Menglong Dong <dongml2@chinatelecom.cn>
> ---
> v2:
> - for nr_args, skip first 'void *__data' argument in btf_trace_##name
>   typedef
> ---
>  kernel/bpf/verifier.c    | 36 ++++++++++++++++++++++++++++++++----
>  kernel/trace/bpf_trace.c |  4 ++--
>  2 files changed, 34 insertions(+), 6 deletions(-)
>
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index faa1ecc1fe9d..422d35c100ff 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -23316,8 +23316,22 @@ static int do_misc_fixups(struct bpf_verifier_en=
v *env)
>                 /* Implement bpf_get_func_arg inline. */
>                 if (prog_type =3D=3D BPF_PROG_TYPE_TRACING &&
>                     insn->imm =3D=3D BPF_FUNC_get_func_arg) {
> -                       /* Load nr_args from ctx - 8 */
> -                       insn_buf[0] =3D BPF_LDX_MEM(BPF_DW, BPF_REG_0, BP=
F_REG_1, -8);
> +                       if (eatype =3D=3D BPF_TRACE_RAW_TP) {
> +                               int nr_args;
> +
> +                               if (!prog->aux->attach_func_proto)
> +                                       return -EINVAL;

can this happen? can we have tp_btf program without attach_func_proto
properly set?

> +                               /*
> +                                * skip first 'void *__data' argument in =
btf_trace_##name
> +                                * typedef
> +                                */
> +                               nr_args =3D btf_type_vlen(prog->aux->atta=
ch_func_proto) - 1;
> +                               /* Save nr_args to reg0 */
> +                               insn_buf[0] =3D BPF_MOV64_IMM(BPF_REG_0, =
nr_args);
> +                       } else {
> +                               /* Load nr_args from ctx - 8 */
> +                               insn_buf[0] =3D BPF_LDX_MEM(BPF_DW, BPF_R=
EG_0, BPF_REG_1, -8);
> +                       }
>                         insn_buf[1] =3D BPF_JMP32_REG(BPF_JGE, BPF_REG_2,=
 BPF_REG_0, 6);
>                         insn_buf[2] =3D BPF_ALU64_IMM(BPF_LSH, BPF_REG_2,=
 3);
>                         insn_buf[3] =3D BPF_ALU64_REG(BPF_ADD, BPF_REG_2,=
 BPF_REG_1);
> @@ -23369,8 +23383,22 @@ static int do_misc_fixups(struct bpf_verifier_en=
v *env)
>                 /* Implement get_func_arg_cnt inline. */
>                 if (prog_type =3D=3D BPF_PROG_TYPE_TRACING &&
>                     insn->imm =3D=3D BPF_FUNC_get_func_arg_cnt) {
> -                       /* Load nr_args from ctx - 8 */
> -                       insn_buf[0] =3D BPF_LDX_MEM(BPF_DW, BPF_REG_0, BP=
F_REG_1, -8);
> +                       if (eatype =3D=3D BPF_TRACE_RAW_TP) {
> +                               int nr_args;
> +
> +                               if (!prog->aux->attach_func_proto)
> +                                       return -EINVAL;
> +                               /*
> +                                * skip first 'void *__data' argument in =
btf_trace_##name
> +                                * typedef
> +                                */
> +                               nr_args =3D btf_type_vlen(prog->aux->atta=
ch_func_proto) - 1;
> +                               /* Save nr_args to reg0 */
> +                               insn_buf[0] =3D BPF_MOV64_IMM(BPF_REG_0, =
nr_args);
> +                       } else {
> +                               /* Load nr_args from ctx - 8 */
> +                               insn_buf[0] =3D BPF_LDX_MEM(BPF_DW, BPF_R=
EG_0, BPF_REG_1, -8);
> +                       }
>
>                         new_prog =3D bpf_patch_insn_data(env, i + delta, =
insn_buf, 1);
>                         if (!new_prog)
> diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
> index 6e076485bf70..9b1b56851d26 100644
> --- a/kernel/trace/bpf_trace.c
> +++ b/kernel/trace/bpf_trace.c
> @@ -1734,11 +1734,11 @@ tracing_prog_func_proto(enum bpf_func_id func_id,=
 const struct bpf_prog *prog)
>         case BPF_FUNC_d_path:
>                 return &bpf_d_path_proto;
>         case BPF_FUNC_get_func_arg:
> -               return bpf_prog_has_trampoline(prog) ? &bpf_get_func_arg_=
proto : NULL;
> +               return &bpf_get_func_arg_proto;
>         case BPF_FUNC_get_func_ret:
>                 return bpf_prog_has_trampoline(prog) ? &bpf_get_func_ret_=
proto : NULL;
>         case BPF_FUNC_get_func_arg_cnt:
> -               return bpf_prog_has_trampoline(prog) ? &bpf_get_func_arg_=
cnt_proto : NULL;
> +               return &bpf_get_func_arg_cnt_proto;
>         case BPF_FUNC_get_attach_cookie:
>                 if (prog->type =3D=3D BPF_PROG_TYPE_TRACING &&
>                     prog->expected_attach_type =3D=3D BPF_TRACE_RAW_TP)
> --
> 2.52.0
>
