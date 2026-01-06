Received: from imap4.hz.codethink.co.uk (imap4.hz.codethink.co.uk [188.40.203.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E5DA2E542C;
	Tue,  6 Jan 2026 23:11:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=188.40.203.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767741064; cv=none; b=gLEXZ/CHpQfZ8TU7fucpOEM5EnbP6762G/2OeG+0Da35BrMLS1H+Gc60ooCJN3IWQMVOCvy8RblxbnMRC9JHjehEA7ucKoCes5w7LJSSfvnkvnsDqWlD7+jru0I1BMTBoeniPnDNAQVpv+G+5CJgcd9VS6mmblKhmSoiZr8AMtw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767741064; c=relaxed/simple;
	bh=VxnBrO1/IiParbQFoVGZ3Ak+Y5mmkMSO+x0JyAMZB78=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=VclI//7EIWHWS131avQZfbl00PzOurphBRl0ygAHZxOIS0jCT4iFETHTJtNi8N+VmCEXbv05OnmRT4TNY1bfsf3BdbAqeEBfSr+fE5RSufuAioAeEBr8XmLA+hr64kMJwMuajhG/p5re6d89rLeBU8Nz+k7ov7AbPVSXzgPcYkY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=codethink.co.uk; spf=pass smtp.mailfrom=codethink.com; dkim=pass (2048-bit key) header.d=codethink.co.uk header.i=@codethink.co.uk header.b=eg8oKh/1; arc=none smtp.client-ip=188.40.203.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=codethink.co.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codethink.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codethink.co.uk header.i=@codethink.co.uk header.b="eg8oKh/1"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=codethink.co.uk; s=imap4-20230908; h=Sender:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:In-Reply-To:
	References; bh=OgvaNCYOKbAO4nZMK3bpBDhFm8EcueI4CTUg7sO8nl0=; b=eg8oKh/1KnKzy3
	evgfF8heljcx6fHuFZqW2u0vPVN7UCjyMi/w0PI+63aSeWsD3s7xOIaijbJnqiwk5dGyYRzpWDQYu
	19m+NmVWEeNMWMYuhJ/Wn51Z1OfuFbs2RUgE677MqCOx3QQb4WvGEM6orzcSAdQblthnc6mQg1o87
	qu7TcNf8se5CfOaNYXaHXMcP7JbOWsRZDfCrZUxwFKg2fiNAVlPZtUgm5yMhS3tuE/IKxGwV+DIZa
	hMVYZJYYjPE3hggK7jo7lalAa7WNPEDEm+VEsk8hLMwCYWkgLnjeFYL0eUWVuLy+152nXJIFL9anF
	yXoXOcm/pUcdJ1Wup1UQ==;
Received: from [63.135.74.212] (helo=rainbowdash)
	by imap4.hz.codethink.co.uk with esmtpsa  (Exim 4.94.2 #2 (Debian))
	id 1vdGCV-008flT-R1; Tue, 06 Jan 2026 23:10:55 +0000
Received: from ben by rainbowdash with local (Exim 4.99.1)
	(envelope-from <ben@rainbowdash>)
	id 1vdGCV-00000000LvP-1HQC;
	Tue, 06 Jan 2026 23:10:55 +0000
From: Ben Dooks <ben.dooks@codethink.co.uk>
To: linux-trace-kernel@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	mhiramat@kernel.org,
	mathieu.desnoyers@efficios.com,
	rostedt@goodmis.org,
	Ben Dooks <ben.dooks@codethink.co.uk>
Subject: [PATCH] trace: ftrace_dump_on_oops[] is not exported, make it static
Date: Tue,  6 Jan 2026 23:10:54 +0000
Message-Id: <20260106231054.84270-1-ben.dooks@codethink.co.uk>
X-Mailer: git-send-email 2.37.2.352.g3c44437643
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: srv_ts003@codethink.com

The ftrace_dump_on_oops string is not used outside of trace.c so
make it static to avoid the export warning from sparse:

kernel/trace/trace.c:141:6: warning: symbol 'ftrace_dump_on_oops' was not declared. Should it be static?

Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
---
 kernel/trace/trace.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index 6f2148df14d9..5c196ea93768 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -138,7 +138,7 @@ cpumask_var_t __read_mostly	tracing_buffer_mask;
  * by commas.
  */
 /* Set to string format zero to disable by default */
-char ftrace_dump_on_oops[MAX_TRACER_SIZE] = "0";
+static char ftrace_dump_on_oops[MAX_TRACER_SIZE] = "0";
 
 /* When set, tracing will stop when a WARN*() is hit */
 static int __disable_trace_on_warning;
-- 
2.37.2.352.g3c44437643

