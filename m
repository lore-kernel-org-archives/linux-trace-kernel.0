Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A7431D88A4;
	Fri, 21 Mar 2025 14:48:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742568513; cv=none; b=AJ+OKme0hp0235LtRi1HGKTrbVE1Lcwj4m2cZ7j2vhcsSFTVOAvu055283nmv6bqJrGYERUJ70iyLMAP0IHt03uIWzEmxICdcWQm8N3g9dlSLjODMk/aZsQIVlTYEaf4mTJpCIfkSdvZRYBdsU53k3VKHQjJ9m0s3eWgjaTGXPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742568513; c=relaxed/simple;
	bh=qPhdBccUurWZ8vX2YNRN+CZDAIh2aFQ2W5yHmydtpBc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bikO88no369Yn2BbWKSJ53/zIGqZDtMfYgDLEYHn84HcpDsDlSBeRrlRIrmgoGmNYTggdhtr0x7i7LFskLGGrIt2HEEa4K+0QgrvDLTHn9dJFuaUZgvALUtJxtXu6rTnSkp6bC9EDQQGxiLfzInLp4KqBWY9Rt2pqmaEXtwP2Qk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CqeTL/i6; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CqeTL/i6"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1742568512; x=1774104512;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=qPhdBccUurWZ8vX2YNRN+CZDAIh2aFQ2W5yHmydtpBc=;
  b=CqeTL/i6WstPnp4hbjC6ijyvkUqNJlQIRlfeTsZ6s/WzvjUZM1vyo2lc
   +5YtBihTSCGajMdkRNFja8+KUSSg2crQaBSlDYLRJOxjBxpSeRt04RBXz
   oS6fCv4XMIDaYucDTzdJmCPaBsNP8l1HC/6CW9ihCi63p5kyenAmo4+oX
   FdJ7REDsO8OU3EkAH+a/O3sG0dkWkM11Pa78cxymaDydAEofYik3dENF4
   cu+3orTsyAz6xetAwSmhL+YJtHEzJ5ItXnLEbEQtfIEU6+jztVQvzSiIL
   GnSst1bMrwk9ZWt432FVfzfSJG3N157km7QQsa5KFUIzw39YDaT7cZovw
   A==;
X-CSE-ConnectionGUID: V47erTjtQ/aDrLSX2ply6w==
X-CSE-MsgGUID: PowIal8FSKCZTXe+T0xaog==
X-IronPort-AV: E=McAfee;i="6700,10204,11380"; a="43955856"
X-IronPort-AV: E=Sophos;i="6.14,264,1736841600"; 
   d="scan'208";a="43955856"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Mar 2025 07:48:29 -0700
X-CSE-ConnectionGUID: tR0FNL3rT5CHMFDHUreADw==
X-CSE-MsgGUID: YBgxQtSKRZeBnT9jt7W0rA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,264,1736841600"; 
   d="scan'208";a="128250099"
Received: from black.fi.intel.com ([10.237.72.28])
  by orviesa003.jf.intel.com with ESMTP; 21 Mar 2025 07:48:25 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id 5FA57708; Fri, 21 Mar 2025 16:48:24 +0200 (EET)
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
	Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: [PATCH v2 4/6] vsnprintf: Mark binary printing functions with __printf() attribute
Date: Fri, 21 Mar 2025 16:40:50 +0200
Message-ID: <20250321144822.324050-5-andriy.shevchenko@linux.intel.com>
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

