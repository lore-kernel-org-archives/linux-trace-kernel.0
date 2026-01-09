Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5324731A547
	for <linux-trace-kernel@vger.kernel.org>; Fri,  9 Jan 2026 16:24:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767975897; cv=none; b=iez7YoSNabJSCtaNbnh8kO777DMefyq4RjKprWFGANbMLv/uUZ8FPILlm3+MAIOWQlCrQdyc1tSzNKkRsQHVMEtuxpqA71csjwnnMmTzhuTqTSgYdcg/cfGn5V0rMjANCur/xjMYhA4yo64UAry77Rka+5Jc2oq19Ow7nI935KY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767975897; c=relaxed/simple;
	bh=DsoNiErAyhf3A90GHQfACdBGfpojvMzHJ+IZ5BcSxgc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YhmzZn++ytWVwrFIQISrJH3M5EuxZx4f4LpfjBgDAxAmdF9Qbltjb+v2Zee9o+4akky5ZjNl61CgEOgXmfYTcH4dg0WQU4oxn8cmTI3u2Gx3y40RCFe4QwANPj2K7Rm2eVo1IyLZRa07lqLnNzUr7Iqsb9jqqzsLpcv/hdWZAjY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TsSq+IG6; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TsSq+IG6"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-477770019e4so35035655e9.3
        for <linux-trace-kernel@vger.kernel.org>; Fri, 09 Jan 2026 08:24:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767975893; x=1768580693; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aHmfnqgDCEmK613FRrQHV+ATkk1Rai86bVueukmcvOY=;
        b=TsSq+IG6ozA/zUfAyQkCipaHBAEicf6+Ng74O2wCD1FeL0qNNProlDRua6tcy9fiNR
         JqzuXzC2g1OSOgPjDpueIaELTRS5X14TU9V7T+XflgzxaNVXlWHdO0rpUkGcPF6XIrAW
         4VsjspW06kmKN3iYDduKFPzZYUDMzn/AfJTihRgeGSKCZw7RPKySM5kQB3Py+YY2/EBQ
         EBYNUzoc+3Xy33QaB3Cm/PPNGv59DYFvbHkXpYxV+Izy0HnDjrkxNFH07fWgO9fUsQkM
         rfzgWuggSjQTUSEHTEGOspr+ajiQI9gDDOE5gO8I8AX/ZsriLNFU56pS3nywr5QcmmdW
         wTCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767975893; x=1768580693;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=aHmfnqgDCEmK613FRrQHV+ATkk1Rai86bVueukmcvOY=;
        b=A7rvCZDZJ5Tgtkhmn+yvsitl8Qny4OE96ml82gekB1KeVWUIJ4hCuVq8Q3jXj2ZPzJ
         B76NMdMPrb+FA+cXlLgEzw7m+8AsUM4mn+ztirWRibgOziVON1PSF3O9DLmrMhz+JYwr
         XU7vR2+BVHzkRZS29SWMv4ZjSSmXLUtNnfoqGnEfwGZQGrwb+HVJgtInXNkfU/vEBLSY
         Bs/Ca50WK+dMuyOO2ubQ+ayqerxqFLAM0jV4IXwDDN2KNfaI2wc6B614gssirVgFvQE2
         Q0GgXuj2S53cVjEdL6eB2aXoSxw27fBtq1BwiEz9TQNj5JXlwPT4yrqLpEViqRuyuo8s
         bYZw==
X-Forwarded-Encrypted: i=1; AJvYcCWTIdsD259ennBtiUASRrEcyU3CpFBptU4J4mvpVedbFcid8hcLy+Rpbp44FnL7UnCFmQEK/zxCvfnqMST6zI7TAKA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyudrOJHKkFK3hj2UcmamOpuu1HnAvWuLxzOyQ9zCAR4j4dFMal
	dF54S2LbPFJot4nEGLA6KYBYKOZTQd68/0KsTobqjs46sTxB1+SO+UDCajOg9Tf/jq8OIIKuY4O
	mnTqmY8QW47VeDzV3+i9kh9AQqxbpJ6h+Ww==
