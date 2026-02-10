Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2106233D6CC;
	Tue, 10 Feb 2026 08:43:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770713011; cv=none; b=un/dZ0W3qq3GAP/f81lcXxF86h+dWfYdqAa4b0wsURHg+McLmRjo4fN1wKDhA4DkjXSwe/N8jVxudgWxHv5ViIIogNDFj0hG7EcQDz56LUCj1oMMOgdZ9/GpbRoizrfojjjq+cgrZGNSTKlbtmh2QhWJYaSQCO8By7EEc+iwe+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770713011; c=relaxed/simple;
	bh=dG9EmmIYFAHtAq8RoU8YbCtRQURdb0azidA9hk2IBiA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Bxi5RhLwGixpjz9i51iOwanKLK1W2napOh0bYZfAvEyOgrPflwLCd17q4KEEuozuayuptmiHHuiffAXTpaGaGOlrCWx8WLN/fgXxf2u2AYZbyrqbL5jDawuUsGNO/JwkcoqKQBlE+aH5cBeNW5imyRXJCR1qWqkzlRsaOwhbhAI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K/q7Xh1P; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K/q7Xh1P"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F383BC19424;
	Tue, 10 Feb 2026 08:43:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770713010;
	bh=dG9EmmIYFAHtAq8RoU8YbCtRQURdb0azidA9hk2IBiA=;
	h=From:To:Cc:Subject:Date:From;
	b=K/q7Xh1P4oMozrPkepOfd/aWCtaaYewwMEfII8RjB3ivuMzN0yODce+nEdWuPXDYH
	 ungvnoZNlJoPd9buv8N93d8LJd9SPvUiV+BCQJfvP6u8dzt4kEtKe9PnmJgHY419Ss
	 NGrp8PHhZEOF9GQ3gngAVCQC1i25awzj/FDKlqJ1zgOo27FKH9q6UHBljIRBId9SEB
	 HRORfAPy46S6M6t+KQR9uPTyGg/pOnaNEQMxqfr+9ULHGL72AigGqexoqUU+6GjWIr
	 1sY0nrqp42LmxbUsnr8VcCugH566AzNA67d2YhNJB7DEeeu6bXA4mE7ReNPvtALMx9
	 qQJAFZtVR0lBA==
From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH v8 0/6] tracing: Remove backup instance after read all
Date: Tue, 10 Feb 2026 17:43:26 +0900
Message-ID:  <177071300558.2293046.12057922262682243630.stgit@mhiramat.tok.corp.google.com>
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

Here is the v8 of the series to improve backup instances of
the persistent ring buffer. The previous version is here:

https://lore.kernel.org/all/177062912135.1230888.17419570791737357433.stgit@mhiramat.tok.corp.google.com/

In this version, I modified the tracefs to check the file permission
even if the user has CAP_DAC_OVERRIDE as same as sysfs[3/6] and remove
read-only check from each read() operations[4/6]. Also add a bugfix [2/6]
for per-cpu buffer_size_kb permission.

Series Description
------------------
Since backup instances are a kind of snapshot of the persistent
ring buffer, it should be readonly. And if it is readonly
there is no reason to keep it after reading all data via trace_pipe
because the data has been consumed. But user should be able to remove
the readonly instance by rmdir or truncating `trace` file.

Thus, [3/5] makes backup instances readonly (not able to write any
events, cleanup trace, change buffer size). Also, [4/5] removes the
backup instance after consuming all data via trace_pipe.
With this improvements, even if we makes a backup instance (using
the same amount of memory of the persistent ring buffer), it will
be removed after reading the data automatically.

---

Masami Hiramatsu (Google) (6):
      tracing: Fix to set write permission to per-cpu buffer_size_kb
      tracing: Reset last_boot_info if ring buffer is reset
      tracefs: Check file permission even if user has CAP_DAC_OVERRIDE
      tracing: Make the backup instance non-reusable
      tracing: Remove the backup instance automatically after read
      tracing/Documentation: Add a section about backup instance


 Documentation/trace/debugging.rst |   19 +++++
 fs/tracefs/event_inode.c          |    2 +
 fs/tracefs/inode.c                |   36 +++++++++-
 fs/tracefs/internal.h             |    3 +
 kernel/trace/trace.c              |  140 ++++++++++++++++++++++++++++---------
 kernel/trace/trace.h              |   13 +++
 kernel/trace/trace_boot.c         |    5 +
 kernel/trace/trace_events.c       |   76 ++++++++++++--------
 8 files changed, 224 insertions(+), 70 deletions(-)

--
Masami Hiramatsu (Google) <mhiramat@kernel.org>
