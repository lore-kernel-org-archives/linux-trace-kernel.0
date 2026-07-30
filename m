Received: from out-178.mta0.migadu.com (out-178.mta0.migadu.com [91.218.175.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8416443E20
	for <linux-trace-kernel@vger.kernel.org>; Thu, 30 Jul 2026 15:05:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785423903; cv=none; b=W4eesvAL8KF8hNmvam3ox4doev7jF2UYvH6RZyY4a1YCrmqyVDOqpPrLtVFNOE9aDCAb1oHGo0If0jUf2VHrgXDXI/OKKDJ9ek3jR/hiHxRqPkNhrXxz/P9W7U4l9pMIXnP6iPCvKOZx6+R1pwIXwmNzsKQ4+wE9j+b8WtHNs5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785423903; c=relaxed/simple;
	bh=nlnEHFDXX/dP1HqALY5VFwo8vRof/49zcm5xHFGIqa0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=XXOPnENt9gmsRYWCXkHHN/LDXRLYj2U0+mTHRh8vnwLnML7T4EeO/X9d1YDVa21SE0sNGuTdkAXU9WQ8zq8nEG51KpVP84P21BPGU5XxZAfnnDgrzb31CzguLqz+VIoyFPUIAtlbcU2hx9uOxgpyrgFaWIoLnKLjIFSNnHhs4/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=l51MrxD/; arc=none smtp.client-ip=91.218.175.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="l51MrxD/"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1785423889;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=MwGTwILnTz3X5A8tudff7bUBj8GGfCDV0msq65uOzW8=;
	b=l51MrxD/nRCjqEiI0aa5c16zF8imvGF48vJE4L7ujvP8+NhJHoab0r4/LyeCHO/uiwN/YE
	AVtJhipySCeR1SUPa2NF/9ogxXQ4GNSs5K1L3XyQbuqnqyUojzgU0YMe0auKu7S4QioM5A
	JReSMIchTvXfH/idQAm3VLM8DnjhknA=
From: Leon Hwang <leon.hwang@linux.dev>
To: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	Leon Hwang <leon.hwang@linux.dev>
Subject: [PATCH 0/4] ftrace: Protect RCU accesses to direct_functions
Date: Thu, 30 Jul 2026 23:04:07 +0800
Message-ID: <20260730150411.88667-1-leon.hwang@linux.dev>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Sashiko reported a potential issue of directly accessing
direct_functions [1], which will be addressed by patch #1.

The patch #2 and #3 protect accesses to the RCU-managed direct_functions
hash in its delete, and modify paths.

The final patch removes an unnecessary empty argument from a
scoped_guard() invocation.

[1] https://lore.kernel.org/all/20260727145217.72B9C1F000E9@smtp.kernel.org/

Leon Hwang (4):
  ftrace: Protect direct_functions in ftrace_find_rec_direct
  ftrace: Protect direct_functions in update_ftrace_direct_del
  ftrace: Protect direct_functions in update_ftrace_direct_mod
  ftrace: Drop extra comma in trace_buffered_event_enable

 kernel/trace/ftrace.c | 27 ++++++++++++++++++---------
 kernel/trace/trace.c  |  2 +-
 2 files changed, 19 insertions(+), 10 deletions(-)

-- 
2.55.0

