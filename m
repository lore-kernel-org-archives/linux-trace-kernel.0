Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AC1A1C6B4;
	Thu, 26 Sep 2024 17:02:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727370122; cv=none; b=dQb15c0E7Z/fkG7ILtR7Hc07KrQJNo2ESF4lYmGMesIR5H9HtvOFBfmX8DSydQPh0KTvj1Uw9guOzjad5Itd2Y4r3X2ioI37obl5aDkXfuMhjIe7K6FsBCL3kNGAs3ALS06gaG/oIebsSSb7IuVr6aQsarBkAB2P+jYD4P0PH1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727370122; c=relaxed/simple;
	bh=K9C9IfIihUP2RQiCo+rWgpc2wkCABq/E2CmKe9wU09U=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=WoKL9ICh50gcuhjDHydFst1OdKmk0qSY6oG2bNGFrslgFJsVTkSCx3QxUpDTkjzmrPH6nDyPXjrHQa7Ef4OoLX7Q07IE2GrD/6/pm4ixmF1leB471tHF1gFktaGbM4fJX4IyyCrR2WCuxJHj77wjyT+QTB1iF6ogHhktMqZiiwk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30B8BC4CEC5;
	Thu, 26 Sep 2024 17:02:01 +0000 (UTC)
Date: Thu, 26 Sep 2024 13:01:59 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: LKML <linux-kernel@vger.kernel.org>, Linux trace kernel
 <linux-trace-kernel@vger.kernel.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Mike Rapoport <mike.rapoport@gmail.com>,
 Kees Cook <keescook@chromium.org>, Hans de Goede <hdegoede@redhat.com>, Ard
 Biesheuvel <ardb@kernel.org>
Subject: [PATCH] Documentation/tracing: Mention that RESET_ATTACK_MITIGATION
 can clear memory
Message-ID: <20240926130159.19e6d0e2@rorschach.local.home>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
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
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 Documentation/admin-guide/kernel-parameters.txt | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index bb48ae24ae69..f9b79294f84a 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -6850,6 +6850,9 @@
 
 				reserve_mem=12M:4096:trace trace_instance=boot_map^traceoff^traceprintk@trace,sched,irq
 
+			Note, CONFIG_RESET_ATTACK_MITIGATION can force a memory reset on boot which
+			will clear any trace that was stored.
+
 			See also Documentation/trace/debugging.rst
 
 
-- 
2.45.2

