Received: from relay.hostedemail.com (smtprelay0012.hostedemail.com [216.40.44.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA1982E36EB;
	Wed, 23 Jul 2025 16:42:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753288929; cv=none; b=jJVj6vpvOgLT985B32MED/KW1RaqD1M8iIzRIROuMle3vpGufyVxgBuL5eNw41AS3fVBX0Tnu3/5D+s3xjTYBiKDk+uMw6RToaK+S6BEzMAUoyhj2qiCanyQajTh3Qk13FfeyvpPAzy3/P4s7OBo7YqpSOAA7bqRIqy7ot0RS3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753288929; c=relaxed/simple;
	bh=uSnA7guYjYj06IC+uiBx+JjZ0jh3KzqUqP15KULIBSk=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=nqwYFVSO1MOtS0pzp91iWfKvaWZ88bU4M9ZIa0s0XzenM+JpRF0sQ1xjnnaAkiergOHJ4CqEz6cGirproRbm1AdnHT31HdrNQfXf4wZeQn4G5xb6i4dZ71NJq3XvmwkQsfcDM55SSt+9YUPE7YMxVmFplMtufkCENjpnlDt9b6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf14.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay06.hostedemail.com (Postfix) with ESMTP id 7F7BB10E109;
	Wed, 23 Jul 2025 16:42:05 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf14.hostedemail.com (Postfix) with ESMTPA id C63EC32;
	Wed, 23 Jul 2025 16:42:03 +0000 (UTC)
Date: Wed, 23 Jul 2025 12:42:02 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: LKML <linux-kernel@vger.kernel.org>, Linux trace kernel
 <linux-trace-kernel@vger.kernel.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Takaya Saeki <takayas@google.com>, Tom
 Zanussi <zanussi@kernel.org>
Subject: [PATCH] tracing: Have eprobes handle arrays
Message-ID: <20250723124202.4f7475be@batman.local.home>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: g8kd9mrjcm6zsd3grc6brgwfqfxobwrt
X-Rspamd-Server: rspamout01
X-Rspamd-Queue-Id: C63EC32
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX19HhRKbnGBvG0HEgbmBP9XIV3xfr1a9QT8=
X-HE-Tag: 1753288923-224884
X-HE-Meta: U2FsdGVkX1+Le3Kvep2ercH1ZO9adFIcpIH3jAlwW3aQsUGGBdyhuZtjlgkK1NGNVLaGj+JgGvy7FnG4ZlGgB9iu+v6I8TByJjO7Ob0ENLEjLZs4Vm6TXfp1F/JpXMMFM0qZ/Hsxm4rfmMLyD+0/0U/gSn/acMQhP+AxdJsu+gnHLQ1f8nuI4FLlvabYSZbVNbrApXm+rWuPg/VLbkUAmABFprP/+wuc4A3z9K4chkSieTr94iJ69jSi2TzFg45eANiE9LROCLZsNYmMgJD1n4Z3eLVIV6mESDqMIBOLrB0w4fDH805E9vHH9MGSTCDDaDh/nQMkhOBThiomGuGH3VoPLbjmohorpo5DSlHU5jDgJeubVIQXqPIumPo4oPNY

From: Steven Rostedt <rostedt@goodmis.org>

eprobes are dynamic events that can read other events using their fields
to create new events. Currently it doesn't work with arrays. When the new
event field is attached to the old event field, it looks at the size of
the field to determine what type of field the new field should be. For 1
byte fields it's a char, for 2 bytes, it's a short and for 4 bytes it's an
integer. For all other sizes it just defaults to "long". This also reads
the contents of the field for such cases.

For arrays that are bigger than the size of long, return the value of the
address of the content itself. This will allow eprobes to read other
values in the array of the old event.

This is useful when raw_syscalls is enabled but the syscall events are
not. The syscall events are created from the raw_syscalls as they have an
array of "args" that holds the 6 long words passed to the syscall entry
point. To read the value of "filename" from sys_openat, the eprobe could
attach to the raw_syscall and read the second value.

It can then even be passed to a synthetic event and converted back to
another eprobe to get the value of "filename" after it has been read by
the kernel during the system call:

 [
   Create an eprobe called "sys" and attach it to sys_enter.
   Read the id of the system call and the second argument
 ]
 # echo 'e:sys raw_syscalls.sys_enter nr=$id:u32 arg2+8($args):u64' >> /sys/kernel/tracing/dynamic_events

 [
   Create a synthetic event "path" that will hold the address of the
   sys_openat filename. This is on a 64bit machine, so make it 64 bits
 ]
 # echo 's:path u64 file;' >> /sys/kernel/tracing/dynamic_events

 [
   Add a histogram to the eprobe/sys which tiggers if the "nr" field is
   257 (sys_openat), and save the filename in the "file" variable.
 ]
 # echo 'hist:keys=common_pid:file=filename if nr == 257' > /sys/kernel/tracing/events/eprobes/sys/trigger

 [
   Attach a histogram to sys_exit event that triggers the "path" synthetic
   event and records the "filename" that was passed from the sys eprobe.
 ]
 # echo 'hist:keys=common_pid:f=$file:onmatch(eprobes.sys).trace(path,$f)' >> /sys/kernel/tracing/events/raw_syscalls/sys_exit/trigger

 [
   Create another eprobe that dereferences the "file" field as a user
   space string and displays it.
 ]
 # echo 'e:open synthetic.path file=+0($file):ustring' >> /sys/kernel/tracing/dynamic_events

 # echo 1 > /sys/kernel/tracing/events/eprobes/open/enable
 # cat trace_pipe
             cat-1142    [003] ...5.   799.521912: open: (synthetic.path) file="/etc/ld.so.cache"
             cat-1142    [003] ...5.   799.521934: open: (synthetic.path) file="/etc/ld.so.cache"
             cat-1142    [003] ...5.   799.522065: open: (synthetic.path) file="/etc/ld.so.cache"
             cat-1142    [003] ...5.   799.522080: open: (synthetic.path) file="/etc/ld.so.cache"
             cat-1142    [003] ...5.   799.522296: open: (synthetic.path) file="/lib/x86_64-linux-gnu/libc.so.6"
             cat-1142    [003] ...5.   799.522319: open: (synthetic.path) file="/lib/x86_64-linux-gnu/libc.so.6"
            less-1143    [005] ...5.   799.522327: open: (synthetic.path) file="/etc/ld.so.cache"
             cat-1142    [003] ...5.   799.522333: open: (synthetic.path) file="/lib/x86_64-linux-gnu/libc.so.6"
             cat-1142    [003] ...5.   799.522348: open: (synthetic.path) file="/lib/x86_64-linux-gnu/libc.so.6"
            less-1143    [005] ...5.   799.522349: open: (synthetic.path) file="/etc/ld.so.cache"
             cat-1142    [003] ...5.   799.522363: open: (synthetic.path) file="/lib/x86_64-linux-gnu/libc.so.6"
            less-1143    [005] ...5.   799.522477: open: (synthetic.path) file="/etc/ld.so.cache"
             cat-1142    [003] ...5.   799.522489: open: (synthetic.path) file="/lib/x86_64-linux-gnu/libc.so.6"
            less-1143    [005] ...5.   799.522492: open: (synthetic.path) file="/etc/ld.so.cache"
            less-1143    [005] ...5.   799.522720: open: (synthetic.path) file="/lib/x86_64-linux-gnu/libtinfo.so.6"
            less-1143    [005] ...5.   799.522744: open: (synthetic.path) file="/lib/x86_64-linux-gnu/libtinfo.so.6"
            less-1143    [005] ...5.   799.522759: open: (synthetic.path) file="/lib/x86_64-linux-gnu/libtinfo.so.6"
             cat-1142    [003] ...5.   799.522850: open: (synthetic.path) file="/lib/x86_64-linux-gnu/libc.so.6"

Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 kernel/trace/trace_eprobe.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/kernel/trace/trace_eprobe.c b/kernel/trace/trace_eprobe.c
index 916555f0de81..7c1a743a5a42 100644
--- a/kernel/trace/trace_eprobe.c
+++ b/kernel/trace/trace_eprobe.c
@@ -343,10 +343,15 @@ get_event_field(struct fetch_insn *code, void *rec)
 			val = *(unsigned int *)addr;
 		break;
 	default:
-		if (field->is_signed)
-			val = *(long *)addr;
-		else
-			val = *(unsigned long *)addr;
+		if (field->size == sizeof(long)) {
+			if (field->is_signed)
+				val = *(long *)addr;
+			else
+				val = *(unsigned long *)addr;
+			break;
+		}
+		/* This is an array, point to the addr itself */
+		val = (unsigned long)addr;
 		break;
 	}
 	return val;
-- 
2.47.2

