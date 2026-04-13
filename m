Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA31138237B;
	Mon, 13 Apr 2026 08:39:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776069570; cv=none; b=qbad0o8NfMxevO5uYknYy/hNcl4QaD1imj/mGbyTrYOmQZdb4uH7BXnDBf9+EmsagwrBKeyHP5Kp+sqw9gEmnS39niQ+mYozROM1wExpGIPY44MTfAxZa9rQh30/bK+LXME3jvNLJJDKx+kxglKmAQe9p3aeNsTpGOUn1CgaW4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776069570; c=relaxed/simple;
	bh=QYPNh5GN0Wqw8m0qUpdyU65zzmwiDooO87P3p7RO7UQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=eaie5mr5AieBv0f2n029JH7JUJ+syadJjz1TGtbRBi21U5BRgNNnACb2ZoyqMRkrj63mW1k09cCuJDyhQuf3Biz9eRpQSCNoF0kfM0TiQB/Hxb0X1NDTD3IBQY8VST3Syj/xLzIGNNayNxVnCRzQeAHR67Tz11fjIPM3yPcIhYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RKJ+3rVg; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RKJ+3rVg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01975C116C6;
	Mon, 13 Apr 2026 08:39:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776069570;
	bh=QYPNh5GN0Wqw8m0qUpdyU65zzmwiDooO87P3p7RO7UQ=;
	h=From:To:Cc:Subject:Date:From;
	b=RKJ+3rVgql+q4mJ6wfRRrJm8wcDsFQu1Ru/Q3JTDVOP8RbDaq8/5VhYu8xPF7gugV
	 1p9GdXwiEERSNfiSKnuB+JQmyYfSsIGv5YnYDdyj238FD8m3u07DSWQTALqIsZotK7
	 sk++3DhiqrcwLqjXEWsfeQuHrI+4nh+JwGBoommnUNwMGOvXXrWc9CRpNZYZWAUn91
	 e/ZMRzLHLg0fBlvPC5bsCXNRWXXvfl59qflan8/YAKFalvQnL2hZd7agPs+Ocq1JP7
	 WspWY5FJ0/6u0/U7Wk4rx5zTNg4rjbLSFf9rgetTO6JDfLL5aXzoCjQCjaZGUK182t
	 5sjn8WRE5bx4g==
From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>
Cc: Menglong Dong <menglong8.dong@gmail.com>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	jiang.biao@linux.dev,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH v5 0/3] tracing/fprobe: Fix fprobe_ip_table related bugs
Date: Mon, 13 Apr 2026 17:39:26 +0900
Message-ID: <177606956628.929411.17392736689322577701.stgit@devnote2>
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

Here is the 5th series of patches to fix bugs in fprobe.
The previous version is here.

https://lore.kernel.org/all/177584108931.388483.11311214679686745474.stgit@devnote2/

This version fixes to remove fprobe_hash_node forcibly when fprobe
registration failed [1/3] and skips updating ftrace_ops when fails
to allocate memory in module unloading [2/3].

Thanks,
---

Masami Hiramatsu (Google) (3):
      tracing/fprobe: Remove fprobe from hash in failure path
      tracing/fprobe: Avoid kcalloc() in rcu_read_lock section
      tracing/fprobe: Check the same type fprobe on table as the unregistered one


 kernel/trace/fprobe.c |  251 +++++++++++++++++++++++++++++--------------------
 1 file changed, 147 insertions(+), 104 deletions(-)

--
Masami Hiramatsu (Google) <mhiramat@kernel.org>
