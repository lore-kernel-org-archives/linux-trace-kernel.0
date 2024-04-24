Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89EAC15ADAD
	for <linux-trace-kernel@vger.kernel.org>; Wed, 24 Apr 2024 12:23:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713961436; cv=none; b=LeCMUDFNiS25xChhTjHftGzLCQRFJjnJXRjVJubDUbTVx7eiqkZgvjZdP0wYc04X2oCuJRGr/wasMyAImPR/p1vkddmvu4sPveuxgxx7Zn2HK68JUU4QtIYKVtlXJykGWm2GxuuMrGgkfK8xpQY8XeAxpNlieDzTmnIEeVTXUaY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713961436; c=relaxed/simple;
	bh=ORZZxGjmGHnHgh+htS3fBicgBeOmFerSKJMRkIfKFiw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dijONokFGKUtfdOQMOaXaXSHpPpSZu+iX/3TLGaUa4muAFIyPNXyUl4uIUN6Gw7vDVeprNlsOVOrtlKHS686ndK5e7XCTgicjOvJwNTTcigYP0InuJ63oRxkfIlg6KvBU5flsCdZxiLKUgsvjo6Zc4RQnpl6IVtkLfVqRZjDpPc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=m/ZSUfR8; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="m/ZSUfR8"
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-2a52c544077so4803053a91.1
        for <linux-trace-kernel@vger.kernel.org>; Wed, 24 Apr 2024 05:23:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1713961435; x=1714566235; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bzPFuKdNUZkpwzAJaOpO9HeYEWhXgRSLVW/xtUMpOxM=;
        b=m/ZSUfR82H3i0sDVyZwmvo7Lc23Xc5zo9fN9b3MtNIK/xjJN+CtGzZ86qHOskbzPqv
         JNua+czu+QxRJ+ryyMG1GdO7Cf53cewI9qQF/+L9tVFfcHvA5J5qB1l1+1OIwnu7mAF+
         BI+aCS7oeiJuWnbXQJEqFiVJ1bMC9lQaA1/GY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713961435; x=1714566235;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bzPFuKdNUZkpwzAJaOpO9HeYEWhXgRSLVW/xtUMpOxM=;
        b=d19/I4/81GfBX3ypOwPEby6DHbxDouz7IlkAAgsCQj0AAhcxdqGsPyfBfL3be4MwvZ
         NMpe9rEklstWRsHOZGalX65b/W9KeMsTFZztJox3954RmM3Zm8N1+LKNSDQPyBOzfLtb
         hXK283rDIVJSJhmzCeMtVtNJpW+Sn7lFSa1+fggTzQWNQ+LF/yxogJKfCAD3WgKdrhOh
         rVxAwRZF9my9+xlFUaiV3V6zzZteOYVOBhJeD7XFhpinByMfrRfY3ZM8EFaQRywI+0C3
         /KD0tek++bNVyrsPrNJrNoRffj4o/V+tlUHhIQlv7hli9Qc0RMki0lZdhuLnqqV/vady
         ZCiw==
X-Forwarded-Encrypted: i=1; AJvYcCUZcdGMJ+yr+tbRlESIMUDNQwu1z4OXAqVKAphL2FheDOZ6QekEiMP6t+NbV/04j3rn9J1vE+JTXG+7EQtR6tNt0r2En9lUDunfEd2cPggfDaWJ
X-Gm-Message-State: AOJu0Ywj02LqYxJbriaWWZlcUeMbFQNkGG6uLncflKbPZO30591rOajU
	H6Ij1JMShaagD848yq5ymQfWkpNK0HCvRlaakMxZPgRGSgtcMXoQR/kWKNv9JDfcrLiq42AQ9CP
	smJn3agu9X25SuRR+nZepF8N01NIEz3wIoVZv
