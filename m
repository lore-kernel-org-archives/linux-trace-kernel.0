Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02A1319D065;
	Thu, 10 Jul 2025 02:23:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752114237; cv=none; b=Ag9/fyeTUkBSysuxjPCIsk0G7sqt41PTcnM8X4dVNPvzv3hdQ3C3Zgq07JP0mW8LcwTNxf4aGT7S6o8vErRXYAp/6PiSKJ+o3mLV35/L5QlnXuyfKkjCs4tgoOAwI38SsQ+SvNKEB3vlGO8bcSACMz3KzMlePTbv6K1S075lY5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752114237; c=relaxed/simple;
	bh=2/XagPuVFGN4kAm58mBH5chGZAYGODG9YlOGIFwxloE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=gkJUO1zgV+A+02qxqj7O6dn16/LLjHefcojkmXboy/wG+tLA10jy4APFeoLD81TaEOHdCfp5TStEjyK6FmZQm1iz+I7GHWXYWxt5djcDlU8Hlo5XelF8s/pgiZEcWbMeo4Ql4rB3T+aDnqJH4orKfqAsr6S2j5FafHhFxe25BqQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bzRMNGN/; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bzRMNGN/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F14EC4CEEF;
	Thu, 10 Jul 2025 02:23:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752114236;
	bh=2/XagPuVFGN4kAm58mBH5chGZAYGODG9YlOGIFwxloE=;
	h=From:To:Cc:Subject:Date:From;
	b=bzRMNGN/jlmZV/q4nJoLT4TM6sEbyZ4TzQect42p4S2daUabT7cdj8z8qpqmlExV5
	 7H6rpyZ2q+YURSICKob+shqYvXMcJ7BUyNodZxzzaerkLVsTaHYxUWRrbXLMocUkBN
	 hZibc1+bqi/UBQEPsTVLkSsdgtrIAyB5GC34hDaEDg5soq79T9r3i9PgaY3ImOX8Da
	 bzBkWspZWYH70RwKe1dCyTgHjPRzGYkaFVvAn7zxlNn7txGJGcLdcLiFTQtcMeIWDE
	 MPPeXwf2rOCubCZM9fc7w+SGqJhjt7/ToEt1Lp0xQ+jU/ZsO5KiGbPKd8bsaJyT+Xd
	 5ZJJxuujYtGuw==
From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To: linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>
Subject: [PATCH 0/3] tools/bootconfig: cleanups and portability updates
Date: Thu, 10 Jul 2025 11:23:53 +0900
Message-ID:  <175211423307.2591046.14863142130524442068.stgit@mhiramat.tok.corp.google.com>
X-Mailer: git-send-email 2.50.0.727.gbf7dc18ff4-goog
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

This series provides several cleanups and updates to the bootconfig
tool and its selftest script. The main goals are to enhance portability,
improve robustness, and clean up the shell script implementation.

[1/3] focuses on portability by replacing GNU-specific commands like
stat, and truncate in the test-bootconfig.sh script with their
POSIX-compliant alternatives (wc, and dd).

[2/3] continues the portability effort by replacing most echo calls
with the more reliable printf command to ensure consistent behavior
across different shells.

[3/3] cleans up the C code in main.c by introducing a macro for the
bootconfig footer size, making the size calculations clearer and
easier to maintain.

Thanks,

---

Masami Hiramatsu (Google) (3):
      tools/bootconfig: Improve portability
      tools/bootconfig: Replace some echo with printf for more portability
      tools/bootconfig: Cleanup bootconfig footer size calculations


 tools/bootconfig/main.c             |   19 +++++++++++--------
 tools/bootconfig/test-bootconfig.sh |   33 +++++++++++++++++----------------
 2 files changed, 28 insertions(+), 24 deletions(-)

--

