Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0ADE526FD91
	for <linux-trace-kernel@vger.kernel.org>; Tue, 15 Jul 2025 07:15:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752563761; cv=none; b=mpIIysDGxgzs4uzCc3jPq4LU+lUm6/n36RRsi7NkoVcNhhX+PrvWWONKxrpsm0zrZiOgV8WkushGi9Y/3/K1Tthz9caI5WVW/GtRDK3tN2RB1CsGpZd44LiAqWr0xpdn3erJgoCOeJCI++f0aOHZJ9QlApZzmPRMKyH5R9DVVZo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752563761; c=relaxed/simple;
	bh=oxJC/T7bkz4/JCpLaCRHxfdvM7WuQxVIXdiukWYNGQU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rFKTCPtjuqtzoDPUZoT4Y12jg1nRADWWvCj9MKfzh1j2MyBGCxZcpwUyCxix1kROV84uZxVD1S/4mjyuQmMidq4t70MgU2+KnvgZOYw7i7ifmJOpU2d+pYrY8UXIP00YLjh3aFpg3d3gge6Knmu8FwMrzpu7YNt3VXiGbqwwhUE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Z0F2F+8z; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Z0F2F+8z"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752563759;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FSD+jH23zaW3frerppDPrVwREbeKazWgfVwxtrGntKo=;
	b=Z0F2F+8zYScXm9nL+TQxTCuKQWfoXak0uMaqMolfc3y5GOyYd3bFI3VOu8FPkAUzHdfDqb
	V5gl323F9S9yDBxQTgpYfoe+CJ3HwNoGxZuNJ4sZrRFXM7W6GgNFwkgZSLLvSL9++6BiGs
	cpSmCR0KkCCiSvY8AUHnrdhvORxGD2A=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-611-jVO5ahnsOGWc5SYmW-ER4Q-1; Tue,
 15 Jul 2025 03:15:55 -0400
X-MC-Unique: jVO5ahnsOGWc5SYmW-ER4Q-1
X-Mimecast-MFC-AGG-ID: jVO5ahnsOGWc5SYmW-ER4Q_1752563754
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 570811956080;
	Tue, 15 Jul 2025 07:15:54 +0000 (UTC)
Received: from gmonaco-thinkpadt14gen3.rmtit.com (unknown [10.45.224.115])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 69E8E180035E;
	Tue, 15 Jul 2025 07:15:49 +0000 (UTC)
From: Gabriele Monaco <gmonaco@redhat.com>
To: linux-kernel@vger.kernel.org,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	linux-trace-kernel@vger.kernel.org
Cc: Gabriele Monaco <gmonaco@redhat.com>,
	Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Nam Cao <namcao@linutronix.de>,
	Tomas Glozar <tglozar@redhat.com>,
	Juri Lelli <jlelli@redhat.com>,
	Clark Williams <williams@redhat.com>,
	John Kacur <jkacur@redhat.com>
Subject: [PATCH v3 10/17] rv: Fix generated files going over 100 column limit
Date: Tue, 15 Jul 2025 09:14:27 +0200
Message-ID: <20250715071434.22508-11-gmonaco@redhat.com>
In-Reply-To: <20250715071434.22508-1-gmonaco@redhat.com>
References: <20250715071434.22508-1-gmonaco@redhat.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

The dot2c.py script generates all states in a single line. This breaks the
100 column limit when the state machines are non-trivial.
Recent changes allow it to print states over multiple lines if the
resulting line would have been too long.

Adapt existing monitors with line length over the limit.

Signed-off-by: Gabriele Monaco <gmonaco@redhat.com>
---
 kernel/trace/rv/monitors/sco/sco.h     | 12 ++++++++++--
 kernel/trace/rv/monitors/snep/snep.h   | 14 ++++++++++++--
 kernel/trace/rv/monitors/snroc/snroc.h | 12 ++++++++++--
 3 files changed, 32 insertions(+), 6 deletions(-)

diff --git a/kernel/trace/rv/monitors/sco/sco.h b/kernel/trace/rv/monitors/sco/sco.h
index 7a4c1f2d5ca1c..83ca9a03331af 100644
--- a/kernel/trace/rv/monitors/sco/sco.h
+++ b/kernel/trace/rv/monitors/sco/sco.h
@@ -39,8 +39,16 @@ static const struct automaton_sco automaton_sco = {
 		"schedule_exit"
 	},
 	.function = {
-		{     thread_context_sco, scheduling_context_sco,          INVALID_STATE },
-		{          INVALID_STATE,          INVALID_STATE,     thread_context_sco },
+		{
+			thread_context_sco,
+			scheduling_context_sco,
+			INVALID_STATE
+		},
+		{
+			INVALID_STATE,
+			INVALID_STATE,
+			thread_context_sco
+		},
 	},
 	.initial_state = thread_context_sco,
 	.final_states = { 1, 0 },
diff --git a/kernel/trace/rv/monitors/snep/snep.h b/kernel/trace/rv/monitors/snep/snep.h
index 6d16b9ad931e1..4cd9abb77b7b2 100644
--- a/kernel/trace/rv/monitors/snep/snep.h
+++ b/kernel/trace/rv/monitors/snep/snep.h
@@ -41,8 +41,18 @@ static const struct automaton_snep automaton_snep = {
 		"schedule_exit"
 	},
 	.function = {
-		{ non_scheduling_context_snep, non_scheduling_context_snep, scheduling_contex_snep,               INVALID_STATE },
-		{               INVALID_STATE,               INVALID_STATE,          INVALID_STATE, non_scheduling_context_snep },
+		{
+			non_scheduling_context_snep,
+			non_scheduling_context_snep,
+			scheduling_contex_snep,
+			INVALID_STATE
+		},
+		{
+			INVALID_STATE,
+			INVALID_STATE,
+			INVALID_STATE,
+			non_scheduling_context_snep
+		},
 	},
 	.initial_state = non_scheduling_context_snep,
 	.final_states = { 1, 0 },
diff --git a/kernel/trace/rv/monitors/snroc/snroc.h b/kernel/trace/rv/monitors/snroc/snroc.h
index c3650a2b1b107..be46f7b9ebb87 100644
--- a/kernel/trace/rv/monitors/snroc/snroc.h
+++ b/kernel/trace/rv/monitors/snroc/snroc.h
@@ -39,8 +39,16 @@ static const struct automaton_snroc automaton_snroc = {
 		"sched_switch_out"
 	},
 	.function = {
-		{      INVALID_STATE,  own_context_snroc,       INVALID_STATE },
-		{  own_context_snroc,      INVALID_STATE, other_context_snroc },
+		{
+			INVALID_STATE,
+			own_context_snroc,
+			INVALID_STATE
+		},
+		{
+			own_context_snroc,
+			INVALID_STATE,
+			other_context_snroc
+		},
 	},
 	.initial_state = other_context_snroc,
 	.final_states = { 1, 0 },
-- 
2.50.1

