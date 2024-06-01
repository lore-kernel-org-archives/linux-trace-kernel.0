Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A460ED8;
	Sat,  1 Jun 2024 08:22:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717230152; cv=none; b=tIoMIGrRTbJUXsvF4HWSVH+4wZFgt6d/ioeNgpIjYXm2EaIngoCZKVVtu+7f78eAv34RlA24cRmiRw0kp1LcwIyH1x32CKjPYmDuhmb7qhSU6YirIKUd9yVt2Q5d7f6bmGjCiPKwXQTM02orjSvHNojGvifDrVxxk1QGjdR6i9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717230152; c=relaxed/simple;
	bh=3Zpc4KSP5zsEw/HCmL80exkin2LGyBPvPU49ttgtTa4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=tj+qlNTQ3m7Gb5YMt5ZvngdS3CfzypAjJbEw1ljYiCAM6qpdu1Vt7RROIqtcyfVl1phVVIfYpUQMU1j5vSTh6nReRb37XQ7dlRH2Tx/KZrOgeRo+APihWkIT6OjPeMh85/YqVZAdcAKEybr2s8oZRDl0It5HIyrmmo8nil0J8CM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ROMsGFrO; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ROMsGFrO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3FBC3C116B1;
	Sat,  1 Jun 2024 08:22:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717230151;
	bh=3Zpc4KSP5zsEw/HCmL80exkin2LGyBPvPU49ttgtTa4=;
	h=From:To:Cc:Subject:Date:From;
	b=ROMsGFrOR2xkXoHgdDker2uIz62Gbt3bioZfPtfC8AeDfc3L+dAZjwjOXlt1/waLU
	 ReSRefbxruGG9cZvOPVYLM37BCMS0fensfPQMoDiLRnVsAnDkMLFPCY51B6chm5lkr
	 cloXaFxjzK1vtazczCt3S1qRbfZr9kieUvBw7aqSznWfTdnGCZqCZhvB5YGR1u2Z91
	 Nec3fA7vb3YiiwZ7EpF/4pbYFvEzgBIRRPRQWxAQ9kbFaBC0Kia6+rq9S1LygLAaZJ
	 B2ux1bkkp0evT3vV4eyb5IH33cSm2U0NDtjC/7RQB90vKddBUsanuDLzXhYueN3hZE
	 JL0YYgJBwVzJQ==
From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	don <zds100@gmail.com>,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	mhiramat@kernel.org
Subject: [PATCH v2 0/3] tracing/probes: Support tracepoint events on modules
Date: Sat,  1 Jun 2024 17:22:27 +0900
Message-Id: <171723014778.258703.6731294779199848686.stgit@devnote2>
X-Mailer: git-send-email 2.34.1
User-Agent: StGit/0.19
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

Hi,

This series implements the tracepoint events on modules.
This version separates a patch for tracepoint subsystem from
fprobe-event patch, and adds a selftests for tracepoint
events on modules.

Thank you,

---

Masami Hiramatsu (Google) (3):
      tracepoint: Support iterating over tracepoints on modules
      tracing/fprobe: Support raw tracepoint events on modules
      sefltests/tracing: Add a test for tracepoint events on modules


 include/linux/tracepoint.h                         |    7 +++
 kernel/trace/trace_fprobe.c                        |   46 +++++++++++++++++---
 kernel/tracepoint.c                                |   16 +++++++
 tools/testing/selftests/ftrace/config              |    1 
 .../test.d/dynevent/add_remove_tprobe_module.tc    |   34 +++++++++++++++
 5 files changed, 96 insertions(+), 8 deletions(-)
 create mode 100644 tools/testing/selftests/ftrace/test.d/dynevent/add_remove_tprobe_module.tc

--
Masami Hiramatsu (Google) <mhiramat@kernel.org>
