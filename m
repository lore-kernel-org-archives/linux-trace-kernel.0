Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B55AC79D0;
	Fri, 17 May 2024 08:41:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715935298; cv=none; b=AIYrHwm/WDzBsKqemYNCOpxwAeireE5sKoTYuetpIGww6W9Tyv90mTJ4D99t/I4EfHpSaNgoDbjKtR5s7q7eBGUw08cLKjQ3Bo166eIKUvHT4LtVcg5zQ2jDDauQpkcgL+QxLPxuSduQ7z35RbfNrnbC9HR8zXYkWPoblYms9sc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715935298; c=relaxed/simple;
	bh=QQ3c2De9LdGOsrV81+Fe8hIhsFloyY7P510SOaBJWno=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=a8+oA8FL1qBrc38pJk1lIYws1wflVqXmqsWL8QuDX9dEwxZzcFONN5jgd+jF3LtvAGtK5DP6/kwVAnWVL8vMUjOBEcSSCHyWl+W9g/SOXDh4gIgKZl5KJ5myzfveSB08paDAI7VocUHphh1fYKeXYagP4oPoMb++t+jngkS3wwU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MCeUhlDo; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MCeUhlDo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4C10C2BD10;
	Fri, 17 May 2024 08:41:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715935298;
	bh=QQ3c2De9LdGOsrV81+Fe8hIhsFloyY7P510SOaBJWno=;
	h=From:To:Cc:Subject:Date:From;
	b=MCeUhlDoBp4cVyVbI3cYb/uFYqZA8viX6hvRq5mcFmxikRXVoDqXjMnBxhs3p+9tr
	 oay74FH/givEjb8kvLv83rNqFhwK2/d8jGUtnRL6Tu9SdyMLQ1nrRYrYc5ecz7Wdyp
	 9IAw9RBxch5c7oia0Wwqq+L6D1Rwcx+HWzTMtOZIkwiRRTn7ST/s3mbt+RY8Srdvlw
	 EvlxXg6ytoConPLi7KTHasVEb0g6CInc1b1SLAmcd4sBBUHS/JveVg16CIpqHnJz9I
	 VbJV8DXLXDTWkDg1kKWYtmoeThI1R2qMjmwZPUxpcKBqPc5dLShhJuK/TzmT471SYq
	 jA5vHlhpzADQQ==
From: Daniel Bristot de Oliveira <bristot@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Daniel Bristot de Oliveira <bristot@kernel.org>,
	John Kacur <jkacur@redhat.com>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: [GIT PULL] tracing/tools: Updates for 6.10
Date: Fri, 17 May 2024 10:41:26 +0200
Message-ID: <20240517084128.173825-1-bristot@kernel.org>
X-Mailer: git-send-email 2.45.0
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Steven,

RTLA:
	Specific for timerlat:

	- Improves the output of timerlat top by adding a missing \n,
	  and by avoiding printing color-formatting characters where
	  they are translated to regular characters.

	- Improves timerlat auto-analysis output by replacing '\t'
	  with spaces to avoid copy-and-paste issues when reporting
	  problems.

	- For timerlat, make the user-space (-u) option the default,
	  as it is the most complete test. Add a -k option to use
	  the in-kernel workload.

	- On timerlat top and hist, add a summary with the overall
	  results. For instance, the minimum value for all CPUs,
	  the overall average and the maximum value from all CPUs.

	- timerlat hist was printing initial values (i.e., 0 as max,
	  and ~0 as min) if the trace stopped before the first Ret-User
	  event. This problem was fixed by printing the "       - "
	  no value string to the output if that was the case.

	For all RTLA tools:

	- Add a --warm-up <seconds> option, allowing the workload to
	  run for <seconds> before starting to collect results.

	- Add a --trace-buffer-size option, allowing the user to set
	  the tracing buffer size for -t option. This option is mainly
	  useful for reducing the trace file. Now rtla depends on
	  libtracefs >= 1.6.

	- Fix the -t [trace_file] parsing, now it does not require
	  the '=' before the option parameter, and better handles the
	  multiple ways a user can pass the trace_file.txt


Please pull the latest trace-tools-v6.10 tree, which can be found at:

  git://git.kernel.org/pub/scm/linux/kernel/git/bristot/linux.git
trace-tools-v6.10

Tag SHA1: dbd633e7f81bac0114f609ff2eade9f4e66a28e2
Head SHA1: 59c22f70b2951d81de410d477ae536ba951b4f37

Daniel Bristot de Oliveira (8):
      rtla/timerlat: Simplify "no value" printing on top
      rtla/auto-analysis: Replace \t with spaces
      rtla/timerlat: Use pretty formatting only on interactive tty
      rtla/timerlat: Add a summary for top mode
      rtla/timerlat: Add a summary for hist mode
      rtla: Add the --warm-up option
      rtla/timerlat: Make user-space threads the default
      rtla: Add --trace-buffer-size option

John Kacur (3):
      rtla/timerlat: Fix histogram report when a cpu count is 0
      rtla: Fix -t\--trace[=file]
      rtla: Documentation: Fix -t, --trace

----
 Documentation/tools/rtla/common_options.rst        |  11 +-
 .../tools/rtla/common_osnoise_options.rst          |   4 +
 .../tools/rtla/common_timerlat_options.rst         |  10 +-
 tools/tracing/rtla/Makefile.config                 |   2 +-
 tools/tracing/rtla/src/osnoise_hist.c              |  55 +++-
 tools/tracing/rtla/src/osnoise_top.c               |  55 +++-
 tools/tracing/rtla/src/timerlat_aa.c               | 109 ++++----
 tools/tracing/rtla/src/timerlat_hist.c             | 294 ++++++++++++++++++---
 tools/tracing/rtla/src/timerlat_top.c              | 250 +++++++++++++++---
 tools/tracing/rtla/src/trace.c                     |  15 ++
 tools/tracing/rtla/src/trace.h                     |   1 +
 11 files changed, 653 insertions(+), 153 deletions(-)
