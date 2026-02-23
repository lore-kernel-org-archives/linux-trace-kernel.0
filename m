Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBC6A313532
	for <linux-trace-kernel@vger.kernel.org>; Mon, 23 Feb 2026 16:27:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771864057; cv=none; b=AgqE9HcmQJK6QH3yiqBhUzv5P61EBhgTPOeqijjkrYFwJWUxCHlK1vOnm+1V45fTLvhJV1ai82kPIfkL6cpQM4pqkEZ6HLP2frIp97y2vMNnMMMGjw7T8IqJAQZPGV+KHLPhkS0rFjtkKyx8PXNyBpwT8u+nEwZOFrlWlS1o1Oo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771864057; c=relaxed/simple;
	bh=ntVk9vb5+bDGwMQjVfmIDX4VnU7IlD06N2nv4VO11SI=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=H35eqThk6BeBQm4s/3nE1QXUIbW4lYRRn327Ucork2aINkDhQLJ3LmpgBm3JNq4TUASAewDME5jjstHLoIjah3uX4WvLn5Y78Qc1XjMWVmVSiAeeJzUe9AL7LV2Hcjf7XQ9Zt0OkmYKK7/5fHbGABOUnSn0xkmApv/75wBPT2zw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FYSfq7az; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FYSfq7az"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1771864055;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sEf5cNZX+eiFDwZbI3I2oBbq99wA4y6PNvMILeXGY0M=;
	b=FYSfq7azaQgTydRYE+FNT/J8SydyQCvRgOTQWyBvhUcNhU31Fec3V1l8zq2FmjlrWoJ0v6
	yweX7T70Y7iMVFdrbWNzv+DmZyNKQfMndHvHBmT0mSGKxQ+cop2Rk0Qv9Frv/ficSmhh12
	1wm5BtUR8uQsG/8QW1YnmFNonOgomgc=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-381-0UdJbZN1MOChyKC2RyFpUg-1; Mon,
 23 Feb 2026 11:27:31 -0500
X-MC-Unique: 0UdJbZN1MOChyKC2RyFpUg-1
X-Mimecast-MFC-AGG-ID: 0UdJbZN1MOChyKC2RyFpUg_1771864050
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id B84331955F38;
	Mon, 23 Feb 2026 16:27:30 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.22.88.94])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 9EFDB1800669;
	Mon, 23 Feb 2026 16:27:28 +0000 (UTC)
From: Wander Lairson Costa <wander@redhat.com>
To: Steven Rostedt <rostedt@goodmis.org>,
	Gabriele Monaco <gmonaco@redhat.com>,
	Nam Cao <namcao@linutronix.de>,
	Wander Lairson Costa <wander@redhat.com>,
	linux-trace-kernel@vger.kernel.org (open list:RUNTIME VERIFICATION (RV)),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v3 07/19] rv/rvgen: fix typos in automata and generator docstring and comments
Date: Mon, 23 Feb 2026 13:17:50 -0300
Message-ID: <20260223162407.147003-8-wander@redhat.com>
In-Reply-To: <20260223162407.147003-1-wander@redhat.com>
References: <20260223162407.147003-1-wander@redhat.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
X-Mimecast-MFC-PROC-ID: dczn96cKD_reudu6tugl2VMUulAfVdzpL9soBeANZmc_1771864050
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

Fix two typos in the Automata class documentation that have been
present since the initial implementation. Fix the class
docstring: "part it" instead of "parses it". Additionally, a
comment describing transition labels contained the misspelling
"lables" instead of "labels".

Fix a typo in the comment describing the insertion of the initial
state into the states list: "bein og" should be "beginning of".

Fix typo in the module docstring: "Abtract" should be "Abstract".

Fix several occurrences of "automata" where it should be the singular
form "automaton".

Signed-off-by: Wander Lairson Costa <wander@redhat.com>
Reviewed-by: Gabriele Monaco <gmonaco@redhat.com>
---
 tools/verification/rvgen/rvgen/automata.py  | 8 ++++----
 tools/verification/rvgen/rvgen/dot2c.py     | 2 +-
 tools/verification/rvgen/rvgen/dot2k.py     | 4 ++--
 tools/verification/rvgen/rvgen/generator.py | 2 +-
 4 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/tools/verification/rvgen/rvgen/automata.py b/tools/verification/rvgen/rvgen/automata.py
