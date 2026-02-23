Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B35D430FF1D
	for <linux-trace-kernel@vger.kernel.org>; Mon, 23 Feb 2026 16:27:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771864077; cv=none; b=nPQnF7p3/W42NWswm+VBxoXMey08ac1mDVeLLaeoE1jExdgKNOHEJpN46w3j0A+PSIo3lQdjQjWh/EQES2N0OfNvbs8NhIrCZ7iC5inhj7b2H6TUTNjjynHgoTJm55jrKhBzFACmpd1ptTbEoMdOe/0hBKSQvcu5N+nPJkn7ZpY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771864077; c=relaxed/simple;
	bh=tkQIqMDRYo46V5iDA5bMpwWOaTpjQP2z8Khn96PUVPc=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=VgQKXP59DJN6HZWE+0cUqRgl/DN1yeml4TIdeoYxtF5B5dgpqAl0LveiuDx39CGGRRLz+k/2+gfM14JLlQwdTD+4NmBswom6l0TJoo11tcsez86u/1OYlN1ac0lAV+l6ag1k8HzHBj//NecEeJBvt2PWHfVNmm9hYEaAdXHRCNw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZRxsWZx0; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZRxsWZx0"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1771864074;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SrUFZV6oLK679oGJODiDwGHpUK22sR45oyIvkICSS4c=;
	b=ZRxsWZx0EtxgVa3CwnXJYmh+vArZp8EyBnPwh1ElC2M/O+LlCRdbWWknTq4J06y4lvh816
	tTjGAs1hdQIeHlnO8IRqbu06y64Ef6VcpKyA20L6FdYki0kKQSSgsZeAeVjoO9J3CBOTgu
	Ue/qmqZevp9w1YSSsmo0cn95Rkbb1dA=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-711-TPzP1EzVN16W_juiwlUrgA-1; Mon,
 23 Feb 2026 11:27:51 -0500
X-MC-Unique: TPzP1EzVN16W_juiwlUrgA-1
X-Mimecast-MFC-AGG-ID: TPzP1EzVN16W_juiwlUrgA_1771864070
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 7B53719560B7;
	Mon, 23 Feb 2026 16:27:50 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.22.88.94])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 61B631800370;
	Mon, 23 Feb 2026 16:27:48 +0000 (UTC)
From: Wander Lairson Costa <wander@redhat.com>
To: Steven Rostedt <rostedt@goodmis.org>,
	Gabriele Monaco <gmonaco@redhat.com>,
	Nam Cao <namcao@linutronix.de>,
	Wander Lairson Costa <wander@redhat.com>,
	linux-trace-kernel@vger.kernel.org (open list:RUNTIME VERIFICATION (RV)),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v3 08/19] rv/rvgen: fix PEP 8 whitespace violations
Date: Mon, 23 Feb 2026 13:17:51 -0300
Message-ID: <20260223162407.147003-9-wander@redhat.com>
In-Reply-To: <20260223162407.147003-1-wander@redhat.com>
References: <20260223162407.147003-1-wander@redhat.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
X-Mimecast-MFC-PROC-ID: 4-kYOufwIjoWlbzq4E1Po64VAW4tZa9HSYLKuAm3QG0_1771864070
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

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
Reviewed-by: Gabriele Monaco <gmonaco@redhat.com>
Reviewed-by: Nam Cao <namcao@linutronix.de>
---
 tools/verification/rvgen/rvgen/automata.py  | 8 ++++----
 tools/verification/rvgen/rvgen/dot2c.py     | 2 +-
 tools/verification/rvgen/rvgen/dot2k.py     | 4 ++--
 tools/verification/rvgen/rvgen/generator.py | 2 +-
 4 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/tools/verification/rvgen/rvgen/automata.py b/tools/verification/rvgen/rvgen/automata.py
index b25378e92b16d..e54486c69a191 100644
--- a/tools/verification/rvgen/rvgen/automata.py
+++ b/tools/verification/rvgen/rvgen/automata.py
@@ -135,7 +135,7 @@ class Automata:
             raw_state = line[-1]
 
             #  "enabled_fired"}; -> enabled_fired
