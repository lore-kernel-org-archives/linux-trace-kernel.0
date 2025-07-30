Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F88E277036;
	Wed, 30 Jul 2025 14:09:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753884569; cv=none; b=Xw88EG9laUjqAPUWtNPkGqGqdicCi2FVsor06TGrCYVLnq243j6t70dp9OAQQzEx2TmzI+cl1zmkfNRQT1aok9/VFYW94JUPIukslDH5YcbFB6UJK0mHd9wvOA2xQ52BsZpN7n8HOmZP7GDEcZs4jdYF67S+lTc47PWQvBQSEyU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753884569; c=relaxed/simple;
	bh=jlSU8x2HUw5hRxeBbQkJqx0lNZvwXdUdDdshjAaerDg=;
	h=Message-ID:Date:From:To:Cc:Subject; b=W4e2MpO/C+yTwRuKLuzn7gj2236LNC/Yf0h1cg1Ow4TfvR2YdYB+MrrOktqV4+xJnbfEfmmPpyHu0Abjx1wBIbpLK4TEPIlsRL9pKAc7GKpTNgJSj+syluBFXf4Ah7xulngBqu5PUOxgJnkbBghQ4EXpNcc9wD1FFQppAySWJZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZEPmr2+P; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZEPmr2+P"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA114C4CEE3;
	Wed, 30 Jul 2025 14:09:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753884568;
	bh=jlSU8x2HUw5hRxeBbQkJqx0lNZvwXdUdDdshjAaerDg=;
	h=Date:From:To:Cc:Subject:From;
	b=ZEPmr2+P556zTytxnzgOEH7quSQEOMxbsblrK0qOcXMoaPqyf99ZDoswBDyimHHJ0
	 TQtz2s2DnQMx3pylemWkeRmxv+tXvdUMOEde40gyv3RZyiehO6SvO2lvtrYv6kyAlr
	 RHnWSvoAt3SOUF6hBkCtUGmsXSgh8TrG17+VEQo0Ap8/ozeM3wbJauQOo7PG2hE05p
	 vxI5W3ZKwZw7RypvWKj6wC7HRyMfCXkGqSFCl/lKFa/mZGprU15qy2e6pRrw6F/zsi
	 PSnyeZnFdDtP9DoGzDu69Xc9OtfEVqVoY70mJxre51i98p68zxatviQS13StvvUsZy
	 fzpTuvRxR0hvA==
Received: from rostedt by gandalf with local (Exim 4.98.2)
	(envelope-from <rostedt@kernel.org>)
	id 1uh7V3-00000005ydr-1OCf;
	Wed, 30 Jul 2025 10:09:45 -0400
Message-ID: <20250730140753.168615576@kernel.org>
User-Agent: quilt/0.68
Date: Wed, 30 Jul 2025 10:07:53 -0400
From: Steven Rostedt <rostedt@kernel.org>
To: linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Namhyung Kim <namhyung@kernel.org>,
 Jonathan Corbet <corbet@lwn.net>,
 Randy Dunlap <rdunlap@infradead.org>
Subject: [PATCH v3 0/2] tracing: Documentation: Add missing config and document for eprobes
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>

Add missing eprobe config option and documentation which should have both been
added back in 5.15.

Changes since v2: https://lore.kernel.org/linux-trace-kernel/20250729161816.678462962@kernel.org/

- Added Kconfig dependency on HAVE_REGS_AND_STACK_ACCESS_API (Masami Hiramatsu)

- Put back s/;/,/ (Randy Dunlap)

Steven Rostedt (2):
      tracing: Have eprobes have their own config option
      Documentation: tracing: Add documentation about eprobes

----
 Documentation/trace/eprobetrace.rst | 269 ++++++++++++++++++++++++++++++++++++
 Documentation/trace/index.rst       |   1 +
 kernel/trace/Kconfig                |  14 ++
 kernel/trace/Makefile               |   2 +-
 4 files changed, 285 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/trace/eprobetrace.rst
