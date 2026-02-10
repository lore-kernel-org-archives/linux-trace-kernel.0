Received: from relay.hostedemail.com (smtprelay0014.hostedemail.com [216.40.44.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79F6413D539;
	Tue, 10 Feb 2026 00:46:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770684403; cv=none; b=YIU0HyG+W0Dhhc+dAcm0xvpQvvfe31OmPn4Xifysq4RxlSMRvVTafO1eORXGFGTv3sG/hRejtTzjy2TuX5ENN1sgId8YrhsGevulXmU7vGc6QJALrqsZUiZHDbTWsZwUmF5F45j9YXO771cMV+O9h4tO1t7Qh/smyOCiFNwnArQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770684403; c=relaxed/simple;
	bh=Mz0dEUQI4b08Ow/MrNE1jcijxf/jfqHWTTqooT340Xw=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=pQE9Oeze7Rq0wa94ipuQwC5pCCjwMzd5N/3EDQ5dS15aMK2XyVPVD/7QBcQzObPyrtiPswsad5h7dOXbiDsK+chKL8o0YzBLklui/ncdQBl0ZjLur1jWcWAwvdS4ugxNVUHWdE21qhUU+rAm+SiRZdOYUIAQzsONLfs49MYRwrk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf05.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay05.hostedemail.com (Postfix) with ESMTP id 9BFD658625;
	Tue, 10 Feb 2026 00:46:34 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf05.hostedemail.com (Postfix) with ESMTPA id F1B8020011;
	Tue, 10 Feb 2026 00:46:32 +0000 (UTC)
Date: Mon, 9 Feb 2026 19:46:31 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: LKML <linux-kernel@vger.kernel.org>, Linux trace kernel
 <linux-trace-kernel@vger.kernel.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, kernel test robot <lkp@intel.com>
Subject: [PATCH v2] tracing: Move d_max_latency out of CONFIG_FSNOTIFY
 protection
Message-ID: <20260209194631.788bfc85@fedora>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: rspamout07
X-Rspamd-Queue-Id: F1B8020011
X-Stat-Signature: wt6t5pqddhg5ydeb1fy1swfutfhc4pxw
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1/lEMVFZmq4+mPllyRT+hwa78pKPfpqwjc=
X-HE-Tag: 1770684392-871041
X-HE-Meta: U2FsdGVkX19nJYNvi8aOwsSOQqzXKu1Ku0gO6Z+3qBv58He0TSsVEDNmi9ahK87VcpooPTHWHSw3bq2W/CO7lcBOrWiS1NuOsxaURGHyznmhXtSQwWJgLXILoeKhE3z4EP4oRO+A3kzxkGnJgWtszOSl0BpxO9IqC6AqOAzRQglNGXQtNPzxbYP8juByNLWKBoaicFf7unEKhE/cLcCMAbaf0qDdCf1dgn702afIIY2prhb+Gl4NdfkXU/pqZyYuW99qBBcwUyEBlnsLPG8y6+DIxxbmhg3sshax6sne/I2jLczjT/9F54jtIM06rGTwhmMuW4oRo5ZqShencaVWRSzlOHcykW+g+upliZU/8aAC93cDj+d78EvZjj/1DLDivkPXPyPRNa3yCTZJtBWs28OSLN4RCfFIcd6BZnji9xU=

From: Steven Rostedt <rostedt@goodmis.org>

The tracing_max_latency shouldn't be limited if CONFIG_FSNOTIFY is defined
or not and it was moved out of that protection to be always available with
CONFIG_TRACER_MAX_TRACE. All was moved out except the dentry descriptor
for it (d_max_latency) and it failed to build on some configs.

Move that out of the CONFIG_FSNOTIFY protection too.

Fixes: ba73713da50e ("tracing: Clean up use of trace_create_maxlat_file()")
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202602092133.fTdojd95-lkp@intel.com/
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
Changes since v1: https://lore.kernel.org/linux-trace-kernel/20260209192746.70529899@fedora/

- Rebased on my for-next branch and not the offending commit

 kernel/trace/trace.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/trace/trace.h b/kernel/trace/trace.h
index 649fdd20fc91..7894bf55743c 100644
--- a/kernel/trace/trace.h
+++ b/kernel/trace/trace.h
@@ -348,8 +348,8 @@ struct trace_array {
 	unsigned int		snapshot;
 #ifdef CONFIG_TRACER_MAX_TRACE
 	unsigned long		max_latency;
-#ifdef CONFIG_FSNOTIFY
 	struct dentry		*d_max_latency;
+#ifdef CONFIG_FSNOTIFY
 	struct work_struct	fsnotify_work;
 	struct irq_work		fsnotify_irqwork;
 #endif /* CONFIG_FSNOTIFY */
-- 
2.51.0

