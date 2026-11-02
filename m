Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793603460;
	b=XYOItl5A3CyFX3xMBrVm/TAHAGrFnlWj/gqX/gBhPWEjMp+EAx/fUQOppNUSgOWMOfhf
	 VTn30n7HGB+CjrHRtonrOtw0q7H4c7g3sKyYWvkrZlSnK1zZO5+pCf2Qd4GKyzZKZyK3b
	 HmLYI+J2UsCPLzVslEpp0OyLH8MTKkP7h3WwdxdRJS2TOzLLsfyALDMJKi9Kn9nzsKem4
	 pVQr+AVeTpA3fMYeWGwSHjkV49kv20+0GsncWgpfFOxG8h232yAgT83p8qxkqbVDs1hVd
	 DSCpIlYcYymILJH2hbkENK0RWIWtDtBuwVqHFyGIOLkfaUTp79wbM54q71AgaDYK6VA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793603460;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 User-Agent:MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=ev+GPuJSMdjcYYdxrSBBzZgvVzbRgj/2WINJJ71YQXc=;
	b=Rxs10iyjzYl6IW9P8VNeJcQp4KqEVbp9gsImno8AqDqcA/w0KaI9C9+74to1r3tIF3O9
	 KaDu0bRPSsg1GM/qr2vfMaiLAkb/14GNsyQRaojbbDkpJ2EyPLENR+oE7CMqOCnoTwMmL
	 lwcuard3/41NsAx76iXhFej+Lp82bfXGz0OqIZ+Mb+S6K0U0kz+CKSe0oQpNBqixc8nNH
	 IODgWbp5fOzAnqnKYxpyw9DCzE91Ah165loBj/UPjN/fxRKUgIhrPuEVCseexgeL2Y5Ty
	 8zLBzcgWKYwX99GpXq2+2wrXBVclZsvy0vD25SWWaZeWbXiUp8bm4G/LkJzclypnBhg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jVhwU9iN;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9B9E606A324;
	Mon,  2 Nov 2026 07:10:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jVhwU9iN
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1A811F000C1;
	Mon,  2 Nov 2026 07:10:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793603459;
	bh=ev+GPuJSMdjcYYdxrSBBzZgvVzbRgj/2WINJJ71YQXc=;
	h=From:To:Cc:Subject:Date;
	b=jVhwU9iNwwkB2N6Egl5t70pSkVQCJty0oL2pPVQ7gkQdxyEIaSBM5y1z8KJjaJ2Kk
	 3ebJ/0HbzKPDwUtFOqG0XqdqDw5J2jPkxZWQpoEI3jCn/xtWwn4pksReQ2+V4OUBp5
	 okpWtnZ2nWYlTIKLGW6PZY0ddFiH38kbSbsdguDg3Blo3sCLvqsHRsfBq4fYAsUNuQ
	 yjbQV1n7zYqQbxVAZUojcjRKy0kqNQfRO/HIKT1OYbL7If3g2XLgNbHMuN5rj1DLsd
	 89Cwn9wHWHfjWUHOXZWffW1lRdLGmHgZk6PYZnXHRMRO9LgXhWIdUg1GaqMqY6n44V
	 eSv8RdAMzRk7w==
From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Naveen N Rao <naveen@kernel.org>,
	"David S . Miller" <davem@davemloft.net>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	Tiezhu Yang <yangtiezhu@loongson.cn>,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org
Subject: [PATCH 0/3] probes: Use trace_printk() in probe handlers
Date: Mon,  2 Nov 2026 16:10:54 +0900
Message-ID: <179360345418.115681.193455787480210412.stgit@devnote2>
X-Mailer: git-send-email 2.43.0
User-Agent: StGit/0.19
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Post: <mailto:linux-trace-kernel@vger.kernel.org>
List-Help: <mailto:linux-trace-kernel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-trace-kernel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

Hi,

Here are patches to update the probe sample code to use trace_printk
instead of normal printk. Since the fprobe and kprobe/kretprobe handlers
can be called from somewhere where console is locked, using printk() is
basically unsafe. Only the unoptimized kprobe on x86 is safe because it
is ran with NMI context (in this case, the kernel uses printk_deferred()
automatically), but optimized kprobe/kretprobe/fprobe are not.

Thus, this series replaces those printk() (pr_*()) with trace_printk()
which should be safe to output the result into trace buffer, and use
trace_dump_stack() instead of stack_trace_print().

The similar issue had been reported by Tiezhu Yang [1] in 2023, but
it was pointed different reason, and not applicable to upstream.
I investigated it again.

[1] https://lore.kernel.org/all/d179086d-78d8-d0e3-e113-9072cffa55f4@loongson.cn/

Thank you,
---
base-commit: bc71431221f5ba8bb33918399552636e059c2c45

Masami Hiramatsu (Google) (3):
      samples/kprobes: Use trace_printk() in probe handlers
      samples/fprobe: Use trace_printk() and trace_dump_stack()
      docs: trace: Warn against using printk() in probe handlers


 Documentation/trace/fprobe.rst      |    5 +++
 Documentation/trace/kprobes.rst     |   11 +++++-
 samples/Kconfig                     |    4 +-
 samples/fprobe/fprobe_example.c     |   49 +++++--------------------
 samples/kprobes/kprobe_example.c    |   69 ++++++++++++++++++-----------------
 samples/kprobes/kretprobe_example.c |   10 +++--
 6 files changed, 66 insertions(+), 82 deletions(-)

--
Masami Hiramatsu (Google) <mhiramat@kernel.org>
