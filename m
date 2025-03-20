Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63F86226CF9;
	Thu, 20 Mar 2025 18:09:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742494177; cv=none; b=TnmSlqxFufZMfItubCpeLEnY0YEXiZapDwwtFZ5+0E9jHuPeklgP7Atr6AT6xX2IClLysDQUDNhfMY6Crh7kQBfVmFpd5s8Fvx6KBiKQ9DjcLH6dhaRWltIpI4l+MK5TQ0mTpL3XbYCE6iC6pk/g+TMAocez5H6hFs9gHdi6o1w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742494177; c=relaxed/simple;
	bh=KSdjX0FfUSl7y+GxVDh/faeFQui6+tylS4V+elc6NWs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oU5jCGcnB4G8hFeBMznLicYMYT3CJTXw9xyzawlsd/EJj0qTu67vvwS/QjGExOs6ENO4wu4v/GnmtK5FF2aAuJiXL4s96fklb5QuKv0pmPB1Zn9KBGWMZjyNi1TrzagC9BHzRu+Xi2A5ooZBr9hcW6CkrnN/TSfnxN9UpnbmU44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SQDbvkg6; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SQDbvkg6"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1742494175; x=1774030175;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=KSdjX0FfUSl7y+GxVDh/faeFQui6+tylS4V+elc6NWs=;
  b=SQDbvkg6NyGd/2VX/wJZUfhCgXxpRo3VFOb7tkTi9nIFEouugb8GhrxY
   E/DzhUsnGO6RCmZYMw0h0R7XIvlayQsxRXdA7W8bcxCY4rd+CWmZ0xVBP
   NBzyVA6dQoU+64ADKOYBfW2yjYv9W/0pm+LEGQX0HJoClF8babJ8qCtT7
   4IDea+6cFIVE3KeCaXS60hhASBib1Gj7Zf7kSowQCfS1/TEtYYgR0E+R6
   23zAgzoM35iKRF8mM1Ksvv9ZvJFFRs+AHPtT+e/wYF+i3u85R6VQpUZ+s
   d+ofsTJIEYA7fktci+7AZlgoQxCOSz7oYLashYxtK0Ywsq7Whxv4jJmNv
   Q==;
X-CSE-ConnectionGUID: tSK0cLZVSCuSl9/CQP1e7w==
X-CSE-MsgGUID: S/H8pdHmQzi2cDheoWCf5g==
X-IronPort-AV: E=McAfee;i="6700,10204,11379"; a="66208809"
X-IronPort-AV: E=Sophos;i="6.14,262,1736841600"; 
   d="scan'208";a="66208809"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2025 11:09:32 -0700
X-CSE-ConnectionGUID: Q3uWJba8ShmIoJZ26CMBow==
X-CSE-MsgGUID: EXOOtSFjSzWVx27gaNKn7w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,262,1736841600"; 
   d="scan'208";a="146405838"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmviesa002.fm.intel.com with ESMTP; 20 Mar 2025 11:09:29 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id 97B3A126; Thu, 20 Mar 2025 20:09:27 +0200 (EET)
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
Subject: [PATCH v1 1/6] seq_buf: Mark binary printing functions with __printf() attribute
Date: Thu, 20 Mar 2025 20:04:22 +0200
Message-ID: <20250320180926.4002817-2-andriy.shevchenko@linux.intel.com>
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

Binary printing functions are using printf() type of format, and compiler
is not happy about them as is:

lib/seq_buf.c:162:17: error: function ‘seq_buf_bprintf’ might be a candidate for ‘gnu_printf’ format attribute [-Werror=suggest-attribute=format]

Fix the compilation errors by adding __printf() attribute.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 include/linux/seq_buf.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/linux/seq_buf.h b/include/linux/seq_buf.h
index fe41da005970..52791e070506 100644
--- a/include/linux/seq_buf.h
+++ b/include/linux/seq_buf.h
@@ -167,8 +167,8 @@ extern int seq_buf_hex_dump(struct seq_buf *s, const char *prefix_str,
 			    const void *buf, size_t len, bool ascii);
 
 #ifdef CONFIG_BINARY_PRINTF
-extern int
-seq_buf_bprintf(struct seq_buf *s, const char *fmt, const u32 *binary);
+__printf(2, 0)
+int seq_buf_bprintf(struct seq_buf *s, const char *fmt, const u32 *binary);
 #endif
 
 void seq_buf_do_printk(struct seq_buf *s, const char *lvl);
-- 
2.47.2

