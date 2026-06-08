Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21C652F0C62
	for <linux-trace-kernel@vger.kernel.org>; Mon,  8 Jun 2026 20:46:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780951616; cv=pass; b=OqUy9LSMr9GW9NE9/hkiF0lNNuucDvjbSTxE8CAs5HzDNgYGHJkHGpv3rfAjALfNpgdl+cwfn7cDalsIrKPhdZElyWF3Wqk1w/xKgO9+xrTEpu9IZ+fTmUA4LEUOTEb7cJVXo7UoY0k4QxRmvNpqNf7bmwLIRAX1WyZFxilUVDQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780951616; c=relaxed/simple;
	bh=VkcZ55KTdEMhzAd9CZKpprqWDhoO/PUfmHma6XOXPHQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MUeufg7m6Q12UIiMBTYpiR6CIg/ecQcHClmbj64iFXTQ0w1B97u9pOqc6Xtm+h0/VWYSAfKQUHvpuC/IF6YdKVcOHiYRg9rESaPGgHIlSoZPB0DlBun1n8bWaSLctzQGt4wq7OIE5lNWS5N/UNIWGR8R/eMV5zti/4nVLDJtBAw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EI0HbSKc; arc=pass smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EI0HbSKc"
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-36b903567fdso4824430a91.1
        for <linux-trace-kernel@vger.kernel.org>; Mon, 08 Jun 2026 13:46:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780951614; cv=none;
        d=google.com; s=arc-20240605;
        b=aquGFan9Gxx8p0M7O0PDM+RL08o/J6p9U9g8p2jvYIqxXf7PgdDaYrT3jwde2b1RSa
         a+YAzOxIot3sQ60sY5i7KTOQrYDXy3pPdSDu3XNY8uV4GY+7+xDKSHlLf+j4zgrAaJ4f
         1t0xRLaM+dpl86bfQnsiJTqFmB/o58otUDdKBbVwZUFsxRUkwSHOSYTy8ybXoZWxLt6W
         83Nx0mkGJMWWsnfHCZIoBzCdc7xfbGeuT34Bvo/t3zbdlu1cmsixXffGk9inDZiDlEWQ
         xbeCOckK5eAM6KZYkjQ3xAcMB1o/teijzTYMlwn0M0p2bIQU1ZyPmjxkHxATS/SMqXun
         RkzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=bEyAmCN5izqc+BHw5LGWc/odGoJ+BdSkQDaB0mqnFRM=;
        fh=M88i1KjQMGzTKRPTmHNRW4oGmxj6pt0LfpfHjdNK9lM=;
        b=H2XNkm2mGdIKU2YdSypJbfn2huyq6rqZU3h63PKT6iVfeCX32HYEsY7k6HNOESuUBJ
         9qSExoSnLabPhsKaAuDq/NmVCpnK3HdyOab55cUkErCIr6O1tPqxbDlW7OmDBelPRiZx
         GifTi1n5lBrfASiuNXDQUx1FTxMtndduA3JYUC//zfDl4HMqimOBCold+bz2Ih9nCNVg
         LepCcfXdQfLyHcysYA1yv0Wf97bIy6VFU5zveLRy1htRX+k6Sv5roztqnjxG1NYf3s2Q
         6G7UG9VCzMmyv7RuKyGhdHa+JuIghT/yQ06s1WCBb4iDiqGI/2ZNLba38fEAUI5aD4wA
         Lk1A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780951614; x=1781556414; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bEyAmCN5izqc+BHw5LGWc/odGoJ+BdSkQDaB0mqnFRM=;
        b=EI0HbSKc1Xnfock0yqprt9Fz5j+7hB8KzBUZs2E3cPxvWJ8Z25VnzRJJOGsr+dmFqM
         azsx+xJsBam8dtWxV+pbdHlgIIkYSZuxPyHrtuUOsUbQ6avaQ0fSDZKPnXU9Aal5HeFx
         OkSJ+GmDq6+HqOGEH1kL+z7VLiVgBCCnUqoms4zvv7U2sqiyEYWF88pUAZ4sCn7FAgjN
         zwLWrdJ8i+eRV7/bdi6ANQrX3Tvk+d4+/n+pyEqMwvQHrzGGZyLoToA7SqpWHGPv5HJp
         x6OMZ6VsZ6xPNoOYIcg5Kce222bHG516XuEm99amQsPudH9V7Fkc7ZLDtK2PYfj2ZvZr
         Ocuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780951614; x=1781556414;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=bEyAmCN5izqc+BHw5LGWc/odGoJ+BdSkQDaB0mqnFRM=;
        b=fUxqbFmvkI5Pv/iq8IcMi7jlY4xJUuySJnVRRvQlKCWFgxuZD+nBwMXZX3ZYmJgfU7
         1hf68ASOCFfu0emni5swyvpFYaVrH+ZWK6UFQDqM8S6zARbYzeBJbGAF7/t1MxZEKhIo
         D4vUSAGNoJ54ZJxWpz8iF7Fe4ehLhN/5dU0XspmtPjMA3wv+mUPCEWaqNHaZipqPXVpw
         8TStu5sRJ5blz2Cm3F++f3qnR0Al9xXjBH/opeZDrHWdRtOIfWs/yIeLB0+U9dXnk5cE
         rT1iuw3qhJ/tYjdF8dx3J94sVDWYkhP76q+JPplssojVHuz5Pie4XwDJ4DhpNZ9DorWX
         mPpQ==