X-Gm-Gg: AY/fxX7XSRl3t4W0Mu66AUx/eLXNYCayid3l0udwYRmgsqDFUTgatq/XQOmW2s75oRn
	isawWBkOYxKgGKRQQPdG1JvDlKCjFG9Ar/OKvfehvQb14H/soHvorm2mMRWPI0x6m4dEVCtRQ0R
	bed1rxVM65HASaIqPJ2yvQB7vWhNqxJVTSNS+hGkAaXKSrAr2aibuwrVlKRbCXGmwlj4q5hq86N
	gGCopY2SPy1g5sJsZOdhQeO1ZjzMZMz41RLe3xg9vuz8dUO9ct2vYSmE446TDQlx96rwWLT85Yd
	Y+sOJdJ0CXCqTvMHla6Flm9W3SmC
X-Google-Smtp-Source: AGHT+IH8/QRjd++hMR8vlKQXLENn7AamAuc5FJZXDbW/uNvxUAJMk5qvZVioKDc46eg8K59Ls8JDHizJk5fuymSkcis=
X-Received: by 2002:a05:600c:4694:b0:46e:3d41:6001 with SMTP id
 5b1f17b1804b1-47d84b3db20mr97255695e9.34.1767975893237; Fri, 09 Jan 2026
 08:24:53 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260109153420.32181-1-leon.hwang@linux.dev> <20260109153420.32181-2-leon.hwang@linux.dev>
In-Reply-To: <20260109153420.32181-2-leon.hwang@linux.dev>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Fri, 9 Jan 2026 08:24:41 -0800
X-Gm-Features: AZwV_Qjs-h5Q6oTESWcQ85ioWJXfjnRIPt3WHmpg0AdmKGFJ63hMwzpPEGHOOQk
Message-ID: <CAADnVQK4O-igzuSvfgjG1ZqdUBXrjNL=4tJZuS1uy36GCD2mVg@mail.gmail.com>
Subject: Re: [PATCH bpf-next 1/3] bpf, x64: Call perf_snapshot_branch_stack in trampoline
To: Leon Hwang <leon.hwang@linux.dev>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, "David S . Miller" <davem@davemloft.net>, David Ahern <dsahern@kernel.org>, 
	Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, X86 ML <x86@kernel.org>, 
	"H . Peter Anvin" <hpa@zytor.com>, Matt Bobrowski <mattbobrowski@google.com>, 
	Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Shuah Khan <shuah@kernel.org>, 
	Network Development <netdev@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	linux-trace-kernel <linux-trace-kernel@vger.kernel.org>, 
	"open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>, kernel-patches-bot@fb.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 9, 2026 at 7:37=E2=80=AFAM Leon Hwang <leon.hwang@linux.dev> wr=
