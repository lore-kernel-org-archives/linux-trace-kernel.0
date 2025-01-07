Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7A2C1DF756;
	Tue,  7 Jan 2025 12:11:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736251880; cv=none; b=GV975GyDpkJtrfLmfCaPG/RmpCBs0AhFWGs5xA+1LzWiukW5JSiLBwBisYTJqCdYEFAIr2TdPCAbmO1VV1zkkVBNWJpDX7d78NdrAK5lbPh7ccMDfNO16CGLw1rXBAWvpa6kf2IXjqx8xKfihSar9Reblp2jo4OErVIzMEDXx8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736251880; c=relaxed/simple;
	bh=ttXlZYbcu4cUdbyQCrfr2kVGW2kymYPcsMSHBJkkeC4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TaWrvcwUl6MlPbfR3x7ovf6D+g4u2FQk3kHvAGvhMsG4WHv63aTop3KEsvKj9Cy+gZRMAUIeVoMYBvGNF6wrGflJnN18IhyUph3qmS5MTl5cg7WzsuENE2LPozsRbTUoIjgNWc/O2uq04N3oJVAD8JXyUT+AC7CqwqMamzjYQyQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=urnK4yTw; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="urnK4yTw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D343FC4CED6;
	Tue,  7 Jan 2025 12:11:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736251880;
	bh=ttXlZYbcu4cUdbyQCrfr2kVGW2kymYPcsMSHBJkkeC4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=urnK4yTwSzoFUTtqQemH2ZW+560oyeAbM9+93TtKoU9/2bSYsCau+JydwgPJOnTON
	 fWBhbTworCgtk8yjbmtcZ0NXe4TAfwD94zQhq3H04eOZUvZnoCfHZnfKTp4CIDrdDJ
	 HUlhrZhcuEtUG0wY/YzLDKMrISx4Y2nSbs1H/hI5l6yA1hQMxBZ3WxXeVoRyKgKOBm
	 DBLK/Jh45ewANXE6UlI7/t1L+I36FlEt8KtXSN/79Ok2AJQbK9BJd0WZMbGqNgY68r
	 xrZ8NorxHZ1jyTNZ2nZqrjflyATU3NKOtt/YtX3TqGGXOVNeCeytJkQuAV5P+Z20Xl
	 gdxY8UkgJR6cg==
From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>,
	Shuah Khan <shuah@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	mhiramat@kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH 2/2] selftests/ftrace: Make uprobe test more robust against binary name
Date: Tue,  7 Jan 2025 21:11:16 +0900
Message-ID: <173625187633.1383744.2840679071525852811.stgit@devnote2>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <173625185823.1383744.4020760882101555349.stgit@devnote2>
References: <173625185823.1383744.4020760882101555349.stgit@devnote2>
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

Make add_remove_uprobe test case more robust against various real
binary name.
Current add_remove_uprobe.tc test expects the real binary of /bin/sh
is '*/bin/*sh', but it does not work on busybox environment.
Instead of using fixed pattern, use readlink to identify real binary
name.

Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
---
 .../ftrace/test.d/dynevent/add_remove_uprobe.tc    |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/ftrace/test.d/dynevent/add_remove_uprobe.tc b/tools/testing/selftests/ftrace/test.d/dynevent/add_remove_uprobe.tc
index a275decdc880..86c76679c56e 100644
--- a/tools/testing/selftests/ftrace/test.d/dynevent/add_remove_uprobe.tc
+++ b/tools/testing/selftests/ftrace/test.d/dynevent/add_remove_uprobe.tc
@@ -6,8 +6,10 @@
 echo 0 > events/enable
 echo > dynamic_events
 
+REALBIN=`readlink -f /bin/sh`
+
 echo 'cat /proc/$$/maps' | /bin/sh | \
-	grep "r-xp .*/bin/.*sh$" | \
+	grep "r-xp .*${REALBIN}$" | \
 	awk '{printf "p:myevent %s:0x%s\n", $6,$3 }' >> uprobe_events
 
 grep -q myevent uprobe_events