index 10146b6061ed2..b25378e92b16d 100644
--- a/tools/verification/rvgen/rvgen/automata.py
+++ b/tools/verification/rvgen/rvgen/automata.py
@@ -3,7 +3,7 @@
 #
 # Copyright (C) 2019-2022 Red Hat, Inc. Daniel Bristot de Oliveira <bristot@kernel.org>
 #
-# Automata object: parse an automata in dot file digraph format into a python object
+# Automata class: parse an automaton in dot file digraph format into a python object
 #
 # For further information, see:
 #   Documentation/trace/rv/deterministic_automata.rst
@@ -33,7 +33,7 @@ class AutomataError(Exception):
     """
 
 class Automata:
-    """Automata class: Reads a dot file and part it as an automata.
+    """Automata class: Reads a dot file and parses it as an automaton.
 
     It supports both deterministic and hybrid automata.
 
@@ -153,7 +153,7 @@ class Automata:
         states = sorted(set(states))
         states.remove(initial_state)
 
-        # Insert the initial state at the bein og the states
+        # Insert the initial state at the beginning of the states
         states.insert(0, initial_state)
 
         if not has_final_states:
@@ -175,7 +175,7 @@ class Automata:
                 line = self.__dot_lines[cursor].split()
                 event = "".join(line[line.index("label") + 2:-1]).replace('"', '')
 
-                # when a transition has more than one lables, they are like this
+                # when a transition has more than one labels, they are like this
                 # "local_irq_enable\nhw_local_irq_enable_n"
                 # so split them.
 
diff --git a/tools/verification/rvgen/rvgen/dot2c.py b/tools/verification/rvgen/rvgen/dot2c.py
index fa44795adef46..9255cc2153a31 100644
--- a/tools/verification/rvgen/rvgen/dot2c.py
+++ b/tools/verification/rvgen/rvgen/dot2c.py
@@ -3,7 +3,7 @@
 #
 # Copyright (C) 2019-2022 Red Hat, Inc. Daniel Bristot de Oliveira <bristot@kernel.org>
 #
-# dot2c: parse an automata in dot file digraph format into a C
+# dot2c: parse an automaton in dot file digraph format into a C
 #
 # This program was written in the development of this paper:
 #  de Oliveira, D. B. and Cucinotta, T. and de Oliveira, R. S.
diff --git a/tools/verification/rvgen/rvgen/dot2k.py b/tools/verification/rvgen/rvgen/dot2k.py
index 47af9f104a829..aedc2a7799b32 100644
--- a/tools/verification/rvgen/rvgen/dot2k.py
+++ b/tools/verification/rvgen/rvgen/dot2k.py
@@ -167,14 +167,14 @@ class da2k(dot2k):
     def __init__(self, *args, **kwargs):
         super().__init__(*args, **kwargs)
         if self.is_hybrid_automata():
-            raise AutomataError("Detected hybrid automata, use the 'ha' class")
+            raise AutomataError("Detected hybrid automaton, use the 'ha' class")
 
 class ha2k(dot2k):
     """Hybrid automata only"""
     def __init__(self, *args, **kwargs):
         super().__init__(*args, **kwargs)
         if not self.is_hybrid_automata():
-            raise AutomataError("Detected deterministic automata, use the 'da' class")
+            raise AutomataError("Detected deterministic automaton, use the 'da' class")
         self.trace_h = self._read_template_file("trace_hybrid.h")
         self.__parse_constraints()
 
diff --git a/tools/verification/rvgen/rvgen/generator.py b/tools/verification/rvgen/rvgen/generator.py
index d932e96dd66d3..988ccdc27fa37 100644
--- a/tools/verification/rvgen/rvgen/generator.py
+++ b/tools/verification/rvgen/rvgen/generator.py
@@ -3,7 +3,7 @@
 #
 # Copyright (C) 2019-2022 Red Hat, Inc. Daniel Bristot de Oliveira <bristot@kernel.org>
 #
-# Abtract class for generating kernel runtime verification monitors from specification file
+# Abstract class for generating kernel runtime verification monitors from specification file
 
 import platform
 import os
-- 
2.53.0

