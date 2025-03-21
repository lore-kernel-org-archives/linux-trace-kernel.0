Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 849E91D86DC;
	Fri, 21 Mar 2025 14:48:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742568513; cv=none; b=JzFx/Q0gCFMDDlMuugdTN7wjU+g8TTtHx0WVB+obccH0/tf//RYicbLQbNtiAttBvlu8JysJEZTyymK5+wtqTY8mqZZ/felLgD6BDznIr3qMSTibTMsEE3Mic3cMNZsxtIKweNTknM7QOssmTYNES06G6mbOu0lrOFrcpOMRss8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742568513; c=relaxed/simple;
	bh=KSdjX0FfUSl7y+GxVDh/faeFQui6+tylS4V+elc6NWs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JX2C2b8CrqsWZtSjoG1QF/2pRyJC+q1IYWEe5wF0O5HqmKq6T+ttQFprmO/B756Kn4cicAxq7GzZkWvxmOQBFA2mPDWlvKP4lbtLOuVdhJKpHx5X4+fGN/OQFnnpi899q7IX/h8oTvwvnJE2vrpc4QgBVANsAENtT7oOMWCRXg8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AHthgjjU; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AHthgjjU"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1742568511; x=1774104511;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=KSdjX0FfUSl7y+GxVDh/faeFQui6+tylS4V+elc6NWs=;
  b=AHthgjjU7GkBLYUgufiJshtoSXWq6/kU5mRxIg1XhnSrQDyKj4g9ZaHP
   EicP8o+2va8yYGAV9I5L/VRnZ5URlUioinQiWyYTVwCvZkJrgnIx6H0rF
   6cEE9f7zKn0Ko4M+B7Rnq8DvbF9klOP0KkxL1RGC/WzZcsowB6/c/FV4J
   U82YdAhLzHZeLiL9VXXdkw9Ocir90CsnVPzaoWdKIRJC5v7gbxqb9mo4B
   7c39A0pqun9Wc8BQ6uesI/n317EcjnYTlNQlf5TyrmXSLubWy9NI+dAc/
   1g02G5Q4oGwNFP/gBgsW4TLzVXER5t4koG1Ee0zeXNgwZs+umYba9XV4/
   A==;
X-CSE-ConnectionGUID: zXElSM94T8OV0F7ytdp+hg==
X-CSE-MsgGUID: 6EXUNvlvQxuL79VL3Ezn0g==
X-IronPort-AV: E=McAfee;i="6700,10204,11380"; a="54051589"
X-IronPort-AV: E=Sophos;i="6.14,264,1736841600"; 
   d="scan'208";a="54051589"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Mar 2025 07:48:29 -0700
X-CSE-ConnectionGUID: ptGMsh16Tv2UG1yupX3UwQ==
X-CSE-MsgGUID: qFj2567SQxyr3o/bHGnpWg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,264,1736841600"; 
   d="scan'208";a="123594414"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmviesa008.fm.intel.com with ESMTP; 21 Mar 2025 07:48:25 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id 2A54D214; Fri, 21 Mar 2025 16:48:24 +0200 (EET)
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
Subject: [PATCH v2 1/6] seq_buf: Mark binary printing functions with __printf() attribute
Date: Fri, 21 Mar 2025 16:40:47 +0200
Message-ID: <20250321144822.324050-2-andriy.shevchenko@linux.intel.com>
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

