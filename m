Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E35D183CCA;
	Fri,  9 May 2025 08:12:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746778363; cv=none; b=igqTrynSE0WnAB0O8dWICL0w/ReI1bV/FUZFSScJloNa0mwx9BePgqjfdR1HYqHvaZ6xF3I9ZGa9paRTFHBOm/VETIcrfAHq194DdyvW3z93vkDDI2V5WXK8s5eoz+WYejqS1N5srgqbbNL/dmfCayNnRmVGylJrFJ9MpqYfcmg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746778363; c=relaxed/simple;
	bh=9REGFnfyFOEyIjAE1cjJKsPFnrPKw4O7e9wg4waN3vU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=kW/sOWaWSyYB1EPbxqstHO9U30LOaozjm3Di7HzmYTJx3D4TOAgYJr9Fe+nvPKrQbQJkihuGjEpKSjxYQ++/767Qao9bLJGsGwnKsqBcE1MKvufQ1B3pRQyZcwvluPu4RL0mh/LkjS3Jzfu3cgPMkiuaXez4AtF5K1UVdsj0wXI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=R3rW/zsp; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=QySoGCdR; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="R3rW/zsp";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="QySoGCdR"
From: Nam Cao <namcao@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1746778360;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9REGFnfyFOEyIjAE1cjJKsPFnrPKw4O7e9wg4waN3vU=;
	b=R3rW/zspQjMpBluc/gsZb37Fb50clTS4rGBHUG1CV02otT7sutwpalZN9XAgcOIhm4ql6m
	M+nhNuVJVkvEXvhE2aEbZ6IRlPDtXhLZznUK0t/ZeL+y/SB4NPSUTL9LI9rY6LToCOr06Z
	+8mcrP0Nr6X4eSgO416wTFsdblVhy/2IsnoXayu3/hcSoI+qJwwlTPhNjvIXY4QiVEVvaj
	7Xk5QROwRaejfaoqnoVZUW4guZ+9cY+n9UexUVSkpgXXXANbYK62IzOjR2YBHsXhUk+wyX
	CG9CE2KVqig4tKST0aOvP/mED85JkfMNtONenf+rqBK3K14W6bo6E+Wf7e1CyA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1746778360;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9REGFnfyFOEyIjAE1cjJKsPFnrPKw4O7e9wg4waN3vU=;
	b=QySoGCdR1EJ9FTnFMPRf64h2C05R+I2dIsUG0w4+QCZJek3eEepGM8T2UdSWTjiDhS++Re
	DX3LFzSLxE+YEvAA==
To: Steven Rostedt <rostedt@goodmis.org>,
	Gabriele Monaco <gmonaco@redhat.com>,
	linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: john.ogness@linutronix.de,
	Nam Cao <namcao@linutronix.de>
Subject: [PATCH v7 01/22] rv: Add #undef TRACE_INCLUDE_FILE
Date: Fri,  9 May 2025 10:12:00 +0200
Message-Id: <805abc4add788ca15bbf98e6cb7c59948290a273.1746776116.git.namcao@linutronix.de>
In-Reply-To: <cover.1746776116.git.namcao@linutronix.de>
References: <cover.1746776116.git.namcao@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Without "#undef TRACE_INCLUDE_FILE", there could be a build error due to
TRACE_INCLUDE_FILE being redefined. Therefore add it.

Also fix a typo while at it.

Reviewed-by: Gabriele Monaco <gmonaco@redhat.com>
Signed-off-by: Nam Cao <namcao@linutronix.de>
---
 kernel/trace/rv/rv_trace.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/kernel/trace/rv/rv_trace.h b/kernel/trace/rv/rv_trace.h
index 422b75f58891..99c3801616d4 100644
--- a/kernel/trace/rv/rv_trace.h
+++ b/kernel/trace/rv/rv_trace.h
@@ -129,8 +129,9 @@ DECLARE_EVENT_CLASS(error_da_monitor_id,
 #endif /* CONFIG_DA_MON_EVENTS_ID */
 #endif /* _TRACE_RV_H */
=20
-/* This part ust be outside protection */
+/* This part must be outside protection */
 #undef TRACE_INCLUDE_PATH
 #define TRACE_INCLUDE_PATH .
+#undef TRACE_INCLUDE_FILE
 #define TRACE_INCLUDE_FILE rv_trace
 #include <trace/define_trace.h>
--=20
2.39.5

