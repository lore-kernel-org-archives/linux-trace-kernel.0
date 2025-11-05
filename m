Received: from relay.hostedemail.com (smtprelay0011.hostedemail.com [216.40.44.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D3F41D7995;
	Wed,  5 Nov 2025 01:53:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762307597; cv=none; b=trNKWDdisGM1pRextHCwJf0wLjjqfcl0IcI+FJqc3oefDW2AIk5TaRXyTV/cLiJM6nPIAPkeTXnDs3Vhc/aFRgjpfr2Mm7mrwXmcu71yeuwN0uGouLL7/JnRj6uPaVPc1fG8n1F8+9QEl+HxAxdvOqdjYg/q2gZ5q18GATj6znk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762307597; c=relaxed/simple;
	bh=xDmQ0JkqFqpk6hbJV4tmG/oi+qMVUrVaXA8mfmWZar8=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=LqVPEexkgYqSLWcGReq+E01mNY1pZYKOLm66Y/D37IWUIwAYEzKqcNCMhpJj/QKxCRUtlTQjo8Esg4cg6mgKuoUnKAUehp8B0vCXZ5u6iM2mfU4PX6oo7Q6F8JRqkbCcyrHRFLcIMRS/twgkk2gM7idFPcgzbhFqEo11YO74g38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf07.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay02.hostedemail.com (Postfix) with ESMTP id 3EA6B135D9B;
	Wed,  5 Nov 2025 01:53:07 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf07.hostedemail.com (Postfix) with ESMTPA id 84A8E20024;
	Wed,  5 Nov 2025 01:53:05 +0000 (UTC)
Date: Tue, 4 Nov 2025 20:53:10 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: LKML <linux-kernel@vger.kernel.org>, Linux trace kernel
 <linux-trace-kernel@vger.kernel.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, kernel test robot <lkp@intel.com>
Subject: [PATCH] tracing: Hide __NR_utimensat and _NR_mq_timedsend when not
 defined
Message-ID: <20251104205310.00a1db9a@batman.local.home>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 84A8E20024
X-Stat-Signature: e1weteh6g97bgrss3ieiy8y13yjqae7r
X-Rspamd-Server: rspamout02
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1/QO88el/5dRNNFe/7srGwsNdU4qtmHJ5s=
X-HE-Tag: 1762307585-439757
X-HE-Meta: U2FsdGVkX1929Gs8lZnVWJ542b8OWjKVWF5iRrW7STnzcR1zWDb/Sc100Z5ayljoe6E1tnUIUWr2dE3CxeCkJCmU0WtxvpWLbrUZp2RWsFiUiqZX6mfG9YFCmPetICpKGG08HYRdjluBN48pExZ6J2qTx5cEu4WrnUJW6RVgnp+KoyBBb+JbksbcJhqyjD1xUTE9B2tQZ52yAJuEPuNuJXmI1C+4fT/qIYdWUfXk/CbISD0fcZkcp5mXBVMJPtguDwAj9lRhds7gRDwNsuW2Eion7K78ulYQ+s203xzuupuUF92k95p09mxFqljstMsp11lnB6vz+MMKq4+LSns/A3tNmNb01OfC7o5M8Tr1Fa6IQb/vaL2uVmZCKGvuyDEN/SnYPIutoSsY96rjGxkYv/fhEQX4EEzEZEViNZ9BiQM=

From: Steven Rostedt <rostedt@goodmis.org>

Some architectures (riscv-32) do not define __NR_utimensat and
_NR_mq_timedsend, and fails to build when they are used.

Hide them in "ifdef"s.

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202511031239.ZigDcWzY-lkp@intel.com/
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 kernel/trace/trace_syscalls.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/kernel/trace/trace_syscalls.c b/kernel/trace/trace_syscalls.c
index e07c5a3cc7ab..e96d0063cbcf 100644
--- a/kernel/trace/trace_syscalls.c
+++ b/kernel/trace/trace_syscalls.c
@@ -1072,7 +1072,9 @@ static void check_faultable_syscall(struct trace_event_call *call, int nr)
 	switch (nr) {
 	/* user arg 1 with size arg at 2 */
 	case __NR_write:
+#ifdef __NR_mq_timedsend
 	case __NR_mq_timedsend:
+#endif
 	case __NR_pwrite64:
 		sys_data->user_mask = BIT(1);
 		sys_data->user_arg_size = 2;
@@ -1186,7 +1188,9 @@ static void check_faultable_syscall(struct trace_event_call *call, int nr)
 	case __NR_syslog:
 	case __NR_statx:
 	case __NR_unlinkat:
+#ifdef __NR_utimensat
 	case __NR_utimensat:
+#endif
 		sys_data->user_mask = BIT(1);
 		break;
 	/* user arg at position 2 */
-- 
2.51.0

