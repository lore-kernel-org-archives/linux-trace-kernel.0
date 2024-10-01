Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDC56C153;
	Tue,  1 Oct 2024 06:17:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727763470; cv=none; b=MeWcK1jvSjNp9IRRynE0Dl4yevG+iRJhF0g0EcJ4ht8lnF4NqFo0jpTx4/isIeILSIfgP5LzgVavTRu+K2uEZ6KJT/tH/OTKpcZfG6CojJAEwLUTdTUTZuJI1PpG/p6RtA8jIaew/YJ1Aonkn8aRBNvr2KCPv99yzZWLViUv64s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727763470; c=relaxed/simple;
	bh=kBUT3EwDlDLkppuHGAjL9CS1vbLaheFqYLZFALiq2jE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=J3xT5zn7YSYPuOl0nIUxxRuKgpqjPXpPen+6zDYMzFRUAURbgLSy6PYUVNjYeTsoJnaNcoV17lEAzNIVvqiJ9/Ww4yCuHhx98zT2Nw5uCSYKOBBJJoRFYRaOGKAidiLPw5JZ0zR+Jea8tizx1jFx+DvpTIyhUdUSja76Hw/m+UE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lZO6iwsC; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lZO6iwsC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55CA4C4AF0B;
	Tue,  1 Oct 2024 06:17:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727763470;
	bh=kBUT3EwDlDLkppuHGAjL9CS1vbLaheFqYLZFALiq2jE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=lZO6iwsChTVHWcmVkbtT+HEtmVpn8/DKDSyrzfGSWVNoS2AsJW61BFCi6ds8dXJPv
	 AvaOc5J3KZI2Yy1AUHhSN+VhfXyI9QL8XIDcnPvmAGVofLcAd4OJuMuzIounjyq5oh
	 4iMDh5sh6w7ADcuYi3c2GdKb3LMK8K4uTB9y7GUiOscFo79syHV5MmMUEsZYeNfp8e
	 OgLocX6VB8gopaE2DjeQpaFYl1REcNgAt816X0lJdv1DCboYchrbZsDZXrH6Qn2a1E
	 LPT5hoFNEQ/b4F5t7T8X/LsTxGIBZQsdH7ozYnLdO9JfXy3uK582So2CshwWhvEsQO
	 LNAnh7Q9i8/6g==
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-2fad15b3eeeso14777211fa.2;
        Mon, 30 Sep 2024 23:17:50 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUnB0YDMkdvYF6hzyWQyerfD8ZTCyahsi9mc2lZMYfMjC02hoKxpesrq6waPyl9DT3TPDpKy307Vx4tWne2usVMQ6w=@vger.kernel.org
X-Gm-Message-State: AOJu0YwUz7rXf02TXttH9lOqYSu+vxz1scJyRp04v447OhJBy9harqWi
	8ndSPp0kuJRdrVo9zwXDORlivLnkM0GcxSfDi6BgnDJ1bsvK+3fvMYv3LljShc0Rlfsht+MsteP
	ANKP1eL9X389ZBj9EUExEbg99iN8=
X-Google-Smtp-Source: AGHT+IGbGutJbA/ztjpsmdWguIxi5XOiBbzu9AF9cYX2DKiBEjTC2FnLnXg5HamKCCDbnP0XS+ChLWVKT0u3KmUQaUc=
X-Received: by 2002:a2e:beaa:0:b0:2ee:8453:5164 with SMTP id
 38308e7fff4ca-2f9d3dbc770mr72590261fa.0.1727763468614; Mon, 30 Sep 2024
 23:17:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240926130159.19e6d0e2@rorschach.local.home>
In-Reply-To: <20240926130159.19e6d0e2@rorschach.local.home>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Tue, 1 Oct 2024 08:17:37 +0200
X-Gmail-Original-Message-ID: <CAMj1kXF1=2wLgM8HP6BvUxdZLK4EdnaORLUTjoDJSZP-hhDJwA@mail.gmail.com>
Message-ID: <CAMj1kXF1=2wLgM8HP6BvUxdZLK4EdnaORLUTjoDJSZP-hhDJwA@mail.gmail.com>
Subject: Re: [PATCH] Documentation/tracing: Mention that RESET_ATTACK_MITIGATION
 can clear memory
To: Steven Rostedt <rostedt@goodmis.org>
Cc: LKML <linux-kernel@vger.kernel.org>, 
	Linux trace kernel <linux-trace-kernel@vger.kernel.org>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Mike Rapoport <mike.rapoport@gmail.com>, 
	Kees Cook <keescook@chromium.org>, Hans de Goede <hdegoede@redhat.com>, 
	Jonathan Corbet <corbet@lwn.net>
Content-Type: text/plain; charset="UTF-8"

On Thu, 26 Sept 2024 at 19:02, Steven Rostedt <rostedt@goodmis.org> wrote:
>
> From: Steven Rostedt <rostedt@goodmis.org>
>
> At the 2024 Linux Plumbers Conference, I was talking with Hans de Goede
> about the persistent buffer to display traces from previous boots. He
> mentioned that UEFI can clear memory. In my own tests I have not seen
> this. He later informed me that it requires the config option:
>
>  CONFIG_RESET_ATTACK_MITIGATION
>
> It appears that setting this will allow the memory to be cleared on boot
> up, which will definitely clear out the trace of the previous boot.
>
> Add this information under the trace_instance in kernel-parameters.txt
> to let people know that this can cause issues.
>
> Link: https://lore.kernel.org/all/20170825155019.6740-2-ard.biesheuvel@linaro.org/
>
> Reported-by: Hans de Goede <hdegoede@redhat.com>
> Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
> ---
>  Documentation/admin-guide/kernel-parameters.txt | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> index bb48ae24ae69..f9b79294f84a 100644
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -6850,6 +6850,9 @@
>
>                                 reserve_mem=12M:4096:trace trace_instance=boot_map^traceoff^traceprintk@trace,sched,irq
>
> +                       Note, CONFIG_RESET_ATTACK_MITIGATION can force a memory reset on boot which
> +                       will clear any trace that was stored.
> +

CONFIG_RESET_ATTACK_MITIGATION can force a wipe of system RAM at warm
reboot on systems that have a TPM enabled, but disabling it does not
prevent it. Also, there are many other reasons why the trace buffer
region may be wiped and/or reused for other purposes, so singling out
CONFIG_RESET_ATTACK_MITIGATION like this is not that useful imo.

As I indicated when this feature was under review, it should be made
very clear that any kernel side changes that affect the system's
behavior in this regard should not be considered regressions. So
instead of mentioning CONFIG_RESET_ATTACK_MITIGATION here, perhaps it
would be better to document that system firmware generally makes no
guarantees about preserving memory contents, and so this feature may
break without warning.

Note that on UEFI systems, there is a so-called 'capsule' interface
which does allow the OS to preserve an arbitrary buffer across a warm
reboot. However, whether it works on all systems is anybody's guess.
