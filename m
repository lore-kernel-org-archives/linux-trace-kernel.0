Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A6FBD531
	for <linux-trace-kernel@vger.kernel.org>; Fri, 15 May 2026 20:31:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778877109; cv=pass; b=edDBtcccCNAKpo6nsK99QTMlbuKpljuwhf8CaaPqPlgEc4bFwgIw11zYvouqfM/1XrxF5QkCrkNf3RWQodyn9UbGCzm4aIxS6pPwcwEhXTnsNhSM9hhN0G5oL2l/iJk49t1rt/yAJrvZrAEYU7d6cD/ttXv9LvDtQVbw4cjY0fQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778877109; c=relaxed/simple;
	bh=9OMOUObyA/NJI8Nj5AuEVkMo+9Md8jL717X6LDMVPXU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=O7DuWR/0oR4u43Nbq8VN/9WTkfFN+4HXCoKe1l5OUXHPvKAGQUxu3Ob3EI70cGtNiqLuTbBsX3CIw9VrSwYK6Su3RbxWUvxdQBAaLBWJjC+FcQet0ll2TgzwVXjp4o5xQm+DpXfnDHi5DvjJNux28oW5LvYlxIzmNB67ojx92S4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bxK/ARjG; arc=pass smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bxK/ARjG"
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-365d8e43759so675929a91.0
        for <linux-trace-kernel@vger.kernel.org>; Fri, 15 May 2026 13:31:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778877106; cv=none;
        d=google.com; s=arc-20240605;
        b=XiAopAFdU3wii4A5vhiH43sur/0/lzU+rGP2M0zk9af4esQWlJAB1K0Yd5hbc2bEEp
         J7mxaK953T503nnphywXlhZrDvrkcuFduE0a0YjzUAJQOViWiOZLhnojID5N1KAxSpoV
         r4s6M6udWEKD1319G3X72uQ6PHnGjAznkQbYnrHxBJW4mguw0UL4dSQThtBhjiAFpciK
         Grx1ePAJ4EFVST67vdrJH6PQjbAeHy/yMIdJlXwKXQsMeVpakyR+QXwnEexUY0JIuoi+
         u4oXgqq1iGmMg1DIpX+J+kG+xKWUXyKN4UCB1xzyFH8AmNLSp8zJlf3PpeBFmppth1IE
         29tQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=GfKMCbzq+rYGH17flAZI0P8SiAo/th+/psoW2A9BSc4=;
        fh=7X6lBVX5PryShcANoae3w2bnLNvXNaW2NljuZubjsq0=;
        b=al38/Wkg13vgZ1tow7+ongBXdelfTD6R72a9Ivr9tA9isOmdYoDZgdU62It3jsCz9R
         CDISu2UyHlfxukMqunmovzQa4Psm0btNgYmK9JBOAa3oj5vv1bEWUx+7rJwojtK9Cywa
         3YfW50SfbyW5nXdx6lIafBXV3CJVEbDP3kh0MiXvPB0/DUYBMBKMqFCX9uqJT0iLoBQy
         FV0wVo0NOeIEQmlHGudy10BPyGsmGNHDSitrqfTZvLtCveybRsIT/5Q/nFfNkuD5F0Tm
         ePMnnx4yfPJDDzSU5pVMVlQPguJKT9+FnVKl6yrSW45T+PzocuVUXPHn18oED1BGwpV3
         iVyA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778877106; x=1779481906; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GfKMCbzq+rYGH17flAZI0P8SiAo/th+/psoW2A9BSc4=;
        b=bxK/ARjGYj3qePrf/PXxgkNvSEO82j7+vGjDXHLEbf5az10TkChLRa2r8SQ2oU2kod
         ndLFWbFDkoKtN9AxZ2NSXRewttsrWIYhpa3yQtRTC6r1+58J4DHYBkhcd2koCZanrUzA
         Lp3znOSLYTxNK7xlAJYVmRt4Uu33pV29+sF0ZBRYQj5lIrb5La/q2xVkEq1g7nWSMXjJ
         xwy+ZY1t+qIAs1doLgjQfhFRawG7gahyqpTekLEmgQCuw9dUrFI8oPmarpCLLxCDZBZf
         Sr0Bm36QZPcXFJ/SfuHqN4uVDe39BxCvIhcCnxbyXrja0dIknV2REUsBxzBChDgpd0y3
         KZ5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778877106; x=1779481906;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=GfKMCbzq+rYGH17flAZI0P8SiAo/th+/psoW2A9BSc4=;
        b=dMZKHUrqerAAWDyoRiHBcGAb7Xm5LIH2smEGtx/lVk46c0R7Lsk+LXxNcwdmuOkzY8
         dDVXESq4e9x+C/c+AZjMX/ArDEKFF4hLHHYMn4FoeTb7AYxa1aMnsk5YBlZNzS0noJ2e
         6KIQtFIfbVteFXDyrNE5iKMzUQ7PrzgIwK4ldjez8YAknihqJZFZoJ3rWzjeuIu6j9tH
         YiiTkq1zOZK/W0r/Akiwg5Oc1yLUTvR1A5dQg7zC57xQpxKGDZ08oERUseXlmPin6UWG
         PdZnwBGqO+X5TRseQm4yFrTb98iNg/WLoXnoaz+9osxjoTtZuCkARI6VqwP4T2yB9rz7
         dhyQ==
