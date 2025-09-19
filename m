Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFFD6313548
	for <linux-trace-kernel@vger.kernel.org>; Fri, 19 Sep 2025 14:10:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758291055; cv=none; b=hlziq4frre3bwyE5DRV/OugZmy8RPpg70eAyEgt6sEvDC09218XTLz1xVrknl5Dsrnh6LdH3hS3m6s5x+FDvDjsMSSW9hDi5tuqpThwQWdkOfDSfQ02tE1/b0b31JJeLhLg6nOn+k3dM3A3I6U+wLWJZrtx225uWn5rS1TNulRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758291055; c=relaxed/simple;
	bh=kjIVDeCQio5SApb6457mOgKFv1l48AiUqMYqDJ8M/eA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EXSd8EsUJ/Ss9HTgfOGV0k4VvJaD7S8zFbLZjij3rAnvq4A3YRwrmAWZsDqU60s9eJx4zoiw8NR+svurl8c9J0zC9E0zk/dxofQ4esxnanfteqmDEQW0RNE8w9sRWxScknKvclhM+m7lKlTSD0BZXsFOYB1NXpVZJgfrnsEJJHY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UsiHKWGZ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UsiHKWGZ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758291052;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oOhcjRwXLstGONdcpZwKT8qBnJaG2xVQ1O0D3hKiOxs=;
	b=UsiHKWGZyjRptUVF0uC9d2F2cJwbn98FI9t+U7jvmRfl9gJsl8qNSoAgsy004N6qbNINVb
	O3gvHLnBnxq1s4bYeHkSNDSO2t14zfozCMKcC0kCw8vGXvELWY47VViMTyoKJpz2q+lNQY
	CLFMwMq8CGj2lA8IW2qfWzHC0HCPm5k=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-344-sVOq365vP7Skbywq4YcaYA-1; Fri,
 19 Sep 2025 10:10:49 -0400
X-MC-Unique: sVOq365vP7Skbywq4YcaYA-1
X-Mimecast-MFC-AGG-ID: sVOq365vP7Skbywq4YcaYA_1758291047
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id C072C1955F42;
	Fri, 19 Sep 2025 14:10:46 +0000 (UTC)
Received: from gmonaco-thinkpadt14gen3.rmtit.csb (unknown [10.45.224.13])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 40EC41955F24;
	Fri, 19 Sep 2025 14:10:41 +0000 (UTC)
From: Gabriele Monaco <gmonaco@redhat.com>
To: linux-kernel@vger.kernel.org,
	Steven Rostedt <rostedt@goodmis.org>,
	linux-trace-kernel@vger.kernel.org
Cc: Gabriele Monaco <gmonaco@redhat.com>,
	Nam Cao <namcao@linutronix.de>,
	Tomas Glozar <tglozar@redhat.com>,
	Juri Lelli <jlelli@redhat.com>,
	Clark Williams <williams@redhat.com>,
	John Kacur <jkacur@redhat.com>
Subject: [PATCH v2 07/20] verification/dot2c: Remove __buff_to_string() and cleanup
Date: Fri, 19 Sep 2025 16:09:41 +0200
Message-ID: <20250919140954.104920-8-gmonaco@redhat.com>
In-Reply-To: <20250919140954.104920-1-gmonaco@redhat.com>
References: <20250919140954.104920-1-gmonaco@redhat.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

str.join() can do what __buff_to_string() does. Therefore replace
__buff_to_string() to make the scripts more pythonic.

Also clean and remove some intermediate functions.

Reviewed-by: Nam Cao <namcao@linutronix.de>
Signed-off-by: Gabriele Monaco <gmonaco@redhat.com>
---
 tools/verification/rvgen/rvgen/dot2c.py | 35 +++++--------------------
 1 file changed, 6 insertions(+), 29 deletions(-)

diff --git a/tools/verification/rvgen/rvgen/dot2c.py b/tools/verification/rvgen/rvgen/dot2c.py
index fd64174fcfad..24894411c3cd 100644
--- a/tools/verification/rvgen/rvgen/dot2c.py
+++ b/tools/verification/rvgen/rvgen/dot2c.py
@@ -26,15 +26,6 @@ class Dot2c(Automata):
         super().__init__(file_path, model_name)
         self.line_length = 100
 
-    def __buff_to_string(self, buff):
-        string = ""
-
-        for line in buff:
-            string = string + line + "\n"
-
-        # cut off the last \n
-        return string[:-1]
-
     def __get_enum_states_content(self) -> list[str]:
         buff = []
         buff.append("\t%s%s = 0," % (self.initial_state, self.enum_suffix))
@@ -45,14 +36,10 @@ class Dot2c(Automata):
 
         return buff
 
-    def get_enum_states_string(self):
-        buff = self.__get_enum_states_content()
-        return self.__buff_to_string(buff)
-
     def format_states_enum(self) -> list[str]:
         buff = []
         buff.append("enum %s {" % self.enum_states_def)
-        buff.append(self.get_enum_states_string())
+        buff += self.__get_enum_states_content()
         buff.append("};\n")
 
         return buff
@@ -71,14 +58,10 @@ class Dot2c(Automata):
 
         return buff
 
-    def get_enum_events_string(self):
-        buff = self.__get_enum_events_content()
-        return self.__buff_to_string(buff)
-
     def format_events_enum(self) -> list[str]:
         buff = []
         buff.append("enum %s {" % self.enum_events_def)
-        buff.append(self.get_enum_events_string())
+        buff += self.__get_enum_events_content()
         buff.append("};\n")
 
         return buff
@@ -127,23 +110,17 @@ class Dot2c(Automata):
 
         return string
 
-    def get_aut_init_events_string(self):
-        return self.__get_string_vector_per_line_content(self.events)
-
-    def get_aut_init_states_string(self):
-        return self.__get_string_vector_per_line_content(self.states)
-
     def format_aut_init_events_string(self) -> list[str]:
         buff = []
         buff.append("\t.event_names = {")
-        buff.append(self.get_aut_init_events_string())
+        buff.append(self.__get_string_vector_per_line_content(self.events))
         buff.append("\t},")
         return buff
 
     def format_aut_init_states_string(self) -> list[str]:
         buff = []
         buff.append("\t.state_names = {")
-        buff.append(self.get_aut_init_states_string())
+        buff.append(self.__get_string_vector_per_line_content(self.states))
         buff.append("\t},")
 
         return buff
@@ -178,7 +155,7 @@ class Dot2c(Automata):
                     line += "\n\t\t}," if linetoolong else " },"
             buff.append(line)
 
-        return self.__buff_to_string(buff)
+        return '\n'.join(buff)
 
     def format_aut_init_function(self) -> list[str]:
         buff = []
@@ -253,4 +230,4 @@ class Dot2c(Automata):
 
     def print_model_classic(self):
         buff = self.format_model()
-        print(self.__buff_to_string(buff))
+        print('\n'.join(buff))
-- 
2.51.0

