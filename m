Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F8621C5792;
	Tue,  1 Oct 2024 13:33:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727789585; cv=none; b=IQDnl+u1JtNzBPlp1mNGmzpIDMGeHmi8nezLvJIkHZF5P29iYD7hT7mASs6+2rYl2VczuVZ1L6qbUrbZTViRxV/2okHLBwD9we9KlNIdzo8iQ736R2qHhOyNT6bE0nswxZ6JZqJT4qkkLoiut+ElwxLq9zfMT6yCEcDBETE8rE0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727789585; c=relaxed/simple;
	bh=ZGubvIhsHDnwCLkDL4aq2NgC5wnx1n/UcbgMP479nKs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fBVELZ3bfuLpC7X7MxBgMRoLQJ27ZKsaDMf+T54elWlTFOR1F5uc/JW+uNFCfJA259q0UZpRYBmf/wtrhmUxhZCXwogOMedSnFcAtszhGUhZv8B2KV+ogGdqXUSk2mw2y2ge18xGab8hOWZBgfe4ynZbgSDIO4LlSEur8Rkx+JY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H6mIFTY9; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H6mIFTY9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7697C4AF0B;
	Tue,  1 Oct 2024 13:33:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727789584;
	bh=ZGubvIhsHDnwCLkDL4aq2NgC5wnx1n/UcbgMP479nKs=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=H6mIFTY9Le6jvgLsc9yncMGHg684ZtowFh6jY+r6LmlTMJzZL6pzUxNleys5kDSTe
	 +T+RALTTqzkw54zOTK8paqkDgdM3W8Qtq8TyZCwg90dba1iI1XDisEwyZkfTW9kC0P
	 1ZRQJFLrqxaN/LD8EBj+vVJZZH/fUrF0Y385KdYTTrOdZGipxJRdzXHcPQup7nrCSb
	 BrZ3gXsXjiF/antmFbtNnvumkCiUHzKRMKyTWK3nFDhloZmH0ohWZxRJeAMp8QZLQA
	 nNy0qoLRJjv7a0vav15MZj2IFKQXzy+76lobAQcFavtfzb5hUw/UEeGwaYMblbWQbB
	 Yr6b48Y6ex+Qw==
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-5398e4ae9efso3264362e87.1;
        Tue, 01 Oct 2024 06:33:04 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCU88DcFrbtDHTNxQr9ZT+Y7x7yeBG5CeFLE4Da5l/DVQ7Sb9EwOnHQn9vsQXXQKa8iqhZCp3Nlff2o3kSg=@vger.kernel.org, AJvYcCWyOEl8pa0aKbc3UV2d2WhSdVE64jRv4wpSxTnJh6NIPe6PiO9yKrg+T2Ki0M8AXoKoO8S1MoXZc6cfJP5O2OMeL3gI@vger.kernel.org
X-Gm-Message-State: AOJu0YxUYEu0OJzsoXL9xRmz7qrDg2V0EQ5tHPaJcwr/nWD3UWxzrddU
	/1DaPJwQB/bzdMYULW2KpH/dCKueFmod9UJ55+p0iBaF5pht4dCw12B01gwCUYjATPMhFchA21r
	NGKVLEKHqeDhKJk/LBXyt9l7lzXc=
X-Google-Smtp-Source: AGHT+IF3XSiyqGcqqKsyS7S/gG5zCgoFaLbgSHfT5W8/vP8o7ZWrcXvi0HOCrJyxvNSX31JD317PS2jtbArhkrxWbww=
X-Received: by 2002:a05:6512:eaa:b0:52d:b226:9428 with SMTP id
 2adb3069b0e04-5389fc33037mr9710257e87.6.1727789583084; Tue, 01 Oct 2024
 06:33:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240926130159.19e6d0e2@rorschach.local.home> <CAMj1kXF1=2wLgM8HP6BvUxdZLK4EdnaORLUTjoDJSZP-hhDJwA@mail.gmail.com>
 <80930b34-3b31-46d7-8172-6c0cd2ee497f@redhat.com> <CAMj1kXGz2isSBBkm1R7DiinNt5nxELRTvrD4XXN9v_TRQrNr-A@mail.gmail.com>
 <20241001085326.5841a9ce@gandalf.local.home>
In-Reply-To: <20241001085326.5841a9ce@gandalf.local.home>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Tue, 1 Oct 2024 15:32:50 +0200
X-Gmail-Original-Message-ID: <CAMj1kXHeEjBXnfz5bx2QYX4g6o1DpFN1b6xCTey2wUcqrmMuDg@mail.gmail.com>
Message-ID: <CAMj1kXHeEjBXnfz5bx2QYX4g6o1DpFN1b6xCTey2wUcqrmMuDg@mail.gmail.com>
Subject: Re: [PATCH] Documentation/tracing: Mention that RESET_ATTACK_MITIGATION
 can clear memory
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Hans de Goede <hdegoede@redhat.com>, LKML <linux-kernel@vger.kernel.org>, 
	Linux trace kernel <linux-trace-kernel@vger.kernel.org>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Mike Rapoport <mike.rapoport@gmail.com>, 
	Kees Cook <keescook@chromium.org>, Jonathan Corbet <corbet@lwn.net>
Content-Type: text/plain; charset="UTF-8"

On Tue, 1 Oct 2024 at 14:52, Steven Rostedt <rostedt@goodmis.org> wrote:
>
> On Tue, 1 Oct 2024 11:35:53 +0200
> Ard Biesheuvel <ardb@kernel.org> wrote:
>
> > All I am asking for is a line in the documentation that says that
> > clobbered trace buffers could occur at any time, regardless of whether
> > CONFIG_RESET_ATTACK_MITIGATION is enabled or not. That way, we have
> > something to refer to when people start filing bugs against the EFI
> > component when this breaks.
>
> How about if I change the comment to this?
>
>         Note, saving the trace buffer across reboots does require that the system
>         is set up to not wipe memory. For instance, CONFIG_RESET_ATTACK_MITIGATION
>         can force a memory reset on boot which will clear any trace that was stored.
>         This is just one of many ways that can clear memory. Make sure your system
>         keeps the content of memory across reboots before relying on this option.
>
> Would that be better?
>

Yes, that looks much better. Thanks.

Acked-by: Ard Biesheuvel <ardb@kernel.org>

> I want to stress that this doesn't work for every setup. It just so happens
> to work for mine and others. I do not want people thinking that it's a bug
> if it doesn't work for them.

Exactly. I can see how this feature is very useful if it happens to
work on your system firmware, but it should be documented as not being
covered by the 'no user visible regressions' policy.
