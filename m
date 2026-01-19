Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BD5F257825
	for <linux-trace-kernel@vger.kernel.org>; Mon, 19 Jan 2026 21:03:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768856616; cv=none; b=Y2RqqRgaN1Oszb6z0ua0a1iwdTLVaCVR6cBlV5dS5hoYzgDcsQlGwldC4iXbuO1PbVvhSryreIVuTTYlYm4UZ0t9tlkS9ItrghMAB5F3eAOhhqJt8Z8AUJouUnGfONyf0CUj0BfH1iPu16Fht7FhZrntxqv7Qj1EnadYx/s/wBA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768856616; c=relaxed/simple;
	bh=Wee6i9AoESUMRTZTBQPlOjKVEuX4WYstZGjIBx1Vdto=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OOPIzTdZGEXjQQyA2IrjoXoIPPDrLox8cy6VFpFT0rfXDzTLtvjq8zNvgYG6bYrkJEnuhppEhbHGBBqAX0zbUylCV8zvJTXz/l+90ytbf/e5mx/VozxLWLGVvlvQSP2NbTQSBj30xWtJzp4SrO6Az3HHzs/B54Jg1aALx+2Xbik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=D5to+AiI; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="D5to+AiI"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1768856613;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ND9bvL6OiKftrWzmoh8F3v2WLvVwAgqURX1kym+kooo=;
	b=D5to+AiIprIY287hIFlk2H+MA4lTGCZ4JjVM/90G5gqTebXmyTbnJAKUq9vk55LPOiMKCr
	/QN+0FFpIBahfTsbcLK3cOoJZ6IOrVUpuRhZQv62Xw/V7J19wB4EnWsV2JLMJXesQNl6hi
	/of5gs55AX3cXoAwKeSslivu4KW9F/U=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-589-QtX2Y7igMlen9r8jT8QoLw-1; Mon,
 19 Jan 2026 16:03:32 -0500
X-MC-Unique: QtX2Y7igMlen9r8jT8QoLw-1
X-Mimecast-MFC-AGG-ID: QtX2Y7igMlen9r8jT8QoLw_1768856611
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 8801319560B5;
	Mon, 19 Jan 2026 21:03:31 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.22.80.137])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 0DC3619560AB;
	Mon, 19 Jan 2026 21:03:28 +0000 (UTC)
From: Wander Lairson Costa <wander@redhat.com>
To: Steven Rostedt <rostedt@goodmis.org>,
	Gabriele Monaco <gmonaco@redhat.com>,
	Nam Cao <namcao@linutronix.de>,
	Wander Lairson Costa <wander@redhat.com>,
	linux-kernel@vger.kernel.org (open list),
	linux-trace-kernel@vger.kernel.org (open list:RUNTIME VERIFICATION (RV))
Subject: [PATCH 12/26] rv/rvgen: fix PEP 8 whitespace violations
Date: Mon, 19 Jan 2026 17:45:48 -0300
Message-ID: <20260119205601.105821-13-wander@redhat.com>
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

Fix whitespace violations throughout the rvgen codebase to comply
with PEP 8 style guidelines. The changes address missing whitespace
after commas, around operators, and in collection literals that
were flagged by pycodestyle.

The fixes include adding whitespace after commas in string replace
chains and function arguments, adding whitespace around arithmetic
operators, removing extra whitespace in list comprehensions, and
fixing dictionary literal spacing. These changes improve code
readability and consistency with Python coding standards.

Signed-off-by: Wander Lairson Costa <wander@redhat.com>
---
 tools/verification/rvgen/rvgen/automata.py  | 12 ++++++------
 tools/verification/rvgen/rvgen/dot2c.py     |  2 +-
 tools/verification/rvgen/rvgen/dot2k.py     |  4 ++--
 tools/verification/rvgen/rvgen/generator.py |  2 +-
 4 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/tools/verification/rvgen/rvgen/automata.py b/tools/verification/rvgen/rvgen/automata.py
index c0c8d13030007..9e1c097ad0e4a 100644
--- a/tools/verification/rvgen/rvgen/automata.py
+++ b/tools/verification/rvgen/rvgen/automata.py
@@ -95,7 +95,7 @@ class Automata:
             raw_state = line[-1]
 
             #  "enabled_fired"}; -> enabled_fired
