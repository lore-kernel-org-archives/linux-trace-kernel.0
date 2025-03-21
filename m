Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DB3F1D514E;
	Fri, 21 Mar 2025 14:48:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742568511; cv=none; b=SnU0lH5K1y15BIkXzHbMRui/+aNTBCbqn9WGrPxzuByLWxZ9uF25iWYi5nTIf8PlnofooZi4qf5okNFZKAmMwRRjGLm6hY7FWWTYi8TTrMfPJ+esVOPiOGYjhxAIaNXPT8y4lsDre4Q+P1RnVwbVq0d1RI0jPV+zn2+GTGBXU/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742568511; c=relaxed/simple;
	bh=1FHN7C7JwKB38srjLAJ+yUcrgQTnh4rrm3GJV2ZvjVw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=WMNuD8rZd/Jl764ZXqGyHcZ4ZwUJzMLWN3htlIEsU9U0rf6zUDtpK2etusqDPa8j5/l6VW0jqQkCd9Qh7H1O4ksfg3T/D/tZR8cNb9+d8swTzGSyN079IiKSOhk6NodKFrVAijEASxnj/tJs5RMjehcg6l63Lr13iw3kCCTFkGo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lA7ODjJX; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lA7ODjJX"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1742568510; x=1774104510;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=1FHN7C7JwKB38srjLAJ+yUcrgQTnh4rrm3GJV2ZvjVw=;
  b=lA7ODjJXShIesYyY48c32qa5SkV7XxUL/6GgJdLFpkB3SXRYr8lS4VZ3
   1b6d6nnp2YVBHVhUrYx8YRVmeP1taaFKnIo+73G8LhVwXAM+yOtayDFJ9
   zI5trGVc/wBmX4mxXRJw1PKBLxILvuXZcdK7POD+8U3OgTD1rS1VKzqWM
   tNeH6Cq2W6TH7CG6nXF9VOHWOpY//WyOL6FKcWjraHitekOwoAe2nnhSt
   0lC1Nnq0O9IXxiunyHCg1Q1UV2+gJ3zx9viv3b0WoCn2vW8BoMXK/W5G3
   aetSgnp7ySp10b8RD9IeIKLsLCBfmW1qevEKc7/TAbH9lLyigd1chPcr0
   Q==;
X-CSE-ConnectionGUID: 5/goPzAzSJSWjVIafERQ9w==
X-CSE-MsgGUID: qvsdVFmHTdiD/X6nnDqvNw==
X-IronPort-AV: E=McAfee;i="6700,10204,11380"; a="43955832"
X-IronPort-AV: E=Sophos;i="6.14,264,1736841600"; 
   d="scan'208";a="43955832"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Mar 2025 07:48:29 -0700
X-CSE-ConnectionGUID: TLrJEag3TEaqkNSfbQmI+A==
X-CSE-MsgGUID: W972xYkATPKc36pjfu1F0A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,264,1736841600"; 
   d="scan'208";a="128250097"
Received: from black.fi.intel.com ([10.237.72.28])
  by orviesa003.jf.intel.com with ESMTP; 21 Mar 2025 07:48:25 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id 1A14A25B; Fri, 21 Mar 2025 16:48:24 +0200 (EET)
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
Subject: [PATCH v2 0/6] vsprintf: Add __printf attribute to where it's required
Date: Fri, 21 Mar 2025 16:40:46 +0200
Message-ID: <20250321144822.324050-1-andriy.shevchenko@linux.intel.com>
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

However starting from v2 the last patch doesn't require the first
part, I prefer still to have them since the functions, while being
_binary_ printf()-like, are still printf()-like. It also puts in align
the tracing stuff with the rest and fixes the wrong parameter value.

These first 4 patches are organised in a strict order and can't be
reshuffled, otherwise it will produce a warnings in between.

I believe the best route for the series is printk tree with immutable
tag or branch for the others.

Alternatively the first 4 patches can be applied first as they
are pretty much straightforward. They also can be squashed to one
(as the same topic behind), but it all is up to the respective
maintainers.

In v2:
- split out patch 5 (Rasmus)
- rewritten the approach for the va_format() fix (Rasmus)
- amended tracing patch (removed a blank line and a __printf() in C file)

Andy Shevchenko (6):
  seq_buf: Mark binary printing functions with __printf() attribute
  seq_file: Mark binary printing functions with __printf() attribute
  tracing: Mark binary printing functions with __printf() attribute
  vsnprintf: Mark binary printing functions with __printf() attribute
  vsnprintf: Drop unused const char fmt * in va_format()
  vsnprintf: Silence false positive GCC warning for va_format()

 include/linux/seq_buf.h   |  4 ++--
 include/linux/seq_file.h  |  1 +
 include/linux/string.h    |  4 ++--
 include/linux/trace.h     |  4 ++--
 include/linux/trace_seq.h |  8 ++++----
 kernel/trace/trace.c      | 11 +++--------
 kernel/trace/trace.h      | 16 +++++++++-------
 lib/vsprintf.c            |  9 +++++++--
 8 files changed, 30 insertions(+), 27 deletions(-)

-- 
2.47.2

