Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8515227BB6;
	Thu, 20 Mar 2025 18:09:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742494178; cv=none; b=JR7TP6Ne1IXfLpp5b/v4peFSVRHD5PgY+NRvkUJgTXhW32IkoSsUcvasWc3CeKtC9bSa9cfcwOrdd8kggwuU/9BfuYeofXTAoj1SCEHNA57NT4m9freVDEkPe2RA/UTGwz2Z48FoE9rx1bEH/o11JP8v38X4jMZj7UX5vr/MlCo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742494178; c=relaxed/simple;
	bh=qPhdBccUurWZ8vX2YNRN+CZDAIh2aFQ2W5yHmydtpBc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tqZUT3Vzuzz1K/x0GdJu0ioktK0AwsxJAxAjEVkoEzrP7kS+q2E2aYpKq44aXgfnpRRGA+MsDwjsIMULni9GPTmzWFuXPL/z6FZ7vCHTC9j//ydDmicJjPWQsixTXbBrWT4SNI9toZ+eC+LdWiG2Vr8Nd/UWyxlOXHqmrx4GRMc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WhccJz05; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WhccJz05"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1742494176; x=1774030176;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=qPhdBccUurWZ8vX2YNRN+CZDAIh2aFQ2W5yHmydtpBc=;
  b=WhccJz05WQTWlyqV5gsBtxf4tfP742y69GKljAegu3C25I3ucdcrgrG3
   YbzqlBU/UdAkIEXmgeCUL+8i87JFxnpJrZkZCYv5kt4z63BK05ZPitKSO
   fOT7WEd5DcQtHan52vPxjS+j8oRUediNEDFhaQvh2XVot46C223VTyDyl
   a1ihZbmREapGniyngOVoOAGXzneTenw9zTpFcMOQlxv7Lbqv37l1Q5n5Y
   7GABmSF5ZIf+OafxoQW7zRtQGtmWIXYXKWCSIXKIYws3Iy/rtk88ZSb/H
   wcPnGcVfPvtv5VM3N+Xp9OaEkJP6T72xaBfs4Joh9I/UkiWOVeMKvGoE+
   Q==;
X-CSE-ConnectionGUID: T3r/awbmQwuzcOkfdU/m4Q==
X-CSE-MsgGUID: ozi8JU7TQzC4GcQ64qtfmA==
X-IronPort-AV: E=McAfee;i="6700,10204,11379"; a="66208817"
X-IronPort-AV: E=Sophos;i="6.14,262,1736841600"; 
   d="scan'208";a="66208817"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2025 11:09:33 -0700
X-CSE-ConnectionGUID: MF2uH33yRI+KnmO3oYhzHQ==
X-CSE-MsgGUID: 2vWPM9FYQt6OjDnL7cjJlA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,262,1736841600"; 
   d="scan'208";a="146405837"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmviesa002.fm.intel.com with ESMTP; 20 Mar 2025 11:09:29 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id C45927D2; Thu, 20 Mar 2025 20:09:27 +0200 (EET)
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
Subject: [PATCH v1 4/6] vsnprintf: Mark binary printing functions with __printf() attribute
Date: Thu, 20 Mar 2025 20:04:25 +0200
Message-ID: <20250320180926.4002817-5-andriy.shevchenko@linux.intel.com>
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

Binary printf() functions are using printf() type of format, and compiler
is not happy about them as is:

lib/vsprintf.c:3130:47: error: function ‘vbin_printf’ might be a candidate for ‘gnu_printf’ format attribute [-Werror=suggest-attribute=format]
lib/vsprintf.c:3298:33: error: function ‘bstr_printf’ might be a candidate for ‘gnu_printf’ format attribute [-Werror=suggest-attribute=format]

Fix the compilation errors by adding __printf() attribute.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 include/linux/string.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/linux/string.h b/include/linux/string.h
index f8e21e80942f..f15696e8e4d4 100644
--- a/include/linux/string.h
+++ b/include/linux/string.h
@@ -336,8 +336,8 @@ int __sysfs_match_string(const char * const *array, size_t n, const char *s);
 #define sysfs_match_string(_a, _s) __sysfs_match_string(_a, ARRAY_SIZE(_a), _s)
 
 #ifdef CONFIG_BINARY_PRINTF
-int vbin_printf(u32 *bin_buf, size_t size, const char *fmt, va_list args);
-int bstr_printf(char *buf, size_t size, const char *fmt, const u32 *bin_buf);
+__printf(3, 0) int vbin_printf(u32 *bin_buf, size_t size, const char *fmt, va_list args);
+__printf(3, 0) int bstr_printf(char *buf, size_t size, const char *fmt, const u32 *bin_buf);
 #endif
 
 extern ssize_t memory_read_from_buffer(void *to, size_t count, loff_t *ppos,
-- 
2.47.2

