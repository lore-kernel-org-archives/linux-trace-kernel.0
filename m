Received: from mail-oa1-f65.google.com (mail-oa1-f65.google.com [209.85.160.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F4CA2D5C8E
	for <linux-trace-kernel@vger.kernel.org>; Thu, 18 Dec 2025 15:05:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766070341; cv=none; b=UH/JpLZnh9GTCvHf7E0VEDRh93EfzWEkelGRexaScVVg9dWTDBjyprPiFkVynLSo3moXLbNAApYexdkKw9YDzVRlaH3q+2GKKJkyG5sOeKmKWpLrX3R4zPC8g+TcQ7Hyk2eoWW2+/K+PbHQXuMuJqWyQuV8t9UTL1A2/5OE+Bbg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766070341; c=relaxed/simple;
	bh=2fXW/yTQnSzTFycxk33wkAysOyNdy+IqqPw6vt65LzQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EHcJhMAc3EAt5b0hFwxkUKwdiybkGdNdgfUahPnGZq6TdC+dVuCoI/7theFdGnQW1JgJb0+6OdY+DF54pIGYn8YKnZDpvlvWbxb5Pca4pChg8ONBtyU9QrXTa67dzWUBsMax7UZmuQIuSEARjofE0WIx2Mtn0xHB9Tp4c9gbtZc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OT7P/G9X; arc=none smtp.client-ip=209.85.160.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OT7P/G9X"
Received: by mail-oa1-f65.google.com with SMTP id 586e51a60fabf-3e37ad3d95aso534056fac.3
        for <linux-trace-kernel@vger.kernel.org>; Thu, 18 Dec 2025 07:05:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766070338; x=1766675138; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7x1LVvCf3VLvAjtIqXQBbk4xwbIbAqccEsSWEs0YiDA=;
        b=OT7P/G9X9OJSjqla3Y/0bv4C+Q3L5xtHMNGGeeBswTGDmQk/JL17a9QWOoyf6sL8Qc
         OlVjpXiiQv8+7kd6fRbdhtnhEJ8y88RRfRXDgAWQBQzBXFo1jnCbKZCtNArtiOtCCksl
         RmJHDAYZD7Bt+9gNTYpW43gger22LrCoPS0rNbeAfDVJBdKo7Kxgc8U+QY731m1o2jtf
         nYa04cw3+nLxh5w968OoOonAvJexhkgjmWgY/2hSc/WKjcgqHaWECvETqo2AFOlOhRme
         qXfR9UuYZTItdtZUBS125fOpsBR2gZ0yjfqb5WTWqWxICYVPH0NhdsEKHsw9SuWMgraY
         MKnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766070338; x=1766675138;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=7x1LVvCf3VLvAjtIqXQBbk4xwbIbAqccEsSWEs0YiDA=;
        b=t7h4wpfUdblLuKXzZaiBb5jYU+fenHcOXoGEcJN5qrY7Xs27oVqdwrqHpX9ZUKDr92
         Keu0WyqvNkEtTdySAyjnlPEFkpQS9U0smtJl3p9GceTCD68Qia5NoytNZDgeQnDNaJZY
         X/2KSokRi5vuq1stCJC0maxFyOMZXrrMExihaS3AGBS5N8XrcLaAbbX9wrE6CmlAzVyJ
         BPQRNecsxr7R0u62yqBquEQMm7I8aVx1uyR/E/f4vvfOQ8Rl0ovFDYikRTGh1ERHwov+
         9Kp0+tG1eVdXswjVJDtDH0NZtmKPcezF72MXTdB0cSoyqdZeC369ivSTJqrf0qpFVu+K
         bErw==
X-Forwarded-Encrypted: i=1; AJvYcCUOhPE+M9UgKXDLH+TlK83mSYARlUC4B7E9qLtasaWbIhzRnIvxkw7mWlaQqjBdg/lgggMN7YbfpPLYkJOX5g/vD2U=@vger.kernel.org
X-Gm-Message-State: AOJu0YwkvkSh2EnXqCaTVKnJ2IXvyDvmkTB4qALbFCuSxqtSVmM3J6g5
	CH75odseRSJn+isIFn4F6RlGCgioyOSRBLLDe29dLhc1Km7uUBeXJwJc/SZbzgTIWQd3RoOUEuB
	fU71SLWqBFC+H/e+X+B/xT/qWsPQtgTw=
X-Gm-Gg: AY/fxX4TMi5b8gCbGs8JrOIephdSGFPz9j9nOdf5xRLKcCynuqnueXb90RDDjMTO6s0
	XGBMriyDOJ63mm1FRIrVqupqV50lE3b1LOjukFFBn6ZGmYkVNAF0tqgYGh8USgLZnR1OVah2Fl9
	mjmnc9KaTZr+pEd9oZoPkOvoLAT8XbhqL2TNJ8S6/cLfo30F9QejYtBd7GyZFg9RjxJzTZHWjwN
	6oxA45H/O4H1I527xagZh92xqwdIUiGRjW8IZj65z5i7KMyWTma/DDiHP5lb/RmEiMjhV0=
X-Google-Smtp-Source: AGHT+IF/fTgkutYeIcFjjXnYQpZJcb84xx01Knr1X9n+e2+wE5pUKMKQXwP4SNGCv9mNmL7FhzoGgDf01xZJLuAW9uk=
X-Received: by 2002:a05:6808:1919:b0:450:4628:e3ce with SMTP id
 5614622812f47-455ac843d39mr8893507b6e.15.1766070334496; Thu, 18 Dec 2025
 07:05:34 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251118123639.688444-1-dongml2@chinatelecom.cn>
 <20251118123639.688444-4-dongml2@chinatelecom.cn> <874ipnkfvt.fsf@igel.home>
In-Reply-To: <874ipnkfvt.fsf@igel.home>
From: Menglong Dong <menglong8.dong@gmail.com>
Date: Thu, 18 Dec 2025 23:05:23 +0800
X-Gm-Features: AQt7F2rBCJ5wWtnPg0y__c3D4AxuhAyRjyuKDUvUD5czSDgloXW-454tfs3x8_U
Message-ID: <CADxym3byFuS7c9C17pUc7EE+ipAoQMdJgsBM0wr5+VV5esNw-Q@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 3/6] bpf: fix the usage of BPF_TRAMP_F_SKIP_FRAME
To: Andreas Schwab <schwab@linux-m68k.org>
Cc: ast@kernel.org, rostedt@goodmis.org, daniel@iogearbox.net, 
	john.fastabend@gmail.com, andrii@kernel.org, martin.lau@linux.dev, 
	eddyz87@gmail.com, song@kernel.org, yonghong.song@linux.dev, 
	kpsingh@kernel.org, sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org, 
	mhiramat@kernel.org, mark.rutland@arm.com, mathieu.desnoyers@efficios.com, 
	jiang.biao@linux.dev, bpf@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 18, 2025 at 10:45=E2=80=AFPM Andreas Schwab <schwab@linux-m68k.=
org> wrote:
>
> On Nov 18 2025, Menglong Dong wrote:
>
> > Some places calculate the origin_call by checking if
> > BPF_TRAMP_F_SKIP_FRAME is set. However, it should use
> > BPF_TRAMP_F_ORIG_STACK for this propose. Just fix them.
> >
> > Signed-off-by: Menglong Dong <dongml2@chinatelecom.cn>
> > Acked-by: Alexei Starovoitov <ast@kernel.org>
>
> This breaks RISC-V:

It's weird, as the 2 flags should be set together all the time
in RISC-V. Sorry that I'm already in bed, I'll check it tomorrow
morning.

Thanks!
Menglong Dong

>
> [    8.584381][    T1] systemd[1]: bpf-restrict-fs: LSM BPF program attac=
hed
> [    8.588359][    T1] Insufficient stack space to handle exception!
> [    8.588823][    T1] Task stack:     [0xff20000000010000..0xff200000000=
14000]
> [    8.589219][    T1] Overflow stack: [0xff600000ffdad070..0xff600000ffd=
ae070]
> [    8.590133][    T1] CPU: 1 UID: 0 PID: 1 Comm: systemd Not tainted 6.1=
8.0-rc5+ #15 PREEMPT(voluntary)  c900881ed1c1988ec5cf3e914d0edeb1b4d83ca3
> [    8.590898][    T1] Hardware name: riscv-virtio qemu/qemu, BIOS 2025.1=
0 10/01/2025
> [    8.591494][    T1] epc : copy_from_kernel_nofault+0xa/0x198
> [    8.592292][    T1]  ra : bpf_probe_read_kernel+0x20/0x60
> [    8.592658][    T1] epc : ffffffff802b732a ra : ffffffff801e6070 sp : =
ff2000000000ffe0
> [    8.593121][    T1]  gp : ffffffff82262ed0 tp : 0000000000000000 t0 : =
ffffffff80022320
> [    8.593566][    T1]  t1 : ffffffff801e6056 t2 : 0000000000000000 s0 : =
ff20000000010040
> [    8.593997][    T1]  s1 : 0000000000000008 a0 : ff20000000010050 a1 : =
ff60000083b3d320
> [    8.594446][    T1]  a2 : 0000000000000008 a3 : 0000000000000097 a4 : =
0000000000000000
> [    8.594940][    T1]  a5 : 0000000000000000 a6 : 0000000000000021 a7 : =
0000000000000003
> [    8.595396][    T1]  s2 : ff20000000010050 s3 : ff6000008459fc18 s4 : =
ff60000083b3d340
> [    8.595831][    T1]  s5 : ff20000000010060 s6 : 0000000000000000 s7 : =
ff20000000013aa8
> [    8.596215][    T1]  s8 : 0000000000000000 s9 : 0000000000008000 s10: =
000000000058dcb0
> [    8.596641][    T1]  s11: 000000000058dca7 t3 : 000000006925116d t4 : =
ff6000008090f026
> [    8.597065][    T1]  t5 : 00007fff9b0cbaa8 t6 : 0000000000000016
> [    8.597363][    T1] status: 0000000200000120 badaddr: 0000000000000000=
 cause: 8000000000000005
> [    8.598033][    T1] Kernel panic - not syncing: Kernel stack overflow
> [    8.598597][    T1] CPU: 1 UID: 0 PID: 1 Comm: systemd Not tainted 6.1=
8.0-rc5+ #15 PREEMPT(voluntary)  c900881ed1c1988ec5cf3e914d0edeb1b4d83ca3
> [    8.599244][    T1] Hardware name: riscv-virtio qemu/qemu, BIOS 2025.1=
0 10/01/2025
> [    8.599659][    T1] Call Trace:
> [    8.600117][    T1] [<ffffffff8001a1f8>] dump_backtrace+0x28/0x38
> [    8.600517][    T1] [<ffffffff80002502>] show_stack+0x3a/0x50
> [    8.600844][    T1] [<ffffffff800122be>] dump_stack_lvl+0x56/0x80
> [    8.601176][    T1] [<ffffffff80012300>] dump_stack+0x18/0x22
> [    8.601518][    T1] [<ffffffff80002abe>] vpanic+0xf6/0x328
> [    8.601819][    T1] [<ffffffff80002d2e>] panic+0x3e/0x40
> [    8.602088][    T1] [<ffffffff80019ef0>] handle_bad_stack+0x98/0xa0
> [    8.602395][    T1] [<ffffffff801e6070>] bpf_probe_read_kernel+0x20/0x=
60
>
> --
> Andreas Schwab, schwab@linux-m68k.org
> GPG Key fingerprint =3D 7578 EB47 D4E5 4D69 2510  2552 DF73 E780 A9DA AEC=
1
> "And now for something completely different."
