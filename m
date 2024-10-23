Received: from mail-yb1-f170.google.com (mail-yb1-f170.google.com [209.85.219.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD283199256;
	Wed, 23 Oct 2024 09:13:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729674815; cv=none; b=DWzgbTPKe4sDwZQaDlnXz6qWdUIxXKOdwZaFCCX3e9eLeTcikNaxeJw+M6ZBsGWEr3j+VQLs7GZNJEcszbbm940Qmn0ARoCZ+b2oab+h8HZbALTpEoGvoSObelXc3e4qKLBJthuBc6XZLkDaqluEF76RAs4ca7Z+O/nv/iMtzkc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729674815; c=relaxed/simple;
	bh=imUayfZ6FdcexhoYxLlSs1KViSlJqRC9UqM6NkcTej8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Wo1oOnj2AAxP8mygn+8wFeonEklP7LCYFIlLA+hro/DfjAQ0934svCMhHk9tSnmoZf6raapNA2E5k4nM6AhLGnFd5KzBfp6XBJe18IoPLJm1lIduAZc+HttQtG1D4FXa2RwAe5xYkAFzQ0PqzybRvgCBsIbC8glB9l15/6UY6X0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.219.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f170.google.com with SMTP id 3f1490d57ef6-e290d48d3f7so5966937276.3;
        Wed, 23 Oct 2024 02:13:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729674812; x=1730279612;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=L+oDcqb1QYvL5id/iCpKgV/nPQYafdkBvaUvh/k83pY=;
        b=ZxFkankLiQoFAABfo369fJzq1iOdWnJtFLIbfjYFkPD5d2+eJ7WRuFpQK4glV3o0iY
         FLzUgLbGO9HGCUCHq6dE5Nn9PYCUHNTR13bee+kfr+x52IXGXuDguD3SdTvvZj6i4K82
         YMj9OsaC3jshTF6U8cb+Li+89eNkl0noC8EUJEq9k2co5Ov2y75Cuhvm09W77bMRcad2
         2xJ4uGsJSo5EHhwjBE/F1y1CQLfYISWaUZZh5SlRnpZL4Rs43DH3LZG/gHAUI0qoS+QE
         Tj/vIBJDM11Y92LxpS7TW2JjPlMIyW7vQ8BF/QHUX8DxjznXoSG3lEj6b99jfxXUoBH+
         Atkw==
X-Forwarded-Encrypted: i=1; AJvYcCWk0XOlL0BZxsLGLG8HSrLeZp8SWn/f2vnGzLgTMWZGIO8prYZnYnHwNWlRXbUgJ36JD3K4nThpmhvdLcqPyBKJc1qP@vger.kernel.org, AJvYcCXc8LNFY8TntlxVKPbcuVgqYNbx7/GGYVi8XOouI7OQ4RpL4XDb8PT7rMX9YeZGmxTJu/x10cNyMbozoCE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzaudJ7x2nDIkKrl2A4RA1ZsSXFJKGXKQUanpWBLYmcZQtcG6j4
	PQdzZ4mkqY9R2Sd8kEHg0dSZ083HAMNyA14omXQrGuPi/DFvNeHERbW1HSj9
X-Google-Smtp-Source: AGHT+IEsNwcalMQATo4MSt55vZY21sRCz6h2iM41AreAqqckBUDClOGkbN4nmAKeolxg7heT/hDheQ==
X-Received: by 2002:a05:690c:668a:b0:6db:de34:8049 with SMTP id 00721157ae682-6e7f0e40050mr21056927b3.16.1729674812351;
        Wed, 23 Oct 2024 02:13:32 -0700 (PDT)
Received: from mail-yb1-f179.google.com (mail-yb1-f179.google.com. [209.85.219.179])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6e5f59f5939sm14531967b3.6.2024.10.23.02.13.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Oct 2024 02:13:31 -0700 (PDT)
Received: by mail-yb1-f179.google.com with SMTP id 3f1490d57ef6-e290d48d3f7so5966916276.3;
        Wed, 23 Oct 2024 02:13:31 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCU54WYoroji8/PHEVCHie3PKoPsEoLRWShe6evK3lELqQjkqTDXvLXYhulnx2IiaIzV7w52ZY3IrAge6X7KcP+kHVyC@vger.kernel.org, AJvYcCXRqwU9cmKg6zvlGeolKrPBMiWsQqgb63X9laKpw/GMkqECSCS++xGlHvIn0gXQNFFoiKRnBbO2RN3Grnk=@vger.kernel.org
X-Received: by 2002:a05:690c:fd5:b0:6e3:4436:56ba with SMTP id
 00721157ae682-6e7f0df6312mr22676227b3.8.1729674811120; Wed, 23 Oct 2024
 02:13:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241021-add-m68k-tracing-support-v1-0-0883d704525b@yoseli.org>
 <20241021-add-m68k-tracing-support-v1-1-0883d704525b@yoseli.org>
 <20241022012809.1ef083cd@rorschach.local.home> <075d6720-a690-437c-a10f-e2746651e2a8@yoseli.org>
 <20241022043037.13efb239@rorschach.local.home> <2c79be22-1157-41e4-9f3a-53443112ca9a@yoseli.org>
 <20241023044711.3eb838fe@rorschach.local.home> <262d7758-c752-49f6-87ef-4f75d681a919@yoseli.org>
In-Reply-To: <262d7758-c752-49f6-87ef-4f75d681a919@yoseli.org>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 23 Oct 2024 11:13:19 +0200
X-Gmail-Original-Message-ID: <CAMuHMdXKCWnFuyOzQyAWdEV4EhqXYXJFn4vCw5ptZ5=sbOCbxg@mail.gmail.com>
Message-ID: <CAMuHMdXKCWnFuyOzQyAWdEV4EhqXYXJFn4vCw5ptZ5=sbOCbxg@mail.gmail.com>
Subject: Re: [PATCH RFC 1/2] m68k: Add tracirqs
To: Jean-Michel Hautbois <jeanmichel.hautbois@yoseli.org>
Cc: Steven Rostedt <rostedt@goodmis.org>, linux-m68k@lists.linux-m68k.org, 
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Jean-Michel,

On Wed, Oct 23, 2024 at 11:07=E2=80=AFAM Jean-Michel Hautbois
<jeanmichel.hautbois@yoseli.org> wrote:
> On 23/10/2024 10:47, Steven Rostedt wrote:
> > On Tue, 22 Oct 2024 11:21:34 +0200
> > Jean-Michel Hautbois <jeanmichel.hautbois@yoseli.org> wrote:
> >> I was not really expecting you to review the m68k one no :-).
> >> I think I have other issues which might have impact on ftrace too.
> >> For instance, when I launch cyclictest I have a warning about HRTIMERS=
:
> >> # cyclictest -p 99
> >> WARN: stat /dev/cpu_dma_latency failed: No such file or directory
> >> WARN: High resolution timers not available
> >> policy: fifo: loadavg: 1.21 0.40 0.14 1/122 245
> >>
> >> T: 0 (  245) P:99 I:1000 C:  11203 Min:     92 Act:  623 Avg:  775 Max=
:
> >>     3516
> >>
> >> The latencies are quite high...
> >
> > Yes, if you don't have high resolution timers, the latency will be high=
.
>
> According to my config, I should have those:
> CONFIG_HIGH_RES_TIMERS=3Dy

Does your hardware have a high resolution timer, and do you have
a driver for it?

$ git grep hrtimer -- arch/m68k/
$

Gr{oetje,eeting}s,

                        Geert

--=20
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k=
.org

In personal conversations with technical people, I call myself a hacker. Bu=
t
when I'm talking to journalists I just say "programmer" or something like t=
hat.
                                -- Linus Torvalds
