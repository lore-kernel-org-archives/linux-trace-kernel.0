Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06B8E3101D4
	for <linux-trace-kernel@vger.kernel.org>; Mon, 23 Feb 2026 16:28:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771864117; cv=none; b=pjmMZumuHYNA8Ibg1a5sMV0o0MD3aHTIFks+Nquthmrp2w1Lr8SYch4xl+G+Xg7d6Uiopc/K9WnLAPPUYJywPewU7NBLoMbpf2HZ7zUb2c3/9xIGmOMUBWh4SkSBryyN6R4I3M70PCDXSODY0eKwoKZDK5aVVbEVlokpZl0Gcb4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771864117; c=relaxed/simple;
	bh=+Rz5Al002Pg+QmwS3Sgv5FtNfWEPgkOkRu97wAzbifQ=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=pSfZ2Fob/JK/oEO43PR485cQpZjdJ1TSSLv2N9L7uh+AOSkzfYBEnqpKSOC61R4gDwMmfdrVr+7hZJZsLbi3KAIXH79xAh7lZBlLSl58ANHfi1atAgpSXkYi88YolbOJi61jQ5UF0PldVK4JZZTaCU2OhLkdEchDDd1Fq32Gedc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ITmUGjUb; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ITmUGjUb"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1771864115;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+PHQlGbsOT9oGTPjaz6e2nYz9/uHpMjqGVB/iTMTzY8=;
	b=ITmUGjUbcMVplxoGM7kvcqK39CNOP7JJtOpEU12ULt6F+DrXNND0PsXS34ZBghX0eio3Ay
	svWKYdS67PRgCn4XarP0VB4nUciIue3ELjk3F3SJimRMpkAJ7Xmxn1sHk92gdpT6bVlQl7
	saHOulqwB7PFHxg1lQRzafw40VhlxEE=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-152-3wuLTW5IOUGL3GxnuySftA-1; Mon,
 23 Feb 2026 11:28:31 -0500
X-MC-Unique: 3wuLTW5IOUGL3GxnuySftA-1
X-Mimecast-MFC-AGG-ID: 3wuLTW5IOUGL3GxnuySftA_1771864110
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 4A4A918005AD;
	Mon, 23 Feb 2026 16:28:30 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.22.88.94])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 2FF0F1800669;
	Mon, 23 Feb 2026 16:28:27 +0000 (UTC)
From: Wander Lairson Costa <wander@redhat.com>
To: Steven Rostedt <rostedt@goodmis.org>,
	Gabriele Monaco <gmonaco@redhat.com>,
	Nam Cao <namcao@linutronix.de>,
	Wander Lairson Costa <wander@redhat.com>,
	linux-trace-kernel@vger.kernel.org (open list:RUNTIME VERIFICATION (RV)),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v3 10/19] rv/rvgen: use class constant for init marker
Date: Mon, 23 Feb 2026 13:17:53 -0300
Message-ID: <20260223162407.147003-11-wander@redhat.com>
In-Reply-To: <20260223162407.147003-1-wander@redhat.com>
References: <20260223162407.147003-1-wander@redhat.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
X-Mimecast-MFC-PROC-ID: gGSoqN6UZ0WZ7NZiZKXpQB0SYEZVi1D26z7a7XbepGw_1771864110
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

Replace hardcoded string literal and magic number with a class
constant for the initial state marker in DOT file parsing. The
previous implementation used the magic string "__init_" directly
in the code along with a hardcoded length of 7 for substring
extraction, which made the code less maintainable and harder to
understand.

This change introduces a class constant init_marker to serve as
a single source of truth for the initial state prefix. The code
now uses startswith() for clearer intent and calculates the
substring position dynamically using len(), eliminating the magic
number. If the marker value needs to change in the future, only
the constant definition requires updating rather than multiple
locations in the code.

The refactoring improves code readability and maintainability
while preserving the exact same runtime behavior.

Signed-off-by: Wander Lairson Costa <wander@redhat.com>
Reviewed-by: Gabriele Monaco <gmonaco@redhat.com>
Reviewed-by: Nam Cao <namcao@linutronix.de>
---
 tools/verification/rvgen/rvgen/automata.py | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/tools/verification/rvgen/rvgen/automata.py b/tools/verification/rvgen/rvgen/automata.py
index e4c0335cd0fba..cdec78a4bbbae 100644
--- a/tools/verification/rvgen/rvgen/automata.py
+++ b/tools/verification/rvgen/rvgen/automata.py
@@ -42,6 +42,7 @@ class Automata:
     """
 
     invalid_state_str = "INVALID_STATE"
+    init_marker = "__init_"
     # val can be numerical, uppercase (constant or macro), lowercase (parameter or function)
     # only numerical values should have units
     constraint_rule = re.compile(r"""
@@ -136,8 +137,8 @@ class Automata:
 
             #  "enabled_fired"}; -> enabled_fired
             state = raw_state.replace('"', '').replace('};', '').replace(',', '_')
-            if state[0:7] == "__init_":
-                initial_state = state[7:]
+            if state.startswith(self.init_marker):
+                initial_state = state[len(self.init_marker):]
             else:
                 states.append(state)
                 if "doublecircle" in self.__dot_lines[cursor]:
-- 
2.53.0