-            state = raw_state.replace('"', '').replace('};', '').replace(',','_')
+            state = raw_state.replace('"', '').replace('};', '').replace(',', '_')
             if state[0:7] == "__init_":
                 initial_state = state[7:]
             else:
@@ -264,7 +264,7 @@ class Automata:
             nr_state += 1
 
         # declare the matrix....
-        matrix = [[ self.invalid_state_str for x in range(nr_event)] for y in range(nr_state)]
+        matrix = [[self.invalid_state_str for x in range(nr_event)] for y in range(nr_state)]
         constraints: dict[_ConstraintKey, list[str]] = {}
 
         # and we are back! Let's fill the matrix
@@ -273,8 +273,8 @@ class Automata:
         while self.__dot_lines[cursor].lstrip()[0] == '"':
             if self.__dot_lines[cursor].split()[1] == "->":
                 line = self.__dot_lines[cursor].split()
-                origin_state = line[0].replace('"','').replace(',','_')
-                dest_state = line[2].replace('"','').replace(',','_')
+                origin_state = line[0].replace('"', '').replace(',', '_')
+                dest_state = line[2].replace('"', '').replace(',', '_')
                 possible_events = "".join(line[line.index("label") + 2:-1]).replace('"', '')
                 for event in possible_events.split("\\n"):
                     event, *constr = event.split(";")
diff --git a/tools/verification/rvgen/rvgen/dot2c.py b/tools/verification/rvgen/rvgen/dot2c.py
index 9255cc2153a31..fc85ba1f649e7 100644
--- a/tools/verification/rvgen/rvgen/dot2c.py
+++ b/tools/verification/rvgen/rvgen/dot2c.py
@@ -182,7 +182,7 @@ class Dot2c(Automata):
                     line += f"\t\t\t{next_state}"
                 else:
                     line += f"{next_state:>{maxlen}}"
-                if y != nr_events-1:
+                if y != nr_events - 1:
                     line += ",\n" if linetoolong else ", "
                 else:
                     line += ",\n\t\t}," if linetoolong else " },"
diff --git a/tools/verification/rvgen/rvgen/dot2k.py b/tools/verification/rvgen/rvgen/dot2k.py
index aedc2a7799b32..e6f476b903b0a 100644
--- a/tools/verification/rvgen/rvgen/dot2k.py
+++ b/tools/verification/rvgen/rvgen/dot2k.py
@@ -134,8 +134,8 @@ class dot2k(Monitor, Dot2c):
         tp_args = tp_args_dict[tp_type]
         if self._is_id_monitor():
             tp_args.insert(0, tp_args_id)
-        tp_proto_c = ", ".join([a+b for a,b in tp_args])
-        tp_args_c = ", ".join([b for a,b in tp_args])
+        tp_proto_c = ", ".join([a + b for a, b in tp_args])
+        tp_args_c = ", ".join([b for a, b in tp_args])
         buff.append(f"	     TP_PROTO({tp_proto_c}),")
         buff.append(f"	     TP_ARGS({tp_args_c})")
         return '\n'.join(buff)
diff --git a/tools/verification/rvgen/rvgen/generator.py b/tools/verification/rvgen/rvgen/generator.py
index 988ccdc27fa37..40d82afb018f5 100644
--- a/tools/verification/rvgen/rvgen/generator.py
+++ b/tools/verification/rvgen/rvgen/generator.py
@@ -228,7 +228,7 @@ obj-$(CONFIG_RV_MON_{name_up}) += monitors/{name}/{name}.o
 
 
 class Monitor(RVGenerator):
-    monitor_types = { "global" : 1, "per_cpu" : 2, "per_task" : 3, "per_obj" : 4 }
+    monitor_types = {"global": 1, "per_cpu": 2, "per_task": 3, "per_obj": 4}
 
     def __init__(self, extra_params={}):
         super().__init__(extra_params)
-- 
2.53.0

