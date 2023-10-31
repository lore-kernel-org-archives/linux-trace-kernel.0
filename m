Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4CEC566C
	for <linux-trace-kernel@vger.kernel.org>; Tue, 31 Oct 2023 04:17:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ce9nlv9n"
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.136])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01331C0;
	Mon, 30 Oct 2023 21:17:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698725868; x=1730261868;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=rpcGncgm1Z5BymoCaEUZ/jhYu8BnNz8T00kr7N/RoqM=;
  b=ce9nlv9nlKz7Wys4kp5cLSrvIC3B35Omdn87VkrMdSy+KbHqamV0HmSI
   IiLVHj9WF5g7t+AMrC+tVzmGtibma4OPmvJ/sytoOxDiLv5oqHvDLzTBb
   DbhI50sNP1f5LiLOYPf+AnF0R3PVpGcgltnIjPCh8R53p7nyMk/vVeqK+
   nGdpMmwMijAo1cn6OUPeamWy4qB8RO/kpNEJt5f3uJzAt87jL/9nebgyn
   mUX2CTwG0ZDl6PjpcHWw5U6zDkKaXluu6lOB9+xsS47rUgiJNR36grspC
   oLqFy1dXSF3QYXLHp6A8kvtwNBKBRpUj3BhCFmqOTOBHsSKBR1GpQuyvd
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10879"; a="367557014"
X-IronPort-AV: E=Sophos;i="6.03,264,1694761200"; 
   d="scan'208";a="367557014"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Oct 2023 21:17:48 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10879"; a="884089007"
X-IronPort-AV: E=Sophos;i="6.03,264,1694761200"; 
   d="scan'208";a="884089007"
Received: from yujie-x299.sh.intel.com ([10.239.159.77])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Oct 2023 21:17:46 -0700
From: Yujie Liu <yujie.liu@intel.com>
To: linux-trace-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Tom Zanussi <zanussi@kernel.org>,
	linux-kernel@vger.kernel.org,
	Mukesh Ojha <quic_mojha@quicinc.com>
Subject: [PATCH] tracing/kprobes: Fix the order of argument descriptions
Date: Tue, 31 Oct 2023 12:13:05 +0800
Message-Id: <20231031041305.3363712-1-yujie.liu@intel.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The order of descriptions should be consistent with the argument list of
the function, so "kretprobe" should be the second one.

int __kprobe_event_gen_cmd_start(struct dynevent_cmd *cmd, bool kretprobe,
                                 const char *name, const char *loc, ...)

Fixes: 2a588dd1d5d6 ("tracing: Add kprobe event command generation functions")
Suggested-by: Mukesh Ojha <quic_mojha@quicinc.com>
Signed-off-by: Yujie Liu <yujie.liu@intel.com>
---
 kernel/trace/trace_kprobe.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/trace/trace_kprobe.c b/kernel/trace/trace_kprobe.c
index e834f149695b..47812aa16bb5 100644
--- a/kernel/trace/trace_kprobe.c
+++ b/kernel/trace/trace_kprobe.c
@@ -1020,9 +1020,9 @@ EXPORT_SYMBOL_GPL(kprobe_event_cmd_init);
 /**
  * __kprobe_event_gen_cmd_start - Generate a kprobe event command from arg list
  * @cmd: A pointer to the dynevent_cmd struct representing the new event
+ * @kretprobe: Is this a return probe?
  * @name: The name of the kprobe event
  * @loc: The location of the kprobe event
- * @kretprobe: Is this a return probe?
  * @...: Variable number of arg (pairs), one pair for each field
  *
  * NOTE: Users normally won't want to call this function directly, but
-- 
2.34.1

