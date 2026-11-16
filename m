Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.221.47
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794853293;
	b=xqEbyc2ropUxHM+Dkj+yvED8xWhtp1C+U3mZ4enuPWNTEFVcCq0wPseLTuxErt4NiIYL
	 ZbcBiTGGSMdeHSZC6xWI1z7q/MbI/vl3k7JQ076Vr4ek7lgX6bd+cUVBXixldGWTet9tH
	 csIAoRyeyvw6Vf2FfdqRBdhYEMzBhqtfa4gV4G4yK9MAbI9Gkm4uGqNyNlEzpzL+kZG9T
	 xMvh4Kty7CKgC5QyL6GI1F4GA/MvZbzN+vwYeV1WSjmlexn2+Bl7eUMhRT2bwFFXVRO80
	 HV1Tl5C7Nig6xbChFD6g+ixoZdlUZJ9XzTYOqqHzIcjPKAWc+u6MbW9y33NKej2DpAg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794853293;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=+mRY/21ginX+39dDXt2VmzWx/r/vzzUjn+TaaDwm54w=;
	b=MbCvH26q1o30WMPWE6WguxgAkoARfavrjM+068hNKAoRRT/GJsTz3EjoNcoWOc0arIwl
	 VQp1i2x+CtQTBZoGCQd4XyJ9k77HSsGTvlnG3+lkeUYbmEcm3GYfJyvRA+Vuq+3Xwaa3z
	 oYoB8roJRuz5/G+ySG8xRtVqADJHE0ntpSHf1dv39M9Y4r4/pXc6R3WAhWUap1bInv6dU
	 Oe6MTSBqU23ImO2KkadWP8ToPMaFVyzDRT7MAnnht91Vfpy7fd5nXoTsIRAz+1wnvbwAY
	 44ky+xHnqfeBQfOTl2fpfKDmvhna5iL5u7WvITprcgTBvsb64FGrNrlX7f7ubxHD6vA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="zm/cbSev";
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.221.47
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFF54606A32A
	for <linux-trace-kernel@vger.kernel.org>; Mon, 16 Nov 2026 18:21:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AFF54606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=zm/cbSev
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-492690dd5daso3656564f8f.1
        for <linux-trace-kernel@vger.kernel.org>; Mon, 16 Nov 2026 10:21:32 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794853291; cv=none;
        d=google.com; s=arc-20260327;
        b=RRjORCq6anZyGoMjwalb4JSxSh5tuuXTS+lR+Ayt5a4hOTPa5iu/9ThVYXpgIqMaq7
         sLESmNeD/OcU4McW+ivRJ/+MTSFeh3iD+6L+4vg4KwrjYyCkvOAeVZbYg8Baf7YA+qmZ
         3gU68tU5MNL3yz0s3subZ93X3q+1R/ZdHlZRQpARaLRnXzPpU9vb+bc8PSXAYajD5UBf
         PjOohmBdZuh4ctDnS0Mhov1J69mKRSBr0X38vrqa79jvuuhS1E+MvIhFxDWHjB6Hc8x8
         uck6P7BmAARpk7GocS0Pg5BOPlR/84D5sRtkBFH8rOW6/SRHJQ4ycOCzfILgMk/X2BNX
         OJwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=+mRY/21ginX+39dDXt2VmzWx/r/vzzUjn+TaaDwm54w=;
        fh=rfV1ytZkHd5sGthCUz8b+ZFsFc87YZDMpdceGrntm2k=;
        b=IxNEDSWhZbuEm9XxXk3jJW6Ked32ulxDEcKf5lXO5+WoZaNd7mp+06UXCxBoNzvDiW
         q+dsYWYRpnr9bDMfFEgScNSvfOmU2Lo5pzwUJbCxU/ZpFsHY9eC3DteZSlD/2kYDdHJO
         msjWJBWgQOhyRa+XIwDksb3nuhf0XWv6ks3WKdeZE+ZWzrfMeG3DP5fSrqYsB+3fTufl
         R35j2xeJJRuLNteeEJxcZ4sFwFn8dYEaUpo+47gwiQU7TXbL2grBKTcJPTckcqzHcJnR
         PSpGNCvWT740bm89pYyBjsLp9dlnjV9bhw8FSjHBDUMRDf+btWtFFKTl0OGgo1gmsVVy
         pVHg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794853291; x=1795458091; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=+mRY/21ginX+39dDXt2VmzWx/r/vzzUjn+TaaDwm54w=;
        b=zm/cbSevgb5vX1U4LBW+YkNSL8vMI4OWxN5YoiqU1WeBbLrEIkidzr4BETmU1pUE76
         ibA5HIiy6+4OwhPntqQbQdP2rXXUs/qTz296mY8FQLW/qWqFDzkfIII0HrqsVbUizGRW
         qKLh8HoK+iHj6ov2kVxLmzZbX0U3tUBUW4ewYnzwG8lYN41vYG+Pg+4ZSlEhcZ64gKNW
         mfuIA/YECNDIq3brvfaWU+UmNJem2HB6zClJf5fsoL+ofoB4zZTZW9IuiFZ001vvUaOb
         GTwXf1fR9c4JzAvZkdsjsFXHJkinyMKl1wWc9m4k/iPd8NKV04p+tt7H78cGlJjofFXV
         DM+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794853291; x=1795458091;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=+mRY/21ginX+39dDXt2VmzWx/r/vzzUjn+TaaDwm54w=;
        b=XPcKRYpKTQlr9xNGmFmRj2K9UmWfXtV5LZz5HTj80KG55mUHpB/Ndof8TLEejIAfN1
         dxijAWe5AL4wJGgAAja3CVO9E2rDfhCbPt7vlJ/hLLSbKwlM6RupRISeghaBZSVVWYD5
         sRcKGvZC9tfH75DYeQD5EOVTepEaOcPXYZUBquUMXVvb8KiQJyT/miZQj3kYKPy41T0r
         MfpO+pw0u7MIaZx8kTeYIvLAdNGs8ZK8pF3UBGAAZxLKWUJnL96MtFVAaNtz94HqJrbt
         c0Rg3HK2oW7EMerlHoJmT62uS+JZsL/Vf7WyVlJPpV5IVCgC/SnXAXyntTpe1QyvOyUD
         Hdhg==
