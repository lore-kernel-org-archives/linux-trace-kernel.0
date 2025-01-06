Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D9A61553BB;
	Mon,  6 Jan 2025 16:03:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736179413; cv=none; b=gOInqct+cSgToKKtvLxTj5hAlpKteOU02M9c5Xb+FHD2XazKB2OyJpg9fLVF/D1ynr/xiiFCL6XRDFMBSYXoMro5KNRKKeIpsRFgkD8+1k5MXmAiVipRFW1mNUnB6V56ftkHvZYnoHw37RhmrT6elguhMUX2NhMH5559KIDU16w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736179413; c=relaxed/simple;
	bh=aHTn1CmSTWoTune9KdD1g9eI9HqqmUvrF1E5SbLmrTQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KjQ1koSWfUy/zTygWFfuO4/G7u+TX33jlsngEP7+KaNEqhB1Si41K8t30id4XTUvNrQcG+4DFbvESVKkWxx7ua51rJeJZu5QUV8Bxwm43lD4aQX8GAjjA6XIO+nkOC/a9xmJ7iSOdthdDBnL70pS0GIKF0KmKpXjgSRUJXF+fIY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QPxpfjNy; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QPxpfjNy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98B2EC4CED6;
	Mon,  6 Jan 2025 16:03:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736179412;
	bh=aHTn1CmSTWoTune9KdD1g9eI9HqqmUvrF1E5SbLmrTQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=QPxpfjNybNQb1Lv+A90w8Qd6mFrCb+dYWdZVwFC6jfRKX90kMhZH5LD21DBz+gRgm
	 lX2r/fsqL+hE0TDFoBbRBj1aztdFWxsgIn62bw4g+l7sqvAR+jLceeSK86zKaG5YDZ
	 DTXK3rToCtZVg0HiB4T8lUTNNyJEW9P4RYVeDQl0hAvtQ+drEVllAZBFPTftMczwq6
	 9RV/0jLQFVPCEpMG6s1oTATamusalBDxW4jNJoR02ofhOTa4fq11lUlSPJ7FUWkyZY
	 h7y9gNVN/Ribp5+27D6Bvnt6mooL+dL5YbV2EQspALgThvd5iNH1txVx5L1frECn3C
	 cA7yItuABBWzg==
From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>,
	Peter Zijlstra <peterz@infradead.org>
Cc: Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	"David S . Miller" <davem@davemloft.net>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Oleg Nesterov <oleg@redhat.com>,
	Tzvetomir Stoyanov <tz.stoyanov@gmail.com>,
	Naveen N Rao <naveen@kernel.org>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Jason Baron <jbaron@akamai.com>,
	Ard Biesheuvel <ardb@kernel.org>,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH v2 3/7] tracing: Use __free() for argv in dynevent
Date: Tue,  7 Jan 2025 01:03:27 +0900
Message-ID: <173617940696.1366315.9993763922773507683.stgit@devnote2>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <173617937395.1366315.17590944219163017504.stgit@devnote2>
References: <173617937395.1366315.17590944219163017504.stgit@devnote2>
User-Agent: StGit/0.19
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

From: Masami Hiramatsu (Google) <mhiramat@kernel.org>

Use __free() for the args allocated by argv_split() in dynevent.

Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
---
 Changes in v3:
  - Rename to __free(argv_free).
 Changes in v2:
  - Rebased on probes/for-next, which reverts previous dynevent guard patch.
---
 kernel/trace/trace_dynevent.c |   23 ++++++++---------------
 1 file changed, 8 insertions(+), 15 deletions(-)

diff --git a/kernel/trace/trace_dynevent.c b/kernel/trace/trace_dynevent.c
index 4376887e0d8a..78242ea6fb30 100644
--- a/kernel/trace/trace_dynevent.c
+++ b/kernel/trace/trace_dynevent.c
@@ -74,24 +74,20 @@ int dyn_event_release(const char *raw_command, struct dyn_event_operations *type
 	struct dyn_event *pos, *n;
 	char *system = NULL, *event, *p;
 	int argc, ret = -ENOENT;
-	char **argv;
+	char **argv __free(argv_free) = NULL;
 
 	argv = argv_split(GFP_KERNEL, raw_command, &argc);
 	if (!argv)
 		return -ENOMEM;
 
 	if (argv[0][0] == '-') {
-		if (argv[0][1] != ':') {
-			ret = -EINVAL;
-			goto out;
-		}
+		if (argv[0][1] != ':')
+			return -EINVAL;
 		event = &argv[0][2];
 	} else {
 		event = strchr(argv[0], ':');
-		if (!event) {
-			ret = -EINVAL;
-			goto out;
-		}
+		if (!event)
+			return -EINVAL;
 		event++;
 	}
 
@@ -101,10 +97,8 @@ int dyn_event_release(const char *raw_command, struct dyn_event_operations *type
 		event = p + 1;
 		*p = '\0';
 	}
-	if (!system && event[0] == '\0') {
-		ret = -EINVAL;
-		goto out;
-	}
+	if (!system && event[0] == '\0')
+		return -EINVAL;
 
 	mutex_lock(&event_mutex);
 	for_each_dyn_event_safe(pos, n) {
@@ -120,8 +114,7 @@ int dyn_event_release(const char *raw_command, struct dyn_event_operations *type
 	}
 	tracing_reset_all_online_cpus();
 	mutex_unlock(&event_mutex);
-out:
-	argv_free(argv);
+
 	return ret;
 }
 

