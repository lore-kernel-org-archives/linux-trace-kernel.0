Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AE3C226541;
	Thu, 20 Mar 2025 18:09:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742494176; cv=none; b=EyhbcktGEMti6LUbUdC58VBchVv4YUR6v3z9Ps72RSwfraCpEMj8G394YworCqknvw5+O+7Zm5Ut4k2t2O56DXw56xppZRva2Ed6MYls6OzeKvQk++rkNj8z51HTKn3gJ+sL/tcM9OdLNjNSdW8Nuq2P2FqDjPrRWYupg+1Za5w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742494176; c=relaxed/simple;
	bh=ubxtZyh8stIn5q0xWikfoRweT1uoZ+QsdH/F25+V/ks=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=jnTGExood+aYZpqK1be1WphRWVO0kKojz9/xckSZJfO75qX2e14TCxx465vuouk4D/bVdBp0e75CG/r8GaheKv8kmfMwB/m2wqvg7f1hXl9UVMEYAlM1NBWMTu79nK4L8h5LcCvyYxioyo1Yd/Q/+/61PEfxrf628bXJvKJsAaA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dzMTzAyu; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dzMTzAyu"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1742494175; x=1774030175;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=ubxtZyh8stIn5q0xWikfoRweT1uoZ+QsdH/F25+V/ks=;
  b=dzMTzAyuz8//f+EPUpU2O44blqo0hsoM7n/GjjpjPiQZ/h25upNt8ltW
   0rAFCVV6RpmW4XZE8e6RJdzWVH+dPCcmtWIg+V2HZAXOIq4OJRpU1SQTl
   ZyZGM6gP49O00UcOZcWHetT15hz6JlfGnAQEqx7yBD4lC9zrd1uT+E0Im
   eSZDDBrWRyBAWdK6RbPK2MWrTS70QrGyNEbRhcyKsf1CmC3QJpahQDa/n
   cOgAqrcBsvy6tsyL4CGPzwoAhCjk5bYCEU/1GaFp5yPocU5vb5d8wu9A6
   J2Kl+RjxNb0Z4l1+vAzTGusOPHRY9FPKd/KDWMjMW1ziVAtfsH1kU6ow+
   w==;
X-CSE-ConnectionGUID: A6wiTs6QQGmDwdRkkyP9dA==
X-CSE-MsgGUID: URsf0/YpTWimB9KvhP9LRg==
X-IronPort-AV: E=McAfee;i="6700,10204,11379"; a="66208799"
X-IronPort-AV: E=Sophos;i="6.14,262,1736841600"; 
   d="scan'208";a="66208799"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2025 11:09:32 -0700
X-CSE-ConnectionGUID: nt4lqcnGT1qXGgDoHxqSJQ==
X-CSE-MsgGUID: Diip9h8ORh2XDfNhU7qMYg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,262,1736841600"; 
   d="scan'208";a="146405836"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmviesa002.fm.intel.com with ESMTP; 20 Mar 2025 11:09:29 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id 869F52A0; Thu, 20 Mar 2025 20:09:27 +0200 (EET)
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
Subject: [PATCH v1 0/6] vsprintf: Add __printf attribute to where it's required
Date: Thu, 20 Mar 2025 20:04:21 +0200
Message-ID: <20250320180926.4002817-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.47.2
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

This whole series started from a simple fix (see the last patch)
to make GCC (Debian 14.2.0-17) happy when compiling with `make W=1`
(note, that CONFIG_WERROR=y and all warnings break the build!)
down to a rabbit hole.

The series is organised in a strict order and can't be split or
reshuffled, otherwise see above.

Also note the last patch has a bit of a hackish approach and
I have no idea how to fix it differently, I tried a few different,
all failed. So, if you think there is a better one, please advise!

I believe the best route for the series is printk tree with immutable
tag or branch for the others.

Andy Shevchenko (6):
  seq_buf: Mark binary printing functions with __printf() attribute
  seq_file: Mark binary printing functions with __printf() attribute
  tracing: Mark binary printing functions with __printf() attribute
  vsnprintf: Mark binary printing functions with __printf() attribute
  vsnprintf: Mark pointer() with __printf() attribute
  vsnprintf: Mark va_format() with __printf() attribute

 include/linux/printk.h    |  5 ++++-
 include/linux/seq_buf.h   |  4 ++--
 include/linux/seq_file.h  |  1 +
 include/linux/string.h    |  4 ++--
 include/linux/trace_seq.h |  7 ++++---
 kernel/trace/trace.c      |  3 ---
 kernel/trace/trace.h      | 16 +++++++++-------
 lib/vsprintf.c            |  9 +++++----
 8 files changed, 27 insertions(+), 22 deletions(-)

-- 
2.47.2