X-Forwarded-Encrypted: i=1; AL+hErErTQTNTWBQwuc1Kuq0pUr+mJuG2zRPslNoiPr8CfgmEyVehESJPgm/Eouxg2WAPg5qWaC4aQhDGu5NSsrS7WtD/Ak=@vger.kernel.org
X-Gm-Message-State: APuU4Z8a60lkxRc0Uw6AoPx9/gAesUlJ9tEpgfW5n0TB7IzMKBrn7Tcb
	GHGD4XwmHxdv1QIAgmloczXRVmhh6gqo8vyQ8l/pf7tIkKjh2Uus53r35saGkvLz8epUbJ3CSLD
	ECoUt6KB1+685mLxKfGkOc374j9C5fyk=
X-Gm-Gg: AZFdTZdq/Chph45IAonlxKa0WnvhA6BOdNvADUw+7mloBainXTXdjL10dwkAg51l6bW
	D1ehzhtSt+HwUcfNZOGDYeAnQSa+QGaVvdqe4l/9GhW3q2ibN/zf0ozbC1vceSiwD4e0Z5wGGP+
	FbMhgkDCyE7bCAjZ19KXF6OqLlHFXFQWx6ev5xJoyYt0xKjNpEHalXdMbYsTYP/s615jQSGzotp
	fdaIN+6uz64YSAkOZ8BJ0Ado2dmGWfgQua4PefIGMF0id5UeJCOIz0i1PA+1IbhnmC2tMstxhJp
	MRAHDyTZ0by6bvtnY2w2JyxzDKlgdP8FGNVeki9coxH70XCDzfkdZwRTa3kt9oa9p1tkHVxqe/j
	T0NXvbujEQsf2YRH1Lyh/GM6PFhTF8iEOp6B7vzhR4qIErsCo0IJONnAX/qf3HNkwew7pdIUFrn
	8huCg2/BkicPmtjpbEnR7t0Lwoj6I/btHZJjSDhc66
