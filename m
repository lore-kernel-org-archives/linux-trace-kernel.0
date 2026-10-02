Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B0B022D4DC;
	Fri,  2 Oct 2026 14:02:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790949738; cv=none; b=naCLLT6/F8SDsRLLG0jfPVTCrnVRKHIVl+nxl6/s6557NEElGzdCX4s7fWlyxzzCQ/0Djx1EVS5b4hEdy2wXjDdVdqaTXgWwlzP7hwTvl9PGprDkZuzr1tWREBAT7L4XTBcuFfKLjZIJaRvQhL9CqjbQezFd8e0mYHZeHjvtOKs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790949738; c=relaxed/simple;
	bh=AC554Ou05N1hw/cT7duBqRDHOUr+JTWVpBTr2ggZFqM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=cErTCQDPaHrNzVwh8R1nVco3NWEaGrGlv62CtsdEq+9H9IWruyt1jH/h1Zu6SUtkQtQGeH5gSbFV2O4WySbjWdzuZUyS35JoJtRL0Csn1Ug38LtTC9pWBKKXKEjA6dEhJ64dlt2E13OAAIlXoi3cs7+Gp/RicdlBPPPXfpzNkvI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CIXGYEjh; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CIXGYEjh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18A311F000FF;
	Fri,  2 Oct 2026 14:02:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790949737;
	bh=iSSvV6DoYFNrgcl/md3k3IV9ZcypTzps793/msz7EC0=;
	h=From:To:Cc:Subject:Date;
	b=CIXGYEjhAPg4K6ZFaCcuCpDRnpGmyQDfYG3D7MoizYCpc4PDEOjcFq4AAdpd/ZDv2
	 LTiLih2IhlEp96xE6vwAQLh7SmCAAEDpiz5+QtwM9ZL4cn9LQaI+WeP9Wm1rDt2xzZ
	 ORu2b2lGtSy7VkixIKT9PBMg2BSfjXjoCSJffHk7Bct7mmOIUZJUL5mHVLDxbNb8h+
	 Lh61cQxsJjuXP5J5XTYxBf4qxtD0TctNN8+Dz7mqPPCdHiZalufzI7IPKzU8gP8IM+
	 iW57VOLzkZ0Q0tldBEzTFBz2X/rYPJudaCTV8lzWVwl/VgMXA1rJAhr74VToXHzW8i
	 ZRVXFb38kW1hQ==
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
Subject: [PATCH v3 0/2] tracing: Override trace_instance parameter
Date: Fri,  2 Oct 2026 23:02:11 +0900
Message-ID: <179094973121.609715.2103310055830923648.stgit@devnote2>
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

Here is the 3rd version of the patches to change the "trace_instance="
kernel parameter to be overridden by later parameters.
The previous version is here:

 https://lore.kernel.org/all/179091984881.537422.15308457677039592540.stgit@devnote2/

This version fixes some issues pointed by Sashiko and add more selftests.
(the selftest is optional.)

Currently if the user specifies the same name trace_instance at
boot time, the later one is skipped.
However, this does not allow user to override the trace_instance
setting via bootloader if user specifies the default trace_instance
in the bootconfig, because the bootconfig parameter is prepended to
the kernel cmdline. (IOW, the bootconfig expects kernel parameters
follow a LAST_WIN policy.)

To fix this issue, [01/02] splits the command line parsing loop
and trace instance initialization loop. The parser checks the
overlap of the trace instance name and overrides with the later one
if those have the same name.

This series also includes a test set as [02/02], which is based on
the ftrace boottime test patchset [1], currently on probes/core.

Detailed changes are here:

Changes in v3:
 [01/02]
  - Count the number of instances in enable_instances().
  - Check whether source instance exists before the backup instance.
  - Fix memmap_area leaking across loop iterations.
  - Add array index range check for boot_instances array.
 [02/02]
  - Add test cases for overriding memory-mapped instances (@trace).
  - Add test cases for overriding backup instances (=source).
  - Add test cases for multiple tabs and empty strings.

[1] https://lore.kernel.org/all/178649540853.438282.4271870161169100680.stgit@devnote2/

Thank you,

---
base-commit: b15df7805dc52555e7c867d33a496edf5be11289

Masami Hiramatsu (Google) (2):
      tracing: Override the same name trace_instance= by latter one
      selftests/ftrace: Add test case for overriding trace_instance parameter


 Documentation/admin-guide/kernel-parameters.txt    |    7 +
 Documentation/trace/debugging.rst                  |   15 ++
 kernel/trace/trace.c                               |  150 +++++++++++++++-----
 .../cmdline-07-trace-instance-override.bconf       |    4 +
 .../cmdline-07-trace-instance-override.cmdline     |    1 
 .../selftests/ftrace/boottime/run_boottime_test.sh |    2 
 .../tests/cmdline-07-trace-instance-override.sh    |  148 ++++++++++++++++++++
 7 files changed, 290 insertions(+), 37 deletions(-)
 create mode 100644 tools/testing/selftests/ftrace/boottime/bootconfigs/cmdline-07-trace-instance-override.bconf
 create mode 100644 tools/testing/selftests/ftrace/boottime/cmdlines/cmdline-07-trace-instance-override.cmdline
 create mode 100755 tools/testing/selftests/ftrace/boottime/tests/cmdline-07-trace-instance-override.sh

--
Masami Hiramatsu (Google) <mhiramat@kernel.org>
