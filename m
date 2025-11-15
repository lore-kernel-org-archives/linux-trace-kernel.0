Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 203701F9F7A
	for <linux-trace-kernel@vger.kernel.org>; Sat, 15 Nov 2025 02:43:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763174582; cv=none; b=rxEONO6VAmTuHPVPDuXxK+Bqjl6u35oN0lCC2cP6ifnMC/I8e1DDXQTJK7MFiSKWMYyz+YuqmUDw1ZSHP+V/yr+mPNziaA2sXuOwWCPbk9tgYXGO2L3mW0OwsJLeX1n5h9bess0mwnvE0hQftWNfMIXGM/6lzC0OOgFxmxfFUNM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763174582; c=relaxed/simple;
	bh=w5wgG1MKR91CsxuNvAx7QjHjZXdAXzWJYTL4WmJ8MPA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=isODxo6OeFRB8iPRUQmxGuFbrwygpUSIRG1avKEoJMdlIMpeySYt9//Yzr5mn8JSY0ul9xDor+70AoFcUV69p4YuF6IkE++CoPRhyRZmrIrEkZhHCjFeDdeTIwN9r+3pORiJaRnkb1PEjs++f7xpAlybcjrZNElMfgVmt3p+7cg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=InKzF0/L; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="InKzF0/L"
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-42b2a0c18caso1408911f8f.1
        for <linux-trace-kernel@vger.kernel.org>; Fri, 14 Nov 2025 18:43:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763174579; x=1763779379; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=w5wgG1MKR91CsxuNvAx7QjHjZXdAXzWJYTL4WmJ8MPA=;
        b=InKzF0/L+mUs9nIhjx41agXCOdcSEgjmWDXJOLZZUGTePezDe+yNhNaahbD8PZTLnK
         vogOTEV+tPcnozcuGTdIfCI97MTmr0oQoeKQMzRCNceJlnlRJ+icTlOg2TYGXARjKo/m
         /96eeDVl/Q1uN3dpIYZbWejR22QABMKPq8MvaVu6oGnVxre5UjjbA7r+GBKI93HJKTdu
         QPrsDo3gEWsFaU/T98DjY6GeBK/TJf8Y6bYQLwEbUdrofbELwdeP25sSAkeVXBNeXcuP
         ruDRBROV+fvINebdCsCN5EccAuhXDiuIjmtrd8XEA2FncTCbW8/pceXH4n0ivg5pmgg3
         9ZyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763174579; x=1763779379;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=w5wgG1MKR91CsxuNvAx7QjHjZXdAXzWJYTL4WmJ8MPA=;
        b=HnRsYtgnSSsMAgKIcBy7kKcpn6U2vsl7PEwv9mL7PnNCBkU1wQOs4nGPup/sps6aHZ
         emfFgNA9aA+/8UKrI+YNqlJP/nBsRTs2X5d89RcK2qOkJQDyM6KXZEzfKjC5IKk5tOpY
         PgIcyUCS+FO+AF5EpxyAuxDDb3eU1Ty/tXRREfHkbcoqv6evmNh4nkkbxrLWFcyfktJH
         yIXTJX7Pe6I3K1YxCtRGNwrGz04MI3sLzgFJfcN66sy9t77HFGt4a1dEcUmZwkKIBze5
         QiWDrZCcqNr9kkZSYXSjKuoJrMTCLcWJR9ibQfbOu/DRMwxpCO4n+/fclk0ACkLIkTdI
         VawQ==
X-Forwarded-Encrypted: i=1; AJvYcCUqab6HL3jrjhPoAgSvkpTtIY5NsLKH6H9+RbIWuKjgL848Sh2ajV1Gd31oeryc+F00Pn8hJ7cHHUP5TAOZgkJ8N/Y=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxx9iARI7KKgVCL58ucHimEhurysBhV+BSzXaj4cFXKRGz03GOn
	pjSf6zlEhJswFNI7wMM1s1i3PSvMXVv5jhMLC0PsJEWG9UPyz6JSbhkuxiJCsyB/pOT3Q2zo8LV
	f40ZuOxLaGNhhnOaR5zAR1cFlozCiTno=
X-Gm-Gg: ASbGncvkNZwBkId677JLh862rIN7VCrEae6Pwsp88AvzA3E75dSkfjF4LVzxTzyOeq3
	o0lumA00lG8r8gH1sbUyj/txgU61ml1KnuJ8BhzW/NJeF6fNjUYy0r4ux9c5QMtPdAwO1VakV2z
	mN9P0c1hWb4kBEoR+QDMYrUxhvORWKy7/wiQtcnZXxkddLAe04qC3WtclTSmVpODHkLqj+2cocX
	d8201dNB6nyumqi+6YKP9qu4iJLY8MhztwadEQirpuXu4wjI7MVMlCMloy1vzYzfrCzSvwctu/4
	6R4noiK/AjbUXVGQkA3rtg1wuH1OYx17Sswauvk=
X-Google-Smtp-Source: AGHT+IHVzQscXXmrUSEQCZZL1CtQ82WdcojH4qYjNbQi464TgTrJ4qRsKMtK0vCa8hnqpYgaM17ur3cDY1FZhF1FUhc=
X-Received: by 2002:a05:6000:290d:b0:427:6a3:e72f with SMTP id
 ffacd0b85a97d-42b595a4daamr4462844f8f.34.1763174579433; Fri, 14 Nov 2025
 18:42:59 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251114092450.172024-1-dongml2@chinatelecom.cn>
 <20251114092450.172024-8-dongml2@chinatelecom.cn> <CAADnVQKw9PtRYooO+qKQ70xgNusEn8qusBFfzU+bZ7WXRg3-3A@mail.gmail.com>
 <CADxym3bKsw=mrG+wNErLouhPSeobuqY7sTZRS=HrNeQ=0=p4Jg@mail.gmail.com>
In-Reply-To: <CADxym3bKsw=mrG+wNErLouhPSeobuqY7sTZRS=HrNeQ=0=p4Jg@mail.gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Fri, 14 Nov 2025 18:42:48 -0800
X-Gm-Features: AWmQ_bmXHzn1ZQkddhrB5SugZxEfOGbPyMWJGgz5O7479flWgWW2q2yLLox05JA
Message-ID: <CAADnVQJiHExkioeh3t=4y1CWPiUkeV08ZHjeJfpZChkY6dNvhg@mail.gmail.com>
Subject: Re: [PATCH RFC bpf-next 7/7] bpf: implement "jmp" mode for trampoline
To: Menglong Dong <menglong8.dong@gmail.com>
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

On Fri, Nov 14, 2025 at 6:39=E2=80=AFPM Menglong Dong <menglong8.dong@gmail=
.com> wrote:
> >
> > How about bpf_trampoline_must_jmp() ?
> > and drop if (!ret) fallback and BPF_TRAMP_F_JMPED bit.
> > It doesn't look to be necessary.
>
> I think you are right. We can check if current trampoline is in "jmp"
> mode with the "orig_flags" instead, and remove the
> BPF_TRAMP_F_JMPED. That means that I need to pass the
> "orig_flags" to
> modify_fentry -> bpf_trampoline_update_fentry(bpf_text_poke).

Yep. Makes sense to me.
