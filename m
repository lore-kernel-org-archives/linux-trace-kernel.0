Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEF403B71D5;
	Tue, 28 Jul 2026 12:49:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785242993; cv=none; b=LOgRCMoLZgCfSwHTX5FuMWPYPtKoeisuBusEzisZdIaJLuh/uBwT5haCUJNRK+rrLvNdEucI7f8sazIT4sLJsj5h2k+rMpD90e5HizwRwUrOzNOU0nqp+yKv470Oj407nl+p7f3MvngSFFZZ0cKlJYBTUoNuX0LwiCMmuekN4/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785242993; c=relaxed/simple;
	bh=R6pIZr8eoixVU/NWIbffg4yuCxH543+NmUqK8fdKsD0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=g6QY+o0/6/h5rYWgc/ezDVSTR4sfEG6ZaLfF8/RNWy1BFLHCb7ghIhyB2Wn8qRrd7FKIaPeNFR0Er+6a+WaoGqWiWQmdiV0VRIugwz/TxAZO/iOC1P2vHZ3/NS7Sr/juxjXVdD4hhrHiv0SWbWT4Gl6FS3uHSTLwMTe2tfoV3Bg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Bx+4D4MM; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Bx+4D4MM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55BBA1F000E9;
	Tue, 28 Jul 2026 12:49:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785242985;
	bh=mOlGHbnoCnDTPlyrEYMlscDbqYIlu3Es6RPIXVT+hSk=;
	h=From:To:Cc:Subject:Date;
	b=Bx+4D4MMYIwGUqCIaQG3AI/aJ65ae3igimJCL0rg3uXHKDSEg9D568X4bsIdC9VIq
	 7QOhxkax7F9qzCEVjY7OlqILS2aDVkTj6yVesG1Yw+LlHj1Scr6zVRiwsjhMDDD+p6
	 bGZxLhL62sWfLYYrMWRF1gZZJYzgkxVr4pcVwkAvTDgDW5QmpiqSNg3rHWvcSxRdX8
	 q16SHuVev3+CdBHtoUByi0Xf48oIeJp0+pW23kgC+dPUDUnBwh4icgq3fdJkTkAXsg
	 ckEkKcF4AOdAUBFGe2S5R65H9muL8tzUJEFNM7RjVVAziwEJ2GTd/R6zBV5Qo4U7Pi
	 wwgsA6OE2rhLQ==
From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>
Cc: Pekka Paalanen <ppaalanen@gmail.com>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	linux-kernel@vger.kernel.org,
	nouveau@lists.freedesktop.org,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH 0/4] tracing/mmiotrace: Fix some bugs in mmiotrace
Date: Tue, 28 Jul 2026 21:49:41 +0900
Message-ID: <178524298182.56416.7520852015178187644.stgit@devnote2>
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

Here are some patches to fix bugs in mmiotrace. I used Antigravity
to scan the code and found some issues.
The first 2 patches are fixing some kind of timing issues. Other
patches are a kind of cleanups.

Thank you,

---
base-commit: 62cc90241548d5570ee68e01aaba6506964e9811

Masami Hiramatsu (Google) (4):
      tracing/mmiotrace: Reset dropped_count in mmio_reset_data()
      tracing/mmiotrace: Add NULL check for mmio_trace_array in logging functions
      tracing/mmiotrace: Use trace_assign_type() in mmio_print_mark()
      tracing/mmiotrace: Clean up coding style and redundant debug logs


 kernel/trace/trace_mmiotrace.c |   36 +++++++++++++++++++++++-------------
 1 file changed, 23 insertions(+), 13 deletions(-)

--
Masami Hiramatsu (Google) <mhiramat@kernel.org>
