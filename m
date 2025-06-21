Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC2781FDD;
	Sat, 21 Jun 2025 00:30:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750465832; cv=none; b=ARhycnsARpOrZOMR7IRxPx1nEUfHZqpQ08N5ZfI+D4fVCgydLIJIdt+OctDEqot1UuBHWeE0QxMnhDGXa2EoZUJXpSFKWbRvWYGXaIcjAxHYrVuZqQ0/7xW++UOAlKVqSi9rceuSfs1VQM32prshQF7ywUUj06AFIwDWFnWScOg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750465832; c=relaxed/simple;
	bh=KUQEeZCG65Qq2/UpFK4Y9O0RCGYWzgrUXwaF9kyKz9Q=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=JUYTiY0KWOwr0rcEbuHPN64J2599DlUc+6R3wA2LnTGWa/N3pdzJ0DvHFOX4TDZ2WIibsP3Jf3Gyr+aenXkIU+kTcHug85wxjBP4acTEO3LEu5WACfWABI18HMK7Gr0lNrf/Tth0uFO73jcDyDefSKfAD0LyfnSXRq/989/dWzw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RK34Sx0t; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RK34Sx0t"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1750465831; x=1782001831;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:to:cc;
  bh=KUQEeZCG65Qq2/UpFK4Y9O0RCGYWzgrUXwaF9kyKz9Q=;
  b=RK34Sx0tkexOBRcP5Fjt2VfwghsFl6VBUVJStSrwgHOGBiHrkS+afR1J
   e2sqbrCj1JKXyghQ5Gb8/YYkUZqy2vzbSBlxQutOmwp/1KYEs664pY+4p
   YmWyY7YOqlKuHhQqaV9caSUgLAcJD+Zebvw6TOdd925Bsh6e9UPQkbnAZ
   euBLYLqKlYHe8uFY9r2Xty0Rf2hV6ubRh2auEj1mZkcwkSS6KgcsTH0V/
   tstsAhKfbp7GpLuDl5uhXGyhLIXT8MFt/eB8Ih3ITpAnTdoeXjdMAh5uC
   UlU8u89O1vqrGBktrKtOJdDGr2uR4Y6UYR6G8dXOAY6Tx+PYzgLa6cdle
   A==;
X-CSE-ConnectionGUID: XU4EHJSXTkKVbSTBnLhXkA==
X-CSE-MsgGUID: irhtmPL/TjmczuLJH6d06w==
X-IronPort-AV: E=McAfee;i="6800,10657,11469"; a="40346143"
X-IronPort-AV: E=Sophos;i="6.16,252,1744095600"; 
   d="scan'208";a="40346143"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jun 2025 17:30:30 -0700
X-CSE-ConnectionGUID: dHoEWLa5Rtuj7WZzVDevBw==
X-CSE-MsgGUID: LZbx1wcZSwu5Z8DhxUkzIA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,252,1744095600"; 
   d="scan'208";a="181925536"
Received: from unknown (HELO [172.25.112.21]) ([172.25.112.21])
  by fmviesa001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jun 2025 17:30:30 -0700
From: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
Date: Fri, 20 Jun 2025 17:30:20 -0700
Subject: [PATCH] tracing/sched: Remove obsolete comment on suffixes
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250620-rneri-tp-comment-fix-v1-1-e0f6495ac33c@linux.intel.com>
X-B4-Tracking: v=1; b=H4sIABv9VWgC/x2MQQqAIBAAvyJ7bsEsw/pKdIjcag9aqEQQ/b2l4
 wzMPJApMWUY1AOJLs58RIG6UrDsc9wI2QuD0cbqzmhMUQIsJy5HCBQLrnyj9a1rvO5nZz1IeiY
 S/W/H6X0/Pw92fWYAAAA=
To: Steven Rostedt <rostedt@goodmis.org>, 
 Masami Hiramatsu <mhiramat@kernel.org>, 
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Ricardo Neri <ricardo.neri@intel.com>, linux-kernel@vger.kernel.org, 
 linux-trace-kernel@vger.kernel.org, 
 Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1750465845; l=1053;
 i=ricardo.neri-calderon@linux.intel.com; s=20250602;
 h=from:subject:message-id; bh=KUQEeZCG65Qq2/UpFK4Y9O0RCGYWzgrUXwaF9kyKz9Q=;
 b=Qw6yreS/bvnFqbNnzhjM6pWi/cf30XF3iFTipMyXyqej9kshrefA4ojLNGaOps3ffNB+grsOj
 awwrpDMsiVKAHlma+ao5dXDV9lbXon22Mo1vWoRZDy71f3a3hqQAUF6
X-Developer-Key: i=ricardo.neri-calderon@linux.intel.com; a=ed25519;
 pk=NfZw5SyQ2lxVfmNMaMR6KUj3+0OhcwDPyRzFDH9gY2w=

Commit ac01fa73f530 ("tracepoint: Have tracepoints created with DECLARE_
TRACE() have _tp suffix") makes it unnecessary to manually add a suffix.

Remove a now obsolete comment.

Signed-off-by: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
---
 include/trace/events/sched.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/include/trace/events/sched.h b/include/trace/events/sched.h
index 4e6b2910cec3..f24c373bcc44 100644
--- a/include/trace/events/sched.h
+++ b/include/trace/events/sched.h
@@ -829,8 +829,6 @@ TRACE_EVENT(sched_wake_idle_without_ipi,
 /*
  * Following tracepoints are not exported in tracefs and provide hooking
  * mechanisms only for testing and debugging purposes.
- *
- * Postfixed with _tp to make them easily identifiable in the code.
  */
 DECLARE_TRACE(pelt_cfs,
 	TP_PROTO(struct cfs_rq *cfs_rq),

---
base-commit: e04c78d86a9699d136910cfc0bdcf01087e3267e
change-id: 20250620-rneri-tp-comment-fix-5d483d09a85d

Best regards,
-- 
Ricardo Neri <ricardo.neri-calderon@linux.intel.com>

