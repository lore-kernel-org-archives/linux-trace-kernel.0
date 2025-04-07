Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E73C2205ABB;
	Mon,  7 Apr 2025 15:59:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744041598; cv=none; b=HeNncFjASa+lCWrVf6LehPIg9FYVo5n34zPh0q4idWH2la+c5n3jfrEqdgdaOEOM065vq3NzRn+a2bd5stFOvwxEM+7oVPLfFX1fuoKYgBGeYTveRGPkVohxX3crF77zDSIn9sN0SAv9ve62U2yVRc2kn5aJ/A8GrS6QdKruq/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744041598; c=relaxed/simple;
	bh=9Bt31F+EEO1/gN5Bg5qO5PcuHnvn3ZA2QYRJT+0Yah0=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=OIp8fP4wW7baNAPf7bcWAGRgGZHzE9I1pWJfcXSQyypQ65QutXADEKIbr71McTbA7HwvHnN9LOLO2sxKJO4eMQXZx5wCeTp1E5Diero/LYElm+FOaN1k7DyBGpgoJtiSZ4d6S+AkhYq0hvrQiyHovJxhQN3OYtDP0w33AmBrvhI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2FA8C4CEE7;
	Mon,  7 Apr 2025 15:59:56 +0000 (UTC)
Date: Mon, 7 Apr 2025 12:01:11 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: LKML <linux-kernel@vger.kernel.org>, Linux Trace Kernel
 <linux-trace-kernel@vger.kernel.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH] tracing: Hide get_vm_area() from MMUless builds
Message-ID: <20250407120111.2ccc9319@gandalf.local.home>
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

The function get_vm_area() is not defined for non-MMU builds and causes a
build error if it is used. Hide the map_pages() function around a:

 #ifdef CONFIG_MMU

to keep it from being compiled when CONFIG_MMU is not set.

Reported-by: Guenter Roeck <linux@roeck-us.net>
Tested-by: Guenter Roeck <linux@roeck-us.net>
Closes: https://lore.kernel.org/all/4f8ece8b-8862-4f7c-8ede-febd28f8a9fe@roeck-us.net/
Fixes: 394f3f02de531 ("tracing: Use vmap_page_range() to map memmap ring buffer")
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 kernel/trace/trace.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index b581e388a9d9..8ddf6b17215c 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -9806,6 +9806,7 @@ static int instance_mkdir(const char *name)
 	return ret;
 }
 
+#ifdef CONFIG_MMU
 static u64 map_pages(unsigned long start, unsigned long size)
 {
 	unsigned long vmap_start, vmap_end;
@@ -9828,6 +9829,12 @@ static u64 map_pages(unsigned long start, unsigned long size)
 
 	return (u64)vmap_start;
 }
+#else
+static inline u64 map_pages(unsigned long start, unsigned long size)
+{
+	return 0;
+}
+#endif
 
 /**
  * trace_array_get_by_name - Create/Lookup a trace array, given its name.
-- 
2.47.2

