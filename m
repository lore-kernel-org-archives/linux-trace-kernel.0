Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 014D32D7DC6;
	Sat, 19 Sep 2026 14:38:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789828703; cv=none; b=PjuXzUq/YHSaIIXMegpc8azZL6mc001xhXFsN5K3AU8+DZ64qS+NNSOcIFVybqWKezLW/aVpGM+bun5Hp+T3Th0oa78MBtGSfLQBYOPw1elY7sDgiua/rAIY7TgkwF3lKWDxfF1k2kA8YeTM3MtUk1asI1R0t4HyUY1fIJdtIcA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789828703; c=relaxed/simple;
	bh=ZG/lbqdTzFGaQFxKi4UzQSfafZtlh1LxnqaiYUObSFA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=diWqH153o87iBYMJJt7BMUT/VLc83wOT9ixBSclUT4Q/7dphAR4nZfc47yzytbBhh856JvoEuz2KQLOqQbV58qNbtIjo/DPPwS+CLO7EQIrVlwgUwQRv7SLarW8pBqhZTaELu6NAcoFHnmNx6pRWvne3/vDOa5XncP8ClEL51SY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=heTMxLEe; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="heTMxLEe"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C26C1F000FF;
	Sat, 19 Sep 2026 14:38:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789828701;
	bh=Ye5WbKjKFgkqarhBNRF073Cdbb5tflcWG8IEwR1LEuk=;
	h=From:To:Cc:Subject:Date;
	b=heTMxLEeMBgy0w7Wxjh+VA34+suUXXAMK1aIMFooksiCr0ru0Z6Ait3WeidESrT23
	 1UmvPqBKhvt7LwqRvsMA1DqJtJ53DsmmXsVABZNjQz9lkz3FTN5lg8q5XY1+TiwAiU
	 Qz59ugb/oOKRQ65QG10XzypTM7k/iMNnwsmVmSb15sqWvQ64trs7IJA7J/kE9T1JQx
	 D2+nVNEMiGFGMvMRRg7nK24zeMHsQL2uuTc2GseSNvY2JiN7zQ9c4ZksSPCiP4KVNF
	 NdX+U9xWLuNNz/psGU0z2nJRDzrshoZPeJmSEChw/e6VXSOoGQyrZfoc6wkT6XKFvy
	 WryK7B15Eitvw==
From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To: Jonathan Corbet <corbet@lwn.net>,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Shuah Khan <shuah@kernel.org>
Cc: Shuah Khan <skhan@linuxfoundation.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH 0/2] tracing: Override trace_instance parameter
Date: Sat, 19 Sep 2026 23:38:16 +0900
Message-ID: <178982869661.289221.2143320719673148321.stgit@devnote2>
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

This changes the trace_instance= kernel parameter to be overriden
by latter parameters. Currently if the user specifies the same
name trace_instance at boot time, the later one is skipped.
However, this does not allow user to override the trace_instance
setting via bootloader if user specifies the default trace_instance
in the bootconfig, because the bootconfig parameter is prepend to
the kernel cmdline. (IOW, the bootconfig expects kernel parameters
are LAST_WIN policy.)

To fix this issue, the [1/2] splits the command line parsing loop
and trace instance initialization loop. The parser checks the
overlap of the trace instance name and override by the later one
if those have the same name.

This series also have a test set as [2/2], which is based on
ftrace boottime test patchset [1], which is currently on
probes/core branch.

(Steve, can you review the boottime test series too? I think we
should have this kind of test anyway, and is nicer to have one in
the kernel tree.)

[1] https://lore.kernel.org/all/178649540853.438282.4271870161169100680.stgit@devnote2/

Thank you,

---

Masami Hiramatsu (Google) (2):
      tracing: Override the same name trace_instance= by latter one
      selftests/ftrace: Add test case for overriding trace_instance parameter


 Documentation/admin-guide/kernel-parameters.txt    |    7 +
 Documentation/trace/debugging.rst                  |   15 ++
 kernel/trace/trace.c                               |  127 +++++++++++++++-----
 .../cmdline-07-trace-instance-override.bconf       |    2 
 .../cmdline-07-trace-instance-override.cmdline     |    1 
 .../tests/cmdline-07-trace-instance-override.sh    |   56 +++++++++
 6 files changed, 174 insertions(+), 34 deletions(-)
 create mode 100644 tools/testing/selftests/ftrace/boottime/bootconfigs/cmdline-07-trace-instance-override.bconf
 create mode 100644 tools/testing/selftests/ftrace/boottime/cmdlines/cmdline-07-trace-instance-override.cmdline
 create mode 100644 tools/testing/selftests/ftrace/boottime/tests/cmdline-07-trace-instance-override.sh

--
Masami Hiramatsu (Google) <mhiramat@kernel.org>
