Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F6A21F5434
	for <linux-trace-kernel@vger.kernel.org>; Fri, 27 Dec 2024 14:49:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735310966; cv=none; b=LylRjFRZzJdaG136Yi7U65P6L8FQ1ivO8TrGw/9G0VOj59BbTH/NarTBdT5jGLcBxjiUnfXvHPg8ibFs0YlCrMjZ9uVdyhFhCcB1YElLwHVltkps78N4ujgeJvipwMIKvuMTOpOeAPZUt7SxtBLhUkDqchtvbvCtj70qYCxeQ+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735310966; c=relaxed/simple;
	bh=PJjpXQ5I5OKRCBaYa/xfQaEFJvnGwUqw3slRbQYQxFg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fgUlSxDh5w20a3yxKQ09mCIBaCL1OfsDzCQJ3yjxkd5LoqL11nhscXUT0Ev/SAp44nqeBx0xNTGWOt4ISQfgiWatdCDdlty8vkfMVWowr2NcnAiqeurrgBay8md4JB1Or8zAcf70rFgHGWHkRBYIctMfjzFnRYlPUIhM9cyC9+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Kha16AWx; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Kha16AWx"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1735310963;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7JdudEOhC1aXDvOiHDkTbGQ89vWCqVqQJ79tEh5M+qM=;
	b=Kha16AWx/4hpd7eIaZqdhfFcR/Kvt/c0WP9ASSs+V4z2cIHWTcLVHi4/3jUHn0lGGC8qam
	jklvjxeAttF9nX+x1X/864oWhWUsvntxd7nnfpvwAPmqkrHj7qF5iIplcBSA3t30sOD8Xm
	CKeuBclMcqRNrVn9+RpCgqNRBHB11qM=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-44-u3b6mG88PEy17m_Fpqdofg-1; Fri,
 27 Dec 2024 09:49:19 -0500
X-MC-Unique: u3b6mG88PEy17m_Fpqdofg-1
X-Mimecast-MFC-AGG-ID: u3b6mG88PEy17m_Fpqdofg
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 10C3E1955F45;
	Fri, 27 Dec 2024 14:49:17 +0000 (UTC)
Received: from gmonaco-thinkpadt14gen3.rmtit.com (unknown [10.39.192.164])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 9F1E73000197;
	Fri, 27 Dec 2024 14:49:14 +0000 (UTC)
From: Gabriele Monaco <gmonaco@redhat.com>
To: Steven Rostedt <rostedt@goodmis.org>,
	linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Juri Lelli <juri.lelli@redhat.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	John Kacur <jkacur@redhat.com>,
	Gabriele Monaco <gmonaco@redhat.com>
Subject: [PATCH 4/8] verification/dot2k: Add support for name and description options
Date: Fri, 27 Dec 2024 15:47:48 +0100
Message-ID: <20241227144752.362911-5-gmonaco@redhat.com>
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

The dot2k command includes options to set a model name with -n and a
description with -D, however those are not used in practice.

This patch allows to specify a custom model name (by default the name of
the dot file without extension) and a description which overrides the
one in the C file.

Signed-off-by: Gabriele Monaco <gmonaco@redhat.com>
---
 tools/verification/dot2/automata.py            | 4 ++--
 tools/verification/dot2/dot2c.py               | 4 ++--
 tools/verification/dot2/dot2k                  | 6 +-----
 tools/verification/dot2/dot2k.py               | 8 +++++---
 tools/verification/dot2/dot2k_templates/main.c | 4 ++--
 5 files changed, 12 insertions(+), 14 deletions(-)

diff --git a/tools/verification/dot2/automata.py b/tools/verification/dot2/automata.py
index bdeb98baa8b06..f6921cf3c9143 100644
--- a/tools/verification/dot2/automata.py
+++ b/tools/verification/dot2/automata.py
@@ -19,9 +19,9 @@ class Automata:
 
     invalid_state_str = "INVALID_STATE"
 
-    def __init__(self, file_path):
+    def __init__(self, file_path, model_name=None):
         self.__dot_path = file_path
-        self.name = self.__get_model_name()
+        self.name = model_name or self.__get_model_name()
         self.__dot_lines = self.__open_dot()
         self.states, self.initial_state, self.final_states = self.__get_state_variables()
         self.events = self.__get_event_variables()
