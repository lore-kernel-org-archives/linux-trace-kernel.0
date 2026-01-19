Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 254C2258CD0
	for <linux-trace-kernel@vger.kernel.org>; Mon, 19 Jan 2026 21:01:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768856471; cv=none; b=Xv2t083kRaj6o8H6kw9kc4C5dw++oCXABtlv89c33BLTOcM3Insu+Uyks9mKOEBn4xTE1SA8lIHxjw01kgrzwArLgpz+9O3VZNvIMB9rcOScrmcgTwh36BaKVV8PN4DBp1IYIlZnEUWc7buqQU7FaAdl5m0+n+pEroLwtGQkHbc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768856471; c=relaxed/simple;
	bh=g9BPMUDl9MALnH9nqEO1jSn+BilUvvqSL5IohiW4+nU=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sXW/p3WFzaIo8MP8itmJYAravMUfybfvD9R0rfABG6vuBJOJgHcp0rXEkzrAu7fAQIyJBPAjm9w6XW8NRBgX1at9Rj1MD3J1pXJmCjtpKKaKrsTzSVH4ZhZvBSnv7AugFsfj514G0bt4n7hkSoGnyctd10fFz+BULegzCRA9xiE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=d6y9AxL2; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="d6y9AxL2"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1768856469;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Ye4ehv+3Lnra9b7oS7d0s1JmOqih58blGer/Fk7p2Ac=;
	b=d6y9AxL2/d60tt513zZ5OtneqprZj4mmW0GG7jZKh763eZnjsUfuuCoShUM3inzhvlgHhJ
	cRcEzDxQoxX/Gu+u8FNEHoQrjZmh68wBKhoVihNH0RLdisS1k18uezj+OsYIsIaU8cI6J4
	OPKt9uUt0sMQSge33KqHUIIkJFNHdV8=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-592-oyU2ygxxN9qEGQOit94WVw-1; Mon,
 19 Jan 2026 16:01:05 -0500
X-MC-Unique: oyU2ygxxN9qEGQOit94WVw-1
X-Mimecast-MFC-AGG-ID: oyU2ygxxN9qEGQOit94WVw_1768856464
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id AEB9C1800447;
	Mon, 19 Jan 2026 21:01:04 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.22.80.137])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 33F7A1955F43;
	Mon, 19 Jan 2026 21:01:01 +0000 (UTC)
From: Wander Lairson Costa <wander@redhat.com>
To: Steven Rostedt <rostedt@goodmis.org>,
	Gabriele Monaco <gmonaco@redhat.com>,
	Nam Cao <namcao@linutronix.de>,
	Wander Lairson Costa <wander@redhat.com>,
	linux-kernel@vger.kernel.org (open list),
	linux-trace-kernel@vger.kernel.org (open list:RUNTIME VERIFICATION (RV))
Subject: [PATCH 06/26] rv/rvgen: use context managers for file operations
Date: Mon, 19 Jan 2026 17:45:42 -0300
Message-ID: <20260119205601.105821-7-wander@redhat.com>
In-Reply-To: <20260119205601.105821-1-wander@redhat.com>
References: <20260119205601.105821-1-wander@redhat.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

Replace manual file open and close operations with context managers
throughout the rvgen codebase. The previous implementation used
explicit open() and close() calls, which could lead to resource leaks
if exceptions occurred between opening and closing the file handles.

This change affects three file operations: reading DOT specification
files in the automata parser, reading template files in the generator
base class, and writing generated monitor files. All now use the with
statement to ensure proper resource cleanup even in error conditions.

Context managers provide automatic cleanup through the with statement,
which guarantees that file handles are closed when the with block
exits regardless of whether an exception occurred. This follows PEP
343 recommendations and is the standard Python idiom for resource
management. The change also reduces code verbosity while improving
safety and maintainability.

Signed-off-by: Wander Lairson Costa <wander@redhat.com>
---
 tools/verification/rvgen/rvgen/automata.py  |  6 ++----
 tools/verification/rvgen/rvgen/generator.py | 12 ++++--------
 2 files changed, 6 insertions(+), 12 deletions(-)

diff --git a/tools/verification/rvgen/rvgen/automata.py b/tools/verification/rvgen/rvgen/automata.py
index ed02d0c69b410..70ff98abea751 100644
--- a/tools/verification/rvgen/rvgen/automata.py
+++ b/tools/verification/rvgen/rvgen/automata.py
@@ -51,13 +51,11 @@ class Automata:
         cursor = 0
         dot_lines = []
         try:
-            dot_file = open(self.__dot_path)
+            with open(self.__dot_path) as dot_file:
+                dot_lines = dot_file.read().splitlines()
         except OSError as exc:
             raise AutomataError(f"Cannot open the file: {self.__dot_path}") from exc
 
-        dot_lines = dot_file.read().splitlines()
-        dot_file.close()
-
         # checking the first line:
         line = dot_lines[cursor].split()
 
diff --git a/tools/verification/rvgen/rvgen/generator.py b/tools/verification/rvgen/rvgen/generator.py
index 6d16fb68798a7..ee75e111feef1 100644
--- a/tools/verification/rvgen/rvgen/generator.py
+++ b/tools/verification/rvgen/rvgen/generator.py
@@ -51,11 +51,8 @@ class RVGenerator:
         raise FileNotFoundError("Could not find the rv directory, do you have the kernel source installed?")
 
     def _read_file(self, path):
-        fd = open(path, 'r')
-
-        content = fd.read()
-
-        fd.close()
+        with open(path, 'r') as fd:
+            content = fd.read()
         return content
 
     def _read_template_file(self, file):
@@ -199,9 +196,8 @@ obj-$(CONFIG_RV_MON_{name_up}) += monitors/{name}/{name}.o
             return
 
     def __write_file(self, file_name, content):
-        file = open(file_name, 'w')
-        file.write(content)
-        file.close()
+        with open(file_name, 'w') as file:
+            file.write(content)
 
     def _create_file(self, file_name, content):
         path = f"{self.name}/{file_name}"
-- 
2.52.0

