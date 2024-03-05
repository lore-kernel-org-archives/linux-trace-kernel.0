Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47E2329417
	for <linux-trace-kernel@vger.kernel.org>; Tue,  5 Mar 2024 03:03:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709607825; cv=none; b=SnKs7/tSEOHjg1Mx0DMpPad7e+EubSdA7Y4FnUcrm8+uZYiJqxQaUXvoTdJVFBvMZojMOkroePsiYNdNAJBhixOrqL3fVC4dBZ8a8ctaLqXjCRJqwCecSJZrx+wo7WX+KwA5OEohUq/4GsARIbDM+nMHQzWsZ6Yog6r/Tva7yKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709607825; c=relaxed/simple;
	bh=jeP7yg03z/TtSAn/5mkkxNPbmXMp4hRVJ5K3zTplORI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OjnTn9mhAhZgWXvANGDWjuPdiRN3iln/DbLdgnevkSDx8RdwRCflBv7jRU/mf/QvxQMAfFPGYG5taIzkrYz2oRho13bifh7JGNdDSmWsgwHqnYpBnuKg1tx0d5xB4o8je3MI2adMDQ7jE4rbGAXNJUZk0y1M6P8CK5gmp3xGePQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=HKyllNPx; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="HKyllNPx"
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-5101cd91017so7235345e87.2
        for <linux-trace-kernel@vger.kernel.org>; Mon, 04 Mar 2024 19:03:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1709607822; x=1710212622; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jeP7yg03z/TtSAn/5mkkxNPbmXMp4hRVJ5K3zTplORI=;
        b=HKyllNPxwzmL+ZZDWf30oH1GUBln58jGMWyd4ynQfDA762c3RVQ+YoTEz9bwKdLvwV
         jN8AoACX8sIgt8+do9rb7d3mmlZYvs8xMMlkYk0JeCmhtdmtuY9Jndq5vMKyyyucbmuy
         JC9/1W92yhOb+1/hYPiwu0xaRQesyc5uau9ZCesgJLP+2GB2AmGW7IZfLsTd0OTkztNm
         Orp8nYa4LpX9z2GdE2i8a0BL/JiUJJiEExy2rDGONQ/w4lwBSZZYBlE48bAQCkSH9Ck9
         3AU+PBHdmSLzx+/xXSNL7yfKh4v7e2rYI84M1/9RJVAUXSsSP8059uW9AkRK5eHRJQgx
         90Dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709607822; x=1710212622;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jeP7yg03z/TtSAn/5mkkxNPbmXMp4hRVJ5K3zTplORI=;
        b=r2FYufPilj9t/apYzosJDKwXU1LDNnreBj7ae/vOZl0NZ6NirAmEOpWk82kRlkCGBd
         geaWUbZ0alWTYdQreqeQVL21BJFTUvk9kIEvT0QjYHWcu+a8j1776QKMH+fe1xyT8nGl
         7f1UH14g2L2/b9AQwdVB4MfiZAlI0JzYMQw5XfebWUqcFTXKhQmb28XjE8C5olqsn2JR
         lpw0Qvie+b/E7m5jYgF2PkXRPilBnkRm3LU1WrBglStu0TRlapvyvqENA9Sr1BZl7yDV
         u8ot88z+rYe8e5seGe06kIhjn6NdOsx9o9HPuh9rArZ1r+MLqkX+7EKkcU9nOpAL2mVs
         I6lQ==
X-Forwarded-Encrypted: i=1; AJvYcCVeqWsM2KPi2Rd70ZtYlhh4A0lEm4kNUdaJtNfrD4mF6cv43mHuXp5yVs4YRVi5eqrGYcWnPaKnyrPMUjMHO4mZFeAUFSLaVNOZtmlD0QHAgWS0
X-Gm-Message-State: AOJu0Yw36BTLyZT6k5XWYL/z1kmpAv+pOCt3YcRclyb1c+XVTKgw/rqm
	hNYuCPHYOjDaz2ufcIcD2xf6IRHthqx8XV0z8csu4ZTDB9JEgh1JUecVNfIVBwpFgFpM7NN19Wm
	xIB5tEPJqCB7Q5/kEFwAmBP6OXWHsZzGYaJ2HaA==
X-Google-Smtp-Source: AGHT+IFPXo6a34SIvWl7lw7N7W4+IchbD08putpSxKw58/8CLAWWz2yNLnjUOFdz0I/fYG+Hmoz7mGxMqGuepuD1+8g=
X-Received: by 2002:ac2:54bb:0:b0:513:1cfb:a848 with SMTP id
 w27-20020ac254bb000000b005131cfba848mr325931lfk.33.1709607822218; Mon, 04 Mar
 2024 19:03:42 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240229121056.203419-1-alexghiti@rivosinc.com>
 <20240229121056.203419-3-alexghiti@rivosinc.com> <20240304-makeshift-bakeshop-26c9611de1a3@spud>
 <87msrdzqxi.fsf@all.your.base.are.belong.to.us>
In-Reply-To: <87msrdzqxi.fsf@all.your.base.are.belong.to.us>
From: Anup Patel <apatel@ventanamicro.com>
Date: Tue, 5 Mar 2024 08:33:30 +0530
Message-ID: <CAK9=C2Xjgr9_H-sHkmAAc95dAm2jd+_dxLUxSM3RM3NrQJFKGQ@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] riscv: Fix text patching when IPI are used
To: =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
Cc: Conor Dooley <conor@kernel.org>, Alexandre Ghiti <alexghiti@rivosinc.com>, 
	Anup Patel <anup@brainfault.org>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Andrea Parri <andrea@rivosinc.com>, Samuel Holland <samuel.holland@sifive.com>, 
	Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, linux-riscv@lists.infradead.org, 
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	=?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@rivosinc.com>, 
	Andrea Parri <parri.andrea@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 5, 2024 at 1:54=E2=80=AFAM Bj=C3=B6rn T=C3=B6pel <bjorn@kernel.=
org> wrote:
>
> Conor Dooley <conor@kernel.org> writes:
>
> > On Thu, Feb 29, 2024 at 01:10:56PM +0100, Alexandre Ghiti wrote:
> >> For now, we use stop_machine() to patch the text and when we use IPIs =
for
> >> remote icache flushes (which is emitted in patch_text_nosync()), the s=
ystem
> >> hangs.
> >>
> >> So instead, make sure every CPU executes the stop_machine() patching
> >> function and emit a local icache flush there.
> >>
> >> Co-developed-by: Bj=C3=B6rn T=C3=B6pel <bjorn@rivosinc.com>
> >> Signed-off-by: Bj=C3=B6rn T=C3=B6pel <bjorn@rivosinc.com>
> >> Signed-off-by: Alexandre Ghiti <alexghiti@rivosinc.com>
> >> Reviewed-by: Andrea Parri <parri.andrea@gmail.com>
> >
> > What commit does this fix?
>
> Hmm. The bug is exposed when the AIA IPI are introduced, and used
> (instead of the firmware-based).
>
> I'm not sure this is something we'd like backported, but rather a
> prerequisite to AIA.
>
> @Anup @Alex WDYT?
>

The current text patching never considered IPIs being injected
directly in S-mode from hart to another so we are seeing this
issue now with AIA IPIs.

We certainly don't need to backport this fix since it's more
of a preparatory fix for AIA IPIs.

Regards,
Anup
