Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1B1B34BA29
	for <linux-trace-kernel@vger.kernel.org>; Thu,  2 Oct 2025 02:03:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759370641; cv=none; b=RUGgbPkaHfgns7bkAVq4wMltbVGhDyOxvMwD5gFUnc0j75TRzEmfYvEJ+ZaGDVbv6g2u3JlCeFxYoTZSbJ+FxswSVWHd0+yPB3U41s8tUUMqQpmBdbVSLEp69NWpIuv0hl8fHuiIoNY4abZhw9yv16Axmzz2aI9k6MucswMT4kI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759370641; c=relaxed/simple;
	bh=qfkFykX9oT8Wwuwz9nMEAGfjVD2TjbyMyEw20I8aMuE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PP4XN15MerT1PowljN6b2xbqeVmS8LKedPRtfK5r/3WOIF7iVc6hGTHQZeFg0JNiXj82TcJ91rQ9q2ld3QmBA0NbOuXfS5wFwLFUiL7io3O3NHH04lspJ4Cp2FsTu6BedONLj4qQdjX3V5pIWliTWzYCbStFm31oMZGR/RizZuQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Wr2wBhLC; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Wr2wBhLC"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-46e37d10f3eso3242655e9.0
        for <linux-trace-kernel@vger.kernel.org>; Wed, 01 Oct 2025 19:03:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759370638; x=1759975438; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VRu4pkeN/m6CBPtrxw2JgG5G5rjbyuAY3nSK+8JNtOA=;
        b=Wr2wBhLCb9KAcstbRD8WZVPcHVVRupu/I/grut1lBo2efdmkJ739z0NKviX9nwmjV0
         mbqELmlQjTk3PNOjAbLgRF0+HcDnDwF3dmoSnHr6KFTcdgcYpOPH2/cjCLO2aR3MEFGy
         ZysFRmLeVPWVK+DndDOnV0k5WM4Xi/O1MJgVD9f7KWfArOElOnX1nK1cmfXaZSVwH5ui
         7Tt1Xg1edChuxygWdQGAbR9i5yS34GGlBWJSCTo+ZhCbEBfwa1Ti5B8YXQ4n9XR5bcjP
         ylwOmarkrCGJjYtB91erLKyvSU/B4nJNHNq26X+DJnobRJ1w/uLXg2e5RMHcRxPL7RTf
         vj5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759370638; x=1759975438;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VRu4pkeN/m6CBPtrxw2JgG5G5rjbyuAY3nSK+8JNtOA=;
        b=hQ9NBzEUmaIQKpKOOUX5vogtBmb05/CqWaVt4aoHP2+JtqYO7N1xB+w6xRlLTa+2c2
         Q6FnreLRo0kuiNfdlooNgCF4ZdyCWbFKzlM9QMK4uX4AANXSLrH7E9Wf2Z7eGYhqmHgF
         OMKrKDFudVmbq1f8qaqqs6DGIc6awBaS60c3Tuk+CVHVEHgkmIrC4d0Dz4SXvHlMogfd
         Vj1lHCLKUHYSkFhgrHger7S1QVqgT5YUh4bUKm61jHr77llS5H+XyZqAsuc81unZCH21
         oAMyAi65n87q3zBZpPmkZhWasVdeZToHOoM43O4kL1AiWG5ENKvvl4XSqwkFo5Ul78qz
         B9qA==
X-Forwarded-Encrypted: i=1; AJvYcCU9oBdQDlu+iUKw6sm5/xmXHctrpq7T+QtsZ8GUHZNmIGv5B9CNsYr4weNgBU4sTjiKH0E7ioVAn+1zZJ1SunESt8Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YzvsPP+SPEQhaHoTIdpqemvyH3vLAalvkiuEsP3wCt8SyIDlNTb
	BezWztyu81NhAzR0MsptO20h+SRQKWQ5yUSZ6Y3BpwHwGfgzmPMJg0YdOM5AludgwXwT0Ux7WVY
	uALQ7Via8LyMiL7E7DHMyB35Jgad+9Hk=
X-Gm-Gg: ASbGncuFnRmimZ5i2+38puo7ahB5KzHBj4j695ddeoqZ/CDOsEPRiE6BFgxYzvyESlY
	TqNf/0TAzAM0wGp1GA/eQLSP5xfN3Pk5ib5cjWEc9WRiTVykSRh14uEB3rPrG1CEH8YnkWnaZes
	q25wWANTaDFwAsSvUTQ2ZLa1IfIt2F0c20r76gtG9m3H95HWf9DkCw7BRjocnxKmMpkSjhFQquM
	mKlon08Ow3Oust/FCbK0PxdVsTy/ajCiCWG5YWEemxxxX3qQM/de3e1odSz
