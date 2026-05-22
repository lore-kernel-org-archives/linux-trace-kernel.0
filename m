Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8357D2BF3F4
	for <linux-trace-kernel@vger.kernel.org>; Fri, 22 May 2026 18:51:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.182
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779475867; cv=pass; b=LL10JmC7hT04PA6YVuwLspaIW8yrYufLTPEbPvmmEfgRCnWrHA3rnfHj2nLwNQLD3D7fruPY4pHxp0wP755Ko0Zep5Xp+AHDIck0ab0JTgBOpjGnGqMmZWKLK1DmmxoTl8npN7I7BNa26ZoXdsuGSw73xIsONBQcWr91UZLVwSI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779475867; c=relaxed/simple;
	bh=OaALwqh6GrwITp0qLR++BQAq/ci4DJlYX8wBhLOC/Wk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cR4qnJP0F473e/GF57JER8KMoqzFtNI256Xi+nDjL1B5Ip0ZsauIuABIUYmfgBUhHNZDizH6K2qFDQebkp4IROHndrgEf89jNIwlinnDk6vE5B6W0QV0tJISJn9wYyh4hb7FtHADQb+djIoYd4tUJT9r5xyLsaDk9AXneWDosI4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lb97WR2E; arc=pass smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lb97WR2E"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2bc7b311e77so35126055ad.0
        for <linux-trace-kernel@vger.kernel.org>; Fri, 22 May 2026 11:51:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779475864; cv=none;
        d=google.com; s=arc-20240605;
        b=azxoneUoHVO66ZuTwY2ll8i46OHcbXfdBhf5y8+p4f/l6tngsXwdWUCk9RLms/nFfY
         yVO9SXyT4uDot7X1MFs1K2KRU5aeqi4i5+SiHiFeej6fc4hZR+sDsP5L+MmGAitXJZJh
         6g7jRNH6cURGJGEyQOWMOsbhA0LQ+B4mNJwCEEhwTyNjstjR3X+mg/FSoRyD+OIP2d0Y
         jByOYHuuimE3NESE8V/YfVe3d0rh0+lg9uuWiUzlek7+m3VD3xdpFZQ8Ttsrk9ZSuRHH
         YvR8MURFYRz5AF9TK3jilDFHuxuW8krgrvd1Uetk45YivW5fUVYFQRNIu4WT7cMsWV1H
         liJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=VPzzgffWs9qzaB/mfNK8xnWAoRUsUOJgdkkCUkU1frU=;
        fh=ZeD580Xca2M7iDR+7NQDrJ1c78Sv6BbjQIAwn/OUYYE=;
        b=bsi5NmjSIjlE/Xcx2a1+O77MdG7dk9gvGMxHAW3zOxhf0bkCuq4Cmy8//k5PANkTg5
         30NbFgrKQXGa0MtMRQCv4JzZikw/TJrvza4Vapse5IAXN/2/nRf3sUSuOYhPbHlUcd97
         Yrgs/WvyXSoo2HYJtxei7mLFoehXJIsJW39+S1nn+ZznsKohXCd2m1xRkWrgn7F8F05y
         SPWsXBZdoeh6P13jTf3KYmT9cD1AjlVRNlw2hkPkQoutaJN4ekyTvJUdYLGuYkUnUJfQ
         xQgeapIXGdoj2QMtv0sBw2UI6Jogad/8pauPXLlkIlFLAz1tQKymuHu6gBHRGnLPgyXF
         Hcmg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779475864; x=1780080664; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VPzzgffWs9qzaB/mfNK8xnWAoRUsUOJgdkkCUkU1frU=;
        b=lb97WR2EcPPSjSWOmKPL3Ujgp9rasNFfyjV+lO95azj2wsQDYle5duHJ44qR6Ykxjk
         DRep0zvpuXbYq9lsv4x2CG2uaUbtOAp0ZyaB7ODwxpx/Tl4ObD5ZyhC5pM1I1XPnQyM5
         Ywrqf3tK6QQ58jZVOVZ5tYbilQJFNwmVJ/tGL9fBGl9ntK3wrmAZPIfpm70SYabN4XsD
         eMZHYHlyRP1dMyBbmnMWYKTKRKp9ubImQjFTTOlYfV0eXMf6RhU/JiymGVR0raO/ntnv
         M4zVxfvlQU1XXXRctCzixVTVVrv8hc4Mp3cDqM58qFuHCBRK4h0nbSZ+qQ6LPNzmrHu1
         99mA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779475864; x=1780080664;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=VPzzgffWs9qzaB/mfNK8xnWAoRUsUOJgdkkCUkU1frU=;
        b=r2yIKknl+vOR6fMgiKM0RTlpVT1pIS29P625H+FlRPUsv0cIGELm4RMQOm8CxjS1Gm
         iKeOKIdFinzzbmu57VgxiI+LNDcuKDVlFNbHtGdMDI1r/tHnAyukO41USq59P3uWbZRR
         Dv8IXPqGSAy1aNR79m/tI9169f5GvHW3Vu3svnYZ6h5Neo0QfJgAIqldxD9C7bZnag0Q
         F/sq87E4L5XWop/aRb9R/Jh3W1CUTauCFGtWaKGmufy2NVjnIJ94a/Im9wZ+exapjdPv
         b5oX5yTg12VCqHw8+3FV4QVrmdy/xygxKGxq32grBx8FpwNCUQ2LR6VHxfF6zYB28tu2
         zVOw==
