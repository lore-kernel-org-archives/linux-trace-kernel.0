Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF4E921ABB1
	for <linux-trace-kernel@vger.kernel.org>; Thu, 14 Aug 2025 15:09:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755184146; cv=none; b=Dr5dxU5gYirPnrDeXTVmjMFtDo+NpvPY3iK88skI+nJBL5Z1Qgh/Tk2N4bial4OfB61ovy09CcCaTUn7M8cFqW2SwF2WqGwhq8m4h+oXdlC5WYiwGcDwkWp8B59pJ3JhLYa1mBk4rcSU6UM9B+u2Qcs9y17qRRLAHmAMIYizRng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755184146; c=relaxed/simple;
	bh=WAxcjs4mlkMLH+eYsjSq2oW557Bf70HFosY1YxOzAw0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ruHflNWhRwoaw/Ni9L4DASZ30uqP96Gn0WWwlpxFjxGsqfENFQKZfEIWLgXXhNrAtrAkeBfWud50Lu4vvBgHhWvIU7/4MpXVjH9hJ0Dd1tmYRInDgZ9W8//HsawqMHBCwaSoilWM0MoFAOWj68BuieAN7jjcaWdN+l1ji/0XFZ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Ayft3NHO; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ayft3NHO"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1755184143;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fLLP4VphC+IL2ZyK3aT8DJKm5lQs3XZabYHcpadQkr0=;
	b=Ayft3NHO2wE/srETAoQjvD4iD08GtzlZJUQB/ULXzU/PMm1pDuZAfxO7uaEyw37dsdo8h6
	QuDV3AO/qd+P9xgIb98N23bvuIRkgR+j1P76h9Gns/WRZsv9PdhmytLnyGPY/vAraq74vF
	wn5epNTbWBXWYcflt0C2+SEp9bJ/oI4=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-515-JJKyOl7vNm2Q1lKPq051Hg-1; Thu,
 14 Aug 2025 11:09:00 -0400
X-MC-Unique: JJKyOl7vNm2Q1lKPq051Hg-1
X-Mimecast-MFC-AGG-ID: JJKyOl7vNm2Q1lKPq051Hg_1755184140
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id CF89E19560AD;
	Thu, 14 Aug 2025 15:08:59 +0000 (UTC)
Received: from gmonaco-thinkpadt14gen3.rmtit.com (unknown [10.44.32.52])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id E01841800280;
	Thu, 14 Aug 2025 15:08:55 +0000 (UTC)
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
Subject: [RFC PATCH 06/17] verification/dot2c: Remove __buff_to_string() and cleanup
Date: Thu, 14 Aug 2025 17:07:58 +0200
Message-ID: <20250814150809.140739-7-gmonaco@redhat.com>
In-Reply-To: <20250814150809.140739-1-gmonaco@redhat.com>
References: <20250814150809.140739-1-gmonaco@redhat.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

str.join() can do what __buff_to_string() does. Therefore replace
__buff_to_string() to make the scripts more pythonic.

Also clean and remove some intermediate functions.

Signed-off-by: Gabriele Monaco <gmonaco@redhat.com>
---
 tools/verification/rvgen/rvgen/dot2c.py | 35 +++++--------------------
 1 file changed, 6 insertions(+), 29 deletions(-)

diff --git a/tools/verification/rvgen/rvgen/dot2c.py b/tools/verification/rvgen/rvgen/dot2c.py
index e92567045c9c..1771a2c9f6b9 100644
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
     def __get_enum_states_content(self):
         buff = []
         buff.append("\t%s%s = 0," % (self.initial_state, self.enum_suffix))
@@ -45,14 +36,10 @@ class Dot2c(Automata):
 
         return buff
 
-    def get_enum_states_string(self):
-        buff = self.__get_enum_states_content()
-        return self.__buff_to_string(buff)
-
     def format_states_enum(self):
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
     def format_events_enum(self):
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
     def format_aut_init_events_string(self):
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
2.50.1

