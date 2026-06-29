Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A270638945D;
	Mon, 29 Jun 2026 06:13:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782713613; cv=none; b=G+varUHuAxS3HRU/3njikDBsW8QIcbyLa1YQPD3eNkNg9VtuiBRSOaJoAvImEfLhSURcrBV4YSCm6c3932lA3znf4nRGlJeEra04I+JLrfUblt1AOSncaK19RCRHHyFATLAK8PANobJdt8ra45lYBOfHaPvsNyUMWL9LUn+BGlk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782713613; c=relaxed/simple;
	bh=iwvJEEmSo6kakYtR3FrwdqO9JhTL7AXMa5BsjUanyOU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PZydxigIFhZ8l5pdi0Y6mgrmuYbt09MIxa7Q2B8NrFQp8BhhMQRWaytoc/wDFsacbm7L+qZdHcpj3Igf0TtO0AIz46xtB9a9GhwY9IjwyAoISuRZOU8bV2YGV7OVxhbkwQ/wuVKISjkvwBqkW9VHjKwEOXaP8mueZ+1ddM/Jtk8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 15EE91F000E9;
	Mon, 29 Jun 2026 06:13:29 +0000 (UTC)
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
Subject: [PATCH v13 03/11] tools/bootconfig: Ignore comment lines in dynamic_events/kprobe_events file
Date: Mon, 29 Jun 2026 15:13:25 +0900
Message-ID: <178271360563.1176915.423090353815990910.stgit@devnote2>
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
 tools/bootconfig/scripts/ftrace2bconf.sh |    2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/bootconfig/scripts/ftrace2bconf.sh b/tools/bootconfig/scripts/ftrace2bconf.sh
index 1603801cf126..8eed445c295e 100755
--- a/tools/bootconfig/scripts/ftrace2bconf.sh
+++ b/tools/bootconfig/scripts/ftrace2bconf.sh
@@ -57,6 +57,8 @@ EOF
 kprobe_event_options() {
 	cat $TRACEFS/kprobe_events | while read p args; do
 		case $p in
+		\#*)
+		continue;;
 		r*)
 		cat 1>&2 << EOF
 # WARN: A return probe found but it is not supported by bootconfig. Skip it.