X-Received: by 2002:a05:6000:2997:10b0:48d:f99d:a0d2 with SMTP id
 ffacd0b85a97d-49c6fe87982mr17681937f8f.15.1794853290904; Mon, 16 Nov 2026
 10:21:30 -0800 (PST)
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Post: <mailto:linux-trace-kernel@vger.kernel.org>
List-Help: <mailto:linux-trace-kernel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-trace-kernel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261116-bpf-raw-tp-regs-preempt-v1-1-d01b6dd8573c@gmail.com>
In-Reply-To: <20261116-bpf-raw-tp-regs-preempt-v1-1-d01b6dd8573c@gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Mon, 16 Nov 2026 10:21:19 -0800
X-Gm-Features: Aa3M54q2mews4rY30WpsGtsZElX86aOjciD3oE3m5xdhDPqaKHj29XjFeRC-ScQ
Message-ID: <CAEf4Bza3BpgTEpqONMcm6FdH2Qc2Tmv-5feVWJfe9wf55iZxpg@mail.gmail.com>
Subject: Re: [PATCH bpf-next] bpf: Disable preemption while a raw tracepoint
 regs slot is in use
To: mike.bazov@gmail.com
Cc: Song Liu <song@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
	Ihor Solodrai <ihor.solodrai@linux.dev>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Eduard Zingerman <eddyz87@gmail.com>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Yonghong Song <yonghong.song@linux.dev>, 
	Emil Tsalapatis <emil@etsalapatis.com>, KP Singh <kpsingh@kernel.org>, 
	Matt Bobrowski <matt@bobrowski.net>, Steven Rostedt <rostedt@goodmis.org>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	bpf@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 16, 2026 at 9:18=E2=80=AFAM Mike Bazov via B4 Relay
