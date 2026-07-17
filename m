Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F3A32D2483;
	Fri, 17 Jul 2026 02:51:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784256705; cv=none; b=nSIKQGtIg31Nw9K/d2Z+aoMo9DzW+egUDk7auDEOTLjdSaDPaAr/lcu7qP8I2b3LUs50xq01yWjlI7WpzglGnaNt6z/ZEZtkGhNVUpn6hlVQa1BPoSbVpZIcM3gxH832nri2+uxrdoopDL57f3G/IJp6z6JjWtJUpmaFh3UpHZg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784256705; c=relaxed/simple;
	bh=YNwsDn1uRiuhxmuuLSbDVMJO2qH08HfE3uhu76tWD6I=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=SJaTZLcEdXXafxe5m34TzcIFil8KMSfKIAVAU46BJ53ewZgtl10XsXgft7bmMApNAfjxgKsloKRCXDRvLuuTL4OpJ+MhjNn9qZ7WjLiAV0m+5nc7rafME1M9i/yACU4z944ylHQ+Sn4+QaLupsSp6qzx3JtyFCqXLyDuG17z5Yg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AnAh4UrL; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AnAh4UrL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 503CB1F000E9;
	Fri, 17 Jul 2026 02:51:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784256704;
	bh=2DGUeMeyGWXKMoOY96FjACWcFXf/rSVJGXKFYETrvbU=;
	h=From:To:Cc:Subject:Date;
	b=AnAh4UrL0pV5+3l6gsiovAUMucvHn0SiuIoWnlx3yMsbEhiC/bVHlY7Rl8r6QoFtB
	 HI4St0oqQXq/a+IrECIvCiAUrJVKCYIfcBca3Ck5nZRfb/S7rziZNM8d03uVtXAddQ
	 4Vq1E0uC63u9xH5tU0SWBqP0co7FsWBoiLxB42BErR+2jAH3C0Pfwlb40REUZ/oRPn
	 t2FtvtJwiFGVMP7eTUmC7mdTTbP2HuoPRj7BdBkbDdDJQeb/iVi6lgDBc+o/d/LRAH
	 VjsRM2FVVG6DN7um1dV7i+xUW/EU42mhIAxea5vRA3n5cYY8kQHVhiLGz1uvp9gehY
	 FDEtYqqc4mjgg==
From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Shuah Khan <shuah@kernel.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH 0/2] tracing: Fix a kernel crash related to :mod: command
Date: Fri, 17 Jul 2026 11:51:39 +0900
Message-ID: <178425669965.84440.3214667180548169854.stgit@devnote2>
X-Mailer: git-send-email 2.43.0
User-Agent: StGit/0.19
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

Hi,

I found a kernel crash bug in tracing with :mod: command and dynamic
events. If we leaves a dynamic event and run :mod: command to set_event,
the kernel gets an oops.

Actually, this bug found by testing wprobe trigger test case, because
ftracetest has another bug which does not clean up the top-level event
filters/triggers before starting instance tests. Thus if the last test
case in the top-level instance fails and if it leaves a dynamic event,
that will be kept and not cleaned up. Then, test.d/event/event-mod.tc
hits this bug.

Here is the reproduce script.
-----
#!/bin/sh

TRACE_DIR="/sys/kernel/tracing"
if [ ! -d "$TRACE_DIR" ]; then
    TRACE_DIR="/sys/kernel/debug/tracing"
fi

if [ ! -d "$TRACE_DIR" ]; then
    echo "Error: Tracefs not found. Please mount tracefs."
    exit 1
fi

cd "$TRACE_DIR"

echo "=== 1. Clear existing triggers and dynamic events ==="
echo > events/sched/sched_process_fork/trigger || true
echo > dynamic_events || true

echo "=== 2. Create a kprobe event ==="
# Adding a kprobe on vfs_write
echo 'p:kprobes/my_kprobe vfs_write' >> dynamic_events
cat dynamic_events

echo "=== 3. Attach enable_event trigger targeting my_kprobe to sched_process_fork ==="
if [ -f "events/sched/sched_process_fork/trigger" ]; then
    echo 'enable_event:kprobes:my_kprobe' > events/sched/sched_process_fork/trigger
    cat events/sched/sched_process_fork/trigger
else
    echo "Error: sched_process_fork event trigger is not supported."
    exit 1
fi

echo "=== 4. Try to delete the kprobe event while the trigger is active ==="
echo "Attempting: echo -:kprobes/my_kprobe >> dynamic_events"
if ! echo '-:kprobes/my_kprobe' >> dynamic_events 2>/dev/null; then
    echo "Result: Successfully reproduced kprobe event deletion failure (Device or resource busy)!"
    echo "The 'my_kprobe' event remains in dynamic_events:"
    cat dynamic_events
else
    echo "Warning: Deletion succeeded? Check if the trigger was active."
fi

echo ""
echo "=== WARNING: The next step will crash the kernel if the union collision bug is not fixed! ==="
echo "Press Ctrl+C to stop now, or press Enter to trigger the kernel panic (via set_event ':mod:...' write)."
read tmp

echo "Triggering kernel panic..."
echo ':mod:trace-events-sample' > set_event
-----

Thanks,

---

Masami Hiramatsu (Google) (2):
      tracing: Fix union collision of module and refcnt for dynamic events
      selftests/ftrace: Reset triggers at top level before instance loop


 kernel/trace/trace_events.c               |    4 +++-
 tools/testing/selftests/ftrace/ftracetest |    1 +
 2 files changed, 4 insertions(+), 1 deletion(-)

--
Masami Hiramatsu (Google) <mhiramat@kernel.org>