X-Google-Smtp-Source: AGHT+IEOsHDrAriPQ5ccIWk1a9ocxN8KZjRUxjEFjc8SwZX/NB0bSLRxrd32X+av/aKdyuNLHStG3LqxQMA5k6kn1yI=
X-Received: by 2002:a05:6000:4013:b0:3ec:b384:322b with SMTP id
 ffacd0b85a97d-42557a149f4mr3761821f8f.46.1759370637917; Wed, 01 Oct 2025
 19:03:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250927061210.194502-1-menglong.dong@linux.dev> <20250927061210.194502-2-menglong.dong@linux.dev>
In-Reply-To: <20250927061210.194502-2-menglong.dong@linux.dev>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Wed, 1 Oct 2025 19:03:46 -0700
X-Gm-Features: AS18NWAHYLA9oCGA8Iamn1bDZUfApRX46uDAtbLK0AvoaC3mAs81FWBgd1QEVe4
Message-ID: <CAADnVQJAdAxEOWT6avzwq6ZrXhEdovhx3yibgA6T8wnMEnnAjg@mail.gmail.com>
Subject: Re: [PATCH RFC bpf-next 1/3] bpf: report probe fault to BPF stderr
To: Menglong Dong <menglong8.dong@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>, bpf <bpf@vger.kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, 
	linux-trace-kernel <linux-trace-kernel@vger.kernel.org>, jiang.biao@linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 26, 2025 at 11:12=E2=80=AFPM Menglong Dong <menglong8.dong@gmai=
l.com> wrote:
>
> Introduce the function bpf_prog_report_probe_violation(), which is used
> to report the memory probe fault to the user by the BPF stderr.
>
> Signed-off-by: Menglong Dong <menglong.dong@linux.dev>
> ---
>  include/linux/bpf.h      |  1 +
>  kernel/trace/bpf_trace.c | 18 ++++++++++++++++++
>  2 files changed, 19 insertions(+)
>
> diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> index 6338e54a9b1f..a31c5ce56c32 100644
> --- a/include/linux/bpf.h
> +++ b/include/linux/bpf.h
> @@ -2902,6 +2902,7 @@ void bpf_dynptr_init(struct bpf_dynptr_kern *ptr, v=
oid *data,
>  void bpf_dynptr_set_null(struct bpf_dynptr_kern *ptr);
>  void bpf_dynptr_set_rdonly(struct bpf_dynptr_kern *ptr);
>  void bpf_prog_report_arena_violation(bool write, unsigned long addr, uns=
igned long fault_ip);
> +void bpf_prog_report_probe_violation(bool write, unsigned long fault_ip)=
;
>
>  #else /* !CONFIG_BPF_SYSCALL */
>  static inline struct bpf_prog *bpf_prog_get(u32 ufd)
> diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
> index 8f23f5273bab..9bd03a9f53db 100644
> --- a/kernel/trace/bpf_trace.c
> +++ b/kernel/trace/bpf_trace.c
> @@ -2055,6 +2055,24 @@ void bpf_put_raw_tracepoint(struct bpf_raw_event_m=
ap *btp)
>         module_put(mod);
>  }
>
> +void bpf_prog_report_probe_violation(bool write, unsigned long fault_ip)
> +{
> +       struct bpf_stream_stage ss;
> +       struct bpf_prog *prog;
> +
> +       rcu_read_lock();
> +       prog =3D bpf_prog_ksym_find(fault_ip);
> +       rcu_read_unlock();
> +       if (!prog)
> +               return;
> +
> +       bpf_stream_stage(ss, prog, BPF_STDERR, ({
> +               bpf_stream_printk(ss, "ERROR: Probe %s access faule, insn=
=3D0x%lx\n",
> +                                 write ? "WRITE" : "READ", fault_ip);
> +               bpf_stream_dump_stack(ss);
> +       }));

Interesting idea, but the above message is not helpful.
Users cannot decipher a fault_ip within a bpf prog.
It's just a random number.

But stepping back... just faults are common in tracing.
If we start printing them we will just fill the stream to the max,
but users won't know that the message is there, since no one
expects it. arena and lock errors are rare and arena faults
were specifically requested by folks who develop progs that use arena.
This one is different. These faults have been around for a long time
and I don't recall people asking for more verbosity.
We can add them with an extra flag specified at prog load time,
but even then. Doesn't feel that useful.
