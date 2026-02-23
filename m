Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD4AD313E01
	for <linux-trace-kernel@vger.kernel.org>; Mon, 23 Feb 2026 16:30:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771864258; cv=none; b=Oww99GYEuFB/Zq6nm1loM64oXVNF7k5V4AFo6X2JbmTde3Ah96u5P+KaZznUTlZ4ttViKSJrtXigEWvOtpwBBlNCS+VByb08jcdgbLH1Uok2El6//JmLMjdWJxYf98010mk2ApFxcw/yM+H2n9huEX6TOELEOMNphSzcNxRPQzw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771864258; c=relaxed/simple;
	bh=4M22TMqr4Kp7d6uOCNhz/fRmCEbkYk7/hUz8OUuWkys=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=tPrfiJ3aRAYMcM7tH1vj6e5hqrceNI5c9cYFz9V5h6+NS/50eWOeF3cIUs6JhPtaFyL0epBb8U6M+hJtelne3yOGVeRGfwB/b1HQx3+5hvVktZaBo8AHNaxodc5jAFcwrBIRa+ahccwhdBDRC23C2IjwRSgyb8HIYrNgaf74PQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MFi/WJ8Q; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MFi/WJ8Q"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1771864255;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AHpeVA2TW9g1nzpiKCBeIjVkqx/nyz9EMg/ZqH0sr8w=;
	b=MFi/WJ8QB/ZODDA3KaULopsRIvMFZytjv8N6DwyUbtOuXi07HqaRV4pOn23lnd6ocJhEUG
	dUK2oCmWDrQwBeklXxhFKh3JBLSpLUeSdrHbwueSTekUrm4w716Jea8L178FuuVy4zSoa5
	sUOf7IAP59Xw9RiFZU0zHtUJPfAy3c0=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-628-jioOAsEAM0GA8o3Fu3jJXg-1; Mon,
 23 Feb 2026 11:30:51 -0500
X-MC-Unique: jioOAsEAM0GA8o3Fu3jJXg-1
X-Mimecast-MFC-AGG-ID: jioOAsEAM0GA8o3Fu3jJXg_1771864249
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 542B9195608F;
	Mon, 23 Feb 2026 16:30:49 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.22.88.94])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 3BC791800370;
	Mon, 23 Feb 2026 16:30:46 +0000 (UTC)
From: Wander Lairson Costa <wander@redhat.com>
To: Steven Rostedt <rostedt@goodmis.org>,
	Gabriele Monaco <gmonaco@redhat.com>,
	Nam Cao <namcao@linutronix.de>,
	Wander Lairson Costa <wander@redhat.com>,
	linux-trace-kernel@vger.kernel.org (open list:RUNTIME VERIFICATION (RV)),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v3 17/19] rv/rvgen: enforce presence of initial state
Date: Mon, 23 Feb 2026 13:18:00 -0300
Message-ID: <20260223162407.147003-18-wander@redhat.com>
In-Reply-To: <20260223162407.147003-1-wander@redhat.com>
References: <20260223162407.147003-1-wander@redhat.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
X-Mimecast-MFC-PROC-ID: Izmk6K-__cKUOPgpCbaIN0Vl0otjr0mS3BkcHJT8E1E_1771864249
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

The __get_state_variables() method parses DOT files to identify the
automaton's initial state. If the input file lacks a node with the
required initialization prefix, the initial_state variable is referenced
before assignment, causing an UnboundLocalError or a generic error
during the state removal step.

Initialize the variable explicitly and validate that a start node was
found after parsing. Raise a descriptive AutomataError if the definition
is missing to improve debugging and ensure the automaton is valid.

Signed-off-by: Wander Lairson Costa <wander@redhat.com>
Reviewed-by: Gabriele Monaco <gmonaco@redhat.com>
---
 tools/verification/rvgen/rvgen/automata.py | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/tools/verification/rvgen/rvgen/automata.py b/tools/verification/rvgen/rvgen/automata.py
index fd2a4a0c3f6eb..ac765c9b2dece 100644
--- a/tools/verification/rvgen/rvgen/automata.py
+++ b/tools/verification/rvgen/rvgen/automata.py
@@ -145,6 +145,7 @@ class Automata:
         # wait for node declaration
         states = []
         final_states = []
+        initial_state = ""
 
         has_final_states = False
         cursor = self.__get_cursor_begin_states()
@@ -171,6 +172,9 @@ class Automata:
                     final_states.append(state)
                     has_final_states = True
 
+        if not initial_state:
+            raise AutomataError("The automaton doesn't have an initial state")
+
         states = sorted(set(states))
         states.remove(initial_state)
 
-- 
2.53.0

