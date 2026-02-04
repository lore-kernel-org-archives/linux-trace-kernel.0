Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B26227F749
	for <linux-trace-kernel@vger.kernel.org>; Wed,  4 Feb 2026 14:53:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770216797; cv=none; b=FDworre5HlMFd0zjKWX3B6fHFQ0RRzSlLntr3RxaUsFvOcKkTz3qRs/+DS915kReFG/OCWipiHjETjhPINYcb5w00IcpNxHQSYTwtTYUlmOMfwJRWKibHKNTzDjI7JlpIj3Km7mB2pYUpF5c6XtWHoZ/yKkAINtqmlQTD940/jM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770216797; c=relaxed/simple;
	bh=zkKfAYsjci/mlp9ECo2S4q4Ily6MLqxWuVPZNo/DVOQ=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=PybcbU5XaRZauPX4svgEliCmqm4a4gTS6wP4xT0xw8TLFZByXdhalk1voH8tAFTAEzY30OVj1Qe7qJnKrxG9AmJtj9rgRfoCPTcLGn8vfgnkwhWzHv2Zx+nOB9eByr/kdc6pHhs7XPI2ZWufoZc1f7Wu6dDnW4SLVPQkiWDTUZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PGpzGAK0; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PGpzGAK0"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1770216796;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=O5AkGAtQbdmjDKuC0+IkHG8P8bWUzPyG8UBDaopQLy0=;
	b=PGpzGAK0Jgv6PiKoh2A1MNDzykhRbzqarDmKXJVlZSTb0Sl/1ZTwLhK4wwD2AYgFXv9VN4
	3Jpg0177Fy/YY62PKP6OzaY1fzhxyPzIHEG4yVwiDgN7BjxvKRgEmAPUBXf46nwFE4stqV
	BITdtHfLcIZuPivBUG1zS5GrMw7OYWw=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-563-22MzpEPaN5-TCngGQ9Y8-g-1; Wed,
 04 Feb 2026 09:53:11 -0500
X-MC-Unique: 22MzpEPaN5-TCngGQ9Y8-g-1
X-Mimecast-MFC-AGG-ID: 22MzpEPaN5-TCngGQ9Y8-g_1770216789
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id B09AF1955F3D;
	Wed,  4 Feb 2026 14:53:09 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.22.88.140])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 336C43000221;
	Wed,  4 Feb 2026 14:53:06 +0000 (UTC)
From: Wander Lairson Costa <wander@redhat.com>
To: Steven Rostedt <rostedt@goodmis.org>,
	Gabriele Monaco <gmonaco@redhat.com>,
	Nam Cao <namcao@linutronix.de>,
	Wander Lairson Costa <wander@redhat.com>,
	linux-trace-kernel@vger.kernel.org (open list:RUNTIME VERIFICATION (RV)),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v2 10/20] rv/rvgen: use class constant for init marker
Date: Wed,  4 Feb 2026 11:42:36 -0300
Message-ID: <20260204144914.104028-11-wander@redhat.com>
In-Reply-To: <20260204144914.104028-1-wander@redhat.com>
References: <20260204144914.104028-1-wander@redhat.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
X-Mimecast-MFC-PROC-ID: NED2tQLLEAjj6GTMuDhR_Hp98OI8EEyKBv1PdwcRdic_1770216789
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
Reviewed-by: Gabriele Monaco <gmonaco@redhat.com>
---
 tools/verification/rvgen/rvgen/automata.py | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/tools/verification/rvgen/rvgen/automata.py b/tools/verification/rvgen/rvgen/automata.py
index 38035d59cdd51..035d0e8c12c9a 100644
--- a/tools/verification/rvgen/rvgen/automata.py
+++ b/tools/verification/rvgen/rvgen/automata.py
@@ -25,6 +25,7 @@ class Automata:
     """
 
     invalid_state_str = "INVALID_STATE"
+    init_marker = "__init_"
 
     def __init__(self, file_path, model_name=None):
         self.__dot_path = file_path
@@ -96,8 +97,8 @@ class Automata:
 
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
2.52.0