X-Forwarded-Encrypted: i=1; AFNElJ/q7AhWYWJ9MeqRu+ze2i1SE+KSwOK1PwUAjdXMmUFcUYj9HqD4ghFP4M5C8KHuFy+jsQ560ja3S+KdGbVTsT3svng=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw7WQHPGwSc40UgN52tERjx9kDTInmaAi8qU5vA1hMihwCKrkA5
	FbkwEixjM94GrsrzRhoO3Ejl1+Xt+VmEA/hrNtBZrHZTlOLNqJTY7CjlIvLwTKX32w/lz9jXQVf
	32ICRRqZBJvhuzqStCMwEf+dsEtL+6jE=
X-Gm-Gg: Acq92OGLHEMmF8vovRnRvcQKXRIG+MZrpWIlVvy4qL+smBpJ/br30ekBKpVYLzNjkXE
	EvnkwPOAbsjpC6kjrdjfMcYM+v85Q9cWLFXx5cV2DFVAFhHnAAn7L/gFCSKVw2kluptn97ISek8
	aXlJiIN69R60ask/dvHNyXTyXAaLnGVTNQRFGXie3MDyiffrDo/eoMYlUc8NYjp+3O1KiQ0ASw5
	7RzWOnoeALLXRnjnNRVU90PAp2iyMYcw8bbj99YgMEQu1TZpDclhsdMXd8dqjCzDU9U/9S2CN8q
	9PtwnzK686F/sPITzy47pwIyIJSOiH5/bIoBz4gdxjNYgZzz2MTICcnuicVR6/HuhU6hgaghcCh
	XSBA+OjCQRFm2Ry2/ACxxcqFxqQ==
X-Received: by 2002:a17:90b:3512:b0:36d:b424:4f17 with SMTP id
 98e67ed59e1d1-370ee82fa3cmr17358938a91.1.1780951614413; Mon, 08 Jun 2026
 13:46:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260526205840.173790-1-jolsa@kernel.org> <20260526205840.173790-6-jolsa@kernel.org>
