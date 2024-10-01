Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F4852B9B0;
	Tue,  1 Oct 2024 09:36:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727775368; cv=none; b=q1RzGxewUckplaNEvRQ+fZHKrYA5aQLXuAERovDlK/I2qFdW3CYXrD7Bt4t3YLNMztN6/bDPov6VB2i5PzBcANyixPB+2I+iBALwoMwVzuRSR/hhMC+CdI3AgL9zf0sBE+Fqh89xXZekdHQEiBt4PYF1dJLEjpeJAUgOp74bq4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727775368; c=relaxed/simple;
	bh=SnKJ8A/vrtG422XbxnH3Br2x9iyClLI2yfFFQeZjfl8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ul68765viLxTkgZrTXhrlPgXJIX/6G2JDwEcEo/yHVvxH+L95onM8cdMjovrQMwP70OrMYQZJk+Fmguwoi4WkyQ+U7jBVZX3E13hMCSMuAffYkycRVVirAzRoxaPpucSpNqVdCQH+HfXaNhsm0e24hfsS81JcscS3kWRqwWSeCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i/R5EPAh; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i/R5EPAh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CDF36C4CECD;
	Tue,  1 Oct 2024 09:36:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727775367;
	bh=SnKJ8A/vrtG422XbxnH3Br2x9iyClLI2yfFFQeZjfl8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=i/R5EPAhJcjj2cZOIWH43NQD5aI2gXW6tizlcVgj5V0WN7WsF5uWVw67N1AEr38kI
	 06ILmgQsTs9pxOjLFicPxumon3RenwQWmhQD8mz55RtKhHEB9a7IM9+ioTLKqO6xy8
	 wO0SralHcePj95Z1+hYICj4MIVeDmpXxJblwufSOATXYGqqxz26uSSv8qFKjeL/NFj
	 W8ZNp85zP+3faF1u9+CV9jTPaN/a5g+XuNNvgpJOC1hrTs9jSYe6xKMAQv35FP2Tc0
	 fZkGpS9oic4Wm58vK0dJlHfjOYu8Cws09tvgTiYmPqMoTRoT9umw2jtioHlN344GQi
	 vWXlS9UbH8MuA==
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-5399041167cso3440224e87.0;
        Tue, 01 Oct 2024 02:36:06 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUGCUWaTimU/GZZ62zkVZRnovxOCShdq1b0+DL1YzKCNQAHh4Vvnuf7BdS32Oz/yozvmkd86y+qsjLqfBh2xUdQ0n5c@vger.kernel.org, AJvYcCUOpQb3pFbR26i56d9m59Ns1QsxV/J8H+xBcliQfFRVVZreeA2aXKHHkdjVSH90fGgX3UpzSfNCbk7KcJ0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx3nn7lS+3T0MnuWkXOyMOfoxzNH33zlW2Teojzo0iQum3cjkfe
	3NP5QbUaCWgGLbF8b8//lSKts2w6xX7K5zu9D64iKOU04hmkiX/ne84LRtjYNhSKDSfmPx8K7CH
	UVBgF1NGX/LK2A8cudHkKk8xs1p8=
X-Google-Smtp-Source: AGHT+IGqOr0HnptSMm3/I2Aa0tANJfQTfWfI/KDOrnqNJZ02shy9R8xgW+fAnrU9ARH1qSSQA004DXP0THV22Zx0m64=
X-Received: by 2002:a05:6512:6618:b0:539:89a8:600f with SMTP id
 2adb3069b0e04-53989a86942mr8741150e87.23.1727775365090; Tue, 01 Oct 2024
 02:36:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240926130159.19e6d0e2@rorschach.local.home> <CAMj1kXF1=2wLgM8HP6BvUxdZLK4EdnaORLUTjoDJSZP-hhDJwA@mail.gmail.com>
 <80930b34-3b31-46d7-8172-6c0cd2ee497f@redhat.com>
In-Reply-To: <80930b34-3b31-46d7-8172-6c0cd2ee497f@redhat.com>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Tue, 1 Oct 2024 11:35:53 +0200
X-Gmail-Original-Message-ID: <CAMj1kXGz2isSBBkm1R7DiinNt5nxELRTvrD4XXN9v_TRQrNr-A@mail.gmail.com>
Message-ID: <CAMj1kXGz2isSBBkm1R7DiinNt5nxELRTvrD4XXN9v_TRQrNr-A@mail.gmail.com>
Subject: Re: [PATCH] Documentation/tracing: Mention that RESET_ATTACK_MITIGATION
 can clear memory
