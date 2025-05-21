Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFFD32AF1E;
	Wed, 21 May 2025 16:40:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747845648; cv=none; b=gZE6jFusfR/eAZQrL4v7W8kPwy7nvqcjVJgepsiLzGXnu9JDYCrxHSq9XMPYmAhTxM1W5S1u4FxiCroMNLg3+3IMAp3JcMi+Ob14xh2AvckskDke8GuTP52BPbbdZsyFybEvsjAOi0ar293sS7Vl0IaAYE6ReAO4dPt/uSYQLNQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747845648; c=relaxed/simple;
	bh=K/k900pxxzDiA8RnCDxd1V23FxVQVY569NbjSNygS5U=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=RQINJdSNMT8xlWRRSoTTCqd2aAn7JyTa95LQGHGMr0FxUdHKG3qsh2r8Do51jUxIBJBDSkNpRPLEcWGx058sgaukf3xjpN1VnhEb3ZkmOFb7e6KHNwUDtNxmIRKW9HiBAVP2DvoEcUrCHhuKF3IdW1PIu+G2+Yh5D7XO98ujQl0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=B0Szw4u0; arc=none smtp.client-ip=209.85.208.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B0Szw4u0"
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-3105ef2a071so81838291fa.1;
        Wed, 21 May 2025 09:40:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747845644; x=1748450444; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=2K4U8sKagmUNoScatR+EDygnq414S+CFvFGtu6kZJkY=;
        b=B0Szw4u0MahAy4nai2FIbP7xEM1rTrB8Pw5Hk3IH2Xtc7Y89xQeyVciEc7TqnxOz2F
         C3twaE0GhaUsFfrtmC36GIDBb0HcsPLQXXiPCCB8vQRhSyleR8TWCj4TU6MqHWzRc4jE
         iM/YQnKtJ00e/ZbYGLJf8PFB3JnvBNWYFNsXK2Tp68fYAT3Ro90dsnTWf0nZhkgKdN87
         elqlgLxXn9IGoVDunjJwebiIY/BIjgxXtXYjsxkIRr3pCyCMoMqJ5Buiz9a+x6p05eKc
         vLXfZqmWWE537WH/9VzSeQZOcaOyb7ps3b0WOftOYNEm7csqcNmmjkiB8CVfl7spUqyu
         4s+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747845644; x=1748450444;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2K4U8sKagmUNoScatR+EDygnq414S+CFvFGtu6kZJkY=;
        b=WVqqY42uZN9qa2tT9POt0XmVMN9lVSUF2fJcOICtlyTMYLLsBEmkS5FE9iF28nS8mE
         9AZqi7dXmcoPJSBrRfhTm/3sJkw7OY6fjEQgVXeRCbuGKysi07TTihRtiqPcHjV8ydih
         amy8tkX5OuL2+desln3FsAYxXstlkL+hWRhxaVfstKhw7Yuo2a0Kp5ao4a/hueeTtkmF
         BnfkDmCuvKg1gDnm/7ozCuT5p9dwElIvURjL3MLLknzHeaav+EoKkas9r/HMfogvgHwb
         iXYGTlI80Sf+0Hlg7i9iR0STGzpfD5AtNJ7tH8rNsuGwaqoTlLhpHkbgkwo0bVdxGO6i
         palA==
X-Forwarded-Encrypted: i=1; AJvYcCUEoKpQ6OWxQ3JEihg+Cq9Iy9feberOvVxGfcnGgSpJtYv5OC3mh5sZ6uCaZ9hiXR1jUURc6qUhHUMc/HH1YcSclbzY@vger.kernel.org, AJvYcCVsBHF0ZWqlJ6Go7kK0I+GntibJ5j0PfZ9nP6kYCynQigtXZatmpCoJsPR+LTztR/+L4QaH6HUGEqNKk3U=@vger.kernel.org
X-Gm-Message-State: AOJu0YytIrHNA1P1a3CQHPHAQrrHtaysTJAUqchKdzNuOJDpE4+fXoeH
	NDya22/eimzcOWpsv/SSIOpxAcZU2RFRT5ZmyNv0OPOQsLOkrC07cYuqaBhlWSLLrlho/KQ9lEI
	eqstRCJhzeABe1v0llLBPrCMPgTg0lEMUTmdI6w==
X-Gm-Gg: ASbGncuBQiVLpTfgMfoXoRPPFPhHPm3BMmHJDKBk0+jApxyU/hemLXWOLuKLYpmthuU
	rhpJHwNluxLf73V8HdGwsOMIWIfXOFLYIQyWe63+BPchBEFNOmZMZ5+wsQGmHeSa1CFFBKdoYFh
	4r/c2SkaZfQXl4hHMrMkacF8Q/zoWEHZPIeqPOLsoEgfN4Ij0/R0hAMw==
X-Google-Smtp-Source: AGHT+IGaO8xc05VxW66TekNIl5EAmRPPBAotPnokgkveiW8JFj88ACBBHLPx6AzHgRQn0iLBLJPjx0FTqgM57W66ILk=
X-Received: by 2002:a05:651c:4184:b0:30b:a9b7:7dfa with SMTP id
 38308e7fff4ca-328096a37b6mr56769421fa.3.1747845643812; Wed, 21 May 2025
 09:40:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: John <john.cs.hey@gmail.com>
Date: Thu, 22 May 2025 00:40:29 +0800
X-Gm-Features: AX0GCFuqttfVh2MjsPk0WxTR42OX0inxuVlUJiKU_YQ3g6YWKN91YyC-se4OhM8
Message-ID: <CAP=Rh=OFdom8bL-KiWf88AyVZkJWnAJ+HBO7rE_74sOFzK=apQ@mail.gmail.com>
Subject: [Bug] soft lockup in syscall_exit_to_user_mode in Linux kernel v6.15-rc5
To: Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Dear Linux Kernel Maintainers,

I hope this message finds you well.

I am writing to report a potential vulnerability I encountered during
testing of the Linux Kernel version v6.15-rc5.

Git Commit: 92a09c47464d040866cf2b4cd052bc60555185fb (tag: v6.15-rc5)

Bug Location: 0010:tracing_gen_ctx_irq_test+0x54/0x1f0 kernel/trace/trace.c:2538

Bug report: https://hastebin.com/share/asotenajan.bash

Complete log: https://hastebin.com/share/kurebaguxo.perl

Entire kernel config:  https://hastebin.com/share/padecilimo.ini

Root Cause Analysis:
The root cause is unbounded recursion or excessive iteration in
lock_acquire() initiated via perf tracepoints that fire during slab
allocations and trace buffer updates. Specifically:
tracing_gen_ctx_irq_test() is invoked while tracing kernel contexts
(e.g., IRQ/softirq nesting).
This tracepoint triggers perf_trace_lock_acquire() and further invokes
lock_acquire() from lockdep.
Inside lock_acquire(), the kernel attempts to inspect instruction
addresses via __kernel_text_address(), which cascades into
unwind_get_return_address() and stack_trace_save().
However, these introspection functions are not expected to run in
real-time-sensitive softirq context and they do not contain preemption
or rescheduling points. With sufficient recursion or stress (e.g.,
slab allocation with tracepoints and lockdep active), CPU#0 gets
trapped and triggers the watchdog.

At present, I have not yet obtained a minimal reproducer for this
issue. However, I am actively working on reproducing it, and I will
promptly share any additional findings or a working reproducer as soon
as it becomes available.

Thank you very much for your time and attention to this matter. I
truly appreciate the efforts of the Linux kernel community.

Best regards,
John
