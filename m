Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F4322EACF6;
	Wed, 13 Aug 2025 14:29:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755095381; cv=none; b=BSAaHR8s9MtYYiTN5F9eYWaikSqlknCtEBgI4XX4yqPmlD/b56LqkOkRTdRYmgEqMgZ1UcRt0eQ9+6tcrEK6JSHz2M4Fu5ULUhuV7etLfNKaEYV09Gg6kYIrzvegSQHp/Ed0TjfZPHAHeL58n19xdDKYwEFpu1S3Df1Sx5pBo9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755095381; c=relaxed/simple;
	bh=91ib6ueUUcjF+u7S7t19Lnu1M8A+TBlf4lrJkxpykjs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=myN0CXyoHmiuhKfTBtmxaVMTITUmAhK6STT8iewL797Nd0E74n3FzwC+xfHWxZ3DMiqFQDYyFjnHZB9phQfifvtGdKO6/XebMD58OaxEPhAIrLOjFku8RWRa4Ld0/4WJK7eWhXKSUWeIMic6k7kQKQ3z9CiEx5INt3BvGhx25ek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W2/EQy+3; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W2/EQy+3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51162C4CEEB;
	Wed, 13 Aug 2025 14:29:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755095380;
	bh=91ib6ueUUcjF+u7S7t19Lnu1M8A+TBlf4lrJkxpykjs=;
	h=From:To:Cc:Subject:Date:From;
	b=W2/EQy+3xfh3bkZEsbOFVqGZMHZiD7eCF1n531ZFwZjZy6lSgnx3vXje7b44clKie
	 hJqPtKEmi1r0Vdu4EwUrfYJBgt5DARbY8/rE3JxAP1LOHBSa0Pnu8NrGWt0nPOQeZG
	 NqAV21/lMqvAwrK4B5GMqkAIMJisjOMys+hxUhO4Siz65uwVq8pNY+jZp2gHLqGMPx
	 EftqPfuAWkPgrZ8u3SKDSkFtPT8MWvZfiic1sLpwunB4vbgFVyfWYcWSMmczA9P+sl
	 8eVoqqSJp1u5nptv1d8DDOuv4Tyv5Fwu7qmIhjzn6YWtnYH9vn5jqIH6nBJu51q+Te
	 XkkuJlPJ0HAHw==
From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH 0/4] tracing: Cleanup uprobe/eprobe events
Date: Wed, 13 Aug 2025 23:29:36 +0900
Message-ID: <175509537667.193596.9139462012987606126.stgit@devnote2>
X-Mailer: git-send-email 2.43.0
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

This series is just for cleanup ugly gotos in uprobe/eprobe events
using __free(). Also, this allocates the traceprobe_parse_context
outside of the argument parsing loop for efficiency.

Thank you,

---

Masami Hiramatsu (Google) (4):
      tracing: probes: Use __free() for trace_probe_log
      tracing: eprobe: Cleanup eprobe event using __free()
      tracing: uprobes: Cleanup __trace_uprobe_create() with __free()
      tracing: uprobe: eprobes: Allocate traceprobe_parse_context per probe


 kernel/trace/trace_eprobe.c |  108 ++++++++++++++++++-------------------------
 kernel/trace/trace_probe.c  |    3 +
 kernel/trace/trace_probe.h  |    4 +-
 kernel/trace/trace_uprobe.c |   82 +++++++++++++--------------------
 4 files changed, 81 insertions(+), 116 deletions(-)

--
Masami Hiramatsu (Google) <mhiramat@kernel.org>
