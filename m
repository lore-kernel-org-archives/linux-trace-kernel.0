Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A56D9239E75
	for <linux-trace-kernel@vger.kernel.org>; Mon, 19 Jan 2026 21:04:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768856701; cv=none; b=MwXu70KmQAdHdAi+k2ojnMqcMvMWxJ+24hhJaoqTTuhD05biZYkTwmPPDsvDfYeCqMAckSzBYtQLS0VGlR3UWS0+qdulpGseyWk5zci9KSmvef8gCBZe0ar2Sr9G3JSleJhjZyGQAPXguFX/FYEh0/5ICukn/Sxmhtgf+MVqmbc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768856701; c=relaxed/simple;
	bh=f2SqH/fw4uU2GRKBJhy3PgUfEnkJ0k0kZ7Wj00Pd78A=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dJPjpCa67oD8e6rgYOgQHXpYOm/8p25G4OROFzjwb+Z/BtDDsbqR49ijIRlQPbrdS+yS86tH2g4sctmIUG1+iv/0djbZy6soG60z1qndVleo1vbz2ikxuieoY1wis1vCGfpbUf5WiLJIap+i0RaqD0bjOpffBY07/B6QGvaS26U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=iaBVuq1v; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iaBVuq1v"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1768856688;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oKSRzVqBoQOOo4lbHRVM5q4aKhOza8YqKKV/MGsaxoE=;
	b=iaBVuq1vlAMDZZIuLu9CH3fQZbE0bSUAz+kwOkK9VpUn6oS6hk8TRyVtxv9CQAWGfXQ5+K
	PTNnk1CpYmukb0I6DWgYc2vN2chw3d8wbRYL395oaN4xAVNar1NXSBZ/+t+3nvwm5FQQpf
	6XwqrNcYe4vsk6/23BTUawmO3/KZAfs=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-384-naREuLfuMpWfuNh6olJyqQ-1; Mon,
 19 Jan 2026 16:04:45 -0500
X-MC-Unique: naREuLfuMpWfuNh6olJyqQ-1
X-Mimecast-MFC-AGG-ID: naREuLfuMpWfuNh6olJyqQ_1768856684
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 31CD21956095;
	Mon, 19 Jan 2026 21:04:44 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.22.80.137])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id AC78D19560AB;
	Mon, 19 Jan 2026 21:04:41 +0000 (UTC)
From: Wander Lairson Costa <wander@redhat.com>
To: Steven Rostedt <rostedt@goodmis.org>,
	Gabriele Monaco <gmonaco@redhat.com>,
	Nam Cao <namcao@linutronix.de>,
	Wander Lairson Costa <wander@redhat.com>,
	linux-kernel@vger.kernel.org (open list),
	linux-trace-kernel@vger.kernel.org (open list:RUNTIME VERIFICATION (RV))
Subject: [PATCH 15/26] rv/rvgen: use class constant for init marker
Date: Mon, 19 Jan 2026 17:45:51 -0300
Message-ID: <20260119205601.105821-16-wander@redhat.com>
In-Reply-To: <20260119205601.105821-1-wander@redhat.com>
References: <20260119205601.105821-1-wander@redhat.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

Replace hardcoded string literal and magic number with a class
constant for the initial state marker in DOT file parsing. The
previous implementation used the magic string "__init_" directly
in the code along with a hardcoded length of 7 for substring
extraction, which made the code less maintainable and harder to
understand.

This change introduces a class constant init_marker to serve as
a single source of truth for the initial state prefix. The code
now uses startswith() for clearer intent and calculates the
substring position dynamically using len(), eliminating the magic
number. If the marker value needs to change in the future, only
the constant definition requires updating rather than multiple
locations in the code.

The refactoring improves code readability and maintainability
while preserving the exact same runtime behavior.

Signed-off-by: Wander Lairson Costa <wander@redhat.com>
---
 tools/verification/rvgen/rvgen/automata.py | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/tools/verification/rvgen/rvgen/automata.py b/tools/verification/rvgen/rvgen/automata.py
index b302af3e5133e..8548265955570 100644
--- a/tools/verification/rvgen/rvgen/automata.py
+++ b/tools/verification/rvgen/rvgen/automata.py
@@ -25,6 +25,7 @@ class Automata:
     """
 
     invalid_state_str = "INVALID_STATE"
+    init_marker = "__init_"
 
     def __init__(self, file_path, model_name=None):
         self.__dot_path = file_path
@@ -96,8 +97,8 @@ class Automata:
 
             #  "enabled_fired"}; -> enabled_fired
             state = raw_state.replace('"', '').replace('};', '').replace(',', '_')
-            if state[0:7] == "__init_":
-                initial_state = state[7:]
+            if state.startswith(self.init_marker):
+                initial_state = state[len(self.init_marker):]
             else:
                 states.append(state)
                 if "doublecircle" in self.__dot_lines[cursor]:
-- 
2.52.0

