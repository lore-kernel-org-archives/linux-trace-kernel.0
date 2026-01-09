Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D21CF33F36E
	for <linux-trace-kernel@vger.kernel.org>; Fri,  9 Jan 2026 21:54:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767995688; cv=none; b=jWtVOCauV3/Lp9A9XizlgeFRSV+myZqEsItQoCXI+QRddNj2W4xige4BstDpGMga/k3JTmTOEqyt6k4tTV0UZmVuBVB5vDzzuJDcKuQ4GalB7y/FGYMNmGr0x8e5VkiUBdV05r3s1RJXzvOuF5fb+C7idpendT/RLN7Pwvm1LFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767995688; c=relaxed/simple;
	bh=SyDIWAo0tBvOlQkzTsioGpGAoFU46xUIN8egUPSsTAE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VuifeIG2xXrVvMKmj7p0zDcPBt4lbH5yfXOl8yS4UdWN3268hla4eeHtQxaMWyQEWfYeA9X6d3t37EhBljR59JijHjnpF1Zww6ctANnFmhHHWvpW7C4uxHv9fq69qQ251xR1cQhOCGRjXdPE04mkYnPEKz+SPdv/2mvHDytjd4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=D0g6DY/3; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D0g6DY/3"
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-432d256c2e6so1632149f8f.3
        for <linux-trace-kernel@vger.kernel.org>; Fri, 09 Jan 2026 13:54:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767995685; x=1768600485; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tVAFv8E90nuSwTqKxRgnODazUOEjPtiM1PD2YijofnQ=;
        b=D0g6DY/3wtCyvp/Gf0LO22FxthxTddH9B0/0kRqrLwXA3kvpeMrHam+Qejs9zAx1PS
         lLdrlHbATh2+5etRjYaApirPXaOg4CqVKWo4AWEEt2z3y+zXRE+WjXeoYNQW+xXAtB1f
         lsfPiGt4j2W1GJbYKRnlQnFEbs0YrmvMKcZYwsbWuvtXHbxQtrso+vt7UnPgecYLfg1O
         6iKGjP3WvMH16sity4HUszas2d+vjmeGMU2aILSSJX0JXK2HD/fQ6+dWEsVPaeDWAOAE
         oIUGvdf1H6Lr1kWLQKDmMMlfHPNz9PC1l+JKJtTommqh2+M4aUdfUJnAejAw4lnDTOqO
         Pe4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767995685; x=1768600485;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=tVAFv8E90nuSwTqKxRgnODazUOEjPtiM1PD2YijofnQ=;
        b=jtwXXmZXSih0HFxuQcDMAHzZd7VvihPXMOX4PAc6QuZowZftOzP8LGtrP6ceK9ILo8
         uE87KYnFOeQOQDNtwf7Pn8Xz0m8he61CCioQPM1I++sedv2H1h4nrh3kCai/2rp67VmK
         C4bHCqlZ1o3gYeHxae9gs9RLQTQNvxS3lQNK19J9anJyeU/A46QFi/JV9nKgvPlKMIIX
         2VQgYgCHY2xtxdtGM68UkFh5y/tp3wEHJipBzkUIsuZkwBi+bwv99Ld9f6N4F2xqnEaA
         JDhJKnuKyhKbcje86+o1BqxzXqkhFR8jxSoIc4lw+KaTiqbmxqB3uzhjrBA0b44wHXL/
         7A1A==
X-Forwarded-Encrypted: i=1; AJvYcCUMopUZqO2jK+alJkSAaAuYlu2Nwp0X85mWGviCc5eDEndCDwg4/8lYxndsS7dqikpd9OGimPJSsKbnvpSg5LPEKXY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxdc26Jmp/EMlcNxuV1S3U/zkIPygjCxCmdYgR+mpcEWahSGxKZ
	HeztiviX4LvlmAftiKCZt16djy3f7k4luaOKL0WY8oMuNeGtofeOqeTW85Dwcxz0DSxtq/tvXaf
	y+w63RCJQX0M5QQwnGqFnPpOFrm+WMIA=
X-Gm-Gg: AY/fxX4s9nvIcoN8vJwldHM3tLdCwTTNYaFqj/e0Segp0i4/4srDhffaqyYeBrf5CYr
	aLZ1C9eMojCR8poTL7XAIPSBxCwmY/0bc83HRtlDj77+SsYHEvfDc9xW4no1EmGRxPGZROTih2v
	m414ZwZqIedgI2IIqwxdksva4GUo6PKUVUUzcgiBLZ5GEsynX5AbfVx+ruPKfo1FJKPVJu8sOqZ
	lTpl03Gg6cY5vIJY+96DnFwh40d3W05cKPd/eN6uvVmFfP9Ahqjp9L0mubZ/bMdobvIxEn0lJCC
	O4WzY2EsrKsDH6qBDvofafwR+mBO
X-Google-Smtp-Source: AGHT+IG51RWpvxWbJijZnqsewtYtgtXdOCi2ZMsxFXQVmXp52Ns/wca2BEkmDyNH6PdrUAOuSauZw7OBjggY3NBoASo=
X-Received: by 2002:a05:6000:18a7:b0:430:ff81:296c with SMTP id
 ffacd0b85a97d-432c37983f5mr12201224f8f.34.1767995685071; Fri, 09 Jan 2026
 13:54:45 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260108220550.2f6638f3@fedora> <da261242-482f-4b47-81c6-b065c5a95c4b@efficios.com>
 <CAADnVQJMa+p_BcYxKUgve2=sqRBwSs3wLGAGhbA0r6hwFpJ+6Q@mail.gmail.com>
 <20260109141930.6deb2a0a@gandalf.local.home> <3c0df437-f6e5-47c6-aed5-f4cc26fe627a@efficios.com>
In-Reply-To: <3c0df437-f6e5-47c6-aed5-f4cc26fe627a@efficios.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Fri, 9 Jan 2026 13:54:34 -0800
X-Gm-Features: AZwV_Qh4smiERtW1bxrkxiHXol6EIjr5MaZya9ZuXLg6cgDa8X3XSY9z9aVSQwI
Message-ID: <CAADnVQLeCLRhx1Oe5DdJCT0e+WWq4L3Rdee1Ky0JNNh3LdozeQ@mail.gmail.com>
Subject: Re: [PATCH v5] tracing: Guard __DECLARE_TRACE() use of
 __DO_TRACE_CALL() with SRCU-fast
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Steven Rostedt <rostedt@goodmis.org>, LKML <linux-kernel@vger.kernel.org>, 
	Linux trace kernel <linux-trace-kernel@vger.kernel.org>, bpf <bpf@vger.kernel.org>, 
	Masami Hiramatsu <mhiramat@kernel.org>, "Paul E. McKenney" <paulmck@kernel.org>, 
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Thomas Gleixner <tglx@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 9, 2026 at 12:21=E2=80=AFPM Mathieu Desnoyers
<mathieu.desnoyers@efficios.com> wrote:
>
>
> * preempt disable/enable pair:                                     1.1 ns
> * srcu-fast lock/unlock:                                           1.5 ns
>
> CONFIG_RCU_REF_SCALE_TEST=3Dy
> * migrate disable/enable pair:                                     3.0 ns

.. and you're arguing that 3ns vs 1ns difference is so important
for your out-of-tree tracer that in-tree tracers need to do
some workarounds?! wtf
