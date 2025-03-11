Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E7812627E3;
	Tue, 11 Mar 2025 17:05:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741712733; cv=none; b=MULULZAvMkc2cGXiaiI9GA5EDZDsnQmopXApVy592CWTVAtrleteW67XIX4DKQ4GCndgKGV1LUCMZXKr3sxVsQ9/ncdbPXMIYeRIIiR7yUqt1x2Ju2T0+kpblFeXhiWFPzTscpyyMF4AyTfPSnqIINpOSCyUYZgNQ7id7o/Hkto=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741712733; c=relaxed/simple;
	bh=oEyGbTvoth7vmSAJ/obSmdU7SImAIuoZDjOIF1BYGRU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=TG8nWdVvncf/fOu4ErYr7Ej8QdNmrCtdZT/aQvVR/Z0y3pyi7+R1UFuOe0Ykqzjx609VLdyHCw093E+CXEypnQbEUwSbyHEsKNoDagE7tyMX+Yx6DXdpY0n0eSiCG9/ILILYvMZlUy1g+CSex4hWIec1Mh5Z9hWAR/G+tbvQFXg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=uv0n2rBy; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=UQOdJ6R/; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="uv0n2rBy";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="UQOdJ6R/"
From: Nam Cao <namcao@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1741712728;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=eoysUVIr9RMMwEjwkmOmSOvor7eg1lyUe7b2Nqa/AGs=;
	b=uv0n2rByLT5aWv3dJyb0ezpQlULmLNc0Rp0fKELnk6It6ehZQw6SL7lzLJj5QfiaNi3K1n
	7VuRkLN7YCgYD0PU9tyglaCcawASMuose5cIqO/BsPTxB5GVACKF3nU7prnyMeMkv5fkV5
	7MNjoX/w4A6dBxMEX2NHcx45iki52uPGUdD7WQ4codEb94xfIsRXxi+142uy0vrpYMv37K
	FOxjxaN8O3Q5HY9EqgQxRp3govmBQF4RnKd5LeDINQzmI7UMZjA2lAyNR9s9kJQMHweeIa
	m6f12VXbZtDxz4eZdkL+Bo6RT2CAYvMmLw8NSk4IeW8JB9YM/o2KZ1yURHED6w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1741712728;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=eoysUVIr9RMMwEjwkmOmSOvor7eg1lyUe7b2Nqa/AGs=;
	b=UQOdJ6R/9AnBSGMURthtnuy8F0mrAsPLa3iCH3HkAGpDKs4AQmh1uqceaYkqJE7wJRWzjL
	Ao7t1/djwcy51dBQ==
To: Steven Rostedt <rostedt@goodmis.org>,
	Gabriele Monaco <gmonaco@redhat.com>,
	john.ogness@linutronix.de,
	linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Nam Cao <namcao@linutronix.de>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	Andy Lutomirski <luto@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>
Subject: [PATCH 06/10] x86/tracing: Move page fault trace points to generic
Date: Tue, 11 Mar 2025 18:05:07 +0100
Message-Id: <7d32e5069e57ec61b0da2f8b31be28a7819457bb.1741708239.git.namcao@linutronix.de>
In-Reply-To: <cover.1741708239.git.namcao@linutronix.de>
References: <cover.1741708239.git.namcao@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Page fault trace points are interesting for other architectures as well.
Move them to be generic.

Signed-off-by: Nam Cao <namcao@linutronix.de>
---
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: x86@kernel.org
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
---
 arch/x86/mm/fault.c                                 |  2 +-
 .../asm/trace =3D> include/trace/events}/exceptions.h | 13 ++++---------
 2 files changed, 5 insertions(+), 10 deletions(-)
 rename {arch/x86/include/asm/trace =3D> include/trace/events}/exceptions.h=
 (79%)

diff --git a/arch/x86/mm/fault.c b/arch/x86/mm/fault.c
index 7e3e51fa1f95..ad4cb1502316 100644
--- a/arch/x86/mm/fault.c
+++ b/arch/x86/mm/fault.c
@@ -38,7 +38,7 @@
 #include <asm/sev.h>			/* snp_dump_hva_rmpentry()	*/
=20
 #define CREATE_TRACE_POINTS
-#include <asm/trace/exceptions.h>
+#include <trace/events/exceptions.h>
=20
 /*
  * Returns 0 if mmiotrace is disabled, or if the fault is not
diff --git a/arch/x86/include/asm/trace/exceptions.h b/include/trace/events=
/exceptions.h
similarity index 79%
rename from arch/x86/include/asm/trace/exceptions.h
rename to include/trace/events/exceptions.h
index 34bc8214a2d7..a631f8de8917 100644
--- a/arch/x86/include/asm/trace/exceptions.h
+++ b/include/trace/events/exceptions.h
@@ -7,7 +7,7 @@
=20
 #include <linux/tracepoint.h>
=20
-DECLARE_EVENT_CLASS(x86_exceptions,
+DECLARE_EVENT_CLASS(exceptions,
=20
 	TP_PROTO(unsigned long address, struct pt_regs *regs,
 		 unsigned long error_code),
@@ -22,7 +22,7 @@ DECLARE_EVENT_CLASS(x86_exceptions,
=20
 	TP_fast_assign(
 		__entry->address =3D address;
-		__entry->ip =3D regs->ip;
+		__entry->ip =3D instruction_pointer(regs);
 		__entry->error_code =3D error_code;
 	),
=20
@@ -30,18 +30,13 @@ DECLARE_EVENT_CLASS(x86_exceptions,
 		  (void *)__entry->address, (void *)__entry->ip,
 		  __entry->error_code) );
=20
-DEFINE_EVENT(x86_exceptions, page_fault_user,
+DEFINE_EVENT(exceptions, page_fault_user,
 	TP_PROTO(unsigned long address,	struct pt_regs *regs, unsigned long error=
_code),
 	TP_ARGS(address, regs, error_code));
-
-DEFINE_EVENT(x86_exceptions, page_fault_kernel,
+DEFINE_EVENT(exceptions, page_fault_kernel,
 	TP_PROTO(unsigned long address,	struct pt_regs *regs, unsigned long error=
_code),
 	TP_ARGS(address, regs, error_code));
=20
-#undef TRACE_INCLUDE_PATH
-#undef TRACE_INCLUDE_FILE
-#define TRACE_INCLUDE_PATH .
-#define TRACE_INCLUDE_FILE exceptions
 #endif /*  _TRACE_PAGE_FAULT_H */
=20
 /* This part must be outside protection */
--=20
2.39.5

