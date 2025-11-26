Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5012320A2C
	for <linux-trace-kernel@vger.kernel.org>; Wed, 26 Nov 2025 10:43:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764153800; cv=none; b=jOtDxeaxt3PJ5aVIcAx9Xbo82XzWp5fKjKZpKD9xdcfB1KNMSWMDSjv1/PqGmrfK3riArzGjwJp0G/2AoCsUu+pcZAVJBY4Opnu1z+jexNmMTJUQTHM5uZmEbsh/Yn69nmvkk+m4s/xLZ1sUwKQ8bF5FNVyeSQKTU4C3zhDsr7M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764153800; c=relaxed/simple;
	bh=GXJ1rwuIhRplydan4OKQf0Ax7rBALdKSap8mSjmJoJ8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kJmgaE55e5wrszUTa/5zo5w0/DxRxX8n2dnfrZkxiXNH0ZK6zyYNGSFNzKl0/bi3xsshmDGmON/M7E1Mlrh3J89arZ3bgLOGaZUZoqd5jmvBr+VSzo2GkK4lxW5UftXljqsVlKo0vS9MuDsySrHeSaZMgfR0aGhK9rf4LADboO4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QqhU12vf; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QqhU12vf"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1764153798;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0yifEd5HDDiuA0nLbLqpegEzOrrP2cY77oVrIqLxs18=;
	b=QqhU12vfi6bLX3a6VzJ7QrpIVi4Tb5klpBltbn9oTr8aJt1Tx/wZpcg1p5ikjInoIuHJ0R
	VM8yLB/y39IHGxy8RfUSpkgjBXs6x53Kq3msHiMh3lmLtUbu0ClMXQy3telBuanpwy/CGf
	btElpG+z3ApZGEcTiKYZi5xZrdvUz/4=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-568-X0BcpMtoNZC3PlLDfX2KmA-1; Wed,
 26 Nov 2025 05:43:14 -0500
X-MC-Unique: X0BcpMtoNZC3PlLDfX2KmA-1
X-Mimecast-MFC-AGG-ID: X0BcpMtoNZC3PlLDfX2KmA_1764153793
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 05CD71956095;
	Wed, 26 Nov 2025 10:43:13 +0000 (UTC)
Received: from gmonaco-thinkpadt14gen3.rmtit.csb (unknown [10.45.226.131])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 82F5A1800451;
	Wed, 26 Nov 2025 10:43:10 +0000 (UTC)
From: Gabriele Monaco <gmonaco@redhat.com>
To: linux-kernel@vger.kernel.org,
	Steven Rostedt <rostedt@goodmis.org>,
	Nam Cao <namcao@linutronix.de>,
	Gabriele Monaco <gmonaco@redhat.com>,
	linux-trace-kernel@vger.kernel.org
Cc: =?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
Subject: [PATCH 6/8] verification/dot2c: Remove __buff_to_string() and cleanup
Date: Wed, 26 Nov 2025 11:42:37 +0100
Message-ID: <20251126104241.291258-7-gmonaco@redhat.com>
In-Reply-To: <20251126104241.291258-1-gmonaco@redhat.com>
References: <20251126104241.291258-1-gmonaco@redhat.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

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
2.51.1

