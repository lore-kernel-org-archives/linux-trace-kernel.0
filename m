Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADDB831D371;
	Mon, 13 Apr 2026 22:35:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776119744; cv=none; b=sbRWZxFE7BdWi8VRk42zy9enjUGnEt9UPJzZqqGk9o+PnwbN+qlLFTpPuOKof1bw6JijjZCPckypjBXASoFRI+qA4vAQIyoEK74P+b0rodHpYTXC1b+Oz5b0KISTqcUDxhwZ1fGJw+DLfFcPlTTfXg/fxER0sSP0BxuIpsOkiw0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776119744; c=relaxed/simple;
	bh=KfSeBaI1YbCKipz3DMKajb6NVWbmhp1fk+9hEWjuUBY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=epdv1NC13UEGT/0z6Jo4M5wkEtYKopoeNEkn9rhtlQnAKXIMkzWhOpkFLwa/8Y92HSQL+XgsVpvBIHjEU/WMrJ8NE1B0cikHhuM6zUpzlUHSKSExU5OEz+5fpVGR9oweaDBJCkZANkwOM9sHOr7RAsVR36wudN6VTu42iuzPx98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oquelxOm; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oquelxOm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2A3FC2BCAF;
	Mon, 13 Apr 2026 22:35:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776119744;
	bh=KfSeBaI1YbCKipz3DMKajb6NVWbmhp1fk+9hEWjuUBY=;
	h=From:To:Cc:Subject:Date:From;
	b=oquelxOm/YilB39Gh6cvwnLSyP+jurXUr2VAmJcWQXiGKuV6fuDPLqIq1KpglkD/h
	 ELnWKSVlLvB7CfTGUCPIE+uOLpHr2rKb6Up1jLLZbWyNiZmtd7N4MnCSdIRW/HspIi
	 vjy/Did/KR0uyvgneA7RMzGjnxjg2lmk7TTUOTC+nQQC3w9+glt4VmaGtdK1rPcp9D
	 lRf7NiVlaO0fqQe7mvYBVgFd7cS+y7BRpNoYq3+KTFSfu3DGpLdJgCjvUmjeLewzMF
	 769BGkaBe4xC0Mhm45FFM/A3lVT9xVY11u/TA8u/VhUl0nGaTyYiQwm+oOlMHttI6+
	 gBc5bFBZbxwpA==
From: Tom Zanussi <zanussi@kernel.org>
To: rostedt@goodmis.org
Cc: pengpeng@iscas.ac.cn,
	mhiramat@kernel.org,
	mathieu.desnoyers@efficios.com,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH 0/2] tracing: fully-qualified var-ref testcase
Date: Mon, 13 Apr 2026 17:35:36 -0500
Message-ID: <cover.1776112478.git.zanussi@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Steve,

Here's the testcase for fully-qualified var references mentioned here
[1].

While working on it, I realized that the printing of the
fully-qualified references was wrong (because the testcases use that
output to remove the trigger), so added the first patch.

It depends on Pengpeng Hou's patch:

  [PATCH v2 1/2] tracing/hist: rebuild full_name on each hist_field_name() call

Thanks,

Tom

[1] https://lore.kernel.org/lkml/36cf0fc5ee3a4476b0a70536d212278a9ee4d380.camel@kernel.org/

Tom Zanussi (2):
  tracing: Fix fully-qualified variable reference printing in histograms
  selftests/ftrace: Add test case for fully-qualified variable
    references

 kernel/trace/trace_events_hist.c              | 15 +++++---
 .../trigger-fully-qualified-var-ref.tc        | 34 +++++++++++++++++++
 2 files changed, 44 insertions(+), 5 deletions(-)
 create mode 100644 tools/testing/selftests/ftrace/test.d/trigger/inter-event/trigger-fully-qualified-var-ref.tc

-- 
2.43.0

