Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC7FA2135A5;
	Wed, 19 Mar 2025 21:50:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742421049; cv=none; b=bMSgZlkPOYGHb8eD4Zh2FoSLenp1kBMSbEsRY62Lxd35FO1G3oIPhIzGEub9jWfVCWIUyJWVZvsXf7I0dQ6adEBL5S1/hlUXyiP5WMTNHsxPt5KCQ8q+CXPOnLbNqDteL2/MyzxP2kwxWZWMUihpUCoQBhxATd9gKDp3jynaWaw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742421049; c=relaxed/simple;
	bh=Q6CE9EVdM3McV8jaRwWAZwHvS6GQOQtPlMpTnMwXgg0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=TJ5gC/wSFPdeq2mJCsZBmwPHNyxCHWnNKLFe49SEcfts+hvghb5BFAfNb8PwOFaP5sWYdvF/ubxqUs/Rzt8lFMv2In1NlOuijaiduV5KKiH+z6uIiqFM7UR6qsMotgpwCF6ElYFu/vpfw1jMgOzgxZrE8FRr1KZX0zB0UVhywWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 216A4106F;
	Wed, 19 Mar 2025 14:50:54 -0700 (PDT)
Received: from e132430.arm.com (unknown [10.57.41.229])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id A9ACA3F673;
	Wed, 19 Mar 2025 14:50:44 -0700 (PDT)
From: Douglas RAILLARD <douglas.raillard@arm.com>
To: rostedt@goodmis.org
Cc: douglas.raillard@arm.com,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH] tracing: Align synth event print fmt
Date: Wed, 19 Mar 2025 21:50:27 +0000
Message-ID: <20250319215028.1680278-1-douglas.raillard@arm.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Douglas Raillard <douglas.raillard@arm.com>

The vast majority of ftrace event print fmt consist of a space-separated
field=value pair. Synthetic event currently use a comma-separated
field=value pair, which sticks out from events created via more
classical means.

Align the format of synth events so they look just like any other event,
for better consistency and less headache when doing crude text-based
data processing.

Signed-off-by: Douglas Raillard <douglas.raillard@arm.com>
---
 kernel/trace/trace_events_synth.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/trace/trace_events_synth.c b/kernel/trace/trace_events_synth.c
index e3f7d09e5512..07ff8be8267e 100644
--- a/kernel/trace/trace_events_synth.c
+++ b/kernel/trace/trace_events_synth.c
@@ -612,7 +612,7 @@ static int __set_synth_event_print_fmt(struct synth_event *event,
 		fmt = synth_field_fmt(event->fields[i]->type);
 		pos += snprintf(buf + pos, LEN_OR_ZERO, "%s=%s%s",
 				event->fields[i]->name, fmt,
-				i == event->n_fields - 1 ? "" : ", ");
+				i == event->n_fields - 1 ? "" : " ");
 	}
 	pos += snprintf(buf + pos, LEN_OR_ZERO, "\"");
 
-- 
2.43.0

