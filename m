Received: from mail.ispras.ru (mail.ispras.ru [83.149.199.84])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DD672EB5A7;
	Tue, 17 Jun 2025 15:21:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.149.199.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750173684; cv=none; b=lnvE7QJxjKVDuooTooGZuLc09/cFo18J0ZChFfV3njzIM2+odyzNTMDdNsYgEtp+pLwqL4iA0WeOG0ubSPNYxs+o/xmNlMM6YWwicFMqyCcQPmly4mgd2lHOHJynjVxLECwVWVT91GH1nEy+cMJOvlbYqe/T7YG4CQ+zT8HK4BU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750173684; c=relaxed/simple;
	bh=yKMNo20wGtG8swo9mIbbV4pAGur42BWT6KCNt0VlPtU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=FSLJIxLNAA4x0DtMLerTRgb6SlWyGY/oHdoUAYek7yI4bdmZBvCJZq7kkx85gBcSmKbNcqESkU1j/WOi/sC2GZywKkhtUPW/oTOgCTu5N05UCHirV5ANCW6dPcTCmwGBXtBwr3LoH0XeV8nZwJr7dLz7tDq1AYCjl0ehetLKcOI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ispras.ru; spf=pass smtp.mailfrom=ispras.ru; dkim=pass (1024-bit key) header.d=ispras.ru header.i=@ispras.ru header.b=K+EtJ6/E; arc=none smtp.client-ip=83.149.199.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ispras.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ispras.ru
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ispras.ru header.i=@ispras.ru header.b="K+EtJ6/E"
Received: from localhost.localdomain (unknown [178.69.224.101])
	by mail.ispras.ru (Postfix) with ESMTPSA id 52A22552F52E;
	Tue, 17 Jun 2025 15:21:19 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.ispras.ru 52A22552F52E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ispras.ru;
	s=default; t=1750173679;
	bh=Qv0/40tdPeceV308WPXjp/y7gd2dyE1vetqgtodqT74=;
	h=From:To:Cc:Subject:Date:From;
	b=K+EtJ6/EPFx6RqKwvFQIiV3sgFzWQBh6kNcWDefWdYzILG2znPAz5x++4LeaV1W/H
	 6YSTgVmVPz5EqtNzPzxgH6ojRaLyme3X1d0rzET4alqAv4o4WIEHVssAQFiAMZtb6F
	 KIt/oaVxF92v4hJY9j0h6swqodq8Kxv4bI5DYkr8=
From: Artem Sadovnikov <a.sadovnikov@ispras.ru>
To: linux-kernel@vger.kernel.org
Cc: Artem Sadovnikov <a.sadovnikov@ispras.ru>,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	linux-trace-kernel@vger.kernel.org,
	lvc-project@linuxtesting.org
Subject: [PATCH] fgraph: Make pid_str size match the comment
Date: Tue, 17 Jun 2025 15:21:09 +0000
Message-ID: <20250617152110.2530-1-a.sadovnikov@ispras.ru>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The comment above buffer mentions sign, 10 bytes width for number and null
terminator, but buffer itself isn't large enough to hold that much data.

This is a cosmetic change, since PID cannot be negative, other than -1.

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Signed-off-by: Artem Sadovnikov <a.sadovnikov@ispras.ru>
---
 kernel/trace/trace_functions_graph.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/trace/trace_functions_graph.c b/kernel/trace/trace_functions_graph.c
index a8c1f56340680..d789d308ab1de 100644
--- a/kernel/trace/trace_functions_graph.c
+++ b/kernel/trace/trace_functions_graph.c
@@ -344,7 +344,7 @@ static void print_graph_proc(struct trace_seq *s, pid_t pid)
 {
 	char comm[TASK_COMM_LEN];
 	/* sign + log10(MAX_INT) + '\0' */
-	char pid_str[11];
+	char pid_str[12];
 	int spaces = 0;
 	int len;
 	int i;
-- 
2.43.0

