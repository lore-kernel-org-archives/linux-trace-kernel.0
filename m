Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33079944D;
	Sun, 26 May 2024 10:11:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716718261; cv=none; b=q1XmFzZgKT1DOnMGNvp30VOR3dmw45cKZ+SeaEuj7nnEG1OAwct6KgPVquY7+SSPZHItdVjPGfNhiDdQxQ5NRdyIhJ4wxe1buwzusx87xlUGTJeJrKFEHZwoVgBXWPnRmXYHBkJL22zzD6LxJ95rRY8OhfsjEj8WMoxZL6DLH6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716718261; c=relaxed/simple;
	bh=sYzAz15/z8faKs1VYVEOVSprSAaIaPmv/HsJiqwELDw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=ApVQzD/grO2TAO3EswoE7P81NufN7TQYqZG9IQtfnD7hMjI6hMZhL4e9tWi+0CeZQoWeDofmdKZagS/lRl4+cEwpPdfSP3VmlN47GimMB1BZxHG4P9h965KSL1uIjD4d62zz6vWmutXBT/jOZ34TDdCSElAIBzTuytvukNpcjng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dkp81Olt; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dkp81Olt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 724D2C2BD10;
	Sun, 26 May 2024 10:10:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716718260;
	bh=sYzAz15/z8faKs1VYVEOVSprSAaIaPmv/HsJiqwELDw=;
	h=From:To:Cc:Subject:Date:From;
	b=dkp81OltoVClOmVRjStYBulaO3MDzGMQsP3SM5sLcQCp4Nql9futT7xmJA4cb7Nub
	 LgWxUaHAdadCzRB8LXOAjaDh5/qZX0eiiMe80EPsz7xrVyFTL3uBP0W+s8SOs0OoJw
	 SvPtYuJHcO+drKGSg99X/D7aBEA+D0qwi6fzwjedeG4O0veWQGse1/pPPLPMs1MRlt
	 oBog3W5kdnSAw0nDmfRVTnLzjLC2jAEE020/bjbSBI8sPReFXjXlrJFJowr4bBD4/D
	 mDSNRgnVBQREPcX04+FZpaB+c+/miRdFHQP2qL3EyPDJnBcnlwDQOqmo3hAf2DUpbc
	 5K37UEGEs5X3g==
From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
	Linux Trace Kernel <linux-trace-kernel@vger.kernel.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Tom Zanussi <zanussi@kernel.org>
Subject: [PATCH 0/3] tracing: Fix some selftest issues
Date: Sun, 26 May 2024 19:10:57 +0900
Message-Id: <171671825710.39694.6859036369216249956.stgit@devnote2>
X-Mailer: git-send-email 2.34.1
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

Here is a series of some fixes/improvements for the test modules and boot
time selftest of kprobe events. I found a WARNING message with some boot 
time selftest configuration, which came from the combination of embedded
kprobe generate API tests module and ftrace boot-time selftest. So the main
problem is that the test module should not be built-in. But I also think
this WARNING message is useless (because there are warning messages already)
and the cleanup code is redundant. This series fixes those issues.

Thank you,

---

Masami Hiramatsu (Google) (3):
      tracing: Build event generation tests only as modules
      tracing/kprobe: Remove unneeded WARN_ON_ONCE() in selftests
      tracing/kprobe: Remove cleanup code unrelated to selftest


 kernel/trace/Kconfig        |    4 ++--
 kernel/trace/trace_kprobe.c |   29 ++++++++++++-----------------
 2 files changed, 14 insertions(+), 19 deletions(-)

--
Masami Hiramatsu (Google) <mhiramat@kernel.org>
