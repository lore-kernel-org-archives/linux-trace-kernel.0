Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92EDF41C317
	for <linux-trace-kernel@vger.kernel.org>; Wed,  4 Feb 2026 14:55:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770216919; cv=none; b=cEnK7tvazvlkVJ05C+lXja+oK0CJEhbWtyWHrJMTs1ZMP1ZOVa5DcK1HzEAJvunK8nSpSx+RpZaTk755Xc3B9aDRFsNOsKfR2dJqs9AiuHdKjXhxCapdb/sM1qqCHwQyQ2saevBr1MxEuBDMIVb+M1uxnA5bV5BhJlqmmHHRnu8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770216919; c=relaxed/simple;
	bh=iEhhcJ2x8m7qLdgs93Q1jzeQeoShFixGz5NGOxbtWK8=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=luipBIn2kdhkAuaF4htfKKiRgQmTRG8S2LQvOdFb6PBKKgPFI5/6CZQxswB5abw/aDqZzIC2rENBPZ2LlnV5ASyyj1dyjUr9VABW4wLXL8QjCyMytq3zmydpROMS+JqZ/WWDrZoma8lM7U7VWx2HgJlNg4rOu6Q5zIwWGcnqx8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GPOIV+NV; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GPOIV+NV"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1770216918;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=y0JzYhi+/A6H34SSd4lFWPfJJhN4jIR9kEhWAeuzvLE=;
	b=GPOIV+NVzvRfude4xVbPpM7C/R8QOvCDghfc4VPmct+P2n011DelOVOz8GcIz7ocWOsiyo
	znvOt5DTztS4EMBiw86sUBMZCPadu5Coo7uabwa419AKDRiv8gPgSJ1eTe3kQAnofSrI7K
	/fFRTyN50bSSWG2g2HhWGf8SW8hbxnY=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-14-sCtI_f4lOR-AKj6iCwzPjA-1; Wed,
 04 Feb 2026 09:55:14 -0500
X-MC-Unique: sCtI_f4lOR-AKj6iCwzPjA-1
X-Mimecast-MFC-AGG-ID: sCtI_f4lOR-AKj6iCwzPjA_1770216913
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id E53A81955F3B;
	Wed,  4 Feb 2026 14:55:12 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.22.88.140])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 6C78130001A5;
	Wed,  4 Feb 2026 14:55:10 +0000 (UTC)
From: Wander Lairson Costa <wander@redhat.com>
To: Steven Rostedt <rostedt@goodmis.org>,
	Gabriele Monaco <gmonaco@redhat.com>,
	Nam Cao <namcao@linutronix.de>,
	Wander Lairson Costa <wander@redhat.com>,
	linux-trace-kernel@vger.kernel.org (open list:RUNTIME VERIFICATION (RV)),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v2 16/20] rv/rvgen: extract node marker string to class constant
Date: Wed,  4 Feb 2026 11:42:42 -0300
Message-ID: <20260204144914.104028-17-wander@redhat.com>
In-Reply-To: <20260204144914.104028-1-wander@redhat.com>
References: <20260204144914.104028-1-wander@redhat.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
X-Mimecast-MFC-PROC-ID: n1HWYJjwd80LGzsCKCjVSDfafYUYgpkqtKQor4xBHOg_1770216913
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

Add a node_marker class constant to the Automata class to replace the
hardcoded "{node" string literal used throughout the DOT file parsing
logic. This follows the existing pattern established by the init_marker
and invalid_state_str class constants in the same class.

The "{node" string is used as a marker to identify node declaration
lines in DOT files during state variable extraction and cursor
positioning. Extracting it to a named constant improves code
maintainability and makes the marker's purpose explicit.

Signed-off-by: Wander Lairson Costa <wander@redhat.com>
---
 tools/verification/rvgen/rvgen/automata.py | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/tools/verification/rvgen/rvgen/automata.py b/tools/verification/rvgen/rvgen/automata.py
index 17b012b868531..270a3d0bf4ce7 100644
--- a/tools/verification/rvgen/rvgen/automata.py
+++ b/tools/verification/rvgen/rvgen/automata.py
@@ -27,6 +27,7 @@ class Automata:
 
     invalid_state_str = "INVALID_STATE"
     init_marker = "__init_"
+    node_marker = "{node"
 
     def __init__(self, file_path, model_name=None):
         self.__dot_path = file_path
@@ -72,7 +73,7 @@ class Automata:
         for cursor, line in enumerate(self.__dot_lines):
             split_line = line.split()
 
-            if len(split_line) and split_line[0] == "{node":
+            if len(split_line) and split_line[0] == self.node_marker:
                 return cursor
 
         raise AutomataError("Could not find a beginning state")
@@ -87,9 +88,9 @@ class Automata:
                 continue
 
             if state == 0:
-                if line[0] == "{node":
+                if line[0] == self.node_marker:
                     state = 1
-            elif line[0] != "{node":
+            elif line[0] != self.node_marker:
                 break
         else:
             raise AutomataError("Could not find beginning event")
@@ -111,7 +112,7 @@ class Automata:
         # process nodes
         for line in islice(self.__dot_lines, cursor, None):
             split_line = line.split()
-            if not split_line or split_line[0] != "{node":
+            if not split_line or split_line[0] != self.node_marker:
                 break
 
             raw_state = split_line[-1]
-- 
2.52.0

