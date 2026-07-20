Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0A6A38B14B;
	Mon, 20 Jul 2026 10:12:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784542335; cv=none; b=XUK0LwznY+LNcrwYLATZpl45lrfe+yFV5d4FwRMA5yHl0K4p1Sivj5nZtwY4G5CG+nCSgoi74gxbbhkS52tt6EqaQPTLcJuBaYUdoH4r+VvL4OdZXoFqd21KoFIPM2HZuKWKhFWPQ/YWSzJbP38yh3zxlTwjXpv4XEkXNezONMQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784542335; c=relaxed/simple;
	bh=/eL2YXFkjNqzUlmWxJ/bajJvUj+zawhqzQLYdRvtjm0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=GksMdCmvdk3gjCNXtsUbw/mgqn6dm3wxuTVe97lxwYSA4GFfFUYPdb3TvtuzkrjDrc3m+MUFqh6SI2T6H+/NpRKRRA1IMI48R/hKM14MqbyL4DknZOH+DnEG9UiGV9y19CK9pP+KnwATfKfvY1Mby6iBKtH6T+sCYrQ5lS/14p0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KZQ7TDeY; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KZQ7TDeY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 335CB1F000E9;
	Mon, 20 Jul 2026 10:12:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784542324;
	bh=vyCXIYkkHkc6+Z33jcG48DE90TTNW5NvNB5qgtu3Xd8=;
	h=From:To:Cc:Subject:Date;
	b=KZQ7TDeY7BJKqKLp1RdFAFELAGidWLll3ITqFh7RjeL6JFIbu9e29Y5Ies01eTHqc
	 /StHenggd9GOhL2K3ygobRT8p/JCxLFsQ+OkzqVgQcnNHNuw7kvP+manJs7w8X7zfV
	 0p/IvV8jzJ8/i1RyOKQcgpmxYLxYRkH8uAnpyHpeqPKlPAjf/5srYgwsSOJv/wTjbg
	 iEi60uRhuHTLkrOhOSJUIu6xdluhgMKfr2gcXvW8fnnT3gsFde3cjB0yOXkshNkZL+
	 qgmQ5F38k67y7Sds/SN1Zf/6wgF3ztLUBqMbFwmjrmEohU9vXurmhTQsjBMXJQuVon
	 Pv7MpoXuAkWnA==
From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH 0/4] tracing/probes: Fixes several bugs
Date: Mon, 20 Jul 2026 19:12:00 +0900
Message-ID: <178454232006.290363.11301475407231432622.stgit@devnote2>
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

Here are a patches to fix some bugs in the probe events and eprobe.
These are found during cleaning up the code. I made these as a split
series because those could be backported. Let me send another
series for cleaning up probe event code.

Thank you,

---

Masami Hiramatsu (Google) (4):
      tracing/probes: Avoid temporary buffer truncation in trace_probe_match_command_args()
      tracing/probes: Prevent out-of-bounds write in __trace_probe_log_err()
      tracing/probes: Fix potential underflow in LEN_OR_ZERO macro
      tracing/eprobe: Fix exact system name matching in eprobe_dyn_event_match()


 kernel/trace/trace_eprobe.c |    3 ++-
 kernel/trace/trace_probe.c  |   13 +++++++------
 2 files changed, 9 insertions(+), 7 deletions(-)

--
Masami Hiramatsu (Google) <mhiramat@kernel.org>