ote:
>
> When the PMU LBR is running in branch-sensitive mode,
> 'perf_snapshot_branch_stack()' may capture branch entries from the
> trampoline entry up to the call site inside a BPF program. These branch
> entries are not useful for analyzing the control flow of the tracee.
>
> To eliminate such noise for tracing programs, the branch snapshot should
> be taken as early as possible:
>
> * Call 'perf_snapshot_branch_stack()' at the very beginning of the
>   trampoline for fentry programs.
> * Call 'perf_snapshot_branch_stack()' immediately after invoking the
>   tracee for fexit programs.
>
> With this change, LBR snapshots remain meaningful even when multiple BPF
> programs execute before the one requesting LBR data.
>
> In addition, more relevant branch entries can be captured on AMD CPUs,
> which provide a 16-entry-deep LBR stack.
>
> Signed-off-by: Leon Hwang <leon.hwang@linux.dev>
> ---
>  arch/x86/net/bpf_jit_comp.c | 66 +++++++++++++++++++++++++++++++++++++
>  include/linux/bpf.h         | 16 ++++++++-
>  2 files changed, 81 insertions(+), 1 deletion(-)
>
> diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
> index e3b1c4b1d550..a71a6c675392 100644
> --- a/arch/x86/net/bpf_jit_comp.c
> +++ b/arch/x86/net/bpf_jit_comp.c
> @@ -12,6 +12,7 @@
>  #include <linux/bpf.h>
>  #include <linux/memory.h>
>  #include <linux/sort.h>
> +#include <linux/perf_event.h>
>  #include <asm/extable.h>
>  #include <asm/ftrace.h>
>  #include <asm/set_memory.h>
> @@ -19,6 +20,7 @@
>  #include <asm/text-patching.h>
>  #include <asm/unwind.h>
>  #include <asm/cfi.h>
> +#include "../events/perf_event.h"
>
>  static bool all_callee_regs_used[4] =3D {true, true, true, true};
>
> @@ -3137,6 +3139,54 @@ static int invoke_bpf_mod_ret(const struct btf_fun=
c_model *m, u8 **pprog,
>         return 0;
>  }
>
> +DEFINE_PER_CPU(struct bpf_tramp_branch_entries, bpf_branch_snapshot);
> +
> +static int invoke_branch_snapshot(u8 **pprog, void *image, void *rw_imag=
e)
> +{
> +       struct bpf_tramp_branch_entries __percpu *pptr =3D &bpf_branch_sn=
apshot;
> +       u8 *prog =3D *pprog;
> +
> +       /*
> +        * Emit:
> +        *
> +        * struct bpf_tramp_branch_entries *br =3D this_cpu_ptr(&bpf_bran=
ch_snapshot);
> +        * br->cnt =3D static_call(perf_snapshot_branch_stack)(br->entrie=
s, x86_pmu.lbr_nr);
> +        */
> +
> +       /* mov rbx, &bpf_branch_snapshot */
> +       emit_mov_imm64(&prog, BPF_REG_6, (long) pptr >> 32, (u32)(long) p=
ptr);
> +#ifdef CONFIG_SMP
> +       /* add rbx, gs:[<off>] */
> +       EMIT2(0x65, 0x48);
> +       EMIT3(0x03, 0x1C, 0x25);
> +       EMIT((u32)(unsigned long)&this_cpu_off, 4);
> +#endif
> +       /* mov esi, x86_pmu.lbr_nr */
> +       EMIT1_off32(0xBE, x86_pmu.lbr_nr);
> +       /* lea rdi, [rbx + offsetof(struct bpf_tramp_branch_entries, entr=
ies)] */
> +       EMIT4(0x48, 0x8D, 0x7B, offsetof(struct bpf_tramp_branch_entries,=
 entries));
> +       /* call static_call_query(perf_snapshot_branch_stack) */
> +       if (emit_rsb_call(&prog, static_call_query(perf_snapshot_branch_s=
tack),
> +                         image + (prog - (u8 *)rw_image)))
> +               return -EINVAL;
> +       /* mov dword ptr [rbx], eax */
> +       EMIT2(0x89, 0x03);
> +
> +       *pprog =3D prog;
> +       return 0;
> +}
> +
> +static bool bpf_prog_copy_branch_snapshot(struct bpf_tramp_links *tl)
> +{
> +       bool copy =3D false;
> +       int i;
> +
> +       for (i =3D 0; i < tl->nr_links; i++)
> +               copy =3D copy || tl->links[i]->link.prog->copy_branch_sna=
pshot;
> +
> +       return copy;
> +}
> +
>  /* mov rax, qword ptr [rbp - rounded_stack_depth - 8] */
>  #define LOAD_TRAMP_TAIL_CALL_CNT_PTR(stack)    \
>         __LOAD_TCC_PTR(-round_up(stack, 8) - 8)
> @@ -3366,6 +3416,14 @@ static int __arch_prepare_bpf_trampoline(struct bp=
f_tramp_image *im, void *rw_im
>
>         save_args(m, &prog, regs_off, false, flags);
>
> +       if (bpf_prog_copy_branch_snapshot(fentry)) {
> +               /* Get branch snapshot asap. */
> +               if (invoke_branch_snapshot(&prog, image, rw_image)) {
> +                       ret =3D -EINVAL;
> +                       goto cleanup;
> +               }
> +       }

Andrii already tried to do it.
I hated it back then and still hate the idea.
We're not going to add custom logic for one specific use case
no matter how appealing it sounds to save very limited LBR entries.
The HW will get better, but we will be stuck with this optimization forever=
.

pw-bot: cr
