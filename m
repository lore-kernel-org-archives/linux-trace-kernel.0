Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61B4628A1D7
	for <linux-trace-kernel@vger.kernel.org>; Mon, 21 Jul 2025 08:24:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753086281; cv=none; b=Vxfb1In6ymJOsld5U1Lxe1JzkA9lN98abquKgp7Nw5DHSoPTfEaOaabYBW/uYlyJ9pkfvUzjwbpr1LQtrYL0/aoaj9ZlDL0IGnjXf9eBBbd1CDHuThmyciUwGpwADED2eb8HJph/rzZHee0fAIHdo9ZVHDkbdsh4CCpllV1nevY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753086281; c=relaxed/simple;
	bh=Ga8yVBxMZrxCER4DlSYRUeaPf3p8P9Ztep0JYFJZdb0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HNiKEcsdBlXYaUR58WYg4mOkuwrhhv23cBO0Pw8YhMJxLyNs1EGW2y3e7czTX6aVpcdL7Pke7v+0uaKK/W+iPLEd0kz5aVyyf46TpSFC6Dljk82Za+NlVb9996GYvTuIop/4LSNhvMnQleQj+dj8cL6yhN/xOfzFVkv7Z9jkSoU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=jVnLfYLP; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="jVnLfYLP"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1753086279;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=svV0wwUY1+UB5fcJv/wWUuhsAIDX4ffekMmgXxkZEo4=;
	b=jVnLfYLPBUBfnxIQFGDLcyg0sEoDtMK3Fx3qXNB81fB5jvFNlxddtrutLW935XFRWhaOkE
	8oWnsQ6BZu/raK/Wih9oXphcOIKVdVeHEwys8K4odhKFYuVBHeOla8bmO8XEO2J/XUdBcY
	Axa+tNViXIqfDhP/DHR9sfWhNUAoRlc=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-657-uTyC1GpPP9iRVa-wHhAT_g-1; Mon,
 21 Jul 2025 04:24:35 -0400
X-MC-Unique: uTyC1GpPP9iRVa-wHhAT_g-1
X-Mimecast-MFC-AGG-ID: uTyC1GpPP9iRVa-wHhAT_g_1753086274
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id B2F27195604F;
	Mon, 21 Jul 2025 08:24:34 +0000 (UTC)
Received: from gmonaco-thinkpadt14gen3.rmtit.com (unknown [10.44.32.136])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 65AD3195608D;
	Mon, 21 Jul 2025 08:24:30 +0000 (UTC)
From: Gabriele Monaco <gmonaco@redhat.com>
To: linux-kernel@vger.kernel.org,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	linux-trace-kernel@vger.kernel.org
Cc: Gabriele Monaco <gmonaco@redhat.com>,
	Nam Cao <namcao@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Tomas Glozar <tglozar@redhat.com>,
	Juri Lelli <jlelli@redhat.com>,
	Clark Williams <williams@redhat.com>,
	John Kacur <jkacur@redhat.com>
Subject: [PATCH v4 09/14] tools/dot2c: Fix generated files going over 100 column limit
Date: Mon, 21 Jul 2025 10:23:19 +0200
Message-ID: <20250721082325.71554-10-gmonaco@redhat.com>
In-Reply-To: <20250721082325.71554-1-gmonaco@redhat.com>
References: <20250721082325.71554-1-gmonaco@redhat.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

The dot2c.py script generates all states in a single line. This breaks the
100 column limit when the state machines are non-trivial.

Change dot2c.py to generate the states in separate lines in case the
generated line is going to be too long.

Also adapt existing monitors with line length over the limit.

Suggested-by: Nam Cao <namcao@linutronix.de>
Signed-off-by: Gabriele Monaco <gmonaco@redhat.com>
---
 kernel/trace/rv/monitors/snep/snep.h    | 14 ++++++++++++--
 tools/verification/rvgen/rvgen/dot2c.py | 20 +++++++++++---------
 2 files changed, 23 insertions(+), 11 deletions(-)

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
diff --git a/tools/verification/rvgen/rvgen/dot2c.py b/tools/verification/rvgen/rvgen/dot2c.py
index 6009caf568d92..97112b65b4177 100644
--- a/tools/verification/rvgen/rvgen/dot2c.py
+++ b/tools/verification/rvgen/rvgen/dot2c.py
@@ -152,28 +152,30 @@ class Dot2c(Automata):
         max_state_name = max(self.states, key = len).__len__()
         return max(max_state_name, self.invalid_state_str.__len__())
 
-    def __get_state_string_length(self):
-        maxlen = self.__get_max_strlen_of_states() + self.enum_suffix.__len__()
-        return "%" + str(maxlen) + "s"
-
     def get_aut_init_function(self):
         nr_states = self.states.__len__()
         nr_events = self.events.__len__()
         buff = []
 
-        strformat = self.__get_state_string_length()
-
+        maxlen = self.__get_max_strlen_of_states() + len(self.enum_suffix)
+        tab_braces = 2 * 8 + 2 + 1 # "\t\t{ " ... "}"
+        comma_space = 2 # ", " count last comma here
+        linetoolong = tab_braces + (maxlen + comma_space) * nr_events >= self.line_length
         for x in range(nr_states):
-            line = "\t\t{ "
+            line = "\t\t{\n" if linetoolong else "\t\t{ "
             for y in range(nr_events):
                 next_state = self.function[x][y]
                 if next_state != self.invalid_state_str:
                     next_state = self.function[x][y] + self.enum_suffix
 
+                if linetoolong:
+                    line += "\t\t\t%s" % next_state
+                else:
+                    line += "%*s" % (maxlen, next_state)
                 if y != nr_events-1:
-                    line = line + strformat % next_state + ", "
+                    line += ",\n" if linetoolong else ", "
                 else:
-                    line = line + strformat % next_state + " },"
+                    line += "\n\t\t}," if linetoolong else " },"
             buff.append(line)
 
         return self.__buff_to_string(buff)
-- 
2.50.1

