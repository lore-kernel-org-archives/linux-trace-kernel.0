Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 800AE480DEB
	for <linux-trace-kernel@vger.kernel.org>; Mon, 18 May 2026 16:14:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779120897; cv=pass; b=X2oaUB8goGN5MeuL47P0/nhpVw+QGWHoMLT/7I0KLAySSiORnge4OfhaVKrYVOev6IRhvYuJjUgCC4WQKYDAoiV/FksbQD8tbHmhlkSkIxTLrp/YDqEaqUgA0OYHuO+LveKaC5yVJF5fBFNGfANLkakSeIrhG53B0h0D/q2ga5U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779120897; c=relaxed/simple;
	bh=EmYKj06afbAhmfrg0dU9ILwqg+Kx17GPBCdiKSIJuRc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ugiPk3n3Oih/5SbVKUfnpVaO2FDo6/bK7iADP49krBKDiUVNSJgkt7B+7ZHi8yTeKYcRx2bsJVuAX4esAWH9jYAKCnnplY05w3KHeahyDrPkMu0gm/tsYY0pIIc1T3vseEEGrTLvRop/gQlglcKl73gtkE+t3PGXdBKzBO7fz3k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nBMieT8R; arc=pass smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nBMieT8R"
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-36974221f93so1111680a91.2
        for <linux-trace-kernel@vger.kernel.org>; Mon, 18 May 2026 09:14:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779120888; cv=none;
        d=google.com; s=arc-20240605;
        b=MKC3xVKNw7h6zBJ6EN/jzbvG1bhdvpz5RY4NqM04ls6G14FSy1z4ZHtA09a8UuA0Ej
         KSruOV2yw+wyHpXyUk59PNDhkFsZeiOEYtO/V3d6tp+n3SuZEU1DE7KTVjJgy1sQMAax
         kWEbRyPCZSOK83i6w1rhMVzPKvw/tFInUUaU1XsEvQYH6CczzyrcMudmkfhGEFTFfj29
         C/UzBbGdFd6+SBSTtMbTyaThaxZqpz7IyUXqwZ/CVjgiyy2Eo7b2vm+1JncvKpPas9lv
         HqjzybT5JadFfOnPCHG4K0TdFGg8kYNi39mX7I/hKUOTk/qsplYH4+/ZwpzwtHNmNSMs
         /Ypw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=sjHa52dJp+dkJOLU1Zzxxd+w92lhdzj56DEfyUv/Ue8=;
        fh=MrvQN9+3qfDAsn9E14XkYhFbbmXgb+kNlTcc46+Dixg=;
        b=euTfti8jdg4Co026JsA+SEq9St6ihWBK1ZYJ7XrhuZRlOQeEOxBn3RcZSvJIniFvQe
         C3yoph/UgPNGC440GFWCAKnp/No4Y16AIGkqxqVv8Yny62xGcitevqqTtJ2HX7f+H6Rx
         BGWS7W1k17VEL5h2ydqo6NopVc9N5BdhS4lFNHFNifG+7qgiapBx/LMCAXPo8AYAmNEz
         r9clLHXaVHgCgk2LBDyOXNwKdaSQtdylRDup83vd2jKO8QtvkuZqqbSU242GrGkEJ796
         h99CbTiq+ERp0MzJylfFSWA3KSLcbFwuWznucmMclFQJJK6L9Jrs9Pt5dSsVeEoD4R2D
         f2Yw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779120888; x=1779725688; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sjHa52dJp+dkJOLU1Zzxxd+w92lhdzj56DEfyUv/Ue8=;
        b=nBMieT8RN/OXdyhR8t0pMmB/zpvPQfGlaxlPd96cjf3lLKvZ7m3+Jdk39kkHQ0Riio
         vHxFKSRWhzhq874LZnald5hnjtUQ40ehymGF53y9Cpj3amIQp+4bqu1yeWP3tdgybkCb
         4m/pm2BJaum9Qx/tF72VhaUQ91LHWCALMtWJBvz3AWAEP5yjMXBos2Qe/7eGCFBoDule
         O+lG3T+x4TzN4cgDXOpOB6PWg04ta7CSMQFGHoZx6tbwhGCx6Wo2rd2mSwVWNA4qWtPW
         T4/u1No6D7B2R487wugtmKVFn57WVGIQ4QFLlPFcHnJrBszwiH5Il+NcL/GBaR6oEvYw
         AUuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779120888; x=1779725688;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=sjHa52dJp+dkJOLU1Zzxxd+w92lhdzj56DEfyUv/Ue8=;
        b=AFs3I13bq506QprH7zn8oQANHHTBDb9JTmukIMO8SvaAhdgCcSA7gIPoD+9d/rQYhB
         j2X2lhTnw3E6jILgAMCqwf0A1alK+NvDQwVPcm5m0VdqQHLJ7FMZ0JmLWOH37XSp82Od
         9kgxJ14qR8ObzmPZVaOOTeX6CFckWrsboa4UphHT+GkSN94K355hx4+8G7/1hvdPCK1i
         tsfZDLrL/jukqReXhh9xWonoWTYLDncO07/PTTIPZUwO/z5mxH5doA43Y8sHgkrCG7I/
         l5OkLRNuyMdwdm/D1JY0rHDHSrEPork4RQKv1RNv5GYZkdYIfRnz8mmz5rlrMJ062U0I
         f2mQ==
