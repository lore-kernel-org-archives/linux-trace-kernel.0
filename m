Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C33221EF39F
	for <linux-trace-kernel@vger.kernel.org>; Wed, 23 Jul 2025 16:13:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753287198; cv=none; b=cPFVBdPst4ZpjzjStfiWddZ8rSBofyUPZind0NjyFinhRSG+fJ3EgvIxG+jrb113mGW0TnPzcdBn+Tlvxr7oYd7SGE5OYDqkneBcKG48yPmlhsj4Be9StLc0NZyKqOEVKbXdzLNfH+P+RWUo6zg81ulE3nEkC9ZK3J3MyfZbnfg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753287198; c=relaxed/simple;
	bh=N5Uoc0liBzLM7aXyPjbS/1RXhjY+sOJcVIcpjLcVyK4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tfms1kHO76KM+Zmm+cdpYbgdTOjJrORpxsVBJ1Q5mJAkerhKYgRX/GEWahvZKVTmTot+MhEsUw9U8AZpfNY4XvBHidjZPNdGjGUvRs6l+v0BHU9vkdhf1YOfDZDWFPWEeQAVEDcINbc6ylu2HFffPziRwv3sX4XVRUKtDM2kobo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JWrP9W2e; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JWrP9W2e"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1753287195;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8IVIAWvFo8V1C9OEtOoVISsPVvxAJbXZ9os28eVmaFA=;
	b=JWrP9W2eYlJiIAUqubo0IC3F7irPQ02T7r9bdDz342l7W6EJwT7vhZlM+CRAH0p6zDUEk9
	D0W8y/c2JS2+8MGKx+0OybQrhul4cdEAYKll6kbTUltwmy0pdf1f3sxRAhwdNhVDgR+Fvj
	2hPecMKRoeFR6SH0FfpcahQd2i02dm8=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-477-G_L5aMTKPpSA5NaYppcndA-1; Wed,
 23 Jul 2025 12:13:12 -0400
X-MC-Unique: G_L5aMTKPpSA5NaYppcndA-1
X-Mimecast-MFC-AGG-ID: G_L5aMTKPpSA5NaYppcndA_1753287191
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 089831800282;
	Wed, 23 Jul 2025 16:13:11 +0000 (UTC)
Received: from gmonaco-thinkpadt14gen3.rmtit.com (unknown [10.44.32.162])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id E6B1D18016FE;
	Wed, 23 Jul 2025 16:13:06 +0000 (UTC)
From: Gabriele Monaco <gmonaco@redhat.com>
To: linux-kernel@vger.kernel.org,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	linux-trace-kernel@vger.kernel.org
Cc: Gabriele Monaco <gmonaco@redhat.com>,
	Nam Cao <namcao@linutronix.de>,
	Tomas Glozar <tglozar@redhat.com>,
	Juri Lelli <jlelli@redhat.com>,
	Clark Williams <williams@redhat.com>,
	John Kacur <jkacur@redhat.com>
Subject: [PATCH 3/5] tools/dot2c: Fix generated files going over 100 column limit
Date: Wed, 23 Jul 2025 18:12:38 +0200
Message-ID: <20250723161240.194860-4-gmonaco@redhat.com>
In-Reply-To: <20250723161240.194860-1-gmonaco@redhat.com>
References: <20250723161240.194860-1-gmonaco@redhat.com>
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
index 6d16b9ad931e..4cd9abb77b7b 100644
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
index 6009caf568d9..b9b6f14cc536 100644
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
+        tab_braces = 2 * 8 + 2 + 1  # "\t\t{ " ... "}"
+        comma_space = 2  # ", " count last comma here
+        linetoolong = tab_braces + (maxlen + comma_space) * nr_events > self.line_length
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

