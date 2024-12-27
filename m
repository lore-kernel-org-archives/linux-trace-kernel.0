Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F199B1F7077
	for <linux-trace-kernel@vger.kernel.org>; Fri, 27 Dec 2024 14:49:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735310979; cv=none; b=bHlt3yuXlURbFI5MAc+mQHvqBbOMGPtuo6T2v2WYh+EVUUZRJUocrLBMk5wwjkxAVFbb3npFTZerBP7QYD9PQuN1/W+Cz6vf7RHBmb/7klOklKglEdFd6HX+n7szb7xHS/KKvVX5LKWbC7aMBMO0Vzww8Yd0lhx0OLyBi+WWl5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735310979; c=relaxed/simple;
	bh=Z3urq5EUmuYA/NYHl0x8fxtqghwCo+KBDanlBBiyPCI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eXqpKjygQ9ZZOuU60+NwHOGTDS/66O60SBIf3gv8EanLqYofCJntN+28o++wer3GzWf53tZWYO3CxG8G0GvODiU+X8/rf4HK0pushZ1JNVKvgqOdTADmw0LcF0/f601/eK+3GDdFtIywBgi3O7Khdz5YxQYBnaSbsirwbV82ad0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SCVD4z1b; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SCVD4z1b"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1735310976;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0Hw7qrrnyl4YScNy8RhFv0VcyaQLPkeJqqGU7A1Q0QI=;
	b=SCVD4z1bYihLF2ENK5Gu/86+kL8r/6nOYQqmVE5WHt+oFvQvV1nlRa3uBz01vS1knvLs1k
	a5GNOyGZLlWEa/8gRX2J6RkR593H9YyIJ6YVmY1uBuMl7IvZAmLC4S35vcTyQbFpZvp3BB
	6ks8Z5Oje1CdCjaCni7FVmXyfnJ4UBQ=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-402-Mq2jqp3rNRKW1rPmd3Kgeg-1; Fri,
 27 Dec 2024 09:49:32 -0500
X-MC-Unique: Mq2jqp3rNRKW1rPmd3Kgeg-1
X-Mimecast-MFC-AGG-ID: Mq2jqp3rNRKW1rPmd3Kgeg
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id B39E21956056;
	Fri, 27 Dec 2024 14:49:31 +0000 (UTC)
Received: from gmonaco-thinkpadt14gen3.rmtit.com (unknown [10.39.192.164])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 0F3E4300F9B6;
	Fri, 27 Dec 2024 14:49:28 +0000 (UTC)
From: Gabriele Monaco <gmonaco@redhat.com>
To: Steven Rostedt <rostedt@goodmis.org>,
	linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Juri Lelli <juri.lelli@redhat.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	John Kacur <jkacur@redhat.com>,
	Gabriele Monaco <gmonaco@redhat.com>
Subject: [PATCH 8/8] verification/dot2k: Implement event type detection
Date: Fri, 27 Dec 2024 15:47:52 +0100
Message-ID: <20241227144752.362911-9-gmonaco@redhat.com>
In-Reply-To: <20241227144752.362911-1-gmonaco@redhat.com>
References: <20241227144752.362911-1-gmonaco@redhat.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

Currently dot2k treats all events equally and registers them with a
general da_handle_event. This is however just part of the work because
some events are necessary to understand when the monitor is entering the
initial state.

Specifically, the da_handle_start_event takes care of setting the
monitor in the initial state and da_handle_start_run_event also
registers the current event in the newly enabled monitor.
da_handle_start_event can be used on events that only lead to the
initial state (as it is currently done in the example monitors), while
da_handle_start_run_event could be used on events that are only valid
from the initial one.
Failing to set at least one of those functions to handle events makes
the monitor useless, since it will never be activated.

This patch adapts dot2k to parse the events that surely lead to the
initial state and set da_handle_start_event for those, if no such event
is found but some events are only valid in the initial event, we instead
set da_handle_start_run_event (it isn't necessary to set both).
We still add a comment to warn the user to make sure this change is
matching the model definition.

Signed-off-by: Gabriele Monaco <gmonaco@redhat.com>
---
 tools/verification/dot2/automata.py | 32 +++++++++++++++++++++++++++++
 tools/verification/dot2/dot2k.py    | 11 ++++++++--
 2 files changed, 41 insertions(+), 2 deletions(-)

diff --git a/tools/verification/dot2/automata.py b/tools/verification/dot2/automata.py
index f6921cf3c9143..d9a3fe2b74bf2 100644
--- a/tools/verification/dot2/automata.py
+++ b/tools/verification/dot2/automata.py
@@ -26,6 +26,7 @@ class Automata:
         self.states, self.initial_state, self.final_states = self.__get_state_variables()
         self.events = self.__get_event_variables()
         self.function = self.__create_matrix()
+        self.events_start, self.events_start_run = self.__store_init_events()
 
     def __get_model_name(self):
         basename = ntpath.basename(self.__dot_path)
@@ -172,3 +173,34 @@ class Automata:
             cursor += 1
 
         return matrix
+
+    def __store_init_events(self):
+        events_start = [False] * len(self.events)
+        events_start_run = [False] * len(self.events)
+        for i, _ in enumerate(self.events):
+            curr_event_will_init = 0
+            curr_event_from_init = False
+            curr_event_used = 0
+            for j, _ in enumerate(self.states):
+                if self.function[j][i] != self.invalid_state_str:
+                    curr_event_used += 1
+                if self.function[j][i] == self.initial_state:
+                    curr_event_will_init += 1
+            if self.function[0][i] != self.invalid_state_str:
+                curr_event_from_init = True
+            # this event always leads to init
+            if curr_event_will_init and curr_event_used == curr_event_will_init:
+                events_start[i] = True
+            # this event is only called from init
+            if curr_event_from_init and curr_event_used == 1:
+                events_start_run[i] = True
+        return events_start, events_start_run
+
+    def is_start_event(self, event):
+        return self.events_start[self.events.index(event)]
+
+    def is_start_run_event(self, event):
+        # prefer handle_start_event if there
+        if any(self.events_start):
+            return False
+        return self.events_start_run[self.events.index(event)]
diff --git a/tools/verification/dot2/dot2k.py b/tools/verification/dot2/dot2k.py
index 83f4d49853a25..7547eb290b7df 100644
--- a/tools/verification/dot2/dot2k.py
+++ b/tools/verification/dot2/dot2k.py
@@ -110,11 +110,18 @@ class dot2k(Dot2c):
         for event in self.events:
             buff.append("static void handle_%s(void *data, /* XXX: fill header */)" % event)
             buff.append("{")
+            handle = "handle_event"
+            if self.is_start_event(event):
+                buff.append("\t/* XXX: validate that this event always leads to the initial state */")
+                handle = "handle_start_event"
+            elif self.is_start_run_event(event):
+                buff.append("\t/* XXX: validate that this event is only valid in the initial state */")
+                handle = "handle_start_run_event"
             if self.monitor_type == "per_task":
                 buff.append("\tstruct task_struct *p = /* XXX: how do I get p? */;");
-                buff.append("\tda_handle_event_%s(p, %s%s);" % (self.name, event, self.enum_suffix));
+                buff.append("\tda_%s_%s(p, %s%s);" % (handle, self.name, event, self.enum_suffix));
             else:
-                buff.append("\tda_handle_event_%s(%s%s);" % (self.name, event, self.enum_suffix));
+                buff.append("\tda_%s_%s(%s%s);" % (handle, self.name, event, self.enum_suffix));
             buff.append("}")
             buff.append("")
         return self.__buff_to_string(buff)
-- 
2.47.1

