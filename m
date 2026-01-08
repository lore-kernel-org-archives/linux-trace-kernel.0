Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D80334797F8;
	Thu,  8 Jan 2026 14:22:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767882177; cv=none; b=Ws4fo0K3xtwUrOXMzUinzTtAW63BjDBdv1zKe3FppXI/WFCgv9vmKkhzF7TGrXyloKoZtPBZOCOQj7Ey2w7q+RLMbEdYLJn6iYjSCRcMOmZDD7JI6BQfthAJVmUkOjU7EN0K5PHL8GzkZ+D7Y4HMiDXIsVSjHwh+jFFtp1f1tYc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767882177; c=relaxed/simple;
	bh=dWtZCi9L+ohp9gF8onh+DfzsELc5kp9FEugc5NA3PUY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=VReBSf4Ql4RSeOt6L4ggLoqvc8xeSuar1IbLA8dN3CWyyLf58SZOSzEHrOhFBq7TbZB2M1EQ7rrff7O2bI1yDENS3++mGc4LOmkXlalUYtYZR8kaKsYP00d+mEGd0JQz2FuY3+QA0tkR4L66soM9HpRTx2KAtXhTR7p9Lbz+P1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sgjUw7NW; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sgjUw7NW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8DBFC16AAE;
	Thu,  8 Jan 2026 14:22:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767882177;
	bh=dWtZCi9L+ohp9gF8onh+DfzsELc5kp9FEugc5NA3PUY=;
	h=From:To:Cc:Subject:Date:From;
	b=sgjUw7NWc90DlfuHwnwZVjyUnTXyE4vv1RiREA+cYdmJ1UZ2T4074ELHkeCBaGs8c
	 rxnVL4vtQLiL0ZjaX6TVLaj7obuHMjCRU84vthJtQKlwrPUm9xs9/uGh2/CQy56Uko
	 5MIV0+RG0M9NPoh3hlgt69N3ZJD3eoIArXBkluXuhtroEE4V39VE1IX7vYq53eRZP9
	 xZEncbIyUa2dcJjWzpLi9J0jVTF4a457ni2rwnfil6JhT0C0XPTQ2crVSGi3hy6vYX
	 yF/vLwjyr59Z/0NHlEb0J87FZo3iPK4Snxm9+K605s2B5osdk7oAGihJUGa4/yPIrA
	 BZH5A+gxyV8lg==
From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH v2 0/2] tracing: Remove backup instance after read all
Date: Thu,  8 Jan 2026 23:22:51 +0900
Message-ID:  <176788217131.1398317.11144318616426272901.stgit@mhiramat.tok.corp.google.com>
X-Mailer: git-send-email 2.52.0.351.gbe84eed79e-goog
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

Here is the 2nd version of the series to improve backup instances of
the persistent ring buffer. The previous version is here:

https://lore.kernel.org/all/176779714767.4193242.1978666866487010024.stgit@mhiramat.tok.corp.google.com/

In this version, I updated [1/2] to use dedicated file operations
for read only instance instead of checking on each write function.
Also use dedicated entries files for eventfs to remove writable
control files from it. So it has only 'format' and 'id' files in
readonly backup instance.

Since backup instances are a kind of snapshot of the persistent
ring buffer, it should be readonly. And if it is readonly
there is no reason to keep it after reading all data via trace_pipe
because the data has been consumed.
Thus, [1/2] makes backup instances readonly (not able to write any
events, cleanup trace, change buffer size). Also, [2/2] removes the
backup instance after consuming all data via trace_pipe.
With this improvements, even if we makes a backup instance (using
the same amount of memory of the persistent ring buffer), it will
be removed after reading the data automatically.

---

Masami Hiramatsu (Google) (2):
      tracing: Make the backup instance readonly
      tracing: Add autoremove feature to the backup instance


 kernel/trace/trace.c        |  227 +++++++++++++++++++++++++++++++++++--------
 kernel/trace/trace.h        |   20 ++++
 kernel/trace/trace_boot.c   |    5 +
 kernel/trace/trace_events.c |   75 ++++++++++----
 4 files changed, 261 insertions(+), 66 deletions(-)

--
Masami Hiramatsu (Google) <mhiramat@kernel.org>
