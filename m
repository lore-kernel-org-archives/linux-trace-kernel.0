Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=216.40.44.15
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795642119;
	b=VAMND6hS5YxWqP2+OiZVclPdoFwavG2qck+ADnigIzvcv6ZFUVsX4vxoSJBSvKlnmhXg
	 qTQHTonWg1XE2FeTW4r+GXNCuhfdEg10cTWTHJXbWr0e5H2P+MbIKIRtk5ihbrF9vBar6
	 DN3XXcsoi5KRmFKY0CPlflJDzwamN1h2l6PsH/zsULia5jezQ6PQKb7AjEsD5vIRhAmfG
	 DtJFUlq4lwMVQzsL1Fu/zFcjBUmoXZ0X3kyPdxDMpeoTBch8ZtqXphLo8zbQs9CpELM/q
	 4GXfA0Ala7UevYVVf9ffp/etwB9J+4pJIMKxZVCd/NyNTuldczqsu6lylgzzVxEDAxA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795642119;
	h=DMARC-Filter:Received:Received:Date:From:To:Cc:Subject:Message-ID:
	 X-Mailer:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-Stat-Signature:X-Spam-Status:X-Rspamd-Server:X-Rspamd-Queue-Id:
	 X-Session-Marker:X-Session-ID:DKIM-Signature:X-HE-Tag:X-HE-Meta;
	bh=wdubbU4C4QfHvxGlPo5i758PKViG5JBAET2wpadLeHU=;
	b=aE/7iScWsaTD8bTgX4+LQhNFPksjcGNDQoeNyMFKdSDUx0U7S9R0rV5CjbVvHhJ7p90y
	 +LyI920xyzunVEnm7buKqEyyev0fP7W4Tqm7cuPsVYEWImmUY9gp0TPQ9OXnj+GGsf/z7
	 3DW1r1Alr5KSKO+8u2WJGujAXDyhlKJscSnIQmitUKrZGsjuGxAePsDgZy9RWYSJla75b
	 kJVmdZfbxQYfklIIs9awHZDAMdLLKhwE8/KMmRGVLJTIKB6d2PukZfLicORs2HJ68tOjl
	 fM7xEDlgRT975LijTUoSmcc5AuLHhxo3fFr99C62qWdlXju3IIHeXl3jLx1ElrSBGkw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=goodmis.org;
	spf=pass smtp.mailfrom=goodmis.org;
	dkim=pass header.d=goodmis.org header.i=@goodmis.org header.a=rsa-sha256 header.s=dkim1 header.b=UucNguBT;
	arc=none smtp.remote-ip=216.40.44.15
