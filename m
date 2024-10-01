Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90D301C579C;
	Tue,  1 Oct 2024 13:56:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727791007; cv=none; b=DOJlx92/opdzLyyWBszKVuL0UuFly+RIe3s6CU19Y1xy3Fa+nH7GzsfLMJVLkrqAbWjuDCI00IDmx0Q14fPk65CO1rlbQbkTXApS2DDRH6mpV1ORFUsaA2jZ2VXmj5eUVLBk76DlovzCjMYjA5zJGNY7otwxeic0jg+HQ12PRCc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727791007; c=relaxed/simple;
	bh=ADO3dNZJ54TIzbUCmtttewpjXcWcj8gwabnqbM0OEfg=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=orknJdWAt2PN3WqY6d6ns4Yh1aCu+ZKP8Fy587xlO64SM87QOPX5VvKWhFp2TdL93JrkmsTIeKCcrGeu6D0+EQEFHRDwnx0UIDOAJE72EZvgHSJBs0HrkMU3RS1u52ZDHwRPmOP3bvU+p7vtgnZs+XEZxt/BB/w6GqAXHScXpNw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9659C4CEC6;
	Tue,  1 Oct 2024 13:56:45 +0000 (UTC)
Date: Tue, 1 Oct 2024 09:57:34 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: LKML <linux-kernel@vger.kernel.org>, Linux Trace Kernel
 <linux-trace-kernel@vger.kernel.org>, linux-doc@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Jonathan Corbet <corbet@lwn.net>, Mike
 Rapoport <mike.rapoport@gmail.com>, Kees Cook <keescook@chromium.org>, Ard
 Biesheuvel <ardb@kernel.org>, Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH v2] Documentation/tracing: Mention that
 RESET_ATTACK_MITIGATION can clear memory
Message-ID: <20241001095734.11a67b4b@gandalf.local.home>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

From: Steven Rostedt <rostedt@goodmis.org>

At the 2024 Linux Plumbers Conference, I was talking with Hans de Goede
about the persistent buffer to display traces from previous boots. He
mentioned that UEFI can clear memory. In my own tests I have not seen
this. He later informed me that it requires the config option:

 CONFIG_RESET_ATTACK_MITIGATION

It appears that setting this will allow the memory to be cleared on boot
up, which will definitely clear out the trace of the previous boot.

Add this information under the trace_instance in kernel-parameters.txt
to let people know that this can cause issues.

Link: https://lore.kernel.org/all/20170825155019.6740-2-ard.biesheuvel@linaro.org/

Reported-by: Hans de Goede <hdegoede@redhat.com>
Reviewed-by: Hans de Goede <hdegoede@redhat.com>
Acked-by: Ard Biesheuvel <ardb@kernel.org>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
Changes since v1: https://lore.kernel.org/20240926130159.19e6d0e2@rorschach.local.home

 - Added more detail explanation that the system may not be able to use
   memory to preserve the tracing ring buffer across reboots and use
   the CONFIG_RESET_ATTACK_MITIGATION as one example.

 Documentation/admin-guide/kernel-parameters.txt | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 1518343bbe22..9881e3b857d0 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -6867,6 +6867,12 @@
 
 				reserve_mem=12M:4096:trace trace_instance=boot_map^traceoff^traceprintk@trace,sched,irq
 
+			Note, saving the trace buffer across reboots does require that the system
+			is set up to not wipe memory. For instance, CONFIG_RESET_ATTACK_MITIGATION
+			can force a memory reset on boot which will clear any trace that was stored.
+			This is just one of many ways that can clear memory. Make sure you system
+			keeps the content of memory across reboots before relying on this option.
+
 			See also Documentation/trace/debugging.rst
 
 
-- 
2.45.2