To: Hans de Goede <hdegoede@redhat.com>
Cc: Steven Rostedt <rostedt@goodmis.org>, LKML <linux-kernel@vger.kernel.org>, 
	Linux trace kernel <linux-trace-kernel@vger.kernel.org>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Mike Rapoport <mike.rapoport@gmail.com>, 
	Kees Cook <keescook@chromium.org>, Jonathan Corbet <corbet@lwn.net>
Content-Type: text/plain; charset="UTF-8"

Hi Hans,

On Tue, 1 Oct 2024 at 10:57, Hans de Goede <hdegoede@redhat.com> wrote:
>
> Hi,
>
> On 1-Oct-24 8:17 AM, Ard Biesheuvel wrote:
> > On Thu, 26 Sept 2024 at 19:02, Steven Rostedt <rostedt@goodmis.org> wrote:
> >>
> >> From: Steven Rostedt <rostedt@goodmis.org>
> >>
> >> At the 2024 Linux Plumbers Conference, I was talking with Hans de Goede
> >> about the persistent buffer to display traces from previous boots. He
> >> mentioned that UEFI can clear memory. In my own tests I have not seen
> >> this. He later informed me that it requires the config option:
> >>
> >>  CONFIG_RESET_ATTACK_MITIGATION
> >>
> >> It appears that setting this will allow the memory to be cleared on boot
> >> up, which will definitely clear out the trace of the previous boot.
> >>
> >> Add this information under the trace_instance in kernel-parameters.txt
> >> to let people know that this can cause issues.
> >>
> >> Link: https://lore.kernel.org/all/20170825155019.6740-2-ard.biesheuvel@linaro.org/
> >>
> >> Reported-by: Hans de Goede <hdegoede@redhat.com>
> >> Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
> >> ---
> >>  Documentation/admin-guide/kernel-parameters.txt | 3 +++
> >>  1 file changed, 3 insertions(+)
> >>
> >> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> >> index bb48ae24ae69..f9b79294f84a 100644
> >> --- a/Documentation/admin-guide/kernel-parameters.txt
> >> +++ b/Documentation/admin-guide/kernel-parameters.txt
> >> @@ -6850,6 +6850,9 @@
> >>
> >>                                 reserve_mem=12M:4096:trace trace_instance=boot_map^traceoff^traceprintk@trace,sched,irq
> >>
> >> +                       Note, CONFIG_RESET_ATTACK_MITIGATION can force a memory reset on boot which
> >> +                       will clear any trace that was stored.
> >> +
> >
> > CONFIG_RESET_ATTACK_MITIGATION can force a wipe of system RAM at warm
> > reboot on systems that have a TPM enabled, but disabling it does not
> > prevent it. Also, there are many other reasons why the trace buffer
> > region may be wiped and/or reused for other purposes, so singling out
> > CONFIG_RESET_ATTACK_MITIGATION like this is not that useful imo.
>
> Since the userspace parts to clear the CONFIG_RESET_ATTACK_MITIGATION
> related EFI variable after cleaning cryptographic keys from RAM has
> never materialized CONFIG_RESET_ATTACK_MITIGATION is pretty much
> guaranteed to clear any traces on any modern machine (and at least
> in Fedora's kernel config it is disabled because of this).
>

Any modern x86 PC, sure.

> I agree that there are more ways the RAM might get cleared, but
> since this will clear the RAM almost 100% of the time it is worth
> documenting this IMHO.
>

Fair enough.

> I get the feeling you (Ard) see documenting this as some sorta bug
> report against CONFIG_RESET_ATTACK_MITIGATION, that is not the intention.
> Quite the opposite the documentation is there to let the user know
> that CONFIG_RESET_ATTACK_MITIGATION works as advertised and that it
> will (almost) always clear the RAM on reboot and thus conflicts with
> keeping traces over reboot.
>

I am not against documenting this. CONFIG_RESET_ATTACK_MITIGATION is
simply incompatible with this feature so it makes sense calling that
out.

But there are so many other ways in which the trace buffer might get
clobbered, and mentioning CONFIG_RESET_ATTACK_MITIGATION in particular
might suggest to some that those other causes are due to kernel bugs.

All I am asking for is a line in the documentation that says that
clobbered trace buffers could occur at any time, regardless of whether
CONFIG_RESET_ATTACK_MITIGATION is enabled or not. That way, we have
something to refer to when people start filing bugs against the EFI
component when this breaks.
