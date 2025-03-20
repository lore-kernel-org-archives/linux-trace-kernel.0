Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F6DD227EB6;
	Thu, 20 Mar 2025 18:09:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742494179; cv=none; b=ph6Pz9p7lJYd3p6b5BVtcGQQvE3+/oKsfLxHoryqalRunb4/RfDPzIeGy9QF2HMkPkw1+LNfItNrTcCexa58YMVp1MCCz6ZOpr4nrEDeQwX4MU9Mrd139NxWBkyWiftRfcxVOj7j1bhp1QGpnP6o4ikHE9/oudeytL41Swcby34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742494179; c=relaxed/simple;
	bh=pQlyCusjB8gPAtS0tOzHj8Kweq7GyzmGdgfWs5InqJI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HlLan+TDe4zHThza7bqHWUm6FbPcC5g7jOpwBXaWuEGvEQJSaduPhFrGDXinKxHcc7gwXXmkAJ3533bQqPDRJbz3Ktq8MYmV/Lk5Pss1WGdZkhIetwvoo7hbul+a9IdnZsykUvD9y8E5UqgoXvrf7i8lPqJfN7nMFaj4CG4kGWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SSGZvQnu; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SSGZvQnu"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1742494177; x=1774030177;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=pQlyCusjB8gPAtS0tOzHj8Kweq7GyzmGdgfWs5InqJI=;
  b=SSGZvQnuY8Zp0xd9gg4TkVIUTWi4ASX0us4wRTdcK+Lqqpg3MeHHFJMD
   D2U73SKvDU7DglUvXX4DFNOlIwq3AyMFwJZsEBDZ0CrqJLnWh3gSStTHM
   Zgt/Oz8/+phJPcwzbfp5qphT8Thva0WNigGpccN2LH9jGazNstHA97qg7
   6ui8eohtkUqzo4KT9GdCgvuyXSbIXGePoP6M+0zQae/kk1zX8Rqklng6F
   gwYkvgvqIij1p6W7RUrwJjg09FMBTW5D198hn+axpmHcjHqJbwULsIIjB
   67nVX9Jj/9ALo+vDLykR37jw4Iz/x3wQsLeUrVrmtFqLayx7HqPZsaQel
   A==;
X-CSE-ConnectionGUID: 1M3Mvc1eQ6yzLHLBdywScA==
X-CSE-MsgGUID: WSsKaYn4SpOZmUKFbYXG/g==
X-IronPort-AV: E=McAfee;i="6700,10204,11379"; a="66208840"
X-IronPort-AV: E=Sophos;i="6.14,262,1736841600"; 
   d="scan'208";a="66208840"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2025 11:09:36 -0700
X-CSE-ConnectionGUID: IgwD9fy+TeCmsAPOY8aUYA==
X-CSE-MsgGUID: ndWpyh7sRQSgDWsVOKzcfQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,262,1736841600"; 
   d="scan'208";a="146405851"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmviesa002.fm.intel.com with ESMTP; 20 Mar 2025 11:09:34 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id D21578B5; Thu, 20 Mar 2025 20:09:27 +0200 (EET)
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
Subject: [PATCH v1 5/6] vsnprintf: Mark pointer() with __printf() attribute
Date: Thu, 20 Mar 2025 20:04:26 +0200
Message-ID: <20250320180926.4002817-6-andriy.shevchenko@linux.intel.com>
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

pointer() is using printf() type of format, and GCC compiler
(Debian 14.2.0-17) is not happy about this:

lib/vsprintf.c:2466:17: error: function ‘pointer’ might be a candidate for ‘gnu_printf’ format attribute [-Werror=suggest-attribute=format]

Fix the compilation errors (`make W=1` when CONFIG_WERROR=y, which is default)
by adding __printf() attribute.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 lib/vsprintf.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/vsprintf.c b/lib/vsprintf.c
index 56fe96319292..8ebb5f866b08 100644
--- a/lib/vsprintf.c
+++ b/lib/vsprintf.c
@@ -2419,7 +2419,7 @@ char *rust_fmt_argument(char *buf, char *end, void *ptr);
  * from Rust code to format core::fmt::Arguments. Do *not* use it from C.
  * See rust/kernel/print.rs for details.
  */
-static noinline_for_stack
+static noinline_for_stack __printf(1, 0)
 char *pointer(const char *fmt, char *buf, char *end, void *ptr,
 	      struct printf_spec spec)
 {
-- 
2.47.2

