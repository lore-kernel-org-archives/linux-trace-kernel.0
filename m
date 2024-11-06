Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 609BE20607C
	for <linux-trace-kernel@vger.kernel.org>; Wed,  6 Nov 2024 22:00:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730930403; cv=none; b=BvH++HwTWKKpkDfrJbxteXwaHt0FU58jP522cEB9NT51BhbRGylAWtRYKyxU6pQstkUjXrIYXGCNVe/06VLykyw/7RrNvNfHpGaMnB3S1Xuy8OvVmjuSq2vQAt4niUVOn+w9LwaGCPWcQ+pAxBiA4GIcy8bx2ybt92mi/NusG2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730930403; c=relaxed/simple;
	bh=Dxb4/6/36affsib/O+PJ+ffEY/uk+DTB5RSnQyNRnpQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VcR8n4EUfM0nQqqRegS/VFrKybboQCIl/e30+WCn1nVbmDnjCIdBx1U99Lw+QW7lxx4XjKshIob5JPjHZtfMlOLyp8kcJ7hWP2NZwLkFJs2KsNj0BN9OtdP5YZpPBx+Jjt/S951uYbbd+ZH9e3mgiSBZ4ybA/nL6vgXzy8HkPl8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=NP7AwOnm; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="NP7AwOnm"
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-2e3686088c3so247771a91.0
        for <linux-trace-kernel@vger.kernel.org>; Wed, 06 Nov 2024 14:00:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1730930401; x=1731535201; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=2Es3p6p94eraJRLtbFRw7m7Hdwqby+HzOFvb3PHSaFg=;
        b=NP7AwOnmZ9GLFrp/oVTVJAx6dEL1Ww3CGaavp1cqZzng2YShGTHATskq3EQZLKSgG7
         YWm9sPDlGGHnefMGhBhyaRxvmNU+fu0xB43m3cvRy6CZAvJp/Q1ahmBbF70bClqlXuDA
         zXS/vqfEzVzpxLcUj0An4kkTBU3Iq1bEGm7pVmIAZheyvSXEGbUZsVH6CjEQqaFKHViS
         BbmtA0b7qv3a17KG5pfQ0xXnKPUsnau4oALOKtHZQCeoQFtVarV/EYjZFXlyUpd0Weg2
         FurVhal2qrbq8Wy6G3g0+5snbYYzItqKLB1fxqNS6Beiv34DADIVvsJpVEQZ2Ts3xCQC
         oIIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730930401; x=1731535201;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2Es3p6p94eraJRLtbFRw7m7Hdwqby+HzOFvb3PHSaFg=;
        b=gHZ9uulh6Coi3vqnSUbtzrcnzyJN1esV/VpTA2XvgNgBe4mLT8tCGRiVykA0+unc3R
         CfGqgPmBQmx4Ri6+z1x/vV75ZDlKVRakDDtizSOjGt5N7OfXnrlE+mBsZq77MKfnFpdC
         5gDL2+9duJQ3Az98cG8rZhaItBxA2EpvvSwtvTD78SmwMQi51aMPIbkU8XgLQCB081jq
         JllKbcodbHIvlTWdPAOZ8U9xRlk9HnvykeOEuqu5nt4A49aBRjr8TQVaHzRmrq/ehX+S
         vA8GrZR7v/A/CfAEae7qPMeC9eRK9ldpp92gCHH0k5egmJLunsFMp1IFLtVJhIfQYNqN
         TpsQ==
X-Forwarded-Encrypted: i=1; AJvYcCVNYH+4W41Xo4imLI+JAjpoB5+6Ld3Y3eTkpsKcIv1FNQVDlm7B6J1b2gAHqkr/Mf3psmyouqDTj6nEJdrDVZKS0MI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzxUpcuS1nZVNAqZOFwDjZELz8KtXxT1XcUAU5GuubVKzU7yqHU
	DZyqt7UsULY36SXPlDNEsPYIfE9bxlkcL7t2Vz8FCPLov+iGkrvG6hAcCQL/iQa6rMlCthSFQLk
	DJVEt/XCJDWdxObotKugYeJOau8EseYCWVe42
X-Google-Smtp-Source: AGHT+IEZLGNIimSbo/bhWn6P2ldR43LdNR4/3zsRJ00TNvlOTTJ7yt5Vn9HuykGDPw5SX87MzIKTxpvA5b2yEhWcddE=
X-Received: by 2002:a17:90a:b305:b0:2e2:b937:eeae with SMTP id
 98e67ed59e1d1-2e92ce2ca0emr32021282a91.5.1730930401453; Wed, 06 Nov 2024
 14:00:01 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241105133610.1937089-1-elver@google.com> <20241105113111.76c46806@gandalf.local.home>
 <CANpmjNMuTdLDMmSeJkHmGjr59OtMEsf4+Emkr8hWD++XjQpSpg@mail.gmail.com>
 <20241105120247.596a0dc9@gandalf.local.home> <CANpmjNNTcrk7KtsQAdGVPmcOkiy446VmD-Y=YqxoUx+twTiOwA@mail.gmail.com>
 <CANpmjNP+CFijZ-nhwSR_sdxNDTjfRfyQ5c5wLE=fqN=nhL8FEA@mail.gmail.com>
 <20241106101823.4a5d556d@gandalf.local.home> <20241106102856.00ad694e@gandalf.local.home>
 <ZyuxmsK0jfKa7NKK@elver.google.com> <20241106162342.3c44a8e9@gandalf.local.home>
In-Reply-To: <20241106162342.3c44a8e9@gandalf.local.home>
From: Marco Elver <elver@google.com>
Date: Wed, 6 Nov 2024 22:59:25 +0100
Message-ID: <CANpmjNMMvZPWJG0rOe=azUqbLbo8aGNVZBre=01zUyST40pYxw@mail.gmail.com>
Subject: Re: [PATCH] tracing: Add task_prctl_unknown tracepoint
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Kees Cook <keescook@chromium.org>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Oleg Nesterov <oleg@redhat.com>, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, Dmitry Vyukov <dvyukov@google.com>, 
	kasan-dev@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

On Wed, 6 Nov 2024 at 22:23, Steven Rostedt <rostedt@goodmis.org> wrote:
...
> > That's pretty much it. I've attached my kernel config just in case I
> > missed something.
>
> OK, it's because you are using trace_pipe (which by the way should not be
> used for anything serious). The read of trace_pipe flushes the buffer
> before the task is scheduled out and the comm saved, so it prints the
> "<...>". If you instead do the cat of trace_pipe *after* running the
> command, you'll see the comm.
>
> So this is just because you are using the obsolete trace_pipe.

I see, thanks for clarifying.  I always felt for quick testing it
serves its purpose - anything equally simple you recommend for testing
but doesn't suffer from this problem?

Thanks,
-- Marco
