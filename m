Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 641092AF19;
	Thu, 16 Jan 2025 01:20:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736990437; cv=none; b=iJmOMH+NWNkxvGKFBFVUCKIqfY6mjJqYnv87H9HG88Wm0RpjOBVjEJPcf2jVXHm94wxNCyBvOPi9g/Zm7Qbj9d5srZjSBFhLyTSsv6yW0CnL2KBoY0mWOdJapP093CsY/CrAvh+zXdKPqd/osqi7K0C5UgFig3lCkUiQ20uy+9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736990437; c=relaxed/simple;
	bh=Lk/x+e6zUsybaanOMHLPBY6zlQw2IGkAsnVwH7B7WsU=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=RTgiJsu+y8JrahRuXTlRLTCX3LkiCindnTF5DsAMmsE/2vSMkl5LX+ex938bKVZ6vfdP/OzVfnR1/2lgQ2QttsaEL2otRjUQk7pIFL0gUhmQVUJb5EIQZw2/qLYICAKIE+BCWb7I/8zioJI3GWSgb5n69982OVqSYejPzub8XWI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05EA6C4CEE3;
	Thu, 16 Jan 2025 01:20:37 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.98)
	(envelope-from <rostedt@goodmis.org>)
	id 1tYEYr-00000000hcW-3YuQ;
	Wed, 15 Jan 2025 20:20:41 -0500
Message-ID: <20250116012041.619083877@goodmis.org>
User-Agent: quilt/0.68
Date: Wed, 15 Jan 2025 20:20:11 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 2/3] selftests/ftrace: Clean up triggers after setting them
References: <20250116012009.840870709@goodmis.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: Steven Rostedt <rostedt@goodmis.org>

The triggers set in trigger-onchange-action-hist.tc and
trigger-snapshot-action-hist.tc are not cleaned up at the end. These tests
can also be done in instances and without cleaning up the triggers, the
instances can not be removed as they are still "busy".

Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 .../test.d/trigger/inter-event/trigger-onchange-action-hist.tc  | 2 ++
 .../test.d/trigger/inter-event/trigger-snapshot-action-hist.tc  | 2 ++
 2 files changed, 4 insertions(+)

diff --git a/tools/testing/selftests/ftrace/test.d/trigger/inter-event/trigger-onchange-action-hist.tc b/tools/testing/selftests/ftrace/test.d/trigger/inter-event/trigger-onchange-action-hist.tc
index 91339c130832..2430f541cd5d 100644
--- a/tools/testing/selftests/ftrace/test.d/trigger/inter-event/trigger-onchange-action-hist.tc
+++ b/tools/testing/selftests/ftrace/test.d/trigger/inter-event/trigger-onchange-action-hist.tc
@@ -19,4 +19,6 @@ if ! grep -q "changed:" events/sched/sched_waking/hist; then
     fail "Failed to create onchange action inter-event histogram"
 fi
 
+echo '!hist:keys=comm:newprio=prio:onchange($newprio).save(comm,prio) if comm=="ping"' >> events/sched/sched_waking/trigger
+
 exit 0
diff --git a/tools/testing/selftests/ftrace/test.d/trigger/inter-event/trigger-snapshot-action-hist.tc b/tools/testing/selftests/ftrace/test.d/trigger/inter-event/trigger-snapshot-action-hist.tc
index 147967e86584..334595daa9f4 100644
--- a/tools/testing/selftests/ftrace/test.d/trigger/inter-event/trigger-snapshot-action-hist.tc
+++ b/tools/testing/selftests/ftrace/test.d/trigger/inter-event/trigger-snapshot-action-hist.tc
@@ -27,4 +27,6 @@ if ! grep -q "comm=ping" snapshot; then
     fail "Failed to create snapshot action inter-event histogram"
 fi
 
+echo '!hist:keys=comm:newprio=prio:onchange($newprio).save(comm,prio):onchange($newprio).snapshot() if comm=="ping"' >> events/sched/sched_waking/trigger
+
 exit 0
-- 
2.45.2


