Received: from relmlie6.idc.renesas.com (relmlor2.renesas.com [210.160.252.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08D601C861D;
	Fri, 14 Mar 2025 09:53:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.160.252.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741946009; cv=none; b=UpNeN06WJ2hYXIvGNrcCLqVu+Rglo8gBpKyDA+ZJG2QqeJ2pGUMQDWSer4N9Fv7YGF+X9FrNCj3KjXRNnKfJHnT63TO95OiLFaATYw1jGmo7WLCdomOH/0NKBQCeznsq4JbvZ4gzkuThGAPHh0BAbtHi2KwJgCx0raqk1z06SU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741946009; c=relaxed/simple;
	bh=5UvQHvHO4GAyWAAJKn2+8upCIfjbrhrfQuDzMxxV2Nw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cloeFP0gx0DRdZdFylORChN3ZXFKo7ERwEmpu6fnVzU8tj3Wo7TKCycVjIVJcWkiMKnI1RVnX3gsPnCZcj45AU/gmmzXhDMqiU7+zlFMDTJ0T7nLLjcMiH98ikinkb4xcLid5S0ZYlzLZDNGYJczRa3FNCE7Ax7P2afr48QNN4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com; spf=pass smtp.mailfrom=bp.renesas.com; arc=none smtp.client-ip=210.160.252.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bp.renesas.com
X-CSE-ConnectionGUID: 6QxDgVtcThiqDbZu1u4mtw==
X-CSE-MsgGUID: 17nN94XkTQirT/8dicy+SQ==
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie6.idc.renesas.com with ESMTP; 14 Mar 2025 18:53:19 +0900
Received: from localhost.localdomain (unknown [10.226.92.208])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id 8000A42D23AC;
	Fri, 14 Mar 2025 18:53:16 +0900 (JST)
From: Biju Das <biju.das.jz@bp.renesas.com>
To: rostedt@goodmis.org
Cc: akpm@linux-foundation.org,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	mark.rutland@arm.com,
	mathieu.desnoyers@efficios.com,
	mhiramat@kernel.org,
	Hi,
	all
Subject: 
Date: Fri, 14 Mar 2025 09:53:12 +0000
Message-ID: <20250314095313.21604-1-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250305164539.379008535@goodmis.org>
References: <20250305164539.379008535@goodmis.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

This series is giving build error on linux-next for 2 days(next-20250314
and next-20250313) on Renesas RZ/G3E SMARC EVK platform (ARM64)

Reverting trace related commits fixes the build issue.

build-errors:
kernel/trace/trace.c: In function ‘save_mod’:
kernel/trace/trace.c:6041:45: error: invalid use of undefined type ‘struct module’
 6041 |         entry->mod_addr = (unsigned long)mod->mem[MOD_TEXT].base;
      |                                             ^~
  CC      net/ethtool/phc_vclocks.o
kernel/trace/trace.c:6041:51: error: ‘MOD_TEXT’ undeclared (first use in this function)
 6041 |         entry->mod_addr = (unsigned long)mod->mem[MOD_TEXT].base;
      |                                                   ^~~~~~~~
kernel/trace/trace.c:6041:51: note: each undeclared identifier is reported only once for each function it appears in
  CC      fs/proc/cpuinfo.o


From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH v4 0/8] ring-buffer/tracing: Save module information in persistent memory
Date: Wed, 05 Mar 2025 11:45:39 -0500	[thread overview]
Message-ID: <20250305164539.379008535@goodmis.org> (raw)


This updates the persistent instance to record what modules were
loaded and what addresses they were loaded at.

First the KASLR offset is recorded in the persistent ring buffer instead of
a text address. This can be used to calculated the address offset.

Next the persistent memory is divided up differently so that there's
a single global meta data for the entire buffer that can hold the
global data, and each per CPU meta data can just hold what it needs.

A scratch area can be created by the caller, in this case the tracing
system, to store data in the persistent memory area.

As the KASLR offset is only needed by the tracer, that data is moved
from the ring buffer meta data into this new storage.

Next the modules that are loaded and where they are loaded is stored in this
new persistent storage.

The module list along with the KASLR offset is now exposed in the
last_boot_info if the buffer is from a previous boot. If it is from the
current boot, the file will only contain:

   # Current

in order to not leak the KASLR offset.

Finally, when new modules are loaded while the trace is active, they too
will be added to this persistent memory. Note, if tracing is stopped, and
then restarted, it clears the module list and will reload all the modules
again so that it doesn't need to keep track of what is loaded or unloaded
while no tracing is going on.

Changse since v3: https://lore.kernel.org/linux-trace-kernel/20250304012516.282694507@goodmis.org/

- Added kerneldoc for scratch_size parameter for __ring_buffer_alloc_range()

Changes since v2: https://lore.kernel.org/linux-trace-kernel/20250215034301.624019422@goodmis.org/

- Have the module loop be protected by RCU and not preemption disabling

- Take the scratch_mutex outside of save_mod() to prevent deadlocks

Changes since v1: https://lore.kernel.org/all/20250205225031.799739376@goodmis.org/

- Rebased on top of the urgent branch

- Allow the size of the scratch area in the persistent ring buffer to be
  defined by the caller.

- Change the output of the last_boot_info to show the kaslr instead of:
  "Offset: <offset>" to "<offset>\t[kernel]" to make it consistent with
  the module output.


Steven Rostedt (8):
      ring-buffer: Use kaslr address instead of text delta
      ring-buffer: Add buffer meta data for persistent ring buffer
      ring-buffer: Add ring_buffer_meta_scratch()
      tracing: Have persistent trace instances save KASLR offset
      module: Add module_for_each_mod() function
      tracing: Have persistent trace instances save module addresses
      tracing: Show module names and addresses of last boot
      tracing: Update modules to persistent instances when loaded

----
 include/linux/module.h      |   6 +
 include/linux/ring_buffer.h |   8 +-
 kernel/module/main.c        |  13 +++
 kernel/trace/ring_buffer.c  | 246 ++++++++++++++++++++++++-----------------
 kernel/trace/trace.c        | 264 ++++++++++++++++++++++++++++++++++++++++----
 kernel/trace/trace.h        |  15 ++-
 kernel/trace/trace_events.c |  40 +++++--
 7 files changed, 449 insertions(+), 143 deletions(-)
 
 


