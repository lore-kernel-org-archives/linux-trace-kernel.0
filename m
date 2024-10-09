Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00B601E284A;
	Wed,  9 Oct 2024 16:25:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728491139; cv=none; b=QxuvV9k2DZJXktOhsi13JZUJVF03Q0Bgerdwh9YKLRCviFwUJX0GEDJr4U42jTAVK/WmqEOZheAqY8sg1CSegeoRD150vzONgPrbERrp/g/I8wtEpiSEqlzE9QP1KOHfqBzm17QFFZNfEbpJZA2y92cbbMpIbSYBCF/amLQ7tWE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728491139; c=relaxed/simple;
	bh=5A8e03ALIcArafOwwK8FQgrsFnyos8sAzJz6+73DYrs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dWDw+De7UpNoSTHCpt6dIfQcEnZ0CIt0XLQKxfqAXbo/RImKNkZiC8v3i3jLCp0aQK/KyD+jg6L2OGIA7lAcThFHD6SCLT4kdwipUMTWXOcChgvL4WzWtva5ENMfvangfISiMJeV1oTgYS6jnu5qDWrx0Om5nXieicS4A9ze6JA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QbYFTZPT; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QbYFTZPT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86A3AC4CECF;
	Wed,  9 Oct 2024 16:25:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728491138;
	bh=5A8e03ALIcArafOwwK8FQgrsFnyos8sAzJz6+73DYrs=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=QbYFTZPT3hvwspGh+kWa5InhFxuP7UeyWhsLE2ww6/uUl5uGZVriDVvKzmKtdBy2Z
	 ccLRJJHiDCJI7f1Hs8OrsqS0WxPIhL50mOqkfMM5vfyl5srmNSsK4Yr48EC800hAcn
	 iAmxOLV14TIvvGY+6DZisQ71RT+V6xHbeDPETmHqGbF+17/YDDyQZL78St2kcHW9Oh
	 WdVGs9qdp2zHa+U9lVW6+1VipdFAUskyZzI85GrrrE2hTN4R0Imva+xDYKetV3/wrw
	 7pleMIskhiNEho62gHvfuB+j6fJkk77pp/h10mAjmZobEN8q02obIHalKt81Oyb05w
	 +Milhm+ou3vZg==
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-5398996acbeso8023678e87.1;
        Wed, 09 Oct 2024 09:25:38 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUK6RAh3qc0Rcw1grSmlJkgnZKDz8ZHLt9hGIuiPiH35AyP1JgZvcjLgbfaTzDdM+oS4j2QQDENT3PGsVONBXLsR0Ct@vger.kernel.org, AJvYcCXhth3EPxX7xriCefaECp9BqY1yecBQ680TDNKSCNHNXIvkBOpEzR1Afip0a7O62JE1S+NPQ5wYi3WR79o=@vger.kernel.org
X-Gm-Message-State: AOJu0YwDrZTPP/Lt8w/vpPuZR5sFbVPzJtOjXagB/L4x6k9Zc7vy30wg
	zIxu2h37m9tfFUL0tafX/XdPrMx5FKatbz3oItX9G8ZZcMIZiT9vNMyNbJTZuhq8+KpM6p8ySkh
	TYssLKBZmrF4BGAEgsXqzB+HDzVg=
X-Google-Smtp-Source: AGHT+IFdvxIZIq7dRRjXJhsBI26xjA6XKjsk9PesdGyZPoHzNTW6/hoyjugC+9+sRHBNgWuf7hqA7LvcQbxj5KDag2E=
X-Received: by 2002:a05:6512:3d93:b0:530:ae22:a6f0 with SMTP id
 2adb3069b0e04-539c488cb71mr2451030e87.5.1728491136896; Wed, 09 Oct 2024
 09:25:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241009153901.3878233-2-ardb+git@google.com> <20241009120257.7b2de987@gandalf.local.home>
 <CAMj1kXFjd8AuHaBMLap6RZ18PR9_Cwv2GFbBkswj-e5YpaQFdA@mail.gmail.com> <20241009121931.6156accd@gandalf.local.home>
In-Reply-To: <20241009121931.6156accd@gandalf.local.home>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Wed, 9 Oct 2024 18:25:25 +0200
X-Gmail-Original-Message-ID: <CAMj1kXEwpXPWVm2X8ZzpMc0JoynA=H8kABzD_Bb5+JEhULEr8Q@mail.gmail.com>
Message-ID: <CAMj1kXEwpXPWVm2X8ZzpMc0JoynA=H8kABzD_Bb5+JEhULEr8Q@mail.gmail.com>
Subject: Re: [PATCH] x86/ftrace: Don't bother preserving/restoring R10/R11
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Ard Biesheuvel <ardb+git@google.com>, linux-trace-kernel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Masami Hiramatsu <mhiramat@kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Wed, 9 Oct 2024 at 18:19, Steven Rostedt <rostedt@goodmis.org> wrote:
>
> On Wed, 9 Oct 2024 18:13:54 +0200
> Ard Biesheuvel <ardb@kernel.org> wrote:
>
> > > > @@ -256,7 +254,6 @@ SYM_INNER_LABEL(ftrace_regs_call, SYM_L_GLOBAL)
> > > >       movq R14(%rsp), %r14
> > > >       movq R13(%rsp), %r13
> > > >       movq R12(%rsp), %r12
> > > > -     movq R10(%rsp), %r10
> > >
> > > This part of the patch I think is perfectly fine. We haven't been restoring
> > > R11 for 12 years I'm sure nobody will notice if we don't restore R10.
> > >
> >
> > Not sure I follow this reasoning tbh. R10/R11 are guaranteed to be
> > dead, so I don't see any point in preserving them. But if you do
> > capture them, shouldn't you at least ensure that the captured values
> > match the values that the callee will observe? (even though they are
> > dead and we know it will never look at them)
>
> Say we have code of:
>
>         pushq   r10
>         pushq   r11
>         call    foo
>         popq    r11
>         popq    r10
>
> Where we add a kprobe to the start of foo, the callback should be able to
> see what r10 and r11 were.

Why exactly is that? The contents of R10 and R11 have no purpose going
forward, so is it just to see what some previous code may have left in
them?

> But the restore part is for the function foo to
> see. It shouldn't care about r10 or r11 and if a kprobe updates them, it
> should not have any effect.
>
> What does restoring r10 and r11 give us?
>

Nothing. Which is why I don't understand why you would need to record
them in the first place.
