Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F22FC60B8A;
	Tue, 29 Jul 2025 16:18:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753805938; cv=none; b=R3nhOad7nkoyAGLA/lf+2wH4mq/jCXWyIxafAsWM400hwmId7WNuaN7QNubPIe4qiSm6wedE8P/F8Gz+Qvm6iyc9zhyQxxDB0ObKhVHH649/2hTMNZam2PDL6Ol36pVMPcZNTBK5d2niwXsaUj7Q2ggSAWsZbmWMzj5ItA5YA+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753805938; c=relaxed/simple;
	bh=KUMUnijnvSOofhAWrR339NcsodbNMkkEXGESr2axtkE=;
	h=Message-ID:Date:From:To:Cc:Subject; b=e4QDLHwq3K3dkbabTFS23wIyDg3s6aG1anuDpios0fG0J4zZfppCWLS53pS0FrJ0M+lD7YJR1wF+pP7xEDeSCFzB0QK9nG2uwGxQHEZOkHcAhEUOLqGi1YfuF2nyiFQHddYLc3/H4YP7miOigDyX0V92H0Q/tYGTqh64oODyjf0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bNe8jxVm; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bNe8jxVm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95798C4CEF4;
	Tue, 29 Jul 2025 16:18:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753805937;
	bh=KUMUnijnvSOofhAWrR339NcsodbNMkkEXGESr2axtkE=;
	h=Date:From:To:Cc:Subject:From;
	b=bNe8jxVmuKNyp88h+O1DORW9bJg89BhQWsImUP033VcRQnJ2eLb8db7GT7YrM1J5u
	 LsdPIcfFulbNL8dtdz90+0HMekaiSCSHLRUVYO+xtKTnO6T/Q8Ge/hrsEJRi5B2Z/w
	 Be8FbWSHl2hXP2rQxkX1I2RPwhlrofg9FHjvjwDYToyrYuyVbrRP2/Ms6FuxzyxL1T
	 DqBpTU3fxeaotYu6SEzafrDUlQU4jyqJJCaFF+g9L+s+Tu5jm4nPM1jgeZIFmQtTYL
	 vH6mN99oZAddoN+VRtI3Jb8eVxWDVpyHWvBUdGft8qqB9enwImJLFqEPyBexfDIuO2
	 xh2KKb9P7Mbow==
Received: from rostedt by gandalf with local (Exim 4.98.2)
	(envelope-from <rostedt@kernel.org>)
	id 1ugn2m-00000004yat-06xE;
	Tue, 29 Jul 2025 12:19:12 -0400
Message-ID: <20250729161816.678462962@kernel.org>
User-Agent: quilt/0.68
Date: Tue, 29 Jul 2025 12:18:16 -0400
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
Subject: [PATCH v2 0/2] tracing: Documentation: Add missing config and document for eprobes
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>


Add missing eprobe config option and documentation which should have both been
added back in 5.15.

Steven Rostedt (2):
      tracing: Have eprobes have their own config option
      Documentation: tracing: Add documentation about eprobes

----
 Documentation/trace/eprobetrace.rst | 269 ++++++++++++++++++++++++++++++++++++
 Documentation/trace/index.rst       |   1 +
 kernel/trace/Kconfig                |  13 ++
 kernel/trace/Makefile               |   2 +-
 4 files changed, 284 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/trace/eprobetrace.rst
