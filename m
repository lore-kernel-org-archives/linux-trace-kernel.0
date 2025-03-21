Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6B08226CF8;
	Fri, 21 Mar 2025 14:48:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742568515; cv=none; b=N7A9uZ/2w81SFI5Kz/fFa8rpEtHD1na4cvIwICF11dDSNA6PnYLkS943YSs6Hj4qYye/raAn2qfX5/bYFd5Ayyuoyim8B3j2l6h8aPopsg2BbXkzbTvZb5bMPkB6RfSizPx8LY5NEKqPjaoTsQEmZDlXG456OxNeChfKiG7KZK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742568515; c=relaxed/simple;
	bh=ZXYi5+hCwMt9VL0lN6Wi5OSskYXnANBgk5fZgVkMnCU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PlqFFYKUbMuZUZenyrRt+4L41RgHgl+m+CTigquQcm778z+gff3zmD2z61gUILuuXuErgRl3J1gj4P7+O5cRZ8Jsp92BDVIBXlEm9n2Hw2tUoI3ZI8D/iCeMi80DOIVoMjF6x2onp21O3SWZfSvS1C0WCuYNE5c0xduOo+/5vxU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CLv7PsKg; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CLv7PsKg"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1742568514; x=1774104514;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ZXYi5+hCwMt9VL0lN6Wi5OSskYXnANBgk5fZgVkMnCU=;
  b=CLv7PsKgItmLe/tZJOXxnx4C11DnBJ/a6M6UjWYILqXD1tYy4KMo7qdR
   Rlo2wOWdnHXEVr4adlaFoviPZvXfnFvObSjppLItR2DuWEPqC1x/tPwFl
   hXVg23qFpXl/wEmnkRtgK/kGkx+90l1X4AsL9ti/XQLjWXwHJTR+eyS1A
   CncOkYtEpCALPAwTd048/i2K/vMGiOsV375daIZIiXpzsq4M+BWNfkwTs
   b1OZA3oofnDu912NtSAge0F6mzODI5kc/SPXD3JX9olYEekFyXeKti81A
   t4ZZsz3T75IJG8vLtIk5DzCUIaa3cdsFwmOvH6WySuE7oV/foIvA5TH4t
   Q==;
X-CSE-ConnectionGUID: 9Y2NKSTpQu+uUeScA9zNmQ==
X-CSE-MsgGUID: uo8goeKIQoC6UZZ/MUkKWQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11380"; a="43962530"
X-IronPort-AV: E=Sophos;i="6.14,264,1736841600"; 
   d="scan'208";a="43962530"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Mar 2025 07:48:33 -0700
X-CSE-ConnectionGUID: CkKTOcn0RAmW5fcNUnj1SA==
X-CSE-MsgGUID: nkf0lf1oTwCLgPMuuEmavg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,264,1736841600"; 
   d="scan'208";a="123880127"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmviesa010.fm.intel.com with ESMTP; 21 Mar 2025 07:48:29 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id 822BC85F; Fri, 21 Mar 2025 16:48:24 +0200 (EET)
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
Subject: [PATCH v2 6/6] vsnprintf: Silence false positive GCC warning for va_format()
Date: Fri, 21 Mar 2025 16:40:52 +0200
Message-ID: <20250321144822.324050-7-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250321144822.324050-1-andriy.shevchenko@linux.intel.com>
References: <20250321144822.324050-1-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

va_format() is using vsnprintf(), and GCC compiler (Debian 14.2.0-17)
is not happy about this:

lib/vsprintf.c:1704:9: error: function ‘va_format’ might be a candidate for ‘gnu_print ’ format attribute [-Werror=suggest-attribute=format]

Fix the compilation errors (`make W=1` when CONFIG_WERROR=y, which is default)
by silencing the false positive GCC warning.

Suggested-by: Rasmus Villemoes <ravi@prevas.dk>
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 lib/vsprintf.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/lib/vsprintf.c b/lib/vsprintf.c
index 899e14e4c469..a55e88895a64 100644
--- a/lib/vsprintf.c
+++ b/lib/vsprintf.c
@@ -1692,6 +1692,10 @@ char *escaped_string(char *buf, char *end, u8 *addr, struct printf_spec spec,
 	return buf;
 }
 
+#pragma GCC diagnostic push
+#ifndef __clang__
+#pragma GCC diagnostic ignored "-Wsuggest-attribute=format"
+#endif
 static char *va_format(char *buf, char *end, struct va_format *va_fmt,
 		       struct printf_spec spec)
 {
@@ -1706,6 +1710,7 @@ static char *va_format(char *buf, char *end, struct va_format *va_fmt,
 
 	return buf;
 }
+#pragma GCC diagnostic pop
 
 static noinline_for_stack
 char *uuid_string(char *buf, char *end, const u8 *addr,
-- 
2.47.2