diff --git a/tools/verification/dot2/dot2c.py b/tools/verification/dot2/dot2c.py
index 87d8a1e1470c6..fa2816ac7b61a 100644
--- a/tools/verification/dot2/dot2c.py
+++ b/tools/verification/dot2/dot2c.py
@@ -22,8 +22,8 @@ class Dot2c(Automata):
     struct_automaton_def = "automaton"
     var_automaton_def = "aut"
 
-    def __init__(self, file_path):
-        super().__init__(file_path)
+    def __init__(self, file_path, model_name=None):
+        super().__init__(file_path, model_name)
         self.line_length = 100
 
     def __buff_to_string(self, buff):
diff --git a/tools/verification/dot2/dot2k b/tools/verification/dot2/dot2k
index d4d7e52d549e8..827b62b8d5e16 100644
--- a/tools/verification/dot2/dot2k
+++ b/tools/verification/dot2/dot2k
@@ -25,16 +25,12 @@ if __name__ == '__main__':
 
     print("Opening and parsing the dot file %s" % params.dot_file)
     try:
-        monitor=dot2k(params.dot_file, params.monitor_type)
+        monitor=dot2k(params.dot_file, params.monitor_type, vars(params))
     except Exception as e:
         print('Error: '+ str(e))
         print("Sorry : :-(")
         sys.exit(1)
 
-    # easier than using argparse action.
-    if params.model_name != None:
-        print(params.model_name)
-
     print("Writing the monitor into the directory %s" % monitor.name)
     monitor.print_files()
     print("Almost done, checklist")
diff --git a/tools/verification/dot2/dot2k.py b/tools/verification/dot2/dot2k.py
index c88b3c0117061..d48ad86a035a7 100644
--- a/tools/verification/dot2/dot2k.py
+++ b/tools/verification/dot2/dot2k.py
@@ -17,17 +17,18 @@ class dot2k(Dot2c):
     monitor_templates_dir = "dot2/dot2k_templates/"
     monitor_type = "per_cpu"
 
-    def __init__(self, file_path, MonitorType):
-        super().__init__(file_path)
+    def __init__(self, file_path, MonitorType, extra_params={}):
+        super().__init__(file_path, extra_params.get("model_name"))
 
         self.monitor_type = self.monitor_types.get(MonitorType)
         if self.monitor_type is None:
-            raise Exception("Unknown monitor type: %s" % MonitorType)
+            raise ValueError("Unknown monitor type: %s" % MonitorType)
 
         self.monitor_type = MonitorType
         self.__fill_rv_templates_dir()
         self.main_c = self.__open_file(self.monitor_templates_dir + "main.c")
         self.enum_suffix = "_%s" % self.name
+        self.description = extra_params.get("description", self.name) or "auto-generated"
 
     def __fill_rv_templates_dir(self):
 
@@ -114,6 +115,7 @@ class dot2k(Dot2c):
         main_c = main_c.replace("%%TRACEPOINT_HANDLERS_SKEL%%", tracepoint_handlers)
         main_c = main_c.replace("%%TRACEPOINT_ATTACH%%", tracepoint_attach)
         main_c = main_c.replace("%%TRACEPOINT_DETACH%%", tracepoint_detach)
+        main_c = main_c.replace("%%DESCRIPTION%%", self.description)
 
         return main_c
 
diff --git a/tools/verification/dot2/dot2k_templates/main.c b/tools/verification/dot2/dot2k_templates/main.c
index 4a05fef7f3c7f..7046171685788 100644
--- a/tools/verification/dot2/dot2k_templates/main.c
+++ b/tools/verification/dot2/dot2k_templates/main.c
@@ -65,7 +65,7 @@ static void disable_%%MODEL_NAME%%(void)
  */
 static struct rv_monitor rv_%%MODEL_NAME%% = {
 	.name = "%%MODEL_NAME%%",
-	.description = "auto-generated %%MODEL_NAME%%",
+	.description = "%%DESCRIPTION%%",
 	.enable = enable_%%MODEL_NAME%%,
 	.disable = disable_%%MODEL_NAME%%,
 	.reset = da_monitor_reset_all_%%MODEL_NAME%%,
@@ -88,4 +88,4 @@ module_exit(unregister_%%MODEL_NAME%%);
 
 MODULE_LICENSE("GPL");
 MODULE_AUTHOR("dot2k: auto-generated");
-MODULE_DESCRIPTION("%%MODEL_NAME%%");
+MODULE_DESCRIPTION("%%MODEL_NAME%%: %%DESCRIPTION%%");
-- 
2.47.1