X-Forwarded-Encrypted: i=1; AFNElJ8n2vSNIfGE6cigHtJm4sU2droyVRY9tB1QsKQBvDi68a+d4aL+YHEoDGEvnUOCsOH5I+uJT8kkPZGS01+95fiqi6Y=@vger.kernel.org
X-Gm-Message-State: AOJu0Yypq/36hGuUuuQnaR9Ahmv2wfIC7poQTfDyYkaptX2TUP47rsmr
	OqMEdRW9Mi8OAmfate7v8bNa6+mbaEcmoKOri7uwwHcBwtvm9fY1RQlrrHVtN8EOPNyR8u4f0yb
	2OrG1riKEXlHzCFGC98+xK4VxiTkP15I=
X-Gm-Gg: Acq92OFZYDn6Cm3SySvvTnL/f0YYWnCoBTT7O3sD5B4A9G/prCWPqVEkHVYsqS5TAZH
	buz9snh62tI7fX4j2cVWfBZExdKCwrBUdL0L1gB+CFFWe5HuPJ+AhOyqs2EXA6Y9GjPTxMeGJ1B
	F43uQw92SrByXl/naE4eLol9r4XXCwgpe4pz4G5FQp0y+yjzXSMOwB8F9XULSx0O1aiIx9AjdVN
	pX09BH3GpgqctIGwii9OmQSqQKnNiMhS/SSt2xNRNZj4C3ha/fPMjyHyIdp85Y09qXeG3JhO3Q+
	3o8ifnp64d9ML4JMAfY8rNrK1aLONBiSgA==
X-Received: by 2002:a17:90b:1d8e:b0:35b:d795:cf5d with SMTP id
 98e67ed59e1d1-3695137f713mr4228692a91.5.1778877105837; Fri, 15 May 2026
 13:31:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260514135342.22130-1-jolsa@kernel.org> <20260514135342.22130-2-jolsa@kernel.org>
In-Reply-To: <20260514135342.22130-2-jolsa@kernel.org>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 15 May 2026 13:31:31 -0700
X-Gm-Features: AVHnY4IkXbPoE27Y25mhMhjX45nN-pzqZNIcNXqxHbAb6I9OJRsGCw2MdyrOT6c
Message-ID: <CAEf4BzZxNLEeyDE2aJVm=T=RzDayaHzAbHxXQqn6M6uqa45obA@mail.gmail.com>
Subject: Re: [PATCH 1/7] uprobes/x86: Move optimized uprobe from nop5 to nop10
To: Jiri Olsa <jolsa@kernel.org>
Cc: Oleg Nesterov <oleg@redhat.com>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@kernel.org>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 14, 2026 at 6:53=E2=80=AFAM Jiri Olsa <jolsa@kernel.org> wrote:
>
> Andrii reported an issue with optimized uprobes [1] that can clobber
> redzone area with call instruction storing return address on stack
> where user code may keep temporary data without adjusting rsp.
>
> Fixing this by moving the optimized uprobes on top of 10-bytes nop
> instruction, so we can squeeze another instruction to escape the
> redzone area before doing the call, like:
>
>   lea -0x80(%rsp), %rsp
>   call tramp
>
> Note the lea instruction is used to adjust the rsp register without
> changing the flags.

