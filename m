Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F0A73F9C5;
	Mon,  9 Dec 2024 02:41:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733712065; cv=none; b=ls/qgaHg6IVx7oajYyOTNJkuStih9OjsKqsj6ax46rp9YdwxZlC8mA2EU4l1DX3JDHaCHPSg4lQ6ibpfsPik9/B781W8zWhcjxvQHPTh/KFxRKJPTXGwmCdbqAVts95+u9Lh26uRK0RMZmQXVigEBVRoM2BwYpFZPatrq6kasjk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733712065; c=relaxed/simple;
	bh=2rqJdfh2VqTrlrWvzNpU8n2YDFFe0Dvw6UygFizQIeQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=CGAH9SeFTYSxM2VrNbHtpVPQIMU62zu6996aVriLViHfIbgqeES+intD257W/vMLhBjqgZUYm/Z/xw5t1HRmfyDMGuC17dX/4Gzq5Yt2Qom84KPaFJtQ4Wdgkbjud3q2J1myAv+4tzsC9EDlt6Pxt5jkEd/SV5GAr8TMZIlxdJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nMBgRpz3; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nMBgRpz3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6755C4CED2;
	Mon,  9 Dec 2024 02:41:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733712064;
	bh=2rqJdfh2VqTrlrWvzNpU8n2YDFFe0Dvw6UygFizQIeQ=;
	h=From:To:Cc:Subject:Date:From;
	b=nMBgRpz3RqmprRB9CumMq/L1UbKbLG4L5u7EyPNxY5VyH7Xb8zyesrxqeG8Nc3nSx
	 gFDpZdCLfRUUdKK4yCWlgWYmSXXCzdq8cijokR+AMRGO/4Ap6fjfZfdPjVec82kzU5
	 hf8w6T7q4RKnoyTmB/tN6lBSdtrFyoJ8/A9LtW9o0T/SRYYMUd/OnNjbkUQmLr7N6y
	 MTBvy2IAFVILP6S/bp0qYCcBQBUb84iadD081Sh6bXDdncgYU/U5b9pPERaqLLjowD
	 /bTbSU3wSmPZa5wOWO/ai+8sTQrQTf2WsWllK65/VyFJGvFiVlYE+mu9v/AMEZp9WZ
	 POVCnrFJgJpaw==
From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>,
	Peter Zijlstra <peterz@infradead.org>
Cc: Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	"David S . Miller" <davem@davemloft.net>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Oleg Nesterov <oleg@redhat.com>,
	Tzvetomir Stoyanov <tz.stoyanov@gmail.com>,
	Naveen N Rao <naveen@kernel.org>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Jason Baron <jbaron@akamai.com>,
	Ard Biesheuvel <ardb@kernel.org>,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH 0/5] kprobes: jump label: Cleanup with guard and __free
Date: Mon,  9 Dec 2024 11:40:57 +0900
Message-ID: <173371205755.480397.7893311565254712194.stgit@devnote2>
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

Here is another series of patches to cleanup kprobes and probe events in
ftrace to use guard() and __free(). This defines new guard and __free for
jump_label. I removed all gotos in kprobes with this series.

Thanks,

---

Masami Hiramatsu (Google) (5):
      jump_label: Define guard() for jump_label_lock
      kprobes: Use guard() for external locks
      kprobes: Use guard for rcu_read_lock
      kprobes: Remove unneeded goto
      kprobes: Remove remaining gotos


 include/linux/jump_label.h |    3 
 kernel/kprobes.c           |  383 ++++++++++++++++++++------------------------
 2 files changed, 181 insertions(+), 205 deletions(-)

--
Masami Hiramatsu (Google) <mhiramat@kernel.org>
