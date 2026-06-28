Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49AEE2F7EE2;
	Sun, 28 Jun 2026 23:52:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782690728; cv=none; b=PnqDwMYr/YOKA7J2lrn0jW2Eqkqx0vbHZmfRL5RAYeqhuAVUfPKD+FOYXzKsPOiZ4l1ZAXo9gCdac/OqF6BX9eUrDv3TyVLSNTXVnmfBzdzTtZMBpa5qGv9ocU3+WTZayIs18MBQCGiz8BgUb+jpGW24hOcDfLvXBGYgdjAXoUo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782690728; c=relaxed/simple;
	bh=o3fcbFp0pBvZ6VeygN5BLrM057jFH+3OjGKMeTl88Ko=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MiLH1sYEfv+KOzE9DBnoujL/xtZxxum7a4hOa2O/09PAWIzbHbW20xvRXjAwM0YDtSfqm01XRON8/P396UTiBEOgHqsn05AZrBxlXj8/RMsRN5F4p5H7fn9qQb8/Cj3tFQUbF6LfRtHIfr5xEvS6Gv0LKwMspXduh+34zYTPsQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fSG6n3Zy; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fSG6n3Zy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4E511F000E9;
	Sun, 28 Jun 2026 23:52:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782690726;
	bh=IwXYV//eN/UulKrBQVQ9tKlK1h/PJvqTlVUST+nm2pU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=fSG6n3ZyLl8toRgb0ipPrbNHvz2p/aMRa6XkkqC9KQ8ccaOCL1viRx6WFCqnzSSHz
	 BcsJk5f8BFEtS11G22yQqBaPu0AvrIiPhmnImK62PR7LYTHiswhTgl5aseZq+NyZyr
	 ibBWDxxQchITIpXTJXfAEZRDTJiUUgIkYOT9+LFW7tXbBSfyaTBdK/MaRocz7W+pjB
	 muK6VUDED6mcqeV3gR8GcgqysLYKd1n4hIye0gIMiRNBR4KiWESrMLeULD5mbGIZ3/
	 lgAWbGTimpQP1K2x82era+bIQeXgdEJtsI3UzOvJlFXrlyzG0+5wYTi4XB3+KSptOf
	 3L871G81JihJQ==
From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH v12 04/11] perf/probe: Ignore comment lines in dynamic_events/kprobe_events file
Date: Mon, 29 Jun 2026 08:52:02 +0900
Message-ID: <178269072265.1161310.10216930316552704905.stgit@devnote2>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <178269068329.1161310.17763177188897860801.stgit@devnote2>
References: <178269068329.1161310.17763177188897860801.stgit@devnote2>
User-Agent: StGit/0.19
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

From: Masami Hiramatsu (Google) <mhiramat@kernel.org>

Since dynamic_events/kprobe_events files show the fetcharg debug
information as comment lines, its reader needs to ignore it.

Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
---
 tools/perf/util/probe-file.c |    2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/perf/util/probe-file.c b/tools/perf/util/probe-file.c
index 4032572cbf55..4d12693a83b3 100644
--- a/tools/perf/util/probe-file.c
+++ b/tools/perf/util/probe-file.c
@@ -197,6 +197,8 @@ struct strlist *probe_file__get_rawlist(int fd)
 		idx = strlen(p) - 1;
 		if (p[idx] == '\n')
 			p[idx] = '\0';
+		if (buf[0] == '#')
+			continue;
 		ret = strlist__add(sl, buf);
 		if (ret < 0) {
 			pr_debug("strlist__add failed (%d)\n", ret);

