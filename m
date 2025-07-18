Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34EA9221F04;
	Fri, 18 Jul 2025 11:34:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752838443; cv=none; b=h4pm1mAQUoomABLY6AFxfW9YvV7WByczcNX+aSHyVsG1h5X4JMAfkQ238GQWsBWO3MYcHpYYATFbzyKk0+HZIkZGxnF9kCqIyMoBr+BM4XZjwWcT1IR247zOIBDuIE43rkNkS4qXItERcb0Lk+E95eskLdlKb1WKkPHznYtwlV4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752838443; c=relaxed/simple;
	bh=boqzQKn0ZqaignEmEkb4dvZ1Eebu9Sj8pshbaOChEYE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=b5yhA5YrBdludaCHsouaVS1g9ZkPqq2DrkWBG54ROlqnT6rNNYiRFvs7Ibh3woJ6Acp6z4+HUVvjS8+kHNkjA1gF9LEmyJbolt9Hf+Qto6xsjlZHrP/5SMbqgjjxTYYvsQ07ggmjsAK/xGVoxfVbOjJJKO8Lcj1CldqAzzxeic8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BiCvAMDw; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BiCvAMDw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3DFE9C4CEEB;
	Fri, 18 Jul 2025 11:34:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752838442;
	bh=boqzQKn0ZqaignEmEkb4dvZ1Eebu9Sj8pshbaOChEYE=;
	h=From:To:Cc:Subject:Date:From;
	b=BiCvAMDw8gJt6iK+hc2o2I6o3SKTHpMhDN1pgKY6OL4wBc8EJ+oxFHEAkeVUBQDQ5
	 ivUynDc1U+kwOK80dRLxrycp1tDvZpMyLMfDwDxUp5RhF5G1NCkI9MFtZVYywL3PiU
	 I1oCQ2bqqdIgnAj0dyAGgzg5b1NwkrorawjswE3pepEk2R5xiSMwqsclZX1XZeFQB+
	 w3V7MGTlrijOz9MIOAMK1ofSMR2cneeIeG2kXKygqvSPBmyTj+M6p31X36kFckqFtY
	 tExWJ4z08o7o6Yg4PQ2qhM4/v0ojELCeey/y1Egx+d9D2Zr+OznZseWEuDTDxU0NSQ
	 U1+t11gjzHXEA==
From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH 0/5] tracing: probes: Use heap instead of stack for temporary buffers
Date: Fri, 18 Jul 2025 20:33:58 +0900
Message-ID: <175283843771.343578.8524137568048302760.stgit@devnote2>
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

Here is a series of cleanup patches which allocate temporary buffers
and objects on heap (slab) instead of the stack. This reduces a
possibility of stack overflow. This may reduce the performance but
the modified path is not a hot path.

---

Masami Hiramatsu (Google) (5):
      tracing: probe: Allocate traceprobe_parse_context from heap
      tracing: fprobe-event: Allocate string buffers from heap
      tracing: kprobe-event: Allocate string buffers from heap
      tracing: eprobe-event: Allocate string buffers from heap
      tracing: uprobe-event: Allocate string buffers from heap


 kernel/trace/trace_eprobe.c |   38 +++++++++++++++++++++++--------
 kernel/trace/trace_fprobe.c |   52 ++++++++++++++++++++++++++++---------------
 kernel/trace/trace_kprobe.c |   49 ++++++++++++++++++++++++++---------------
 kernel/trace/trace_probe.h  |    9 +++++++
 kernel/trace/trace_uprobe.c |   37 ++++++++++++++++++++++---------
 5 files changed, 129 insertions(+), 56 deletions(-)

--
Masami Hiramatsu (Google) <mhiramat@kernel.org>
