Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 975C21DDC2B
	for <linux-trace-kernel@vger.kernel.org>; Thu, 21 Nov 2024 15:01:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732201272; cv=none; b=hQ8NnvgAz1EQeKVkYkP2FfsJiVy/58Rwt6abKLMR/Rcs3RXMUygQYPdhwR+YigtDZjzuPFw5CYYUSmx6SG3hVZcifSaOBIgMCi9r0KYAB08O9O8swushnPosnoUxZlFmnqOftKi1sUVgR3nNwm3+qCB2Zou+1YepX0noYWbXsrs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732201272; c=relaxed/simple;
	bh=A3GuQfKrjl1zxHsRqkErZDd3QUP5e+zRugoys5u61lU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nDLGDFVibLNUA6pSK9218faU27krbkemZf2hK5AcjX7k8DwnT+B4XNbfDF6qIPdh2Sw7LGz4BmJvzq9pQqRGzo9FsjWPqvqwKV+K684KV6sbdAF2mLOx4g/GLdIkkGa6/ZH3MU3BQMrrB8LdFu8i9vCKDx6E4s7M6CoW4Fa6RA4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZK0R75fl; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZK0R75fl"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1732201269;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7iW2GgQ76FFxiG2vAuE/IlUcKhIYlf2Yr45L9NzM84w=;
	b=ZK0R75flJHuRyO9aud/SfiLQwtB3X0qipZI8MbE5L8OwSBoaEUj9fh+4HNu/OaQEyiY/+a
	3NM81+Ls7nYVzCwde1Wor1uIGHvF9XQPxWSJukrNJO9AVLj300McnzHem9yF53TL3ogkgT
	vWiATjJQ5osrxXC5diEgy3Xacz7/obU=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-300-1fh2EouHO3iDsZpFdQqq6g-1; Thu,
 21 Nov 2024 10:01:06 -0500
X-MC-Unique: 1fh2EouHO3iDsZpFdQqq6g-1
X-Mimecast-MFC-AGG-ID: 1fh2EouHO3iDsZpFdQqq6g
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 633121956046;
	Thu, 21 Nov 2024 15:01:05 +0000 (UTC)
Received: from gmonaco-thinkpadt14gen3.rmtit.com (unknown [10.39.194.245])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 2971A30000DF;
	Thu, 21 Nov 2024 15:01:02 +0000 (UTC)
From: Gabriele Monaco <gmonaco@redhat.com>
To: linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Steven Rostedt <rostedt@goodmis.org>
Cc: Tomas Glozar <tglozar@redhat.com>,
	John Kacur <jkacur@redhat.com>,
	Gabriele Monaco <gmonaco@redhat.com>
Subject: [PATCH 4/4] verification/dot2k: Add support for name and description options
Date: Thu, 21 Nov 2024 15:59:57 +0100
Message-ID: <20241121145957.145700-5-gmonaco@redhat.com>
In-Reply-To: <20241121145957.145700-1-gmonaco@redhat.com>
References: <20241121145957.145700-1-gmonaco@redhat.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

The dot2k command allows specifying a model name with -n and a
description with -D, however those are not used in practice.
This patch allows to specify a custom model name (by default the name of
the dot file without extension) and a description which overrides the
one in the C file.

Signed-off-by: Gabriele Monaco <gmonaco@redhat.com>
---
 tools/verification/dot2/automata.py            | 4 ++--
 tools/verification/dot2/dot2c.py               | 4 ++--
 tools/verification/dot2/dot2k                  | 6 +-----
 tools/verification/dot2/dot2k.py               | 6 ++++--
 tools/verification/dot2/dot2k_templates/main.c | 2 +-
 5 files changed, 10 insertions(+), 12 deletions(-)

diff --git a/tools/verification/dot2/automata.py b/tools/verification/dot2/automata.py
index bdeb98baa8b0..2c4639a73474 100644
--- a/tools/verification/dot2/automata.py
+++ b/tools/verification/dot2/automata.py
@@ -19,9 +19,9 @@ class Automata:
 
     invalid_state_str = "INVALID_STATE"
 
-    def __init__(self, file_path):
+    def __init__(self, file_path, model_name=None):
         self.__dot_path = file_path
-        self.name = self.__get_model_name()
+        self.name = model_name if model_name is not None else self.__get_model_name()
         self.__dot_lines = self.__open_dot()
         self.states, self.initial_state, self.final_states = self.__get_state_variables()
         self.events = self.__get_event_variables()
diff --git a/tools/verification/dot2/dot2c.py b/tools/verification/dot2/dot2c.py
index 87d8a1e1470c..fa2816ac7b61 100644
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
index d4d7e52d549e..2d580f26d7c0 100644
--- a/tools/verification/dot2/dot2k
+++ b/tools/verification/dot2/dot2k
@@ -25,16 +25,12 @@ if __name__ == '__main__':
 
     print("Opening and parsing the dot file %s" % params.dot_file)
     try:
-        monitor=dot2k(params.dot_file, params.monitor_type)
+        monitor=dot2k(params.dot_file, params.monitor_type, params.model_name, params.description)
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
index c88b3c011706..f5f829a03f84 100644
--- a/tools/verification/dot2/dot2k.py
+++ b/tools/verification/dot2/dot2k.py
@@ -17,8 +17,8 @@ class dot2k(Dot2c):
     monitor_templates_dir = "dot2/dot2k_templates/"
     monitor_type = "per_cpu"
 
-    def __init__(self, file_path, MonitorType):
-        super().__init__(file_path)
+    def __init__(self, file_path, MonitorType, model_name=None, description=None):
+        super().__init__(file_path, model_name)
 
         self.monitor_type = self.monitor_types.get(MonitorType)
         if self.monitor_type is None:
@@ -28,6 +28,7 @@ class dot2k(Dot2c):
         self.__fill_rv_templates_dir()
         self.main_c = self.__open_file(self.monitor_templates_dir + "main.c")
         self.enum_suffix = "_%s" % self.name
+        self.description = description if description is not None else self.name
 
     def __fill_rv_templates_dir(self):
 
@@ -114,6 +115,7 @@ class dot2k(Dot2c):
         main_c = main_c.replace("%%TRACEPOINT_HANDLERS_SKEL%%", tracepoint_handlers)
         main_c = main_c.replace("%%TRACEPOINT_ATTACH%%", tracepoint_attach)
         main_c = main_c.replace("%%TRACEPOINT_DETACH%%", tracepoint_detach)
+        main_c = main_c.replace("%%DESCRIPTION%%", self.description)
 
         return main_c
 
diff --git a/tools/verification/dot2/dot2k_templates/main.c b/tools/verification/dot2/dot2k_templates/main.c
index 4a05fef7f3c7..0987c5e56ec8 100644
--- a/tools/verification/dot2/dot2k_templates/main.c
+++ b/tools/verification/dot2/dot2k_templates/main.c
@@ -88,4 +88,4 @@ module_exit(unregister_%%MODEL_NAME%%);
 
 MODULE_LICENSE("GPL");
 MODULE_AUTHOR("dot2k: auto-generated");
-MODULE_DESCRIPTION("%%MODEL_NAME%%");
+MODULE_DESCRIPTION("%%DESCRIPTION%%");
-- 
2.47.0

