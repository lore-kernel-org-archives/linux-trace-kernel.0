Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEADB34F262;
	Tue, 13 Jan 2026 06:52:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768287140; cv=none; b=UUo20NaxWyLoF/dLcvda1GBLlMdCPkveAvKudfO6lYCY1siHKnzlxHCXKwt/VZNasrS2K5Pl0kIopAUoN2AGpzRp7zDaEg7l73RyN5ytaKwVfy2ckL86nGMKWPg6/G7Waa4TcPNfXQdpTg4xW8EfeiIuOYR+cUPCS1jmyeB5H0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768287140; c=relaxed/simple;
	bh=Ly+cI4Ib8ygKSHMODP52z6OW3wpklziHAdoF8RKXO/g=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=W7EFgYS4qmwLp7skDP/lXMHA7ukJzdNVyu8hpl9WzhEz9y5GvOCSE6pxVYEQb6OiR94PAv61fbNNfP/evBOUw5DVmhJzdGXKp/lKhCJytKierMKMBopFMrNk6IpnpH9BaV1AkiSfAEPmrJMn+/p2KNvMHifuCY4zlR+gLcS+kFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=p/1L8NXG; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="p/1L8NXG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1D89C116C6;
	Tue, 13 Jan 2026 06:52:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768287139;
	bh=Ly+cI4Ib8ygKSHMODP52z6OW3wpklziHAdoF8RKXO/g=;
	h=From:To:Cc:Subject:Date:From;
	b=p/1L8NXGMp6Y0knoqLY3v5i85FIZVerDJJrnLSKW64PpiFlkrbGwnczBvxEOxi7OV
	 3PtF6XMblsUixnzyjgT3JnABnoFblD7uSwg2tqiEE2NPeDjBQKEk6QEoQH707QsR9B
	 8Pi72InnkPiYo1D9jN3J7+dKxbilZBYdwIlWyRJex7HupJ92V/jqrb8HyOkDpovDZs
	 mB7IES0ZZZDCbQyUE6ObCLxzHVMKbBJhQCqqnwmLeQd9iv6gUcUbyvdR1j0GnTKarD
	 V0sJGBz2CEofJXHtW8LPgQgazYkq0tWLc4ImZC3UDeAZd+KAHYL46hfX0bKUncAeqB
	 fcc3gxjAWd7dw==
From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH v3 0/2] tracing: Remove backup instance after read all
Date: Tue, 13 Jan 2026 15:52:13 +0900
Message-ID:  <176828713313.2161268.62228177827727824.stgit@mhiramat.tok.corp.google.com>
X-Mailer: git-send-email 2.52.0.457.g6b5491de43-goog
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

Here is the 3rd version of the series to improve backup instances of
the persistent ring buffer. The previous version is here:

https://lore.kernel.org/all/176788217131.1398317.11144318616426272901.stgit@mhiramat.tok.corp.google.com/

In this version, I updated [1/2] to back to checking readonly
flag and consolidate the eventfs_entries.

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


 kernel/trace/trace.c        |  164 +++++++++++++++++++++++++++++++++++--------
 kernel/trace/trace.h        |   14 +++-
 kernel/trace/trace_boot.c   |    5 +
 kernel/trace/trace_events.c |   68 +++++++++++-------
 4 files changed, 191 insertions(+), 60 deletions(-)

--
Masami Hiramatsu (Google) <mhiramat@kernel.org>