X-Google-Smtp-Source: AGHT+IH2IM9SxHij/Nzj82Ol3E1aFfE6LovFWRkib+r17aS6b+q4k8qg3+2XI8OPsrBM5WUhWdYyVJmomgqCmRh7whw=
X-Received: by 2002:a17:90a:df8d:b0:2af:3c7f:3531 with SMTP id
 p13-20020a17090adf8d00b002af3c7f3531mr1386367pjv.33.1713961434840; Wed, 24
 Apr 2024 05:23:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <171318533841.254850.15841395205784342850.stgit@devnote2> <171318535003.254850.2125783941049872788.stgit@devnote2>
In-Reply-To: <171318535003.254850.2125783941049872788.stgit@devnote2>
From: Florent Revest <revest@chromium.org>
Date: Wed, 24 Apr 2024 14:23:43 +0200
Message-ID: <CABRcYmK_Btem8cBbz=j==RWxw11PQ8cNAUshNA540VD3O=2WEQ@mail.gmail.com>
Subject: Re: [PATCH v9 01/36] tracing: Add a comment about ftrace_regs definition
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>, Steven Rostedt <rostedt@goodmis.org>, 
	linux-trace-kernel@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, bpf <bpf@vger.kernel.org>, 
	Sven Schnelle <svens@linux.ibm.com>, Alexei Starovoitov <ast@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Alan Maguire <alan.maguire@oracle.com>, Mark Rutland <mark.rutland@arm.com>, 
	Peter Zijlstra <peterz@infradead.org>, Thomas Gleixner <tglx@linutronix.de>, Guo Ren <guoren@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 15, 2024 at 2:49=E2=80=AFPM Masami Hiramatsu (Google)
<mhiramat@kernel.org> wrote:
>
> From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
>
> To clarify what will be expected on ftrace_regs, add a comment to the
> architecture independent definition of the ftrace_regs.
>
> Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> Acked-by: Mark Rutland <mark.rutland@arm.com>
> ---
>  Changes in v8:
>   - Update that the saved registers depends on the context.
>  Changes in v3:
>   - Add instruction pointer
>  Changes in v2:
>   - newly added.
> ---
>  include/linux/ftrace.h |   26 ++++++++++++++++++++++++++
>  1 file changed, 26 insertions(+)
>
> diff --git a/include/linux/ftrace.h b/include/linux/ftrace.h
> index 54d53f345d14..b81f1afa82a1 100644
> --- a/include/linux/ftrace.h
> +++ b/include/linux/ftrace.h
> @@ -118,6 +118,32 @@ extern int ftrace_enabled;
>
>  #ifndef CONFIG_HAVE_DYNAMIC_FTRACE_WITH_ARGS
>
> +/**
> + * ftrace_regs - ftrace partial/optimal register set
> + *
> + * ftrace_regs represents a group of registers which is used at the
> + * function entry and exit. There are three types of registers.
> + *
> + * - Registers for passing the parameters to callee, including the stack
> + *   pointer. (e.g. rcx, rdx, rdi, rsi, r8, r9 and rsp on x86_64)
> + * - Registers for passing the return values to caller.
> + *   (e.g. rax and rdx on x86_64)

Ooc, have we ever considered skipping argument registers that are not
return value registers in the exit code paths ? For example, why would
we want to save rdi in a return handler ?

But if we want to avoid the situation of having "sparse ftrace_regs"
all over again, we'd have to split ftrace_regs into a ftrace_args_regs
and a ftrace_ret_regs which would make this refactoring even more
painful, just to skip a few instructions. :|

I don't necessarily think it's worth it, I just wanted to make sure
this was considered.

> + * - Registers for hooking the function call and return including the
> + *   frame pointer (the frame pointer is architecture/config dependent)
> + *   (e.g. rip, rbp and rsp for x86_64)
> + *
> + * Also, architecture dependent fields can be used for internal process.
> + * (e.g. orig_ax on x86_64)
> + *
> + * On the function entry, those registers will be restored except for
> + * the stack pointer, so that user can change the function parameters
> + * and instruction pointer (e.g. live patching.)
> + * On the function exit, only registers which is used for return values
> + * are restored.
> + *
> + * NOTE: user *must not* access regs directly, only do it via APIs, beca=
use
> + * the member can be changed according to the architecture.
> + */
>  struct ftrace_regs {
>         struct pt_regs          regs;
>  };
>