-            state = raw_state.replace('"', '').replace('};', '').replace(',','_')
+            state = raw_state.replace('"', '').replace('};', '').replace(',', '_')
             if state[0:7] == "__init_":
                 initial_state = state[7:]
             else:
@@ -132,7 +132,7 @@ class Automata:
             #  ------------ event is here ------------^^^^^
             if self.__dot_lines[cursor].split()[1] == "->":
                 line = self.__dot_lines[cursor].split()
-                event = line[-2].replace('"','')
+                event = line[-2].replace('"', '')
 
                 # when a transition has more than one labels, they are like this
                 # "local_irq_enable\nhw_local_irq_enable_n"
@@ -162,7 +162,7 @@ class Automata:
             nr_state += 1
 
         # declare the matrix....
-        matrix = [[ self.invalid_state_str for x in range(nr_event)] for y in range(nr_state)]
+        matrix = [[self.invalid_state_str for x in range(nr_event)] for y in range(nr_state)]
 
         # and we are back! Let's fill the matrix
         cursor = self.__get_cursor_begin_events()
@@ -170,9 +170,9 @@ class Automata:
         while self.__dot_lines[cursor].lstrip()[0] == '"':
             if self.__dot_lines[cursor].split()[1] == "->":
                 line = self.__dot_lines[cursor].split()
-                origin_state = line[0].replace('"','').replace(',','_')
-                dest_state = line[2].replace('"','').replace(',','_')
-                possible_events = line[-2].replace('"','').replace("\\n", " ")
+                origin_state = line[0].replace('"', '').replace(',', '_')
+                dest_state = line[2].replace('"', '').replace(',', '_')
+                possible_events = line[-2].replace('"', '').replace("\\n", " ")
                 for event in possible_events.split():
                     matrix[states_dict[origin_state]][events_dict[event]] = dest_state
             cursor += 1
diff --git a/tools/verification/rvgen/rvgen/dot2c.py b/tools/verification/rvgen/rvgen/dot2c.py
index fa9e9ae16640f..b291c29160fc2 100644
--- a/tools/verification/rvgen/rvgen/dot2c.py
+++ b/tools/verification/rvgen/rvgen/dot2c.py
@@ -172,7 +172,7 @@ class Dot2c(Automata):
                     line += f"\t\t\t{next_state}"
                 else:
                     line += f"{next_state:>{maxlen}}"
-                if y != nr_events-1:
+                if y != nr_events - 1:
                     line += ",\n" if linetoolong else ", "
                 else:
                     line += "\n\t\t}," if linetoolong else " },"
diff --git a/tools/verification/rvgen/rvgen/dot2k.py b/tools/verification/rvgen/rvgen/dot2k.py
index 291385adb2c20..de44840f63eda 100644
--- a/tools/verification/rvgen/rvgen/dot2k.py
+++ b/tools/verification/rvgen/rvgen/dot2k.py
@@ -109,8 +109,8 @@ class dot2k(Monitor, Dot2c):
         tp_args = tp_args_event if tp_type == "event" else tp_args_error
         if self.monitor_type == "per_task":
             tp_args.insert(0, tp_args_id)
-        tp_proto_c = ", ".join([a+b for a,b in tp_args])
-        tp_args_c = ", ".join([b for a,b in tp_args])
+        tp_proto_c = ", ".join([a + b for a, b in tp_args])
+        tp_args_c = ", ".join([b for a, b in tp_args])
         buff.append(f"	     TP_PROTO({tp_proto_c}),")
         buff.append(f"	     TP_ARGS({tp_args_c})")
         return '\n'.join(buff)
diff --git a/tools/verification/rvgen/rvgen/generator.py b/tools/verification/rvgen/rvgen/generator.py
index ea1fa0f5d818d..0491f8c9cb0b9 100644
--- a/tools/verification/rvgen/rvgen/generator.py
+++ b/tools/verification/rvgen/rvgen/generator.py
@@ -229,7 +229,7 @@ obj-$(CONFIG_RV_MON_{name_up}) += monitors/{name}/{name}.o
 
 
 class Monitor(RVGenerator):
-    monitor_types = { "global" : 1, "per_cpu" : 2, "per_task" : 3 }
+    monitor_types = {"global": 1, "per_cpu": 2, "per_task": 3}
 
     def __init__(self, extra_params={}):
         super().__init__(extra_params)
-- 
2.52.0

