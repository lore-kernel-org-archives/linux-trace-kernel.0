Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFDFD3A7839;
	Fri,  2 Oct 2026 05:44:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790919854; cv=none; b=hdYuG6lwB4ZSaU1PvqwCcvJDnKvp+kT6pThRa/SsFzCIqrtRjOmzIdjFXaeXNDSeMo8a+HxfXPLY/GgXmr9GMwKFQaAO2pUfjdnK1aY9O7d3D6x6G/6cOiABYSnA4LRYNpGhYGbzniLjlsw9ybWOgFDthFWLN7xm7ZhvGUpMlhY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790919854; c=relaxed/simple;
	bh=ZBgpqZPWpticOMwSYeR4OAjdNddV7/FnkRDPOGXVpC0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=KCfuBH+fQygaQz6+pWMWq8GnZvBNB//TZb2dL+lWguCePq4kZh1mvEL4TiROjoyX2uXOjDVhzXBSWV2NVEilX+of/0OPeqAD33UXcpXv6gB5ylOdg3go1dbG1BLbIO3saZBtvkDS3ZeVqulBXcoG3923kmuVOB2g44S0AVp1ftA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=emopOcoM; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="emopOcoM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 455171F000FF;
	Fri,  2 Oct 2026 05:44:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790919853;
	bh=90a4gwunhvf6bS+CcpBuX/hrPKVeCYIVX5w940XA6vs=;
	h=From:To:Cc:Subject:Date;
	b=emopOcoMCwan7ZmQkjl8j1uktbRXSz0vbD2Q3jl0vZJ6BQ1lrBueWnq3250eionJZ
	 9tgbS3TGemDo0l70By3hYB6iDSYo4dSXV/Eo88sEsBQXkChpwyoTUk0tvHDPbAsLJr
	 Gl5hw6qCdhdlLm1WDt7oJVfcHDIPjrYo0xvSE4SWGO24ULIN9TjnZaLvscsLigqxpv
	 TTzfSPBl/4nQV7FeuQ1/fR3cBgqFyC9pOHUsfgCXjJtncP4SedfkcFN3DKij1BFLdD
	 KdZUKp0avoIyrs9g+RgMi4KjbObF5fe0uLQao7lkASjqPRYpa5x0Hb+n2Vv/9UgC8X
	 0fwauQxnQg5vA==
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
Subject: [PATCH v2 0/2] tracing: Override trace_instance parameter
Date: Fri,  2 Oct 2026 14:44:08 +0900
Message-ID: <179091984881.537422.15308457677039592540.stgit@devnote2>
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

Here is the 2nd version of the patches to change the "trace_instance="
kernel parameter to be overriden by latter parameters.
The previous version is here:

 https://lore.kernel.org/all/178982869661.289221.2143320719673148321.stgit@devnote2/

In this version, I just rebased it on probes/core. 

Currently if the user specifies the same name trace_instance at
boot time, the later one is skipped.
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

[1] https://lore.kernel.org/all/178649540853.438282.4271870161169100680.stgit@devnote2/

Thank you,

---
base-commit: b15df7805dc52555e7c867d33a496edf5be11289

Masami Hiramatsu (Google) (2):
      tracing: Override the same name trace_instance= by latter one
      selftests/ftrace: Add test case for overriding trace_instance parameter


 Documentation/admin-guide/kernel-parameters.txt    |    7 +
 Documentation/trace/debugging.rst                  |   15 ++
 kernel/trace/trace.c                               |  130 ++++++++++++++------
 .../cmdline-07-trace-instance-override.bconf       |    2 
 .../cmdline-07-trace-instance-override.cmdline     |    1 
 .../tests/cmdline-07-trace-instance-override.sh    |   56 +++++++++
 6 files changed, 173 insertions(+), 38 deletions(-)
 create mode 100644 tools/testing/selftests/ftrace/boottime/bootconfigs/cmdline-07-trace-instance-override.bconf
 create mode 100644 tools/testing/selftests/ftrace/boottime/cmdlines/cmdline-07-trace-instance-override.cmdline
 create mode 100644 tools/testing/selftests/ftrace/boottime/tests/cmdline-07-trace-instance-override.sh

--
Masami Hiramatsu (Google) <mhiramat@kernel.org>
