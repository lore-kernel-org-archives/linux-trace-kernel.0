Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FD25296BBC;
	Tue, 14 Oct 2025 05:52:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760421131; cv=none; b=AHoMVRmIz+VbMOZw2hToye1+tARvc613SwmPhY7Nh3enXn/DAfy6bdt+i5DRg2X73POO+z08CzaTQK44gHlXv7OfgLxJf54hT0cRecAEO795Z3ZA7sis/K23eDNL9gpPw+Q/UnMiCHl0/S9czK/o7HZyXOMNqsbjPUQGKqXpCMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760421131; c=relaxed/simple;
	bh=yE4otWvZU4Jrskckd+v6o+z+ojQlfXZUrj863Kn0nY0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=WqUirfp9A5yskBaGOnPl3tRG1WUPhIV7EaPucipzLGIib61ltzeoELMHtPfj940MnV/YYKn12d9jasBD1MOhZVQyruHEpv1pHq8/OYEz+ehUiQScPNnZ7drTe9XX9ysSwk0k+5qJY+ITGUJBkmrvitp5ZGPtlVWvs+oHXAb3S68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=yhTWxYN1; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=hPIkfGj6; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="yhTWxYN1";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="hPIkfGj6"
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1760421127;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rLm7wrnotyCpSh6f7aVAhYMGC1hTWgfZzHXUgAF4Hfk=;
	b=yhTWxYN1BBcLXd6vnmeiAk+p6Wlu/yi/sJCo2jZrlv/ZnY9bMAVshG2t1orBMbcgymsuAs
	aXrwOXriyMibWsmyu+FzxxRhXtX5JII6tNPUD8eA2rHDRd7hL22Sw1zvBTuNeUqtENMJXa
	29HhVm8GSt3oLEs0VgcEfcLfqORXaZOsE0R0A4RDrY5avZD4Qy3HA9C+bvx1hS+Va9qjKm
	65szbq4QIObqSRUpdp3SQuvQOip7jYa6F52HCuFGxRHnDJZ9QD/OcEkdtyMF9GSAWGciIW
	6whi64c7RWfuf9oEQxDEYywUGQXNr0VMiDAYfl1O7uYyA9HJM+s6/oFfjRHCzw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1760421127;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rLm7wrnotyCpSh6f7aVAhYMGC1hTWgfZzHXUgAF4Hfk=;
	b=hPIkfGj67KkIWC06CchyQs7B4SfBTIVSKRlDicJKqMIVsCm8iMRfS5ZQERw/ZgTH7zkZF7
	Qmwk322uoWG47VDQ==
Date: Tue, 14 Oct 2025 07:51:58 +0200
Subject: [PATCH 3/3] rv: Add explicit lockdep context for reactors
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20251014-rv-lockdep-v1-3-0b9e51919ea8@linutronix.de>
References: <20251014-rv-lockdep-v1-0-0b9e51919ea8@linutronix.de>
In-Reply-To: <20251014-rv-lockdep-v1-0-0b9e51919ea8@linutronix.de>
To: Steven Rostedt <rostedt@goodmis.org>, 
 Gabriele Monaco <gmonaco@redhat.com>, 
 Masami Hiramatsu <mhiramat@kernel.org>, 
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
 Nam Cao <namcao@linutronix.de>
Cc: linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1760421123; l=1585;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=yE4otWvZU4Jrskckd+v6o+z+ojQlfXZUrj863Kn0nY0=;
 b=FIOTXXkkhrTy8L9KJ7JXt3Od3s9we1ct+A+gzwvfdmDJf+8Qx32JO97IJerHT9urDxUT30MWb
 vSrEEy5fyDCCN1y6RnMrKHWeeIv/c1NivWB6/qOgQgQBq7UT2CC3jOe
X-Developer-Key: i=thomas.weissschuh@linutronix.de; a=ed25519;
 pk=pfvxvpFUDJV2h2nY0FidLUml22uGLSjByFbM6aqQQws=

Reactors can be called from any context through tracepoints.
When developing reactors care needs to be taken to only call APIs which
are safe. As the tracepoints used during testing may not actually be
called from restrictive contexts lockdep may not be helpful.

Add explicit overrides to help lockdep find invalid code patterns.

The usage of LD_WAIT_FREE will trigger lockdep warnings in the panic
reactor. These are indeed valid warnings but they are out of scope for
RV and will instead be fixed by the printk subsystem.

Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
---
 kernel/trace/rv/rv_reactors.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/kernel/trace/rv/rv_reactors.c b/kernel/trace/rv/rv_reactors.c
index 8c02426bc3bd944265f809e431283d1a20d56a8c..d9d335ae9badaa320f1d35dd159a033c3a30eb1a 100644
--- a/kernel/trace/rv/rv_reactors.c
+++ b/kernel/trace/rv/rv_reactors.c
@@ -61,6 +61,7 @@
  *      printk
  */
 
+#include <linux/lockdep.h>
 #include <linux/slab.h>
 
 #include "rv.h"
@@ -480,6 +481,7 @@ int init_rv_reactors(struct dentry *root_dir)
 
 void rv_react(struct rv_monitor *monitor, const char *msg, ...)
 {
+	static DEFINE_WAIT_OVERRIDE_MAP(rv_react_map, LD_WAIT_FREE);
 	va_list args;
 
 	if (!rv_reacting_on() || !monitor->react)
@@ -487,7 +489,9 @@ void rv_react(struct rv_monitor *monitor, const char *msg, ...)
 
 	va_start(args, msg);
 
+	lock_map_acquire_try(&rv_react_map);
 	monitor->react(msg, args);
+	lock_map_release(&rv_react_map);
 
 	va_end(args);
 }

-- 
2.51.0