Received: from relay.hostedemail.com (smtprelay0015.hostedemail.com [216.40.44.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53F2B606A686;
	Wed, 25 Nov 2026 21:28:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 53F2B606A686
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=goodmis.org header.i=@goodmis.org header.a=rsa-sha256 header.s=dkim1 header.b=UucNguBT
Received: from omf09.hostedemail.com (lb01a-stub [10.200.18.249])
	by unirelay04.hostedemail.com (Postfix) with ESMTP id DD2621A0127;
	Wed, 25 Nov 2026 21:28:36 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf09.hostedemail.com (Postfix) with ESMTPA id 5929C2002B;
	Wed, 25 Nov 2026 21:28:35 +0000 (UTC)
Date: Wed, 25 Nov 2026 16:28:34 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: LKML <linux-kernel@vger.kernel.org>, Linux Trace Kernel
 <linux-trace-kernel@vger.kernel.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>
Subject: [PATCH] tracing: Fix crash on lseek of recursed_functions file in
 WRONLY mode
Message-ID: <20261125162834.2df4c684@gandalf.local.home>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Post: <mailto:linux-trace-kernel@vger.kernel.org>
List-Help: <mailto:linux-trace-kernel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-trace-kernel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: 13sh7uftiah7bap37uf43166tou7rs5z
X-Rspamd-Server: rspamout01
X-Rspamd-Queue-Id: 5929C2002B
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX196g8AXPR6bH19cV/ubkt6iXbYx8UNBFl4=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=goodmis.org; h=date:from:to:cc:subject:message-id:mime-version:content-type:content-transfer-encoding; s=dkim1; bh=wdubbU4C4QfHvxGlPo5i758PKViG5JBAET2wpadLeHU=; b=UucNguBT12twrZlEpugFW5pJz2f7V0GWkoE8v1IaIcJyp+IkW/9c/n2yPqQNizn+Vzl1Tl8Ba114PvKQtc31IO22psvVw4GYDNU4OqdV4Bb2efuapEg3jqsvG9ZWUJPpedWv64lMi6d/boLDIHknPi3/M7MsTkBVzp+PI8Vil38=
X-HE-Tag: 1795642115-248737
X-HE-Meta: U2FsdGVkX1/XR1JtDt00ecgL6V0EUmK/f/Wn1BLFGABCzfOSF7AD8Kjpi/mFYbpAFQn7zXqB8GhD2qWa0WM38qFVinKhIjHN3f2T5Vtru7LMVXOVtSaMNjzsjChx48bdAIBMj81dNwOm4hJUC3ykWZMXy7Tyi9uDa4wexl7qXuZVLXgn9yvk0qAhvJx7s2/rx3NBhZ8ixYE3y3qj8Kk5bO4ki4g+y3LElofmqy7/y4w8t2GHjGAUVoNKfZ2LO9jFa4wkj5AA+OPRNkr4h1/Az1MGWteErvGHSjuX2BbZEJOLfIW7P4s00kRLnyxgUqOzETnwFik3vYTc574WYLPdalkvuultSahIrIO8NbOvkyuMT9EemkbgAHH9OkK2GyTe2ADdR0WiAl8/qefYyvhMjFQNDuZYC0sQSbjrEctCpmnNQP74g2IS68ToSg0ZEQsOKpjnEzaPfvxq0Wo88kW87SurKgC88yQDxYRFLNxL07c=

From: Steven Rostedt <rostedt@goodmis.org>

The lseek method for the "recursed_functions" file only handles
seq_lseek() which is for when the file is opened for reading. If the file
is opened for WRONLY, it will cause a NULL pointer dereferenced:

Oops: general protection fault, probably for non-canonical address 0xdffffc0000000012: 0000 [#1] SMP KASAN PTI
 KASAN: null-ptr-deref in range [0x0000000000000090-0x0000000000000097]
 CPU: 5 UID: 0 PID: 1100 Comm: lseek Not tainted 7.4.0-rc4-test-00006-g4dca8a8ee893 #36 PREEMPT(lazy)
 Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.17.0-debian-1.17.0-1 04/01/2014
 RIP: 0010:__mutex_lock+0x162/0x2550
 Code: 08 84 d2 0f 85 a1 1c 00 00 44 8b 0d 38 cb df 03 45 85 c9 75 29 48 b8 00 00 00 00 00 fc ff df 48 8d 7b 58 48 89 fa 48 c1 ea 03 <80> 3c 02 00 0f 85 a6 1c 00 00 48 3b 5b 58 0f 85 3f 0e 00 00 bf 01
 RSP: 0018:ffff8881211afd10 EFLAGS: 00010206
 RAX: dffffc0000000000 RBX: 0000000000000038 RCX: 8000000000000000
 RDX: 0000000000000012 RSI: ffffffff8588bdfb RDI: 0000000000000090
 RBP: ffff8881211afe70 R08: 0000000000000001 R09: 0000000000000000
 R10: ffff8881083f8000 R11: ffffed10247ebc54 R12: 0000000000000000
 R13: 0000000000000000 R14: dffffc0000000000 R15: 1ffff11024235fac
 FS:  00007fb27d236780(0000) GS:ffff8882b4581000(0000) knlGS:0000000000000000
 CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
 CR2: 000055fb6eb6e008 CR3: 000000011d26e006 CR4: 0000000000172ef0
 Call Trace:
  <TASK>
  ? seq_lseek+0x60/0x3d0
  ? kmem_cache_free+0x14b/0x610
  ? __pfx___mutex_lock+0x10/0x10
  ? do_sys_openat2+0xd8/0x180
  ? seq_lseek+0x60/0x3d0
  seq_lseek+0x60/0x3d0
  ? __pfx___x64_sys_openat+0x10/0x10
  ksys_lseek+0x3c/0xb0
  do_syscall_64+0xcd/0x6f0
  entry_SYSCALL_64_after_hwframe+0x76/0x7e
 RIP: 0033:0x7fb27d33fa17
 Code: 8b 05 fd 03 0e 00 64 c7 00 0d 00 00 00 eb b2 e8 ef 98 01 00 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 b8 08 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 01 c3 48 8b 15 c9 03 0e 00 f7 d8 64 89 02 48
 RSP: 002b:00007ffd486d0258 EFLAGS: 00000202 ORIG_RAX: 0000000000000008
 RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007fb27d33fa17
 RDX: 0000000000000002 RSI: 0000000000000000 RDI: 0000000000000003
 RBP: 00007ffd486d0280 R08: 0000000000000000 R09: 0000000000000000
 R10: 0000000000000000 R11: 0000000000000202 R12: 0000000000000002
 R13: 00007fb27d482000 R14: 00007ffd486d03b0 R15: 000055fb6eb6cdd8
  </TASK>
 Modules linked in:
 ---[ end trace 0000000000000000 ]---

A helper function "tracing_lseek()" already exists for this use case. Have
the file_operations for the recursed_functions file use that.

Cc: stable@vger.kernel.org
Fixes: 773c16705058e ("ftrace: Add recording of functions that caused recursion")
Reported-by: sashiko-bot@kernel.org
Closes: https://sashiko.dev/?list=org.kernel.vger.linux-trace-kernel#/patchset/20260502174741.39636-1-yashsuthar983%40gmail.com
Signed-off-by: Steven Rostedt <rostedt@goodmis.org>
---
 kernel/trace/trace_recursion_record.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/trace/trace_recursion_record.c b/kernel/trace/trace_recursion_record.c
index 4f63bec052fc..0452c9c4c558 100644
--- a/kernel/trace/trace_recursion_record.c
+++ b/kernel/trace/trace_recursion_record.c
@@ -217,7 +217,7 @@ static const struct file_operations recursed_functions_fops = {
 	.open           = recursed_function_open,
 	.write		= recursed_function_write,
 	.read           = seq_read,
-	.llseek         = seq_lseek,
+	.llseek         = tracing_lseek,
 	.release        = recursed_function_release,
 };
 
-- 
2.53.0

