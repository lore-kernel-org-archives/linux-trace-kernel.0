Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B4271C3312;
	Tue,  1 Oct 2024 12:52:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727787159; cv=none; b=NeFlaRHJSOGl1jHiizdrXS9eKdeQVtOo6jHmeU7da4G7AapR/crViAvqgsfCSyBm0mv07Q7O2w1KPVNPdkomeLtFBDEKdAEfba4COWtMclrMofRl0+fiv1kTA+uTvwapGIEgAt+nC4MS1BpXXQZfvuZN+HnUV/yeawBMkXPQTMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727787159; c=relaxed/simple;
	bh=aGaAIKBOaEg38Bg0Blb5V51gc+udAfeRUBy9Fk/mbKc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UwrV69YtlAbqT1QO0gbSuGALypImnezfyZ9nZxj4s10TbL4RqdiCYxWSeOKhNxRcGuRIK25ZYvhJRzd5jJ5I+YhfalYQawrPUvpHzyiZGqOgGIl0F0/H77X6F8s5ZMRArN+lUOQoSvz54mGjX0hG2uovZmQjUS4rszGJhYsAgXE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30F3EC4CEC6;
	Tue,  1 Oct 2024 12:52:38 +0000 (UTC)
Date: Tue, 1 Oct 2024 08:53:26 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Ard Biesheuvel <ardb@kernel.org>
Cc: Hans de Goede <hdegoede@redhat.com>, LKML
 <linux-kernel@vger.kernel.org>, Linux trace kernel
 <linux-trace-kernel@vger.kernel.org>, Masami Hiramatsu
 <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Mike Rapoport <mike.rapoport@gmail.com>, Kees Cook <keescook@chromium.org>,
 Jonathan Corbet <corbet@lwn.net>
Subject: Re: [PATCH] Documentation/tracing: Mention that
 RESET_ATTACK_MITIGATION can clear memory
Message-ID: <20241001085326.5841a9ce@gandalf.local.home>
In-Reply-To: <CAMj1kXGz2isSBBkm1R7DiinNt5nxELRTvrD4XXN9v_TRQrNr-A@mail.gmail.com>
References: <20240926130159.19e6d0e2@rorschach.local.home>
	<CAMj1kXF1=2wLgM8HP6BvUxdZLK4EdnaORLUTjoDJSZP-hhDJwA@mail.gmail.com>
	<80930b34-3b31-46d7-8172-6c0cd2ee497f@redhat.com>
	<CAMj1kXGz2isSBBkm1R7DiinNt5nxELRTvrD4XXN9v_TRQrNr-A@mail.gmail.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 1 Oct 2024 11:35:53 +0200
Ard Biesheuvel <ardb@kernel.org> wrote:

> All I am asking for is a line in the documentation that says that
> clobbered trace buffers could occur at any time, regardless of whether
> CONFIG_RESET_ATTACK_MITIGATION is enabled or not. That way, we have
> something to refer to when people start filing bugs against the EFI
> component when this breaks.

How about if I change the comment to this?

        Note, saving the trace buffer across reboots does require that the system
        is set up to not wipe memory. For instance, CONFIG_RESET_ATTACK_MITIGATION
        can force a memory reset on boot which will clear any trace that was stored.
        This is just one of many ways that can clear memory. Make sure your system
        keeps the content of memory across reboots before relying on this option.

Would that be better?

I want to stress that this doesn't work for every setup. It just so happens
to work for mine and others. I do not want people thinking that it's a bug
if it doesn't work for them.

-- Steve
