Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4199038AC79;
	Mon, 29 Jun 2026 06:13:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782713625; cv=none; b=nkA78NXzvFTpI3dKO/zGJafsqtV1rDVTPLeKhVVUeYSHSPALtIYFtMT17eZSJemqpzDQyapE5Xd75Tpx/0MSVMUK1NhV+DJMy5QrUKGQo+Wvex+cAIfHmmuiEtXLa+LPBtEr7pdJHF+foT4+YA3bTD+AhpCJaYGOUr+YGr8dOzs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782713625; c=relaxed/simple;
	bh=o3fcbFp0pBvZ6VeygN5BLrM057jFH+3OjGKMeTl88Ko=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LO3BTfBtcPCvff2Io6j7bYZ/BQMgwfQkvaZMOowho0UcwERm8HwJNEDUmeVFSIUXYOx72fHFPdxBT9wzH5XM0YeYKZzFKUG6e3UrbPePSU0FBIqvZoSzNF9kA93LOUADES/Zh8M0bo/ZYysY3CW7VP1bMYBTwYDCl9YSqk3MoV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I/fPi33e; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I/fPi33e"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA5A01F000E9;
	Mon, 29 Jun 2026 06:13:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782713623;
	bh=IwXYV//eN/UulKrBQVQ9tKlK1h/PJvqTlVUST+nm2pU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=I/fPi33eTrn+iBtx7nmTb+N8YKtEz1HF1s+veaGxYh8/o+GiTVfwVJRCSWCbxBC4W
	 Z0rPkbXmCsn9CU8WoAJgsCkDjjXq9Uhdw51P4mU3tjHlGFoKUKbQUgAUavpVRHsUFU
	 eCYJwx4Lc3VrAPFISPnW7Fo2GTJ/UBVR8lizE9yhJ2l3yKxzWeS8Zzaz+jdGt2zmTW
	 g+snyn1kbKAuzDkdSonf3jAE9NXm3AsMrab8S4qaB4qDGgwdxcJX7dDULL5cymK8Mc
	 +QLXNUBfSSiw8YMxg/BSYfJkJTaSjmV/rDS8t0jvdUxAHgIsIg1GG+oE5JzV/Fn40o
	 E7II/SaGSzZPg==
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
Subject: [PATCH v13 04/11] perf/probe: Ignore comment lines in dynamic_events/kprobe_events file
Date: Mon, 29 Jun 2026 15:13:38 +0900
Message-ID: <178271361825.1176915.16095297120719039761.stgit@devnote2>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <178271357142.1176915.7193483024740701480.stgit@devnote2>
References: <178271357142.1176915.7193483024740701480.stgit@devnote2>
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

