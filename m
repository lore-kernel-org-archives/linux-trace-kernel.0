Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C753A30F93C
	for <linux-trace-kernel@vger.kernel.org>; Mon, 23 Feb 2026 16:27:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771864038; cv=none; b=WIqA+E+qJ+zI1vYg8n+a3NnBfKaiepjVbJyRNy7g1Udejj/9qjcwKvYr+RijuPCPGcA6v54soMwUu7azS04DGfH6WCRRHRN/yz3l8A7qOfyz9gSczG/y7t8BNzFIYO8S719aahvst2ew5mIA1LqB94Qj3pJe0Bngt41/wbaVLhc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771864038; c=relaxed/simple;
	bh=J3sPcfz4gojiOiJFFuYU+FJssFjLUIPfHpd24s+ff1M=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=Ngq3og42OH1378+p5JPO+inGp/CKE8vOIrnHVAU+f81dbw1VytShhlYYNTaN9jJQ8wNlWhW2yMfWDRLTQw9VlLfVDxib28MNla+pzxW015RLYQklok+OXe/rSfoPOfsxf6IL4ogedTy/LgUvstHiXV6yrWYKevOeEFq4sBuEDfE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HN7t+mGM; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HN7t+mGM"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1771864035;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=s+Yn0zt6+sQ5OLXpiasx6aOYEpSEow6FT6ozp6AHGpg=;
	b=HN7t+mGMEvuu1qas4mo/fqCK6O41UnqfVvZLDV9a+td8w+9qfodunQL35ojgSckJnhdgZ5
	VKLJPuPyPZIMngQsjTIZdPOc8Atj0Ny+7YysxCMFnn3itpnJZMsHDVOI0WNnZhtOpgv7bc
	4xvR08QqXc5naTFPluZ09RrHyFuu3g8=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-494-s-AJGslQOEOtd2vOdbjEPQ-1; Mon,
 23 Feb 2026 11:27:12 -0500
X-MC-Unique: s-AJGslQOEOtd2vOdbjEPQ-1
X-Mimecast-MFC-AGG-ID: s-AJGslQOEOtd2vOdbjEPQ_1771864031
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id D2D8219560A2;
	Mon, 23 Feb 2026 16:27:10 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.22.88.94])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id B9DCF180066A;
	Mon, 23 Feb 2026 16:27:08 +0000 (UTC)
From: Wander Lairson Costa <wander@redhat.com>
To: Steven Rostedt <rostedt@goodmis.org>,
	Gabriele Monaco <gmonaco@redhat.com>,
	Nam Cao <namcao@linutronix.de>,
	Wander Lairson Costa <wander@redhat.com>,
	linux-trace-kernel@vger.kernel.org (open list:RUNTIME VERIFICATION (RV)),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v3 06/19] rv/rvgen: use context managers for file operations
Date: Mon, 23 Feb 2026 13:17:49 -0300
Message-ID: <20260223162407.147003-7-wander@redhat.com>
In-Reply-To: <20260223162407.147003-1-wander@redhat.com>
References: <20260223162407.147003-1-wander@redhat.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
X-Mimecast-MFC-PROC-ID: fVgWd6HI2LcI6LTwPlFi3pKxtVnLNxg9PBiADPnNyNw_1771864031
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
index 4f5681265ee24..10146b6061ed2 100644
--- a/tools/verification/rvgen/rvgen/automata.py
+++ b/tools/verification/rvgen/rvgen/automata.py
@@ -91,13 +91,11 @@ class Automata:
         cursor = 0
         dot_lines = []
         try:
-            dot_file = open(self.__dot_path)
+            with open(self.__dot_path) as dot_file:
+                dot_lines = dot_file.read().splitlines()
         except OSError as exc:
             raise AutomataError(exc.strerror) from exc
 
-        dot_lines = dot_file.read().splitlines()
-        dot_file.close()
-
         # checking the first line:
         line = dot_lines[cursor].split()
 
diff --git a/tools/verification/rvgen/rvgen/generator.py b/tools/verification/rvgen/rvgen/generator.py
index 61174b139123b..d932e96dd66d3 100644
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
2.53.0

