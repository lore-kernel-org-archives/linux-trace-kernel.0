Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4308F1D63F5;
	Fri, 21 Mar 2025 14:48:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742568512; cv=none; b=gHYwZwzLQanK0QMvlHBmp++Tt4aDyeMfLtc+B6MMKm4ZxKvG4XjraeQfzEbxNYRANEDZiJ52pe6GJ6bCOHMMX5V8avwhTJyu6vFp0EYv0MIPmlAPHPYAS8keUiO8wFmffI0Uxhr+HpBwhVpTIfFy1RN7HEb38huhjYUIR4Ti1aQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742568512; c=relaxed/simple;
	bh=ZjSo7eVpfj+8bQUd8bOZ5xX/jg5b3oj1RsnbRQGEH9M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=l7hlcUlCqMP+vjQHjZjYvrrnkhfAYR3OU14hQqyYYUgtD6eCfYVa2eCYOjRLhOkJ9Wo4/LIDO71sExYSw5OfpSPQw7DxB29zg+JXreFNDRmSNtpa0L2hN7QfImWtAMxCxg6cqqs5CzpER6fSwT9RiwhmDKslwgzdNzs8I4Puo6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Wgntf6aK; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Wgntf6aK"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1742568512; x=1774104512;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ZjSo7eVpfj+8bQUd8bOZ5xX/jg5b3oj1RsnbRQGEH9M=;
  b=Wgntf6aKipvN1ivgUb/So8ugFe7bwMPMAZ1g5khdP4DxXFMP8DrByOzf
   qLzTpFAmj3KJ0y6lZwjZdLNG/e/jjovPWRx9BRKNtvgw9e+qhVhhRdENv
   +ef/QIKYOof3SnwDHkywIma9qipfQzOw7TW3Vg8hMimmSCG5fYzamFygN
   8WWqL53T5uzYZZ8CrE1TFn7sGyTvqObxnQjzveYUxXo3hZCXoQkO3JCQ4
   UahMCA0jUH2iMNokwGnWDJfM5IjSo49tiokfRPcpkYcwReQkt11seak6d
   6EMIuvfTVO+OD2WjMVCHUaJmjzccCJ1k8u0NrDYEtMpbPvqp92OjSvKU8
   Q==;
X-CSE-ConnectionGUID: 97+tsq2/TK6Q5malYGPyaw==
X-CSE-MsgGUID: Zs6+P1OZQgOZs6jT7HNSHQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11380"; a="43955845"
X-IronPort-AV: E=Sophos;i="6.14,264,1736841600"; 
   d="scan'208";a="43955845"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Mar 2025 07:48:29 -0700
X-CSE-ConnectionGUID: FFLmS4KmTE+MWxzWg0bcwA==
X-CSE-MsgGUID: /oWpPbPXQKqKNQaw9/rT0w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,264,1736841600"; 
   d="scan'208";a="128250098"
Received: from black.fi.intel.com ([10.237.72.28])
  by orviesa003.jf.intel.com with ESMTP; 21 Mar 2025 07:48:25 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id 3BE82663; Fri, 21 Mar 2025 16:48:24 +0200 (EET)
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
Subject: [PATCH v2 2/6] seq_file: Mark binary printing functions with __printf() attribute
Date: Fri, 21 Mar 2025 16:40:48 +0200
Message-ID: <20250321144822.324050-3-andriy.shevchenko@linux.intel.com>
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