I think it should be very loudly explained that we can't go back to
nop10 and have to do short jump over patched sequence (and why).

>
> The optimized uprobe performance stays the same:
>
>         uprobe-nop     :    3.129 =C2=B1 0.013M/s
>         uprobe-push    :    3.045 =C2=B1 0.006M/s
>         uprobe-ret     :    1.095 =C2=B1 0.004M/s
>   -->   uprobe-nop10   :    7.170 =C2=B1 0.020M/s
>         uretprobe-nop  :    2.143 =C2=B1 0.021M/s
>         uretprobe-push :    2.090 =C2=B1 0.000M/s
>         uretprobe-ret  :    0.942 =C2=B1 0.000M/s
>   -->   uretprobe-nop10:    3.381 =C2=B1 0.003M/s
>         usdt-nop       :    3.245 =C2=B1 0.004M/s
>   -->   usdt-nop10     :    7.256 =C2=B1 0.023M/s
>
> [1] https://lore.kernel.org/bpf/20260509003146.976844-1-andrii@kernel.org=
/
> Reported-by: Andrii Nakryiko <andrii@kernel.org>
> Closes: https://lore.kernel.org/bpf/20260509003146.976844-1-andrii@kernel=
.org/
> Fixes: ba2bfc97b462 ("uprobes/x86: Add support to optimize uprobes")
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> ---
>  arch/x86/kernel/uprobes.c | 121 +++++++++++++++++++++++++++-----------
>  1 file changed, 86 insertions(+), 35 deletions(-)
>
> diff --git a/arch/x86/kernel/uprobes.c b/arch/x86/kernel/uprobes.c
> index ebb1baf1eb1d..f7c4101a4039 100644
> --- a/arch/x86/kernel/uprobes.c
> +++ b/arch/x86/kernel/uprobes.c
> @@ -636,9 +636,21 @@ struct uprobe_trampoline {
>         unsigned long           vaddr;
>  };
>
> +#define LEA_INSN_SIZE          5
> +#define OPT_INSN_SIZE          (LEA_INSN_SIZE + CALL_INSN_SIZE)
> +#define OPT_JMP8_OFFSET                (OPT_INSN_SIZE - JMP8_INSN_SIZE)
> +#define REDZONE_SIZE           0x80
> +
> +static const u8 lea_rsp[] =3D { 0x48, 0x8d, 0x64, 0x24, 0x80 };
> +
> +static bool is_lea_insn(const uprobe_opcode_t *insn)
> +{
> +       return !memcmp(insn, lea_rsp, LEA_INSN_SIZE);
> +}
> +
>  static bool is_reachable_by_call(unsigned long vtramp, unsigned long vad=
dr)
>  {
> -       long delta =3D (long)(vaddr + 5 - vtramp);
> +       long delta =3D (long)(vaddr + OPT_INSN_SIZE - vtramp);
>
>         return delta >=3D INT_MIN && delta <=3D INT_MAX;
>  }
> @@ -651,7 +663,7 @@ static unsigned long find_nearest_trampoline(unsigned=
 long vaddr)
>         };
>         unsigned long low_limit, high_limit;
>         unsigned long low_tramp, high_tramp;
> -       unsigned long call_end =3D vaddr + 5;
> +       unsigned long call_end =3D vaddr + OPT_INSN_SIZE;
>
>         if (check_add_overflow(call_end, INT_MIN, &low_limit))
>                 low_limit =3D PAGE_SIZE;
> @@ -826,8 +838,8 @@ SYSCALL_DEFINE0(uprobe)

should we change -ENXIO to -EPROTO or some other distinct error code,
so libbpf can avoid using nop5 attachment on kernels new enough to
support nop5 optimization, but old enough to not do this properly with
nop10?

>         regs->ax  =3D args.ax;
>         regs->r11 =3D args.r11;
>         regs->cx  =3D args.cx;
> -       regs->ip  =3D args.retaddr - 5;
> -       regs->sp +=3D sizeof(args);
> +       regs->ip  =3D args.retaddr - OPT_INSN_SIZE;
> +       regs->sp +=3D sizeof(args) + REDZONE_SIZE;
>         regs->orig_ax =3D -1;
>
>         sp =3D regs->sp;

[...]
