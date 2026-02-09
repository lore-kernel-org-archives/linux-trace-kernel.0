Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F04993624DE;
	Mon,  9 Feb 2026 09:25:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770629127; cv=none; b=dFsBvme10p/JjSW5nnd4Y2qZ0T0VGpe0jVwOs+je7ysMlwNljDnLDgGOtTkw4DrPqBMpfPj7RwnRf8oxP6AVfjEQDJjuZpY+XiqZKxTl8axUUtD0mzDs8PuOvT75OuYSYK94YrUVxRZNOwSbJPBBNL4zf/deGbLh4eqixYLVNow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770629127; c=relaxed/simple;
	bh=yE0bheDne9TwHsTGNwhEk7VpljIzA9tnemRSljhHX1w=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=JVuNn6Lh6VQh6hnYLC+h/MnmN2RVhJNXC8TbwMkBhM4rz5LxiyEKw4pL/kHpffOrhMcDZSWp1RyikAGyoYnAT55Ikq3OVBLd1iPE9PTlT8VXJK/rD8lFwdPGhZI8kJXRqYJm1GUVDVyzVHMDKbKL8ZCjQtgpp0yQyytxgQJA5II=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=leq3j1fA; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="leq3j1fA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3538C116C6;
	Mon,  9 Feb 2026 09:25:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770629126;
	bh=yE0bheDne9TwHsTGNwhEk7VpljIzA9tnemRSljhHX1w=;
	h=From:To:Cc:Subject:Date:From;
	b=leq3j1fACIB5aUwWOXG6lKWBl8qKYwilH+1JJynfMjEgio8eSDUw0Di0/jf2Ubfmz
	 PHMGzvnerR+BjUkXJoC8eFe125u+ajJNmU88qj3W4l8wx+xyQVQbCsQN+KITjaQe1s
	 2ecqJS5M02pPZucuCt7keuiDbMMgClFz3Tn6Pnm1tkJaPcYL8Z6HGp2eFDX/LAqWEA
	 Z43obHdRqCtJmhyQHHkSXj/2BAS+8yDcb0D69OGPousmV6hEldEPNplJhg+MjwDPdr
	 ND0q5t+1IDcUHEgzvj5ChR/DcHlBuGBZJdRNnrLTnb10f8bNn3gd5krgkSK5RF1l7y
	 RMme6HSlJgPFQ==
From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH v7 0/4] tracing: Remove backup instance after read all
Date: Mon,  9 Feb 2026 18:25:21 +0900
Message-ID:  <177062912135.1230888.17419570791737357433.stgit@mhiramat.tok.corp.google.com>
X-Mailer: git-send-email 2.53.0.239.g8d8fc8a987-goog
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

Here is the v7 of the series to improve backup instances of
the persistent ring buffer. The previous version is here:

https://lore.kernel.org/all/176991653525.4025429.12655335935351822711.stgit@mhiramat.tok.corp.google.com/

This version is rebased on the latest linux-trace/for-next,
remove update_last_data_if_empty() from snapshot file [1/4] and,
use -EACCES instead of -EPERM.

Series Description
------------------
Since backup instances are a kind of snapshot of the persistent
ring buffer, it should be readonly. And if it is readonly
there is no reason to keep it after reading all data via trace_pipe
because the data has been consumed. But user should be able to remove
the readonly instance by rmdir or truncating `trace` file.

Thus, [2/4] makes backup instances readonly (not able to write any
events, cleanup trace, change buffer size). Also, [3/4] removes the
backup instance after consuming all data via trace_pipe.
With this improvements, even if we makes a backup instance (using
the same amount of memory of the persistent ring buffer), it will
be removed after reading the data automatically.

---

Masami Hiramatsu (Google) (4):
      tracing: Reset last_boot_info if ring buffer is reset
      tracing: Make the backup instance non-reusable
      tracing: Remove the backup instance automatically after read
      tracing/Documentation: Add a section about backup instance


 Documentation/trace/debugging.rst |   19 ++++
 kernel/trace/trace.c              |  161 ++++++++++++++++++++++++++++++-------
 kernel/trace/trace.h              |   13 +++
 kernel/trace/trace_boot.c         |    5 +
 kernel/trace/trace_events.c       |   76 ++++++++++-------
 5 files changed, 208 insertions(+), 66 deletions(-)

--
Masami Hiramatsu (Google) <mhiramat@kernel.org>
