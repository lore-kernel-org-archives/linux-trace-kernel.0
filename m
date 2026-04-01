Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D4542F25F0;
	Wed,  1 Apr 2026 06:37:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775025464; cv=none; b=if4iMu9BErar5kiKHLeGGN4l/jnaonBrKYzRukjV5RL8MA4OrYZ476ft3fQPhoT/jo4Cr7WKXZCwO+P+HQHf0oV444MYbA1+saSkzrP57OnBZux3QOFzCZumr/04dzlIhJZ7x9qXxYjRFrFKwtBPRLo8J3xaj3hJGGlAvl9Uc0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775025464; c=relaxed/simple;
	bh=uFvolVvUj4GeZV1fy87NvrCdKUCaAySDrJWQiZaymBE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=nLTFTbwV9/8gNhwvlag8FSwgCwt8cH35ntlebg3FjHu0sG18oMIKytq6ODRz10qhFziW0Q37N6aaOIp2+prQcREstT8ok+iIsmlHNWvNJwWqD8ZtCDz6b5qb5ZIKXNSg2xoWGkkQPm0uSoNd9y8rEib32gr00VniWBvRhgW7hwk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RnIiKkCI; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RnIiKkCI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E3EDC2BC9E;
	Wed,  1 Apr 2026 06:37:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775025464;
	bh=uFvolVvUj4GeZV1fy87NvrCdKUCaAySDrJWQiZaymBE=;
	h=From:To:Cc:Subject:Date:From;
	b=RnIiKkCIdDiPcDyEAoi0m4iYzoMECOyCYkAyAh/lthYknjxWomgN6IjWeK3aNsPD6
	 S48H9beHx6GPmyjwjBlnjEmCAy1GmNkAdxEf8i7jJBt9ReSEFJ4QPCjgm0KJqr9HUc
	 wjesAZr4c1K6hNhO2C6r0YOlVePEIrX/cCcGn7087opB+kuIXgm343mY/RbM3EbnEd
	 a+ZGwUxoc3yiZBxUDawCZSUxrUXuipodGuM+OEMuDSp5oh0i2aFAamS9k10OJsAyeD
	 yVYctyoqezZDrvjTcrKUXGtQxG1q0DwLKZg4uRLq6R3XTApaZPZzb6AJWKT1p5PxbG
	 arMW3TZWoGkjg==
From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH v10 0/3] tracing: Remove backup instance after read all
Date: Wed,  1 Apr 2026 15:37:39 +0900
Message-ID:  <177502545902.1311542.15822886746171808738.stgit@mhiramat.tok.corp.google.com>
X-Mailer: git-send-email 2.53.0.1118.gaef5881109-goog
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

Here is the v10 of the series to improve backup instances of
the persistent ring buffer. The previous version is here:

https://lore.kernel.org/all/177497473558.569199.6527680985537865638.stgit@mhiramat.tok.corp.google.com/

In this version, I fixed to use trace_array_destroy() and
cancel_work_sync() to avoid possible race. And remove unneeded
work_pending() check in trace_array_kick_autoremove()
(for trace_array_cancel_autoremove() to avoid deadlock of
workqueue, it still use work_pending() check) [2/3] and
add a newline at EOF [3/3]

Series Description
------------------
Since backup instances are a kind of snapshot of the persistent
ring buffer, it should be readonly. And if it is readonly
there is no reason to keep it after reading all data via trace_pipe
because the data has been consumed. But user should be able to remove
the readonly instance by rmdir or truncating `trace` file.

Thus, [1/3] makes backup instances readonly (not able to write any
events, cleanup trace, change buffer size). Also, [2/3] removes the
backup instance after consuming all data via trace_pipe.
With this improvements, even if we makes a backup instance (using
the same amount of memory of the persistent ring buffer), it will
be removed after reading the data automatically.

Thanks,

---

Masami Hiramatsu (Google) (3):
      tracing: Make the backup instance non-reusable
      tracing: Remove the backup instance automatically after read
      tracing/Documentation: Add a section about backup instance


 Documentation/trace/debugging.rst |   19 ++++
 kernel/trace/trace.c              |  160 ++++++++++++++++++++++++++++---------
 kernel/trace/trace.h              |   13 +++
 kernel/trace/trace_boot.c         |    5 +
 kernel/trace/trace_events.c       |   76 ++++++++++--------
 5 files changed, 202 insertions(+), 71 deletions(-)

--
Masami Hiramatsu (Google) <mhiramat@kernel.org>
