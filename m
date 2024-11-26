Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1399946C;
	Tue, 26 Nov 2024 13:56:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732629375; cv=none; b=UsWcbbaEAHeG1St3BG/CGzVYuSrEmriEg+dTSF3ZU5L0r80ZaSJ59vwH6Sq4itEPJ4OG1GU888ByV3GSB0+pdAgAGbSvXMrgVTpRYQRYGq5QD5XmtMPS9oiEBdjH9XFGEHRaoNzt/zmmxQCwLHtYDEDrgsdljlHkqqk5RQbHA4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732629375; c=relaxed/simple;
	bh=ZAsbaqEaGI/WKQrfcJuQo3mVRFqOYmUFMiOfVZxFjiM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=LFQ30QkGif80HY/kGPiOI1HXl2Qlk80lXyZb3Yd3I78E65UzdlmEO7/npns0rYTkCeIjRk7dK7rRlVO9tM84Pms/ug+AyhEqDb8U4WYmaZiVGtn1YaKceCkZOf2vN2AieHvPCPelkj2vYwmaQdhRDR+TJCyfljifuQl+/RzcbpI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iZnPJa7Y; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iZnPJa7Y"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D33A9C4CECF;
	Tue, 26 Nov 2024 13:56:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732629375;
	bh=ZAsbaqEaGI/WKQrfcJuQo3mVRFqOYmUFMiOfVZxFjiM=;
	h=From:To:Cc:Subject:Date:From;
	b=iZnPJa7Y3I9EwedTFWfCLbMpqcI3A/Fy5upycSjL/CuBM89JRYoJ0LdiKzWThTvHD
	 D4kPsujI12LkclqAUu/WCthTDzQABSzqjrAsC+H1fVkda+CmagWQWkHWU2EFN5VKYe
	 HpCmghotnYvyppNEKMXT+nFKmudvIueKtBIiWArApdmUhXkReIQRvZ25HPGdqCNKAj
	 EGiSZwkFWrODoI/zKwM9sByPulgBtOEgB6hZUJk9Pe5BvgNc1sAT3yDQ1YJn04d45N
	 4qrDgGdFM32uipwXcczqzLw508nDDpEpuyxS3uI4+S7NEFnVbf+JEbzGBVoA0nwQEU
	 uoF80nn7Y8fqw==
From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>,
	Naveen N Rao <naveen@kernel.org>
Cc: Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	"David S . Miller" <davem@davemloft.net>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Oleg Nesterov <oleg@redhat.com>,
	Tzvetomir Stoyanov <tz.stoyanov@gmail.com>,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH 0/6] kprobes: tracing/probes: Fix and cleanup to use guard
Date: Tue, 26 Nov 2024 22:56:10 +0900
Message-ID: <173262937038.8323.5774362855789721936.stgit@devnote2>
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

This series fixes eprobes and cleanup kprobes and probe events in ftrace
to use guard() and scoped_guard() instead of pairs of mutex locks.

Some locks are still not using guard(). We need some more work to complete.

Thanks,

---

Masami Hiramatsu (Google) (6):
      tracing/eprobe: Fix to release eprobe when failed to add dyn_event
      kprobes: Adopt guard() and scoped_guard()
      tracing/kprobe: Adopt guard() and scoped_guard()
      tracing/uprobe: Adopt guard() and scoped_guard()
      tracing/eprobe: Adopt guard() and scoped_guard()
      tracing/dynevent: Adopt guard() and scoped_guard()


 kernel/kprobes.c              |  205 ++++++++++++++++++-----------------------
 kernel/trace/trace_dynevent.c |   12 +-
 kernel/trace/trace_eprobe.c   |   31 +++---
 kernel/trace/trace_kprobe.c   |   18 +---
 kernel/trace/trace_uprobe.c   |   15 +--
 5 files changed, 121 insertions(+), 160 deletions(-)

--
Masami Hiramatsu (Google) <mhiramat@kernel.org>
