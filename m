Received: from mail-yx1-f67.google.com (mail-yx1-f67.google.com [74.125.224.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 251BF1E0DD8
	for <linux-trace-kernel@vger.kernel.org>; Sat, 15 Nov 2025 02:26:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763173595; cv=none; b=ln0Vk5ROSZFsde5EvToP3my/R3f+DDAevvMq/OmCxVrWMWdBXI3Vsy/hQH/qh6+GnEnIqVq6PKbH0IBMV0tPIbNRPMjq3qbglb3Dar5vPlwiWg/97ZlScyXu1vVUM6Z8wPXe++DDPZDwTS4I+7sfDMnDF3b+WrtMvCyo4/FG88g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763173595; c=relaxed/simple;
	bh=w/K6RurYyjKwDb9uwr75l06xBH4l2DKlYqRmxHlI2jk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KQ3Uzn589hYCzyz8OALoyfE0s7XDyjEl6IzuBlsm53gjNzhwhrJctkGgoC5gIRhSub7d5pp3dPbavxPvwuyGMD3YaG+KBbAxnDel2JHd3dmJwkpg1Z2/r5Dqfai98EFcfCwJmiep+IpwpxvB30+cpW5wgOVveB0nMoHFt2fjH3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Mt+NTtak; arc=none smtp.client-ip=74.125.224.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Mt+NTtak"
Received: by mail-yx1-f67.google.com with SMTP id 956f58d0204a3-640f2c9cc72so1987627d50.3
        for <linux-trace-kernel@vger.kernel.org>; Fri, 14 Nov 2025 18:26:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763173593; x=1763778393; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4p8fQmw3Qlh03PwyHgF0UmpBDAFUeZSS6CX7+CeIrVQ=;
        b=Mt+NTtak+2wk/3nn5F5N0ECx2AmVbISF7N1MbYhhhNAJlhBgsHUZy0y+DBbmwrwU9o
         gTrzHBQKxGuGOpzuk/RAXigCmQCdphMcEW5YGodLKEzCO2YRmiOgLrNc59F6n9RH0hT+
         hFrn15UjIrFalQSDTLQA3NeVBp/bi66aWE+UyQ9fGD0/fGPhyWaRH1rC7S8+tHmaXmdW
         38u3r+Lo1w7A8Nm1Ienq12kVsjC2+iUKctVdTpfg0jyR46AtS0imb6SPeEuVZhJvUXxz
         pB2sH1ClItAXxES1YLrTEyhozhd5frWs0OQGQv7XBK1XIkCn+cuvKT8aXhVVXhVXAfb1
         /s7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763173593; x=1763778393;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=4p8fQmw3Qlh03PwyHgF0UmpBDAFUeZSS6CX7+CeIrVQ=;
        b=WPtBbrrLcypFwB1s/D7outY3kWzDnRBoP9vKMyCh0uYySW85QO+74AIa36OrKoQs6I
         Oy5JJpX6WqLodiAf6AVyK9I90NbtFoxW8bmUaKLVpOHArzp48rTZ/rl2KxlGIM9iH/UR
         WykOhxhfN02bvx4fyD0Fbu/+fSnZ3+pW/MGyeTJHmXRGf4/uu2CnpvEV3DWSmK5l+7fy
         KG4suX2nYBg15rsXx/8Ba0KBFwCcvhS4EeyP7kir0DAUdGuBN2/GqdA52kJKtDmhfdhR
         BRLmNEDKHZ7QUHYloHbq9siJjeX2w/ah+CrV9xJMnpwUDUQ5GO4cXlNspU0RXOCJqWeq
         a0cQ==
X-Forwarded-Encrypted: i=1; AJvYcCWi7CyVgYaHzHPCFIdotsZRqfGwnVcrwCzTx5sQLx1CylyUaHlJBVFfHVGUK2KA5vnrfNSLuKdHMhMBAVeXTl0AWNw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxMQr/BTMkBB+x2ZAfAHb0yGDfxrxq369gTtoEaJCjnKmeGUFGQ
	N8LSZhlc8xuhZ+rdR23Wc9BJEgcXYvgUIqHY8pG+17/8OXiNG/nNLhI5XfCKfHiHBu90kyPiAuz
	ZgUsthDmmSI5T/RzdrcksMXhDeO2yegQ=
X-Gm-Gg: ASbGncvMbvlhXAk1wLrzuV1iq9czr0cGt734yimjio5JY47CBDN59ZU+TCwyZGb5wM4
	JacBib6icKqU8nPD3gM+dhBBikeca+SDAgI6D8SWa1kKIEYzn6/trXVjy0nMkGNZ8eOcsvngocb
	qjesP+2pueIqDuHNKBRmLUbKi5NdLR6T0BhuuFyh4rp4uRexitCmmNOR7xnxdERdEyGGRcKLb0h
	c/83DLLjOpKFIC/NEjNKZF+I50ICuqyBOZNy+3INzoUeM/0QVclxre9kGo3bjK8SdS7MjM=
X-Google-Smtp-Source: AGHT+IHvm41JAhUDEbyWTid8WkjAehWDnQr8gxbsk25b0U+TU9Sap7KQD49QTdx/V9RytVZkc+BiLTIzprFbrokBkLo=
X-Received: by 2002:a05:690c:4882:b0:787:c849:6554 with SMTP id
 00721157ae682-78929dff3e2mr94246947b3.13.1763173593065; Fri, 14 Nov 2025
 18:26:33 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251114092450.172024-1-dongml2@chinatelecom.cn>
 <20251114092450.172024-6-dongml2@chinatelecom.cn> <CAADnVQLemtF-m5et+c5pWppNZoWnWBehtMCHVJU9Yagvi+dRZA@mail.gmail.com>
In-Reply-To: <CAADnVQLemtF-m5et+c5pWppNZoWnWBehtMCHVJU9Yagvi+dRZA@mail.gmail.com>
From: Menglong Dong <menglong8.dong@gmail.com>
Date: Sat, 15 Nov 2025 10:26:22 +0800
X-Gm-Features: AWmQ_bmbzoRUinc7PMPnzhciwmLUmNSoyFDnepiHxuuzmLIwO33uSziHm1ylXkk
Message-ID: <CADxym3a3UCgW1ukK_VZEfqM6YvPT1ZAE=Wd52oq1FhHwdhf4Cg@mail.gmail.com>
Subject: Re: [PATCH RFC bpf-next 5/7] bpf: introduce bpf_arch_text_poke_type
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>, Steven Rostedt <rostedt@goodmis.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, John Fastabend <john.fastabend@gmail.com>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, Eduard <eddyz87@gmail.com>, 
	Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>, 
	Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, bpf <bpf@vger.kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, 
	linux-trace-kernel <linux-trace-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Nov 15, 2025 at 2:42=E2=80=AFAM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Fri, Nov 14, 2025 at 1:25=E2=80=AFAM Menglong Dong <menglong8.dong@gma=
il.com> wrote:
> >
> > Introduce the function bpf_arch_text_poke_type(), which is able to spec=
ify
> > both the current and new opcode. If it is not implemented by the arch,
> > bpf_arch_text_poke() will be called directly if the current opcode is t=
he
> > same as the new one. Otherwise, -EOPNOTSUPP will be returned.
> >
> > Signed-off-by: Menglong Dong <dongml2@chinatelecom.cn>
> > ---
> >  include/linux/bpf.h |  4 ++++
> >  kernel/bpf/core.c   | 10 ++++++++++
> >  2 files changed, 14 insertions(+)
> >
> > diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> > index d65a71042aa3..aec7c65539f5 100644
> > --- a/include/linux/bpf.h
> > +++ b/include/linux/bpf.h
> > @@ -3711,6 +3711,10 @@ enum bpf_text_poke_type {
> >         BPF_MOD_JUMP,
> >  };
> >
> > +int bpf_arch_text_poke_type(void *ip, enum bpf_text_poke_type old_t,
> > +                           enum bpf_text_poke_type new_t, void *addr1,
> > +                           void *addr2);
> > +
>
> Instead of adding a new helper, I think, it's cleaner to change
> the existing bpf_arch_text_poke() across all archs in one patch,
> and also do:
>
> enum bpf_text_poke_type {
> +       BPF_MOD_NOP,
>         BPF_MOD_CALL,
>         BPF_MOD_JUMP,
> };
>
> and use that instead of addr[12] =3D !NULL to indicate
> the transition.
>
> The callsites will be easier to read when they will look like:
> bpf_arch_text_poke(ip, BPF_MOD_CALL, BPF_MOD_CALL, old_addr, new_addr);
>
> bpf_arch_text_poke(ip, BPF_MOD_NOP, BPF_MOD_CALL, NULL, new_addr);
>
> bpf_arch_text_poke(ip, BPF_MOD_JMP, BPF_MOD_CALL, old_addr, new_addr);

Yeah, much clearer. The new helper also makes me feel a bit
dizzy.

Thanks!
Menglong Dong
