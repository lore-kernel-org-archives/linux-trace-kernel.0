Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com [209.85.219.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7052E20FA8A
	for <linux-trace-kernel@vger.kernel.org>; Thu, 12 Dec 2024 10:06:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733997985; cv=none; b=VQ7ELuMRftmxzSHJyRIEES9kynklTjMYmZyOwYKHqbVcM336d5pSROF571lhll0JaIrx7mYcw0jVaU44e37uQj052+7fESJQcbX7i4RhEjkG58iuuVJkROt63529MP/xWWchLYPmp5RXEk9i/q+zSmJmUJdKCYO06fbE+yHYYfI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733997985; c=relaxed/simple;
	bh=u2lqw8UUeZ+pB1gxUrdc+rJ/PnMeN4apvADmtF38BGU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Kkn3aQXdj0Dp0xxv4AFOX3/XPDfzXz4xadN9fs7XDMv19VxiJcKfEFJ2ODQclhM3p7iDD370Mh2d0gIuNJPdE4wQr7zZIArdYJscUn7hiqFJIeeG5uLq3ghoIwS26UdbTMtb3qDnLxrF14PWQGr3Z6GSjOXj7AXOrvqIBFNVTu8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=BNpeZ0Os; arc=none smtp.client-ip=209.85.219.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="BNpeZ0Os"
Received: by mail-qv1-f52.google.com with SMTP id 6a1803df08f44-6d87ab49423so4408946d6.0
        for <linux-trace-kernel@vger.kernel.org>; Thu, 12 Dec 2024 02:06:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1733997982; x=1734602782; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Of1BFeg2KON1xNm3jFNunekzp1UDOQsJoCnNxyLjjW4=;
        b=BNpeZ0Osd1eOOMbedsNNvbi6Kh0Rqnj8d3bJPj8qZXZ4QSwHAGfRAgZhaPZybRH4ne
         noT4fnFNN9czijbAFZxC1MkAlmO7N9bPiGL+quQ7DQ+mxt5/+Q3xyVuSys0roqBe/XlM
         OcLiCIcvx3Ra55HFM5c7dTRfcAKdItQIa9du3TQDj6fq5V6qLo0kl5FQnhnsI8UFK0RU
         fy4F/4OdU6qE9UteJzcP6Cm6AyPhECDFJ0Kqd/3kqNz8gl1xDhsEWaIBiEMnqC6oCSoP
         MBJ7gihWpeUEsKKZloTB3Qbor9ktEqM3w8e4It3VYAUnLqnmwZMbwVnLyB3YmLOY60YX
         FOFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733997982; x=1734602782;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Of1BFeg2KON1xNm3jFNunekzp1UDOQsJoCnNxyLjjW4=;
        b=YgN1YA4ipvJXsvWIotAV6yHUrUeGOUMjKvsK+/WC1NpYPZCmXPlJnV8sNEO/gRZzuK
         VcwuaiJUcd6a+E4ayhbKd01CPELwp724kFcjXcONnEO0QQJFLoCWpVTkz8yygabsB3d3
         kmfhhn0pjYJIhW477zcPUJ30Vvr0uYZJT+aUqmhpXvZPYjRnNsVqTfxeGI43FiCGcXXR
         y8e5lii4CkjQUeMs6CymT8SiwCwy41TU6rsQszokR7zPuNR2bC208GeTKJQplm9yjVeo
         gW57uO4Ake5nirupJPe1hR6ycSlyIoPo1d6sd2Lx6xx35tKuvdsL4Ip5IPUcFpc4HlLd
         dHhw==
X-Forwarded-Encrypted: i=1; AJvYcCWy5J7f9hIrjWoJIZswYLpVbo5XWALK5HLVgn7eDKfl8wBlPQGd2WjIm8g+rAUx1SItlj5wCIulQ6gXpjS38e9mYZc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwN0t8O1ohln+yNORC6+hzLbguFlrR+ANpPVVUhHKL7WrV32igq
	sC+3f1N+lJ7TxbEKzQL6e66zmBZtZ2Y6jg4Z74OJwlBPTW9mkHEJlUOVisHeG3YBqXa7ak7Cddu
	nYhPx+mHhWzNrmzA1lgjQaeylDrikfVof/ic9
X-Gm-Gg: ASbGncsReFP3QhWIuZ00/Ldwbm3sC2XE3dRiUEdJp0akTC1DPzgdtjlu8yJiApj7TFN
	fCbew9HwV1bdFC3GVOo26EBsmkFGUDVzyCSS9j46EevbmqK5GsuCMSPG7eV5r5vgLF3E=
X-Google-Smtp-Source: AGHT+IHUvvVABps1uuPMxjIXuv4cTLRDFnTx/UHIKWDoA76gNJlFIEgBNsM3HWFBYgN6SlATfLNLOarEKRNTza20ijc=
X-Received: by 2002:a05:6214:21a6:b0:6d8:99cf:d2e3 with SMTP id
 6a1803df08f44-6dae3913ff2mr41578706d6.22.1733997982309; Thu, 12 Dec 2024
 02:06:22 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241108113455.2924361-1-elver@google.com>
In-Reply-To: <20241108113455.2924361-1-elver@google.com>
From: Alexander Potapenko <glider@google.com>
Date: Thu, 12 Dec 2024 11:05:45 +0100
Message-ID: <CAG_fn=VyvPfJnPcXOOAeFqNakKKYzjuUdDqW5Z4rVQMgQA=AGw@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] tracing: Add task_prctl_unknown tracepoint
To: Marco Elver <elver@google.com>
Cc: Steven Rostedt <rostedt@goodmis.org>, Kees Cook <keescook@chromium.org>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Oleg Nesterov <oleg@redhat.com>, 
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	Dmitry Vyukov <dvyukov@google.com>, kasan-dev@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 8, 2024 at 12:35=E2=80=AFPM 'Marco Elver' via kasan-dev
<kasan-dev@googlegroups.com> wrote:
>
> prctl() is a complex syscall which multiplexes its functionality based
> on a large set of PR_* options. Currently we count 64 such options. The
> return value of unknown options is -EINVAL, and doesn't distinguish from
> known options that were passed invalid args that also return -EINVAL.
>
> To understand if programs are attempting to use prctl() options not yet
> available on the running kernel, provide the task_prctl_unknown
> tracepoint.
>
> Note, this tracepoint is in an unlikely cold path, and would therefore
> be suitable for continuous monitoring (e.g. via perf_event_open).
>
> While the above is likely the simplest usecase, additionally this
> tracepoint can help unlock some testing scenarios (where probing
> sys_enter or sys_exit causes undesirable performance overheads):
>
>   a. unprivileged triggering of a test module: test modules may register =
a
>      probe to be called back on task_prctl_unknown, and pick a very large
>      unknown prctl() option upon which they perform a test function for a=
n
>      unprivileged user;
>
>   b. unprivileged triggering of an eBPF program function: similar
>      as idea (a).
>
> Example trace_pipe output:
>
>   test-380     [001] .....    78.142904: task_prctl_unknown: option=3D123=
4 arg2=3D101 arg3=3D102 arg4=3D103 arg5=3D104

For what it's worth:

> Signed-off-by: Marco Elver <elver@google.com>
Reviewed-by: Alexander Potapenko <glider@google.com>
