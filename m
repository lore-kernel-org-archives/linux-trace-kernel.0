Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CAAB2F7F0A;
	Tue, 13 Oct 2026 20:54:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791924859; cv=none; b=hKfvjkqVeQ+uYKD22FPAZnDOuSGxxglWpypnd4h0tdEJ7sWt6SyP/ywnOgVQAvkdzyqUj/UUacZL16mzMQrYj4Xnc8LQOf7OvFr2PZa+PKC1NXLtYynlmfeeA5FiPiUXJ9UC9c2Zn4NStX3R3yZJ4BVhtYHElHNhuRhwHK6uzSA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791924859; c=relaxed/simple;
	bh=Bn8oR+l+zR+ZM6syV+GQYRZ8h9hjje3iIS0akDpqeFo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=B+heZtV7O+OYpdqoE1VyE3NfJMX+f+UcllnsUhGQA5Fsu6eyshwATqKznz+qQZzsmqmRrdLq8nneL5R6ccawfXgdCZd11RMAuijejAmvpOM2Vuz3HIX4wgsofHW/s01K744+X+wExu78tUQNfF2fAjWsyu/r8s2XG059R3fHshE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b2p4IUz3; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b2p4IUz3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 829041F00893;
	Tue, 13 Oct 2026 20:54:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791924858;
	bh=6Yt2BLc1q9KTroObaUHnDNXB1Vc5/5ysO1qCbeCq82A=;
	h=From:To:Cc:Subject:Date;
	b=b2p4IUz3rNsk0+5oZsUlp0s97gfDJmik4/xjcPlzslrNo+sJK4iF8d6FECFb85cW9
	 oawWeHc395QMMLayQYXabzRP1sggZ6g9k0u8GVocYGbyLu/yGTjW7dAYc5H68YwdgF
	 pBXvUzYEzORkfJUfTlXcbRWkIvf+IBNaJ7AJ5Xd3C6PRO8V7rFlzXvtF7HZZtd8mgW
	 61b3dfpbqXYso3+C7teMXqHZ8RAdEofoRjOPyFqocpUziZZOgb1kt4DMjQtiFfgnNP
	 0zzl+yhgOGHs19xnr/ImokMq0UxqCHAKnK4s4I9sQfC5npsCuTvrSwDX5apmYSB511
	 IyHJZcSG37muA==
From: Arnd Bergmann <arnd@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Yu Peng <pengyu@kylinos.cn>,
	Thomas Gleixner <tglx@kernel.org>,
	=?UTF-8?q?Thomas=20Wei=C3=9Fschuh=20=28Schneider=20Electric=29?= <thomas.weissschuh@linutronix.de>,
	Namhyung Kim <namhyung@kernel.org>,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH] tracing/synthetic: avoid comparing string against NULL
Date: Tue, 13 Oct 2026 22:53:52 +0200
Message-ID: <20261013205412.2579779-1-arnd@kernel.org>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnd Bergmann <arnd@arndb.de>

gcc-10 warns about passing a NULL argument into __synth_event_add_val(),
which uses it in an unchecked strcmp():

In function '__synth_event_add_val',
    inlined from 'synth_event_add_next_val' at kernel/trace/trace_events_synth.c:2162:9:
kernel/trace/trace_events_synth.c:2076:8: error: argument 2 null where non-null expected [-Werror=nonnull]
 2076 |    if (strcmp(field->name, field_name) == 0)
      |        ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
In file included from include/linux/string.h:65,
                 from kernel/trace/trace_events_synth.c:8:
kernel/trace/trace_events_synth.c: In function 'synth_event_add_next_val':
arch/s390/include/asm/string.h:39:5: note: in a call to function 'strcmp' declared here
   39 | int strcmp(const char *s1, const char *s2);
      |     ^~~~~~

The code is actually correct here, as the trace_state->add_name
does check for it, but this is hard for the compiler to prove.

Avoid the problem by repeating the check where the compiler
sees it.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 kernel/trace/trace_events_synth.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/kernel/trace/trace_events_synth.c b/kernel/trace/trace_events_synth.c
index dc15658a887c..c1287ca95aff 100644
--- a/kernel/trace/trace_events_synth.c
+++ b/kernel/trace/trace_events_synth.c
@@ -2073,7 +2073,8 @@ static int __synth_event_add_val(const char *field_name, u64 val,
 	if (trace_state->add_name) {
 		for (i = 0; i < event->n_fields; i++) {
 			field = event->fields[i];
-			if (strcmp(field->name, field_name) == 0)
+			if (!field_name ||
+			    strcmp(field->name, field_name) == 0)
 				break;
 		}
 		if (!field) {
-- 
2.53.0

