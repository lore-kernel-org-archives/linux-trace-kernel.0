Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77256281376;
	Tue,  4 Mar 2025 15:36:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741102591; cv=none; b=Ss+mRj77joXZv/I+dPzLwe4YXiYLh91R+3R5eDVz6Gsb7FgimlG1A+Ivc+/Bp++CU7OHV5zn/kZYnzGgypjujNmo528imETeOn1Pip/ZF+uwDpEVDt8jQF1o7kp77TSgJ8LP8yhxap18Dolmr/Wp0QFPax+DqaoJvHlXHagwogc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741102591; c=relaxed/simple;
	bh=tSynnfCl+qgL/CFGDBo3wiUx8w791HmiuNgz26+G8M8=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=hyyirDZauHIKHJJ3O3O9/yoY5KwcAU6XbsOk7Hz9+Q9j2rVdlchCY5URvtJkNYMUFgGSfW/NoSmkfUZ+FnR1jOmoYwl++JX0nQVxhkoV/JV74ZWzqoTAUYNHvHAFF4LYNq4UfjU/bZP4RuFsutBOAss0DuuyLHmARK/cdzX0Hv8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 557E2C4CEE5;
	Tue,  4 Mar 2025 15:36:30 +0000 (UTC)
Date: Tue, 4 Mar 2025 10:37:24 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: LKML <linux-kernel@vger.kernel.org>, Linux Trace Kernel
 <linux-trace-kernel@vger.kernel.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Masami Hiramatsu
 <mhiramat@kernel.org>
Subject: [PATCH] tracing: Update MAINTAINERS file to include tracepoint.c
Message-ID: <20250304103724.174ecb36@gandalf.local.home>
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

Updates to the tracepoint.c file should not only be Cc'd to LKML, but also
to linux-trace-kernel@vger.kernel.org. But because it is not listed in the
MAINTAINERS file, it does not get added.

Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 4ff26fa94895..c203aa4225b0 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -24063,6 +24063,7 @@ F:	fs/tracefs/
 F:	include/linux/trace*.h
 F:	include/trace/
 F:	kernel/trace/
+F:	kernel/tracepoint.c
 F:	scripts/tracing/
 F:	tools/testing/selftests/ftrace/
 
-- 
2.47.2

