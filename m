Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBF7E3EFFAE;
	Fri, 26 Jun 2026 14:14:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782483291; cv=none; b=JR1KOUe7m6zn7VDARKKkepXJaPc1F4/KCyte+qFEe9kUCnCTy4IcJ/MDLSBPprt1xUN3OdQC6Io6/fUYwnB8R5QhO4rdzL+AwLb9DkT+ax85dfpAyXs3u/2F1qOkjLenJ2MBnDT++tMUt9OhklKIrmNZqn1xFKSQlUCX4/8hljw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782483291; c=relaxed/simple;
	bh=iwvJEEmSo6kakYtR3FrwdqO9JhTL7AXMa5BsjUanyOU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=F4cz0M9tYYaF32Y69USXSDj6YKkM/r/D+MmUPZor13nkfl6MqzGzBoC049y4K7RABf5LDNJjKDHs6mIl4KpqBbeKbVas72zr3cqR02uHF/F8WKvgjMeFQDxeuDa8nE6hoK+ndz/EtVv9Mvd3h+K9H1xErHgTwnkHZsTG2G04+9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hJS3pV1Z; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hJS3pV1Z"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D14D1F000E9;
	Fri, 26 Jun 2026 14:14:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782483290;
	bh=DRQQpc50/HOc5q+xOiqMoSHrmuL8PZ/YatZQSWy4Uu4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=hJS3pV1Zexa+WcZsLne1IHF/E+pVDkx8yNsPhfMHYalHzy++BcXRhsACExWufF0O/
	 QB17u9KhqjnGMFmGIPuXmptaSsCvX9M+LKsiHj6cUlweeU/Y/AVJT4fD4hdIwSEo1m
	 N8ps5W6aMkGl7xzh1638Y1SIWF2cI6PLDikLYlmMkrktwMtGxs4BSPZIpra2k+B+3f
	 RktnAgUwg+yc+/+I0irODp8E3mhb3UqYHMQyVMUtX2gJOGW9b3G9a+BtihNv8R3ttt
	 gRcZNzbSFcfKXDwh0ZJjlVbCpcVW//Fx12/dBuEG6vHR7fnBctsTOHpP7Mtzd3XV5I
	 mT8QTg3jrmySQ==
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
Subject: [PATCH v11 03/11] tools/bootconfig: Ignore comment lines in dynamic_events/kprobe_events file
Date: Fri, 26 Jun 2026 23:14:46 +0900
Message-ID: <178248328618.841606.12096364096224070176.stgit@devnote2>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <178248325671.841606.17344906774310339507.stgit@devnote2>
References: <178248325671.841606.17344906774310339507.stgit@devnote2>
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

