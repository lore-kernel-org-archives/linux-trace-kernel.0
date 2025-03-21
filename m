Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CB47225387;
	Fri, 21 Mar 2025 14:48:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742568515; cv=none; b=giwKghD1yS9MNEF3NqMBz2M7QZ0Gfx0u4/AAtp/T6l2orVaPpf4CL9u9oIfQClLutl9Qr4KWanUZ46GGRdXFn9LLBXP0Ec71bEO3VVSPHc1N72XyNRH0Bhdg47zyE+8QOXMwZdwQuelkuzPNLu4ZJZKeY1iFZqz8cTgf52wVpkI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742568515; c=relaxed/simple;
	bh=Na8tB43VtqlJupW8wV1IfANzSElg1383772Apvo0nrY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JX3vleWAzEKtU3pyfyzNmXm5yeQJu/Xr2f4nDFpTWiYDCIwzNtCRISnmd1A0DgR9IzYBrFaFKl/QSK2BFqFE8rjnYT/0/RZimeDUgjoE6HYaBX5YuuB5ncczf1Aeb7/ACnpuqsV1loe7kAc7+h9+HP53xsFwsgV73W1G0g3E7NA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UfsRMnTT; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UfsRMnTT"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1742568513; x=1774104513;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Na8tB43VtqlJupW8wV1IfANzSElg1383772Apvo0nrY=;
  b=UfsRMnTTyl+39B47I1FQD0q/ot929A3/CjQsGla6dHmG837d8vlxzxij
   uDdAGnGLP2PRggOsR7Bdj+PFVMwdCS3C67CMJGleapX9s11bMH+3f9qRT
   rCLgfprWbfj3gA1N1hAdDbLDSeChNhs5d/iGXnZEDvqGOyWRorkJc7obY
   riQGSLoMUQBM6F64xjaHtFtgA2rHTgYh+u2noCPoKYFVZQPtMXJcKHNvK
   UVcc4yMWz9FJb+LYbWX1hVFPovd56YXyWQ1Cs+yLy/YVQhNVrI5GKPy2M
   m8goa1QMpJ9A9H5iTKHC4bQb+jK0gvW8+pDlzmTBHN6aSBlOGReGpqjkJ
   g==;
X-CSE-ConnectionGUID: K2tCvh/qRsenadyo8Qzcng==
X-CSE-MsgGUID: CRg5h7x8RCqtjODLOCayUw==
X-IronPort-AV: E=McAfee;i="6700,10204,11380"; a="54051601"
X-IronPort-AV: E=Sophos;i="6.14,264,1736841600"; 
   d="scan'208";a="54051601"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Mar 2025 07:48:33 -0700
X-CSE-ConnectionGUID: 6HSOltahRJiClIsozq5QGA==
X-CSE-MsgGUID: PDQtDl5dQaCTPovu4pm4pA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,264,1736841600"; 
   d="scan'208";a="123594439"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmviesa008.fm.intel.com with ESMTP; 21 Mar 2025 07:48:29 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id 70C16720; Fri, 21 Mar 2025 16:48:24 +0200 (EET)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	Kees Cook <kees@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	"Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
	linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Cc: Andy Shevchenko <andy@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Petr Mladek <pmladek@suse.com>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Rasmus Villemoes <ravi@prevas.dk>
Subject: [PATCH v2 5/6] vsnprintf: Drop unused const char fmt * in va_format()
Date: Fri, 21 Mar 2025 16:40:51 +0200
Message-ID: <20250321144822.324050-6-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250321144822.324050-1-andriy.shevchenko@linux.intel.com>
References: <20250321144822.324050-1-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

va_format() doesn't use original formatting string, drop that
argument as it's done elsewhere in similar cases.

Suggested-by: Rasmus Villemoes <ravi@prevas.dk>
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 lib/vsprintf.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/lib/vsprintf.c b/lib/vsprintf.c
index 56fe96319292..899e14e4c469 100644
--- a/lib/vsprintf.c
+++ b/lib/vsprintf.c
@@ -1693,7 +1693,7 @@ char *escaped_string(char *buf, char *end, u8 *addr, struct printf_spec spec,
 }
 
 static char *va_format(char *buf, char *end, struct va_format *va_fmt,
-		       struct printf_spec spec, const char *fmt)
+		       struct printf_spec spec)
 {
 	va_list va;
 
@@ -2462,7 +2462,7 @@ char *pointer(const char *fmt, char *buf, char *end, void *ptr,
 	case 'U':
 		return uuid_string(buf, end, ptr, spec, fmt);
 	case 'V':
-		return va_format(buf, end, ptr, spec, fmt);
+		return va_format(buf, end, ptr, spec);
 	case 'K':
 		return restricted_pointer(buf, end, ptr, spec);
 	case 'N':
-- 
2.47.2

