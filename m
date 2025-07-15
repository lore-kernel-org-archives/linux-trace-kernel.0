Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CD4F27464A
	for <linux-trace-kernel@vger.kernel.org>; Tue, 15 Jul 2025 07:15:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752563756; cv=none; b=pZkYTSwnU0v01ERecMYmTMGXPRc5xY3tX8XV/EeIRj3aqoPnB139cP1aUee0zbW/pp+7GsNCgUVuycD2OS3zudTTV1PeaF/z7LTnyrBE60MtNsR4ZyWIpoZtEkDo0r7MxLK1SQR+TxmPb/NKNSfFhFzoosUeoKonUlS6R3/eKYc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752563756; c=relaxed/simple;
	bh=EB6OavY8GOQrwmyL4t23FzAOwDBXpgnmSBqsL/ObkbU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rHzpWbtuhKL/50Klv0WEdZZ5/niO0DeCiNytP75mYL0XI/uAlho+IM1pOZjM/IlExZUgODhumopqJIQgYPlk4wdlEylND1gnDt1C6tfGEyBX5xtafYthJo8376Snitrg2GgqX21rqFtJt5DOZ47Nd5exJ3dRC/XZ6T3caOaBc9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Kxqg9qSi; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Kxqg9qSi"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752563753;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oyzwPIViG0moxxldrjogzJHEpjbWV9q0dAQxkvYlKNc=;
	b=Kxqg9qSiwjZYc+q3QtAAxua4yn1H900tG+R4HYx+bHvIkKFFcqTY7liAq2onYyuWAcz1zh
	kbqLS4aIzIYEObhqSOMQEgN3d48MOaHu5l9I4suan6XediuWbDRjY6Cwv+VMc+G/zvZVD+
	Xo3vXsXjE6N/Dl0rjYylP4SIt2ULOfo=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-35-6upA8k0AP_2QZhPO-ZIu8A-1; Tue,
 15 Jul 2025 03:15:49 -0400
X-MC-Unique: 6upA8k0AP_2QZhPO-ZIu8A-1
X-Mimecast-MFC-AGG-ID: 6upA8k0AP_2QZhPO-ZIu8A_1752563748
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 50E9E1800366;
	Tue, 15 Jul 2025 07:15:48 +0000 (UTC)
Received: from gmonaco-thinkpadt14gen3.rmtit.com (unknown [10.45.224.115])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 5FA4D180045B;
	Tue, 15 Jul 2025 07:15:43 +0000 (UTC)
From: Gabriele Monaco <gmonaco@redhat.com>
To: linux-kernel@vger.kernel.org,
	Steven Rostedt <rostedt@goodmis.org>,
	linux-trace-kernel@vger.kernel.org
Cc: Nam Cao <namcao@linutronix.de>,
	Gabriele Monaco <gmonaco@redhat.com>,
	Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Tomas Glozar <tglozar@redhat.com>,
	Juri Lelli <jlelli@redhat.com>,
	Clark Williams <williams@redhat.com>,
	John Kacur <jkacur@redhat.com>
Subject: [PATCH v3 09/17] tools/dot2c: Fix generated files going over 100 column limit
Date: Tue, 15 Jul 2025 09:14:26 +0200
Message-ID: <20250715071434.22508-10-gmonaco@redhat.com>
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

From: Nam Cao <namcao@linutronix.de>

The dot2c.py script generates all states in a single line. This breaks the
100 column limit when the state machines are non-trivial.

Change dot2c.py to generate the states in separate lines in case the
generated line is going to be too long.

Co-authored-by: Gabriele Monaco <gmonaco@redhat.com>
Signed-off-by: Nam Cao <namcao@linutronix.de>
Signed-off-by: Gabriele Monaco <gmonaco@redhat.com>
---
 tools/verification/rvgen/rvgen/dot2c.py | 19 ++++++++++---------
 1 file changed, 10 insertions(+), 9 deletions(-)

diff --git a/tools/verification/rvgen/rvgen/dot2c.py b/tools/verification/rvgen/rvgen/dot2c.py
index 6009caf568d92..5216d98ae21c8 100644
--- a/tools/verification/rvgen/rvgen/dot2c.py
+++ b/tools/verification/rvgen/rvgen/dot2c.py
@@ -152,28 +152,29 @@ class Dot2c(Automata):
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
+        # account for tabs and spaces/punctuation for each event
+        linetoolong = 16 + (maxlen + 3) * nr_events >= self.line_length
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

