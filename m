Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 198603783D1;
	Fri, 10 Apr 2026 09:35:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775813715; cv=none; b=sVR6mZeAK6lONpkHbW7A73zFpaxUJd/LiFwKBYqSeULQ76yXazp1KOUJ4HEdnQdBXk8Kd6vZPs2FsVvbrsZS9V2beZF/XMKBaXdguN/xq/4CvNwP8a9+8f11txGxpftakdWxvHrlYk17+BLzFOMaBgk5RO9JP6p3PSiGpqoobCs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775813715; c=relaxed/simple;
	bh=H4wV2aZYrJKillZrnt1cfp32w2a7H/Y75W84iTu+c94=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Xaa5glpubp0hVNftpDzG/jubMjc43Vw4fS4VlWju3LxanqTRfXjsQLA2S7vzoRWan13qsfS+25H2TWR8ehkNvlV1ln4bRFg5v+Bc1dK6rmtqLZnhuG3b1YHdmYAe2EQ5s6PqdRqQpHD3ajkb8Z22n8qK+clvwE6s2umOewul17E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OTmXd+Vw; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OTmXd+Vw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB848C19425;
	Fri, 10 Apr 2026 09:35:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775813714;
	bh=H4wV2aZYrJKillZrnt1cfp32w2a7H/Y75W84iTu+c94=;
	h=From:To:Cc:Subject:Date:From;
	b=OTmXd+Vwpoj4esPLpFDlYATfejZkBcod/qiW77F+79KmdnO4VWZ0mRAbXG/Eh5FVM
	 APYjNu3AfegPassJRO57eMucKwyWic63GmLxEK/UhNtyGp+oKegXMY4jRv+Nk28pjm
	 tRILU/pUEsi/w1igYAXvcJvgPcE6KAu9g7k6rBeCYcYrjcg5vAY27jFziBL03C68le
	 2+TjjC0Gt2CFex/2EIzP+FS7CQiCIbQ4RAiUga6tQG0VX+YM+UHwSVFIJv+Mfu8yGt
	 0YsrgvChec7nxib2b33AqIWaeXJfhdi6FtOZkHPwBj5FZDNGySb32+0GYC5tWoRF3P
	 sJmtdItynjnEA==
From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>
Cc: Menglong Dong <menglong8.dong@gmail.com>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	jiang.biao@linux.dev,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH v3 0/3] tracing/fprobe: Fix fprobe_ip_table related bugs
Date: Fri, 10 Apr 2026 18:35:09 +0900
Message-ID:  <177581370903.617881.3002655215679528157.stgit@mhiramat.tok.corp.google.com>
X-Mailer: git-send-email 2.53.0.1213.gd9a14994de-goog
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

Here are patches to fix bugs in fprobe.

The previous version is here.

https://lore.kernel.org/all/177573094819.3666478.11900825120958856397.stgit@mhiramat.tok.corp.google.com/

In this version, I added another bugfix for registration
failure of fprobe [1/3] (since this is the patch for oldest bug),
and move retry-loop inside rhltable_walk_enter()/exit()[2/3].
Both are reported by Sashiko[1].

[1] https://sashiko.dev/#/patchset/177573094819.3666478.11900825120958856397.stgit%40mhiramat.tok.corp.google.com

Thank you!

---

Masami Hiramatsu (Google) (3):
      tracing/fprobe: Remove fprobe from hash in failure path
      tracing/fprobe: Avoid kcalloc() in rcu_read_lock section
      tracing/fprobe: Check the same type fprobe on table as the unregistered one


 kernel/trace/fprobe.c |  217 +++++++++++++++++++++++++++++--------------------
 1 file changed, 128 insertions(+), 89 deletions(-)

--
Masami Hiramatsu (Google) <mhiramat@kernel.org>
