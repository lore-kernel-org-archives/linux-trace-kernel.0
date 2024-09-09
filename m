Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C50012B17C;
	Mon,  9 Sep 2024 10:53:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725879215; cv=none; b=SygaLMc9LRHhyLmrEiSIw07PVGuK0dtAJSYQnIAFUyyPWXU7NKxyYaVw/UqgokAxdkSqY9jPpIoNqKC0+By/k7wv2M4SmBnI9CDKPiDJ4Su8yi/r8DTxzU+BCcb2cYq22J1Jb/8zeGxyVcIE9cPc/KW3EMPnd8c2bwjvvvSK5CU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725879215; c=relaxed/simple;
	bh=L8zTApnftuKIPWF/1of8D45op0E0msf9CkZIUtmNpFs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Mnvx6/O0ncf16z0hFb7JT7PAO8Zq8Ye+DMVQ+bjituz2qLaNVdLspZ6ar5AIeHjZ8oqPsvdl+wHAcUp1WO5sDVQuNnYSnCYSOk+eP7l6hRCEDQA3dtNprmaWOlIFECoFV7bmn49Uv96ZkHd4sPyM0A19NDI7JmU/0IxnXAZ6K0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=knyb+Huo; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="knyb+Huo"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1725879215; x=1757415215;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=L8zTApnftuKIPWF/1of8D45op0E0msf9CkZIUtmNpFs=;
  b=knyb+Huodiw21UGMwt3KwL+fuBNNJNTNSYWLKyRRRXDAPWW3l6WsdY0z
   hrGjpt23pLwx42kcombxSKD41SppKFIIGAF6PV2sBYm/itoy7QpPQDNgX
   eqKd2GT1usZXNoRiNX/rcfQIw5PEHgNVw/T3KBIHyfkXll5aKVHeHdOgH
   +E/rqD3Ga9iFxjouZHMpg1QjgDheTLhQcXkQZa/bdvEZaNEGkcS/Mmn0P
   O4/Oz8pZQpsWDCvQ24FxVDJhNJjCJEAB+dSNSSPThL1lv3/PqWW5s1ZZ2
   hXLQzvnWTjPLHE2AdYgt6W7YEHKU4gUQsOoxEVuVdF/QzbRSdj13iqmOz
   A==;
X-CSE-ConnectionGUID: XmwGIDJuSLW+AmVngX+Htw==
X-CSE-MsgGUID: lEARyM13RL6X7uEOcJKrcg==
X-IronPort-AV: E=McAfee;i="6700,10204,11189"; a="24433125"
X-IronPort-AV: E=Sophos;i="6.10,214,1719903600"; 
   d="scan'208";a="24433125"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Sep 2024 03:53:34 -0700
X-CSE-ConnectionGUID: Cz/m6/G4QZ2LE+eZo4SCbg==
X-CSE-MsgGUID: +xWHHtMaR3iJ6nkWb8mwxw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,214,1719903600"; 
   d="scan'208";a="70744672"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmviesa003.fm.intel.com with ESMTP; 09 Sep 2024 03:53:30 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id 3A6AB321; Mon, 09 Sep 2024 13:53:28 +0300 (EEST)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Steven Rostedt <rostedt@goodmis.org>,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	llvm@lists.linux.dev
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 1/1] tracing: Drop unused helper function to fix the build
Date: Mon,  9 Sep 2024 13:53:14 +0300
Message-ID: <20240909105314.928302-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.43.0.rc1.1336.g36b5255a03ac
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A helper function defined but not used. This, in particular,
prevents kernel builds with clang, `make W=1` and CONFIG_WERROR=y:

kernel/trace/trace.c:2229:19: error: unused function 'run_tracer_selftest' [-Werror,-Wunused-function]
 2229 | static inline int run_tracer_selftest(struct tracer *type)
      |                   ^~~~~~~~~~~~~~~~~~~

Fix this by dropping unused functions.

See also commit 6863f5643dd7 ("kbuild: allow Clang to find unused static
inline functions for W=1 build").

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 kernel/trace/trace.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index edf6bc817aa1..c3b2c7dfadef 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -2226,10 +2226,6 @@ static __init int init_trace_selftests(void)
 }
 core_initcall(init_trace_selftests);
 #else
-static inline int run_tracer_selftest(struct tracer *type)
-{
-	return 0;
-}
 static inline int do_run_tracer_selftest(struct tracer *type)
 {
 	return 0;
-- 
2.43.0.rc1.1336.g36b5255a03ac

