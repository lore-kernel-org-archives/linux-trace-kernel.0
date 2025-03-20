Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A289228CA9;
	Thu, 20 Mar 2025 18:09:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742494179; cv=none; b=K7o1OM0zxXAqACdtXsXkWfYb3heUiqyt70jlwS0OmFAIT0VYh/VnkxmhZqKtCGqQLZDL27JMrd3iGg5c8ohGCTyhFNmIdXTqtN0hidnsI1ZL3Lhm8MGKBbezaS/iI/VYa972QMOhjLPNkq6yW2/Fb3/7fB1/OBnOH8oZAcN1Des=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742494179; c=relaxed/simple;
	bh=B/IrAUEQScS6ZPsOJQ4R3YhljPCbyRabKcJDMFmRDeQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tvd5emxYTxs+7L4YnsmcA0K2vl+oflrujR4YMKDkC+fTHFjBJt6Sl2myj5s/aTi+InaDOsgAqUYvl9XpTzYsERYs/LTtXTMv4bUlEudSOt0oF53+pc2y6lZPye0Sd5aCPd0gp57Si7EdbIUM5RhDHSp8I7UI+OlfodjqJeL8eFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YWzHs6kc; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YWzHs6kc"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1742494178; x=1774030178;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=B/IrAUEQScS6ZPsOJQ4R3YhljPCbyRabKcJDMFmRDeQ=;
  b=YWzHs6kck+k7i1+3vJoIT2SCj2+LsdLEIqPzmpXyKw0D90hySLy4wsrU
   SoKH2l3nkK8yVaPCStYwkqqqJoB66NA1o2GXbJKzq7C3fULWJOTFGALDR
   ghAH99xP1FGWP2Bvk13ZJjB5VlioUth/fZTvL21OOU6sVFttBZsTWI+3l
   XMBQOr/Su2q9VMo+ugKrj18ZliyQOimKfE+qyRYPisoPmHLbiJUG7H7IB
   mW48X3NNcSeKyA2XaNX5p8XczS9XtVcA0jj4MSX2UiAKUrmsyWACzdP50
   7qmMFxrIoWAlZ9mA4ajiDXnNI7p8WI5SYFduJ9Cy7O0ft6bPNmqJ5MJRK
   w==;
X-CSE-ConnectionGUID: 5r3QEwJiQvWgXqKBw0pk2g==
X-CSE-MsgGUID: ugQFD39TQ2iKL9Hw2sLZVw==
X-IronPort-AV: E=McAfee;i="6700,10204,11379"; a="66208853"
X-IronPort-AV: E=Sophos;i="6.14,262,1736841600"; 
   d="scan'208";a="66208853"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2025 11:09:37 -0700
X-CSE-ConnectionGUID: CHnv/ul0T6a72fTp0xFsGw==
X-CSE-MsgGUID: WZmDiWoFQ6SBrvIt0IIw8g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,262,1736841600"; 
   d="scan'208";a="146405852"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmviesa002.fm.intel.com with ESMTP; 20 Mar 2025 11:09:34 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id DC0738B7; Thu, 20 Mar 2025 20:09:27 +0200 (EET)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Petr Mladek <pmladek@suse.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	Kees Cook <kees@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	"Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
	linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Cc: John Ogness <john.ogness@linutronix.de>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Andy Shevchenko <andy@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>
Subject: [PATCH v1 6/6] vsnprintf: Mark va_format() with __printf() attribute
Date: Thu, 20 Mar 2025 20:04:27 +0200
Message-ID: <20250320180926.4002817-7-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250320180926.4002817-1-andriy.shevchenko@linux.intel.com>
References: <20250320180926.4002817-1-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

va_format() is using printf() type of format, and GCC compiler
(Debian 14.2.0-17) is not happy about this:

lib/vsprintf.c:1704:9: error: function ‘va_format’ might be a candidate for ‘gnu_print ’ format attribute [-Werror=suggest-attribute=format]

Fix the compilation errors (`make W=1` when CONFIG_WERROR=y, which is default)                                   by adding __printf() attribute. This, unfortunately, requires to reconsider
the type of the parameter used for that. That's why I added static_assert()
and used explicit casting. Any other solution I tried failed with the similar
or other error.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 include/linux/printk.h | 5 ++++-
 lib/vsprintf.c         | 7 ++++---
 2 files changed, 8 insertions(+), 4 deletions(-)

diff --git a/include/linux/printk.h b/include/linux/printk.h
index 4217a9f412b2..182d48b4930f 100644
--- a/include/linux/printk.h
+++ b/include/linux/printk.h
@@ -2,12 +2,13 @@
 #ifndef __KERNEL_PRINTK__
 #define __KERNEL_PRINTK__
 
-#include <linux/stdarg.h>
 #include <linux/init.h>
 #include <linux/kern_levels.h>
 #include <linux/linkage.h>
 #include <linux/ratelimit_types.h>
 #include <linux/once_lite.h>
+#include <linux/stdarg.h>
+#include <linux/stddef.h>
 
 struct console;
 
@@ -87,6 +88,8 @@ struct va_format {
 	va_list *va;
 };
 
+static_assert(offsetof(struct va_format, fmt) == 0);
+
 /*
  * FW_BUG
  * Add this to a message where you are sure the firmware is buggy or behaves
diff --git a/lib/vsprintf.c b/lib/vsprintf.c
index 8ebb5f866b08..ebb3c563a7ee 100644
--- a/lib/vsprintf.c
+++ b/lib/vsprintf.c
@@ -1692,9 +1692,10 @@ char *escaped_string(char *buf, char *end, u8 *addr, struct printf_spec spec,
 	return buf;
 }
 
-static char *va_format(char *buf, char *end, struct va_format *va_fmt,
-		       struct printf_spec spec, const char *fmt)
+static __printf(3, 0)
+char *va_format(char *buf, char *end, const char *fmt, struct printf_spec spec)
 {
+	struct va_format *va_fmt = (struct va_format *)fmt;
 	va_list va;
 
 	if (check_pointer(&buf, end, va_fmt, spec))
@@ -2462,7 +2463,7 @@ char *pointer(const char *fmt, char *buf, char *end, void *ptr,
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