X-Forwarded-Encrypted: i=1; AFNElJ/mH5urrJDn8PdrSWjEJG3pBkyx6h/Hvio9MCUVzuaP9S/8xNFtqhFdXk3qDt65Mj5JvXGOTxFkJcHRRdib+0nkG90=@vger.kernel.org
X-Gm-Message-State: AOJu0YwRAKfv9wXkKSx2Ln1jIKvxXCHR1oN1hBiUzPyXyLBAnnpT0Msg
	97QMtqKjaiKKJjJwRI3c+mZqlw0zHbq0arIebXVqa8c3MacSnb/etScztDD0NPveaTJGeBvcvRa
	t/EUDz0FrdeVkAlflUyhsQFor1e6Po3o=
X-Gm-Gg: Acq92OHO49aPpgfgvL3ZsIj8WaFhkSicF4BqjVE6qs5Dpm6BcAq6pbXKKKUNRSN6WYg
	4zNEXQz5D2g69PJT7PTx7gEI9j3eKd+HEgE6fl43kttSM0NSqE9fTQSmIwfevsXSHJ3e5opkk0o
	bTqjBwh3epWxcmHQvJnGQc7lBxbrHfcgAPu7D9Z2418VAfrM6zWR1q6FC5v8cTldAJmRV6ISDek
	GfAEwV2IVuzJOTwVPE423MEiwgtm/IaDp0gKkwOTycFjI0EbOedpCehxaLhe0Rf/C+INGocUgt+
	Jy2yeg2DQFzpt1md4n71AFqC+6oVIEDMPBna82YRjaUu
X-Received: by 2002:a17:903:350c:b0:2b0:6068:4c5f with SMTP id
 d9443c01a7336-2bea21d2cafmr84051825ad.8.1779475863565; Fri, 22 May 2026
 11:51:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260521124411.31133-1-jolsa@kernel.org> <20260521124411.31133-5-jolsa@kernel.org>
In-Reply-To: <20260521124411.31133-5-jolsa@kernel.org>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 22 May 2026 11:50:44 -0700
X-Gm-Features: AVHnY4Lbju_bUJqvfmufLKSuAon8uixVrUWfmqySa5rIUP5B6I4r3oU-FehqBLc
Message-ID: <CAEf4BzZ+MToBKJS9Vdu=YZrX+2kRpUcmWejVhuoqhtu-ijqDAQ@mail.gmail.com>
Subject: Re: [PATCHv3 04/12] uprobes/x86: Move optimized uprobe from nop5 to nop10
To: Jiri Olsa <jolsa@kernel.org>
Cc: Oleg Nesterov <oleg@redhat.com>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@kernel.org>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 21, 2026 at 5:44=E2=80=AFAM Jiri Olsa <jolsa@kernel.org> wrote:
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
> We use nop10 and following transofrmation to optimized instructions
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
>   2) Trap the call slot before rewriting the NOP tail:
>       cc 2e 0f 1f 84 [cc] 00 00 00 00
>
>      From offset 0 this traps on the uprobe INT3.  A thread reaching
>      offset 5 traps on the temporary INT3 instead of seeing a partially
>      patched call.
>
>   3) Rewrite the LEA tail and call displacement, keeping both INT3 bytes:
>       cc [8d 64 24 80] cc [d0 d1 d2 d3]
>
>      From offset 0 and offset 5 this still traps.  The bytes between
>      them are not executable entry points while both traps are in place.
>
>   4) Restore the call opcode at offset 5:
>       cc 8d 64 24 80 [e8] d0 d1 d2 d3
>
>      From offset 0 this still traps.  From offset 5 the instruction is
>      the final CALL to the uprobe trampoline.
>

I'm sorry if I'm slow, but I don't understand why we need that second
cc at offset 5? Isn't original nop10 processed by CPU as single
instruction? So it will either be at ip of nop10, or at ip+10, no? If
we trap at ip and in int3 handler +10 from there while we are
installing lea+call, why do we need cc on byte 5?

I.e., I don't understand how CPU can end up being at ip+5 until we
finalize lea+call sequence? Can it?


>   5) Publish the first LEA byte:
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
>      Same as 5) above.
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

it's cool that we don't have to do jmp for the first byte, fancy :)

>
> Note as explained in [2] we need to use following nop10:
>        PF1   PF2   ESC   NOPL  MOD   SIB   DISP32
> NOP10: 0x66, 0x2e, 0x0f, 0x1f, 0x84, 0x00, 0x00, 0x00, 0x00, 0x00 -- cs n=
opw 0x00000000(%rax,%rax,1)
>
> which means we need to allow 0x2e prefix which maps to INAT_PFX_CS
> attribute in is_prefix_bad function.
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
>  arch/x86/kernel/uprobes.c | 281 +++++++++++++++++++++++++++++---------
>  1 file changed, 217 insertions(+), 64 deletions(-)
>

[...]
