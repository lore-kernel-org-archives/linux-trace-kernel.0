Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A0141B2EF2;
	Tue, 28 Jan 2025 15:37:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738078621; cv=none; b=tP+ISrIZDdnpAJCDwq6oUOPlLOtuS/zAIJnufjnTrUYuQCoqPu3tCrK4Lq2KO78vkCjITcbI5NURAIkPpwFP2sZccHE3iNOJE446dVrKcRS91k42zKnKb3sXpdzrJ3fIsYxFXU5i8Xz+t3f0gxCvp3TzDtLuryO9z0EwKyGVwsI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738078621; c=relaxed/simple;
	bh=ejvGvxDF5yAPWXPwpBg5i1B8k96w29wdbygQAFpGMRA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=SNdE7IkRzrDVaVzvQV2pPvNeQOZnkAKdsst0a1Cp755oqe3DBANuKs88OlscfonOjd9NhOBYYYwXC61ySkc6NccxgMj90M4lFOyXwghy2da6gp4Og7M7u8GDMbw62iCNY7JaXxRHSTfRMRc+/Wz3/Tn72ARCDOTVsaAUGG6nn24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Obvy5MS3; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Obvy5MS3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1DD4C4CED3;
	Tue, 28 Jan 2025 15:36:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738078621;
	bh=ejvGvxDF5yAPWXPwpBg5i1B8k96w29wdbygQAFpGMRA=;
	h=From:To:Cc:Subject:Date:From;
	b=Obvy5MS3Jr+eKW+kLvZgBd8rWEybuKawOlrgb4Ul6D2OvAUq8gQ5NpFXdBSYCDfzm
	 dH9VIOdUG3YSSYPTuW9sKHOsT0+LfRmBG6dFkSAXVfygowI1Wh9Ti5AewJiUs5HWXs
	 /dOS9nIGmtvxnQkhdzzzVGwPxhKMM7n4oRgR34379mJA5F1IBHozLLQw/xgXBvnJcY
	 ZzjY3ZfDhadvR2N2ToYPP2vVFVXbSbBGEhmc8t6V5/1ElhAnn4IGPFRwsXFx1BKpcw
	 5plHKgj5a+PmNWU/rLJqHAYN3vKrOgfnWX1rxevKugTc/IU0qUTyIOHf5JxHqjkJ1M
	 nqnura8sm757A==
From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Luis Chamberlain <mcgrof@kernel.org>,
	Petr Pavlu <petr.pavlu@suse.com>,
	Sami Tolvanen <samitolvanen@google.com>,
	Daniel Gomez <da.gomez@samsung.com>,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	linux-modules@vger.kernel.org
Subject: [RFC PATCH 0/3] tracing: Introduce relative stacktrace
Date: Wed, 29 Jan 2025 00:36:56 +0900
Message-ID:  <173807861687.1525539.15082309716909038251.stgit@mhiramat.roam.corp.google.com>
X-Mailer: git-send-email 2.48.1.262.g85cc9f2d1e-goog
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

This introduces relative stacktrace, which records stacktrace entry as
the offset from _stext instead of raw address. User can enable this
format by setting options/relative-stacktrace.

Basically, this does not change anything for users who are using ftrace
with 'trace' text-formatted interface. This changes how each stacktrace
entry address is stored, so users who is using 'trace_pipe_raw' needs
to change how to decode the stacktrace.

Currently, the stacktrace is stored as raw kernel address. Thus, for
decoding the binary trace data, we need to refer the kallsyms. But this
is not useful on the platform which prohibits to access /proc/kallsyms
for security reason. Since KASLR will change the kernel text address,
we can not decode symbols without kallsyms in userspace.

On the other hand, if we record the stacktrace entries in the offset
from _stext, we can use System.map file to decode it. This is also good
for the stacktrace in the persistent ring buffer, because we don't need
to save the kallsyms before crash anymore.

The problem is to decode the address in the modules because it will be
loaded in the different place. To solve this issue, I also introduced
'module_text_offsets' event, which records module's text and init_text
info as the offset from _stext when loading it. User can store this
event in the (another) persistent ring buffer for decoding.

Thank you,

---

Masami Hiramatsu (Google) (3):
      tracing: Record stacktrace as the offset from _stext
      tracing: Introduce "rel_stack" option
      modules: tracing: Add module_text_offsets event


 include/trace/events/module.h |   40 ++++++++++++++++++++++++++++++++++++++++
 kernel/module/main.c          |    1 +
 kernel/trace/trace.c          |   11 ++++++++++-
 kernel/trace/trace.h          |    2 ++
 kernel/trace/trace_entries.h  |   22 ++++++++++++++++++++++
 kernel/trace/trace_output.c   |   35 +++++++++++++++++++++++++++++++----
 6 files changed, 106 insertions(+), 5 deletions(-)

--
Signature