X-Forwarded-Encrypted: i=1; AFNElJ/WVdL7WXeKOreljfobiefQqwziCfKH585V7tUS1CwwW/TUAc6BvTMK5KvWL6E4z0n62P6yJ65fg0GOH/84oMrIwN0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxleu47WWQJCsmGFZwEUgsp4gKew7ijtY+ruwnEKuLe+7FGEXB6
	5QGXm/ofIHeUtwZ2YSR6G/lRwdzgCox7xKfkm/spDAAr6HrFneDTGa7f0Hf71ZWsUX/rfIJzjmK
	b+UCcTGFq5qy+KwKwMcZMJRbMnEAZdy8=
X-Gm-Gg: Acq92OE9eW2rs33Nx31ZB+MSc6QXk02W1v1rtuKwlZahfR4Ay9SbPA8wOnsjX06BfBK
	I/hqDE56QZHvD3p2tW1RrKop0HPvBRLmQ45rlCci8XNkJKR9/TdRc7z0SV1sZA5GdIpny4cLehn
	sdr9E+aLEK6fMlaTMDDHiw3Nto0gjHTamOMx2aeUG/gs8ZhawtM7LFCZs0V1Nr17vyr0EMNNcnd
	CQSNGgoekNdpy7mn2necAvdctUwMotZn8AGjcd07Y5qf2nhCyq02BiIdB158XT9ZfiW5FAhONro
	IPxclZY+aoh7AXOu+TA+8arvjG1VvOeEQw==
X-Received: by 2002:a17:90b:4a:b0:35d:a0b7:9608 with SMTP id
 98e67ed59e1d1-369519feb17mr15447389a91.7.1779120887793; Mon, 18 May 2026
 09:14:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260514135342.22130-1-jolsa@kernel.org> <20260514135342.22130-2-jolsa@kernel.org>
 <20260518104306.GU3102624@noisy.programming.kicks-ass.net>