<devnull+mike.bazov.gmail.com@kernel.org> wrote:
>
> From: Mike Bazov <mike.bazov@gmail.com>
>
> bpf_perf_event_output(), bpf_get_stackid() and bpf_get_stack() of raw
> tracepoint and tracing programs have no pt_regs, so they fill in one of
> three per-CPU slots, picked by a per-CPU nest counter:
>
>   get_bpf_raw_tp_regs()   level++, use regs[level - 1]
>   put_bpf_raw_tp_regs()   level--
>
> That only works if the users of a CPU leave in the reverse order they
> came, as a task, an interrupt and an NMI do. These programs run with
> migration disabled but preemption enabled, so tasks can leave in any
> order:
>
>   task A              task B              task C
>   get: regs[0]
>   <preempted>
>                       get: regs[1]
>                       <preempted>
>   put: level 1
>                                           get: regs[1]
>                                           fills in its regs
>                       uses regs[1]
>
> B sends a sample or a stack trace with the registers of C. Profilers and
> tracers then attribute it to the wrong task, and nothing reports an
> error. The per-CPU recursion counter of a program doesn't prevent it:
> the slots are shared by all programs, so it takes two of them.
>
> Disable preemption from get to put, as the two other users of this
> scheme do since commit f2c67a3e60d1 ("bpf: Disable preemption in
> bpf_perf_event_output") and commit d62cc390c2e9 ("bpf: Disable
> preemption in bpf_event_output"). Nothing in between sleeps: the
> sleepable bpf_get_stack() of these programs doesn't use the slots.
>
> The cost is small: the helpers already disable preemption around most
> of their work, the unwind in bpf_get_stack() and bpf_get_stackid() and
> all of bpf_perf_event_output(); this adds the few instructions around
> it.
>
> Signed-off-by: Mike Bazov <mike.bazov@gmail.com>
> ---
> A reproducer, x86-64: two raw tracepoint programs on sys_enter call
> bpf_perf_event_output() once each, with the program's number as data.
> Two threads make syscalls on CPU 0, and a SCHED_FIFO thread preempts
> them every 20us. The IP of a sample is regs->ip of the slot, the return
> address of the helper call. The reproducer reads that address for both
> programs from their JIT images and checks every sample.
>
> Without this patch, 7 to 18 samples per program and 10s run have the IP
> of the other program, out of 1.4M. With it, none. bpf_get_stack() and
> bpf_get_stackid() in the same setup return an empty kernel stack
> instead: the unwinder looks for the other task's sp on the current
> stack and doesn't find it.
>
> 5 runs of 10s, debug config, CONFIG_PREEMPT=3Dy, preempt=3Dfull, on
> bpf-next 0fb18ce8a2e9:
>
>                                      without     with
>   bpf_perf_event_output, wrong IP    7-18        0      per program
>   bpf_get_stack, empty stacks        362-535     0
>   bpf_get_stackid, empty stacks      168-364     0
>
> The bpf_get_stackid() case with bpftrace, whose kstack calls it; @a[]
> and @b[] count the empty stacks:
>
> bpftrace -e '
>   rawtracepoint:sys_enter /comm =3D=3D "dd"/ { @a[kstack(1)] =3D count();=
 }
>   rawtracepoint:sys_enter /comm =3D=3D "dd"/ { @b[kstack(1)] =3D count();=
 }' &
>   taskset -c 0 dd if=3D/dev/zero of=3D/dev/null bs=3D1 &
>   taskset -c 0 dd if=3D/dev/zero of=3D/dev/null bs=3D1 &
>   taskset -c 0 chrt -f 1 perl -e 'select(undef, undef, undef, 2e-5) while=
 1' &
> ---
>  kernel/trace/bpf_trace.c | 11 +++++++++--
>  1 file changed, 9 insertions(+), 2 deletions(-)
>

this looks fine per se, but I'm just questioning why do we need all
those shenanigans with per-cpu stack of pt_regs and why we don't just
have local bpf_raw_tp_regs where we need them? seems like pt_regs are
around 200-300 bytes, that doesn't seem ridiculous to have them on the
stack

anyone would object if we just has a simple and straightforward local
variable and get rid of per-cpu hacks?


  | Arch        | pt_regs         | BPF ctx               |
  |-------------|-----------------|-----------------------|
  | x86_64      | 168             | pt_regs               |
  | i386        | 68              | pt_regs               |
  | arm64       | 336/320         | user_pt_regs, 272     |
  | arm         | 72              | pt_regs               |
  | riscv64     | 288             | user_regs_struct, 256 |
  | riscv32     | 144             | user_regs_struct, 128 |
  | powerpc64   | 384             | user_pt_regs, 352     |
  | powerpc32   | 176/192/224/240 | user_pt_regs, 176     |
  | s390x       | 200             | user_pt_regs, 152     |
  | loongarch64 | 320             | user_pt_regs, 360     |
  | mips64      | 304/400         | pt_regs               |
  | mips32      | 184             | pt_regs               |
  | sparc64     | 160             | pt_regs               |
  | sparc32     | 80              | pt_regs               |



> diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
> index b4ff9d4e8..eb3daf2bf 100644
> --- a/kernel/trace/bpf_trace.c
> +++ b/kernel/trace/bpf_trace.c
> @@ -1639,11 +1639,17 @@ static DEFINE_PER_CPU(struct bpf_raw_tp_regs, bpf=
_raw_tp_regs);
>  static DEFINE_PER_CPU(int, bpf_raw_tp_nest_level);
>  static struct pt_regs *get_bpf_raw_tp_regs(void)
>  {
> -       struct bpf_raw_tp_regs *tp_regs =3D this_cpu_ptr(&bpf_raw_tp_regs=
);
> -       int nest_level =3D this_cpu_inc_return(bpf_raw_tp_nest_level);
> +       struct bpf_raw_tp_regs *tp_regs;
> +       int nest_level;
> +
> +       /* The slots nest: a task must not be preempted while it holds on=
e */
> +       preempt_disable();
> +       tp_regs =3D this_cpu_ptr(&bpf_raw_tp_regs);
> +       nest_level =3D this_cpu_inc_return(bpf_raw_tp_nest_level);
>
>         if (nest_level > ARRAY_SIZE(tp_regs->regs)) {
>                 this_cpu_dec(bpf_raw_tp_nest_level);
> +               preempt_enable();
>                 return ERR_PTR(-EBUSY);
>         }
>
> @@ -1653,6 +1659,7 @@ static struct pt_regs *get_bpf_raw_tp_regs(void)
>  static void put_bpf_raw_tp_regs(void)
>  {
>         this_cpu_dec(bpf_raw_tp_nest_level);
> +       preempt_enable();
>  }
>
>  BPF_CALL_5(bpf_perf_event_output_raw_tp, struct bpf_raw_tracepoint_args =
*, args,
>
> ---
> base-commit: 8835113107b2cf75df33a71e265cdeec5d5d13e0
> change-id: 20261116-bpf-raw-tp-regs-preempt-1f7019989ab9
>
> Best regards,
> --
> Mike Bazov <mike.bazov@gmail.com>
>
>
