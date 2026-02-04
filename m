Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9CFD2E92BC
	for <linux-trace-kernel@vger.kernel.org>; Wed,  4 Feb 2026 14:51:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770216711; cv=none; b=nqlVpTctJ8b7As39DXk+DeKQzLD0MZKLcge4WHW2TocL9Cxdegw4ngeCeZxqQcgBcellcBvolvnETVpaBFpaLtZYuv3WEiAW5Ii4rW7O6hYeDI+9TXpfBWuat2RJyjgK1jYpUE30sED/JU3octUkPliiA3z87QkbJxVBdzRph44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770216711; c=relaxed/simple;
	bh=vKGoCud62RvTn/RnPIPbJSk8pA3OGV7VeKLMQKjyh+w=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=nTpKL+gbazE7NyW0EeelqIco4T6Lkq5EGS0FSAqOQ1Z3aLPhV5Rw7t4iIi3WgktPPAcluAhYx8aIu+tub9d7qxqZwzSTuTjQDdjcatJF/j2kM3x+5Wk9DaHGeXuSj/TzU8l2rZg02P8k1MwpDo7cz+QLQVZM6MjheP8qRyKSqts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Fyj0zBr5; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Fyj0zBr5"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1770216710;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=keHT6bdZvc3LtAXA8IGY3q2fOIXGt3Nvqkknb+sVMEQ=;
	b=Fyj0zBr5wdmFb3BoCim0QNiTDvOaM/TWSbapspfhI6nlG8Vlo+YSbXyXOfkEiIOl1TM7Xd
	ERPk+RCbWAOcg9FhLNkq551G/s7b8fsESwB0r6SSFrtlU+BUbsFSFr6Q26TrqQ6q8nJISn
	nKTgqwIYPRkZqge3px/U71/A+uVPWQk=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-417-scbrbT51NtWHnT0oR8H5Sw-1; Wed,
 04 Feb 2026 09:51:47 -0500
X-MC-Unique: scbrbT51NtWHnT0oR8H5Sw-1
X-Mimecast-MFC-AGG-ID: scbrbT51NtWHnT0oR8H5Sw_1770216706
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id B3F371956059;
	Wed,  4 Feb 2026 14:51:46 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.22.88.140])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 3242A30001B9;
	Wed,  4 Feb 2026 14:51:43 +0000 (UTC)
From: Wander Lairson Costa <wander@redhat.com>
To: Steven Rostedt <rostedt@goodmis.org>,
	Gabriele Monaco <gmonaco@redhat.com>,
	Nam Cao <namcao@linutronix.de>,
	Wander Lairson Costa <wander@redhat.com>,
	linux-trace-kernel@vger.kernel.org (open list:RUNTIME VERIFICATION (RV)),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v2 06/20] rv/rvgen: use context managers for file operations
Date: Wed,  4 Feb 2026 11:42:32 -0300
Message-ID: <20260204144914.104028-7-wander@redhat.com>
In-Reply-To: <20260204144914.104028-1-wander@redhat.com>
References: <20260204144914.104028-1-wander@redhat.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
X-Mimecast-MFC-PROC-ID: R-JIHuzbP3Xhwa0GbaNMG6hT_EkXFyAIL8pIvNN7Ln0_1770216706
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

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
Reviewed-by: Nam Cao <namcao@linutronix.de>
Reviewed-by: Gabriele Monaco <gmonaco@redhat.com>
---
 tools/verification/rvgen/rvgen/automata.py  |  6 ++----
 tools/verification/rvgen/rvgen/generator.py | 12 ++++--------
 2 files changed, 6 insertions(+), 12 deletions(-)

diff --git a/tools/verification/rvgen/rvgen/automata.py b/tools/verification/rvgen/rvgen/automata.py
index 07ae81e9a49fa..1feb5f0c0bc3e 100644
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