In-Reply-To: <20260518104306.GU3102624@noisy.programming.kicks-ass.net>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Mon, 18 May 2026 09:14:35 -0700
X-Gm-Features: AVHnY4JK4mY1rOZBzuAPZOoe3LWqZaJCXqcJOCk5pjKz8K5LnElg5g71QZFlCcA
Message-ID: <CAEf4BzaSKBJDyo=GpRAfB45nqCu4CQ6RyVv2kX2hXhF+KhBTBA@mail.gmail.com>
Subject: Re: [PATCH 1/7] uprobes/x86: Move optimized uprobe from nop5 to nop10
To: Peter Zijlstra <peterz@infradead.org>
Cc: Jiri Olsa <jolsa@kernel.org>, Oleg Nesterov <oleg@redhat.com>, Ingo Molnar <mingo@kernel.org>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, x86@kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, May 18, 2026 at 3:43=E2=80=AFAM Peter Zijlstra <peterz@infradead.or=
g> wrote:
>
>
> You seem to have forgotten to Cc LKML and x86 :-(
>
> On Thu, May 14, 2026 at 03:53:36PM +0200, Jiri Olsa wrote:
>
> > @@ -1017,17 +1030,32 @@ static int int3_update(struct arch_uprobe *aupr=
obe, struct vm_area_struct *vma,
> >  static int swbp_optimize(struct arch_uprobe *auprobe, struct vm_area_s=
truct *vma,
> >                        unsigned long vaddr, unsigned long tramp)
> >  {
> > -     u8 call[5];
> > +     u8 insn[OPT_INSN_SIZE], *call =3D &insn[LEA_INSN_SIZE];
> >
> > -     __text_gen_insn(call, CALL_INSN_OPCODE, (const void *) vaddr,
> > +     /*
> > +      * We have nop10 instruction (with first byte overwritten to int3=
),
> > +      * changing it to:
> > +      *   lea -0x80(%rsp), %rsp
> > +      *   call tramp
> > +      */
> > +     memcpy(insn, lea_rsp, LEA_INSN_SIZE);
> > +     __text_gen_insn(call, CALL_INSN_OPCODE,
> > +                     (const void *) (vaddr + LEA_INSN_SIZE),
> >                       (const void *) tramp, CALL_INSN_SIZE);
> > -     return int3_update(auprobe, vma, vaddr, call, true /* optimize */=
);
> > +     return int3_update(auprobe, vma, vaddr, insn, OPT_INSN_SIZE, true=
 /* optimize */);
> >  }
> >
> >  static int swbp_unoptimize(struct arch_uprobe *auprobe, struct vm_area=
_struct *vma,
> >                          unsigned long vaddr)
> >  {
> > -     return int3_update(auprobe, vma, vaddr, auprobe->insn, false /* o=
ptimize */);
> > +     /*
> > +      * We have optimized nop10 (lea, call), changing it to 'jmp rel8'=
 to
> > +      * end of the 10-byte slot instead of restoring the original nop1=
0,
> > +      * because we could have thread already inside lea instruction.
>
> Inaccurate, RIP could be on CALL, not inside LEA. Writing NOP10 would
> make it inside NOP10 though, and that would cause havoc IF you use the
> normal NOP10.
>
> Thing is, the encoding of NOP{8,9,10} would actually allow you to
> preserve the CALL instruction :-)
>
> That is, observe:
>
>        PF1   PF2   ESC   NOPL  MOD   SIB   DISP32
>
> NOP10: 0x66, 0x2e, 0x0f, 0x1f, 0x84, 0x00, 0x00, 0x00, 0x00, 0x00 -- cs n=
opw 0x00000000(%rax,%rax,1)
> NOP10: 0x66, 0x2e, 0x0f, 0x1f, 0x84, 0xe8, 0x78, 0x56, 0x34, 0x12 -- cs n=
opw 0x12345678(%rax,%rbp,8)
>
> Specifically the CALL opcode sits in the SIB byte and decodes like:
>
>   e8 :=3D 11 101 000
>
>   scale =3D 11  (2^3 =3D 8)
>   index =3D 101 BP
>   base  =3D 000 AX
>
> And the displacement is just that, a displacement.
>
> So you *could* in fact, write back _A_ NOP10, just not the standard
> NOP10.
>
> > +      */
> > +     u8 jmp[OPT_INSN_SIZE] =3D { JMP8_INSN_OPCODE, OPT_JMP8_OFFSET };
> > +
> > +     return int3_update(auprobe, vma, vaddr, jmp, JMP8_INSN_SIZE, fals=
e /* optimize */);
> >  }
>
> Changelog wants significant update to explain this scheme.
>
> So we have:
>
>   NOP10 -+-> LEA -0x80(%rsp), %rsp, CALL foo -> JMP.d8 +8
>          |                                          |
>          `------------------------------------------'
>
> And you want to belabour the point of how you ensure re-writing the CALL
> instruction isn't a problem (because I'm not convinced).
>
> Note that the above results in:
>
> initial:
> 0: 0x66, 0x2e, 0x0f, 0x1f, 0x84, 0x00, 0x00, 0x00, 0x00, 0x00 -- cs nopw =
0x00000000(%rax,%rax,1)
>
> optimize-int3:
> 1: 0xcc, 0x2e, 0x0f, 0x1f, 0x84, 0x00, 0x00, 0x00, 0x00, 0x00 -- int3
> optimize-tail:
> 2: 0xcc, 0x8d, 0x64, 0x24, 0x80, 0xe8, 0x12, 0x34, 0x56, 0x78 -- int3; ca=
ll 0x78563412
> optimize-finish:
> 3: 0x48, 0x8d, 0x64, 0x24, 0x80, 0xe8, 0x12, 0x34, 0x56, 0x78 -- lea -0x8=
0(%rsp),%rsp; call 0x78563412
>
> unoptimize-int3:
> 4: 0xcc, 0x8d, 0x64, 0x24, 0x80, 0xe8, 0x12, 0x34, 0x56, 0x78 -- int3; ca=
ll 0x78563412
> unoptimize-tail:
> 5: 0xcc, 0x08, 0x64, 0x24, 0x80, 0xe8, 0x12, 0x34, 0x56, 0x78 -- int3; ca=
ll 0x78563412
> unoptimize-finish:
> 6: 0xeb, 0x08, 0x64, 0x24, 0x80, 0xe8, 0x12, 0x34, 0x56, 0x78 -- jmp.d8 +=
8; call 0x78563412
>
> optimize-int3:
> 7: 0xcc, 0x08, 0x64, 0x24, 0x80, 0xe8, 0x12, 0x34, 0x56, 0x78 -- int3; ca=
ll 0x78563412
> optimize-tail:
> 8: 0xcc, 0x8d, 0x64, 0x24, 0x80, 0xe8, 0x78, 0x56, 0x34, 0x12 -- int3; ca=
ll 0x12345678
> optimize-finish:
> 9: 0x48, 0x8d, 0x64, 0x24, 0x80, 0xe8, 0x78, 0x56, 0x34, 0x12 -- int3; ca=
ll 0x12345678
>
> Note that from step 7 to step 8, you re-write the CALL instruction
> without going through INT3. This means it is entirely possible for a
> concurrent execution to observe a composite instruction.
>
> This is NOT sound!

We shouldn't need to change call instruction ever, uprobe trampoline
is permanent within the given process and its address won't change.

>
> However, I think it can be salvaged, if instead of only writing INT3 at
> +0, you also write INT3 at +5. The sequence then becomes:
>
> initial:
> 0: 0x66, 0x2e, 0x0f, 0x1f, 0x84, 0x00, 0x00, 0x00, 0x00, 0x00 -- cs nopw =
0x00000000(%rax,%rax,1)
>
> optimize-int3:
> 1: 0xcc, 0x2e, 0x0f, 0x1f, 0x84, 0xcc, 0x00, 0x00, 0x00, 0x00 -- int3; in=
t3
> optimize-tail(s):
> 2: 0xcc, 0x8d, 0x64, 0x24, 0x80, 0xcc, 0x12, 0x34, 0x56, 0x78 -- int3; in=
t3
> optimize-finish-1:
> 3: 0xcc, 0x8d, 0x64, 0x24, 0x80, 0xe8, 0x12, 0x34, 0x56, 0x78 -- int3; ca=
ll 0x78563412
> optimize-finish-2:
> 3: 0x48, 0x8d, 0x64, 0x24, 0x80, 0xe8, 0x12, 0x34, 0x56, 0x78 -- lea -0x8=
0(%rsp),%rsp; call 0x78563412
>
> unoptimize-int3:
> 4: 0xcc, 0x8d, 0x64, 0x24, 0x80, 0xe8, 0x12, 0x34, 0x56, 0x78 -- int3; ca=
ll 0x78563412
> unoptimize-tail:
> 5: 0xcc, 0x2e, 0x0f, 0x1f, 0x84, 0xe8, 0x12, 0x34, 0x56, 0x78 -- int3; ca=
ll 0x78563412
> unoptimize-finish:
> 6: 0x66, 0x2e, 0x0f, 0x1f, 0x84, 0xe8, 0x12, 0x34, 0x56, 0x78 -- cs nopw =
0x78563412(%rax,%rbp,8); call 0x78563412
>
> optimize-int3:
> 7: 0xcc, 0x2e, 0x0f, 0x1f, 0x84, 0xcc, 0x12, 0x34, 0x56, 0x78 -- int3; in=
t3
> optimize-tail(s):
> 8: 0xcc, 0x8d, 0x64, 0x24, 0x80, 0xcc, 0x78, 0x56, 0x34, 0x12 -- int3; in=
t3
> optimize-finish-1:
> 9: 0xcc, 0x8d, 0x64, 0x24, 0x80, 0xe8, 0x78, 0x56, 0x34, 0x12 -- int3; ca=
ll 0x12345678
> optimize-finish-2:
> 9: 0x48, 0x8d, 0x64, 0x24, 0x80, 0xe8, 0x78, 0x56, 0x34, 0x12 -- lea -0x8=
0(%rsp),%rsp; call 0x12345678
>

[...]
