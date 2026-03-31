Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCD8041B37F;
	Tue, 31 Mar 2026 16:32:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774974740; cv=none; b=Fzetb/zKUgYrrt62uHZY4UrO54A1fipRjxFN7gYKmoJXCdh7/dU7GLxdjcHmA/Plr6LT3MN/xkoUKzn6zKEBmNlt9WbCoyO2PP2rkGw9t31KZB/dxS6tXGu/jRDyBzXdob09Iz9ceCMCV3s7GHGA7Rqdqm9MUMdeYHk7i+iksdM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774974740; c=relaxed/simple;
	bh=ChNDJuMEIjBS4vXqgZDNJqV0FHV3rq35gcKCq69tMaU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=F6x5AKbfUYTRsnXxFe/LqG5mgjD4qnhbvu3RUc5Unp+Eqblybj8pwN7H/JMiG9hud0xmhB1MatMDZ7ArVfZ2iGLl5Aa7PbuiNjudI4bmJcPEPmNrMm+RPoWSypiTnKJjt5kDZwo2zZMkQ2a7hCHhuU43DNEKINtCaoVWjJF2V7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WnAvJ9p6; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WnAvJ9p6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C68ADC2BCB3;
	Tue, 31 Mar 2026 16:32:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774974740;
	bh=ChNDJuMEIjBS4vXqgZDNJqV0FHV3rq35gcKCq69tMaU=;
	h=From:To:Cc:Subject:Date:From;
	b=WnAvJ9p6TE2MINHQUdmyWpzEFULWzfCzIf2o/9Q1eOCKVFBgOdn3P0iBjyEVkPknA
	 IUK/N2L1CoLKLvNNo3XuZ0WpyPEVq9RoxJbxC8ktzubEncJ9PjVC+CW/P0d4QIBWF8
	 OBebRkuacgo83QHfNIxk7WKPseyKSaV/6AuT4tgCwXLJSrgyVm1x9eDIzX4SSsl14V
	 yFPjcbkhTqOcJtmoV4SihPbT8C6UqUuqHblloEBNMJexhfe1t8AiXfKtIdRMI0jcEx
	 cIT7ynQ6AM6dzfEaNnC08xfaehzDQsH7/ijQDTMpWE3xsH/FgvLaB0w/Ana1E6z6xh
	 wGcDJo5dOtJIA==
From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH v9 0/3] tracing: Remove backup instance after read all
Date: Wed,  1 Apr 2026 01:32:16 +0900
Message-ID:  <177497473558.569199.6527680985537865638.stgit@mhiramat.tok.corp.google.com>
X-Mailer: git-send-email 2.53.0.1118.gaef5881109-goog
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

Here is the v9 of the series to improve backup instances of
the persistent ring buffer. The previous version is here:

https://lore.kernel.org/all/177071300558.2293046.12057922262682243630.stgit@mhiramat.tok.corp.google.com/

In this version, I removed bugfixes (those are actual fixes/minor
updates) and the force permission check in tracefs
because superuser can modify the permission by itself. Instead,
simply add read-only and FMODE_WRITE check in the related open()
file operations[1/3]. Also, I fixed 2 bugs in autoremove patch
to init dedicated workqueue correctly [2/3].

Series Description
------------------
Since backup instances are a kind of snapshot of the persistent
ring buffer, it should be readonly. And if it is readonly
there is no reason to keep it after reading all data via trace_pipe
because the data has been consumed. But user should be able to remove
the readonly instance by rmdir or truncating `trace` file.

Thus, [1/3] makes backup instances readonly (not able to write any
events, cleanup trace, change buffer size). Also, [2/3] removes the
backup instance after consuming all data via trace_pipe.
With this improvements, even if we makes a backup instance (using
the same amount of memory of the persistent ring buffer), it will
be removed after reading the data automatically.

Thanks,

---

Masami Hiramatsu (Google) (3):
      tracing: Make the backup instance non-reusable
      tracing: Remove the backup instance automatically after read
      tracing/Documentation: Add a section about backup instance


 Documentation/trace/debugging.rst |   19 ++++
 kernel/trace/trace.c              |  166 +++++++++++++++++++++++++++++--------
 kernel/trace/trace.h              |   13 +++
 kernel/trace/trace_boot.c         |    5 +
 kernel/trace/trace_events.c       |   76 ++++++++++-------
 5 files changed, 208 insertions(+), 71 deletions(-)

--
Masami Hiramatsu (Google) <mhiramat@kernel.org>