In-Reply-To: <20260526205840.173790-6-jolsa@kernel.org>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Mon, 8 Jun 2026 13:46:39 -0700
X-Gm-Features: AVVi8CfRk6L2D7B6rQ3r0LikUw7cueXdxCQXSNM3PID6p4IbsR9995QvIqtVNp4
Message-ID: <CAEf4BzZiFUeFa4fdghuSGpqiEzyvJVxs6TDgJd5U4hSj--imiQ@mail.gmail.com>
Subject: Re: [PATCHv4 05/13] uprobes/x86: Move optimized uprobe from nop5 to nop10
To: Jiri Olsa <jolsa@kernel.org>
Cc: Oleg Nesterov <oleg@redhat.com>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@kernel.org>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 26, 2026 at 1:59=E2=80=AFPM Jiri Olsa <jolsa@kernel.org> wrote:
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
>
> We use nop10 and following transformation to optimized instructions
> above and back as suggested by Peterz [2].
>
> Optimize path (int3_update_optimize):
>
>   1) Initial state after set_swbp() installed the uprobe:
>       cc 2e 0f 1f 84 00 00 00 00 00
>
>      From offset 0 this is INT3 followed by the tail of the original
>      10-byte NOP.
>
>      After a previous unoptimization bytes 5..9 may still contain the
>      old call instruction, which remains valid for threads already there.
>
>   2) Rewrite the LEA tail and call displacement:
>       cc [8d 64 24 80 e8 d0 d1 d2 d3]
>
>      From offset 0 this traps on the uprobe INT3.  Bytes 1..9 are not
>      executable entry points while byte 0 is trapped.
>
>   3) Publish the first LEA byte:
>       [48] 8d 64 24 80 e8 d0 d1 d2 d3
>
>      From offset 0 this is:
>         lea -0x80(%rsp), %rsp
>         call <uprobe-trampoline>
>
> Unoptimize path (int3_update_unoptimize):
>
>   1) Initial optimized state:
>       48 8d 64 24 80 e8 d0 d1 d2 d3
>      Same as 3) above.
>
>   2) Trap new entries before restoring the NOP bytes:
>       [cc] 8d 64 24 80 e8 d0 d1 d2 d3
>
>      From offset 0 this traps. A thread that had already executed the
>      LEA can still reach the intact CALL at offset 5.
>
>   3) Restore bytes 1..4 of the original NOP while keeping byte 0 trapped
>      and byte 5 as CALL.
>       cc [2e 0f 1f 84] e8 d0 d1 d2 d3
>
>      From offset 0 this still traps. Offset 5 is still the CALL for any
>      thread that was already past the first LEA byte.
>
>   4) Publish the first byte of the original NOP:
>       [66] 2e 0f 1f 84 e8 d0 d1 d2 d3
>
>      From offset 0 this is the restored 10-byte NOP; the CALL opcode and
>      displacement are now only NOP operands.  Offset 5 still decodes as
>      CALL for a thread that was already there.
>
>      Tthere is only a single target uprobe-trampoline for the given nop10
>      instruction address, so the CALL instruction will not be changed acr=
oss
>      unoptimization/optimization cycles.
>      Therefore, any task that is preempted at the CALL instruction is gua=
ranteed
>      to observe that CALL and not anything else.
>
> Note as explained in [2] we need to use following nop10:
>        PF1   PF2   ESC   NOPL  MOD   SIB   DISP32
> NOP10: 0x66, 0x2e, 0x0f, 0x1f, 0x84, 0x00, 0x00, 0x00, 0x00, 0x00 -- cs n=
opw 0x00000000(%rax,%rax,1)
>
> which means we need to allow 0x2e prefix which maps to INAT_PFX_CS
> attribute in is_prefix_bad function.
>
> Also changing the uprobe syscall error when called out of uprobe
> trampoline to -EPROTO, so we are able to detect the fixed kernel.
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
> [2] https://lore.kernel.org/bpf/20260518104306.GU3102624@noisy.programmin=
g.kicks-ass.net/#t
> Reported-by: Andrii Nakryiko <andrii@kernel.org>
> Closes: https://lore.kernel.org/bpf/20260509003146.976844-1-andrii@kernel=
.org/
> Fixes: ba2bfc97b462 ("uprobes/x86: Add support to optimize uprobes")
> Assisted-by: Codex:GPT-5.5
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> ---
>  arch/x86/kernel/uprobes.c | 255 ++++++++++++++++++++++++++++----------
>  1 file changed, 190 insertions(+), 65 deletions(-)
>

[...]

> @@ -943,13 +1026,31 @@ static int int3_update(struct arch_uprobe *auprobe=
, struct vm_area_struct *vma,
>         smp_text_poke_sync_each_cpu();
>
>         /*
> -        * Write first byte.
> +        * 3) Restore bytes 1..4 of the original NOP while keeping byte 0=
 trapped
> +        *    and byte 5 as CALL:
> +        *    cc [2e 0f 1f 84] e8 d0 d1 d2 d3
> +        */
> +       ctx.expect =3D EXPECT_SWBP_OPTIMIZED;
> +       err =3D uprobe_write(auprobe, vma, vaddr + 1, insn + 1,
> +                          LEA_INSN_SIZE - 1, verify_insn,
> +                          true /* is_register */, false /* do_update_ref=
_ctr */,

tbh, it's quite subtle and non-obvious why is_register should be set
to true first two times (and especially that is_register and
do_update_ref_ctr are implicitly connected), not sure how to make it
cleaner, but maybe leave a short comment explaining this twice
register, once unregister sequence?

> +                          &ctx);
> +       if (err)
> +               return err;
> +
> +       smp_text_poke_sync_each_cpu();

[...]
