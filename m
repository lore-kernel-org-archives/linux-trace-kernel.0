Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47F3F226173;
	Thu, 20 Mar 2025 18:09:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742494175; cv=none; b=oL+Q9tcVC5A/j/O8HXSON3QOne+wo/iD+deuFXWHLq5IadnAJOxixnvVSWRaCynv1GK+Hw1a2G0s9FJElRcRWGVRy3urenphjUhwd6/ac2ZInh49+Wi6CYwmn+uxL3U1DD59cRAs3F8a8u7fUtvtwUeh3DD8lfyB0JOSz3Cov4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742494175; c=relaxed/simple;
	bh=ZjSo7eVpfj+8bQUd8bOZ5xX/jg5b3oj1RsnbRQGEH9M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LQcoSwos/X+N+QdtP8iz/bvPc2tHJ1lXIW0Lg9sGgmrWOJHB5gWzIpE7HLHb5QFbsjct7KLJeU6XJcGuRFE57hlGfyw1P83D31oPOTpLPr/80zKcNc70LclHKzOIzJyPei5lH30vQD0MKAnGtDC1tDdkXkJZx+RYM8gmZjH/Oy0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nhI7RhMw; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nhI7RhMw"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1742494173; x=1774030173;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ZjSo7eVpfj+8bQUd8bOZ5xX/jg5b3oj1RsnbRQGEH9M=;
  b=nhI7RhMw3WoFS59rb221ncNv3qM73xE680L3ljrqwWVGoZBLLOS7k6Tg
   idSkqQcSXszzmsMSd4Ai+a/fzvnJoDXVcM3GKP1FWTj/bW9PcTIBUHcqZ
   il+yMKF1WfA3fbijlwOGYb3PGaI1QFOZqmx6FPsRiXUs7wj9dJQpAmuMt
   Tn/iazAKVJIsQvXN8TnH2ke1xoP5VOQ4PDvnBfFD9OSHN50IINAkIdoBr
   UH0TkA6n4OzwdOC5RsBFdq07d+NAzN51Xe5z+xEQQzLT0fdPJ2gI3e89e
   gb7o8xZBKpP9F+SwPpUBysGD7hDdL1yoU5+Zub7Gv4Wt2OXHmPnaTHyWb
   A==;
X-CSE-ConnectionGUID: A5r6vbjpSxKVMpmpYOHrsQ==
X-CSE-MsgGUID: jHqWRRWfQpOE+3RMSW6RJQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11379"; a="66208788"
X-IronPort-AV: E=Sophos;i="6.14,262,1736841600"; 
   d="scan'208";a="66208788"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2025 11:09:32 -0700
X-CSE-ConnectionGUID: qm5chT69RlW864m3IXdCuw==
X-CSE-MsgGUID: bix4mCOxR7eM5F5LNBk5FQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,262,1736841600"; 
   d="scan'208";a="146405835"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmviesa002.fm.intel.com with ESMTP; 20 Mar 2025 11:09:29 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id A712C2A7; Thu, 20 Mar 2025 20:09:27 +0200 (EET)
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
Subject: [PATCH v1 2/6] seq_file: Mark binary printing functions with __printf() attribute
Date: Thu, 20 Mar 2025 20:04:23 +0200
Message-ID: <20250320180926.4002817-3-andriy.shevchenko@linux.intel.com>
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

fs/seq_file.c:418:35: error: function ‘seq_bprintf’ might be a candidate for ‘gnu_printf’ format attribute [-Werror=suggest-attribute=format]

Fix the compilation errors by adding __printf() attribute.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 include/linux/seq_file.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/linux/seq_file.h b/include/linux/seq_file.h
index 2fb266ea69fa..d6ebf0596510 100644
--- a/include/linux/seq_file.h
+++ b/include/linux/seq_file.h
@@ -181,6 +181,7 @@ int seq_open_private(struct file *, const struct seq_operations *, int);
 int seq_release_private(struct inode *, struct file *);
 
 #ifdef CONFIG_BINARY_PRINTF
+__printf(2, 0)
 void seq_bprintf(struct seq_file *m, const char *f, const u32 *binary);
 #endif
 
-- 
2.47.2

