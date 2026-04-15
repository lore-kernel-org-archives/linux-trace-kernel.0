Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 175971A8F84;
	Wed, 15 Apr 2026 10:08:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776247717; cv=none; b=e4VwHI2D4aD6dt7oNwKTWY31qjNimAXB5FCH+uetgyn6LbGxgZEJDt8w7/sMFGPpCzUYBYCOXk8FODhHJw4jNQ/2l9wBz2vn3/0lyau9QxNDVHPMLghlzObOyn9aAeWzsYDjQrfpfEKNg1obCkEYkIbUeC68PZO+i9ed/rjtuG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776247717; c=relaxed/simple;
	bh=pSqjqcHgt54UQS9FjHangF7VpZ9ARoqCKZUWjireVvY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=MhXNLppcivaTHU/EguxS+DTWWygDC5nd46G+fIiv7N3Fip8APbCnY6yjthBTIe7h4x9BXW25DXdUIUfbf9+14d2THj/c1HABjxYjTlG6CLSwIwH8TfXcPt4WZmNHv1Dt7sQeN3sgJ4WEWdf7qAcRung/6f0WEMI71oKOHwZGlJ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h5U8jQE5; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h5U8jQE5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CDC68C19424;
	Wed, 15 Apr 2026 10:08:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776247716;
	bh=pSqjqcHgt54UQS9FjHangF7VpZ9ARoqCKZUWjireVvY=;
	h=From:To:Cc:Subject:Date:From;
	b=h5U8jQE5goDKcf+yk0M5b37xXaSj+3GnbgVVABPVGqvCz5qdf8sZLgCNvABZzvauS
	 BHnALrdJxUeHXs4e9nvLLepSpLjxPavA0qfxQRWos9IxdualNVCVek3fVR6HPtiUtw
	 8s7dRC49ZdV8FAIOP9CN3HeKJnGbQsgLiFsmxtEsE06EEnxsRrPg3VCicxlCVlkKG/
	 zaTnTsuc1itlPMrqgBszXZpKBQl+HKt86i1CNtiyHlnderPWaGjDtcQy+hZDdqQU+v
	 atpf65e9cYBUuFboFmsNu8OtyCjDWBG1Ut1LXTxEsAgB4d0PdDirGQQF4OiKs4Y8E0
	 kpyousEJAltdg==
From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>
Cc: Menglong Dong <menglong8.dong@gmail.com>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	jiang.biao@linux.dev,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH v7 0/6] tracing/fprobe: Fix fprobe_ip_table related bugs
Date: Wed, 15 Apr 2026 19:08:32 +0900
Message-ID:  <177624771150.2407691.15764846647014540969.stgit@mhiramat.tok.corp.google.com>
X-Mailer: git-send-email 2.54.0.rc1.513.gad8abe7a5a-goog
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

Here is the 7th version of fprobe bugfix series.
The previous version is here.

https://lore.kernel.org/all/177615807787.1165997.921227352050738693.stgit@mhiramat.tok.corp.google.com/

In this version, I added yet another bugfixes (again) for make
unregister_fprobe() more robust for memory pressure [2/6]. And
remove uneeded RCU sync [3/6]. And split checking whether ftrace_ops
is registered from the number of registered fprobes, because
ftrace_ops can be unregistered in module unloading[6/6].

Thank you!

Masami Hiramatsu (Google) (6):
      tracing/fprobe: Reject registration of a registered fprobe before init
      tracing/fprobe: Unregister fprobe even if memory allocation fails
      tracing/fprobe: Remove fprobe from hash in failure path
      tracing/fprobe: Avoid kcalloc() in rcu_read_lock section
      tracing/fprobe: Check the same type fprobe on table as the unregistered one
      tracing/fprobe: Fix to unregister ftrace_ops if it is empty on module unloading


 kernel/trace/fprobe.c |  480 +++++++++++++++++++++++++++++++++----------------
 1 file changed, 323 insertions(+), 157 deletions(-)


base-commit: 4346be6577aaa04586167402ae87bbdbe32484a4
--
Masami Hiramatsu (Google) <mhiramat@kernel.org>
