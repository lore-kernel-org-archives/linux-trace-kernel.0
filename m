Received: from relay.hostedemail.com (smtprelay0016.hostedemail.com [216.40.44.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8DD87FBA2;
	Mon,  8 Dec 2025 13:53:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765202030; cv=none; b=Snu/2hK+SMjOGDq04ddqESS/xleIPYvOyHkHtk2yz/V3NQwUO++DDwPi/VezIH3sJi4Y3I+af2VvSmo0j9hMOA2k4iC7RvsCEPlkpbaqEzXZAHghgiDwfT/eD3J1htfBzVYSWmU5Iup+T8K3PGPe5SOuHZSEwRX54GYiS8IYnDE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765202030; c=relaxed/simple;
	bh=kGLgJo0qAQeZ4xq7tJiv28JH6Pn+8T+WMDt2c8twWgE=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=pE0iUw5ESTju6b8DFikp0vHO0+HypxtiQe5WlTNkwTg0QZ1tZGePPLZ/2wq1pfzi6dLOdudwA5hDZqrP6C3V4sX/uzVmxXGPX3iV3Q+i2RRGddJ65ZbGG6YRuRzw3nya2Eq+F8Md4hkoon3dk7URtkAZ8XL0feAxaGG1bGfCZvw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf09.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay01.hostedemail.com (Postfix) with ESMTP id 8EC9E1DF453;
	Mon,  8 Dec 2025 13:53:46 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf09.hostedemail.com (Postfix) with ESMTPA id CE4CC2002B;
	Mon,  8 Dec 2025 13:53:43 +0000 (UTC)
Date: Mon, 8 Dec 2025 08:53:36 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: LKML <linux-kernel@vger.kernel.org>, Linux trace kernel
 <linux-trace-kernel@vger.kernel.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Masahiro Yamada <masahiroy@kernel.org>
Subject: PATCH] tracing: Fix unused tracepoints when module uses only
 exported ones
Message-ID: <20251208085336.6658743c@debian>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: rspamout06
X-Rspamd-Queue-Id: CE4CC2002B
X-Stat-Signature: uybzryx5pywxd4q4niei19xfzu1i64ib
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1/xlnNNl8Ydd9l1xCqLXaFYyvzAPWxUAdI=
X-HE-Tag: 1765202023-811648
X-HE-Meta: U2FsdGVkX1+Eb04YbqnZmTzQ1MPE1cCbWdFHo7N5OmekTOxr0zHvu+kpvrSMVmpsFS6Jj5ddldpjH4JinXcJ/Bzj8JQMTnZlhDwlhbigeeHjFiZGgLfFP3ahNBXMUguH5idUXOleqIWuRdAxAndmtulj7xJm0pMAA7xKnUz4dE7zx/+Q76PxLM67R/DSmQy4/UV54/N8WYXHaBbynU+kZ2H1nV1EHNeXcVpW/KWs7EdclacVWuZI8tXNQLXnpQNjZCiIR+0Zv4HdTQr7toCyA9Wj245drErm+icZYhvReFmAM3NrDTTyQhWPVC2qfVd0FretyBHKIMri72wri5GEwPEJNiFSEL10LPpouYxUogBbVF+NZQXvSxiVNM3ALIeU

From: Steven Rostedt <rostedt@goodmis.org>

Building the KVM intel module failed to build with UT=1:

no __tracepoint_strings in file: arch/x86/kvm/kvm-intel.o
make[3]: *** [/work/git/test-linux.git/scripts/Makefile.modfinal:62: arch/x86/kvm/kvm-intel.ko] Error 1

The reason is that the module only uses the tracepoints defined and
exported by the main kvm module. The tracepoint-udpate.c code fails the
build if a tracepoint is used, but there's no tracepoints defined. But
this is acceptable in modules if the tracepoints is defined in the vmlinux
proper or another module and exported.

Do not fail to build if a tracepoint is used but no tracepoints are
defined if the code is a module. This should still never happen for the
vmlinux itself.

Fixes: e30f8e61e2518 ("tracing: Add a tracepoint verification check at build time")
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 scripts/tracepoint-update.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/scripts/tracepoint-update.c b/scripts/tracepoint-update.c
index 7f7d90df14ce..90046aedc97b 100644
--- a/scripts/tracepoint-update.c
+++ b/scripts/tracepoint-update.c
@@ -210,6 +210,9 @@ static int process_tracepoints(bool mod, void *addr, const char *fname)
 	}
 
 	if (!tracepoint_data_sec) {
+		/* A module may reference only exported tracepoints */
+		if (mod)
+			return 0;
 		fprintf(stderr,	"no __tracepoint_strings in file: %s\n", fname);
 		return -1;
 	}
-- 
2.51.0

