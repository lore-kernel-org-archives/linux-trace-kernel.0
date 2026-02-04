Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F14E41B36E
	for <linux-trace-kernel@vger.kernel.org>; Wed,  4 Feb 2026 14:52:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770216732; cv=none; b=C5Wxb8Mm6G5a2sCFFVNV1eeRzVbkB11ukI/L6iOJ23LP0Bk5G6+Ye+eO+dB6LS3L0DGghSbDr4ZENZluTvTuROKXcKeeOf4SKQBlK1efkWqzPFWx9zRt9UN3w1uRiW4rLatFtbrgb0+UCHicr53ptwkT8Y9Ojsz2lYLLtiiPMzk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770216732; c=relaxed/simple;
	bh=IGs1ScYkFP71z6UE7aLtED39zD3lhjPE8dE990QTpiU=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=ExhIAKaPviSY9k6RsCMtQuB6gZtmPpyOdCpONFDWADIjNrSU4kyR8aVkiepyUNgZU4yYc3jhMkBYGXSuy9m2PkZfcL1IWpP9dH3tF0oFcs74Y2HMUceTqq9g0xmGve5OOiopGoiUTk0DryEYznWcLDKzswkmFLq6vwI3X/ACMbY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=AUSlWZF2; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AUSlWZF2"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1770216731;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=P84/evlpnt3DS/S6sXWGMrp9V98TiF/ksHbNeWWrihw=;
	b=AUSlWZF2/GIDFC5AFa0tArecMVXO3FZEIik1qWi75bGLcCSXxaR7nnEJ8BvaXt3NAKUVr8
	FWdDCKyuqUAfvEMI2qz13Exm3b6Gr/pZBwW7S9sADauJK7jyE1cRZDjQCwcOQ0RCOnpj+c
	ypKFQrUUImi3zMOhf0yTLBY6e6aY6FA=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-530-8ReFqjsNMByCzp8K5EXM7w-1; Wed,
 04 Feb 2026 09:52:08 -0500
X-MC-Unique: 8ReFqjsNMByCzp8K5EXM7w-1
X-Mimecast-MFC-AGG-ID: 8ReFqjsNMByCzp8K5EXM7w_1770216727
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 5CA461956096;
	Wed,  4 Feb 2026 14:52:07 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.22.88.140])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id CEA3F30001A5;
	Wed,  4 Feb 2026 14:52:04 +0000 (UTC)
From: Wander Lairson Costa <wander@redhat.com>
To: Steven Rostedt <rostedt@goodmis.org>,
	Gabriele Monaco <gmonaco@redhat.com>,
	Nam Cao <namcao@linutronix.de>,
	Wander Lairson Costa <wander@redhat.com>,
	linux-trace-kernel@vger.kernel.org (open list:RUNTIME VERIFICATION (RV)),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v2 07/20] rv/rvgen: fix typos in automata and generator docstring and comments
Date: Wed,  4 Feb 2026 11:42:33 -0300
Message-ID: <20260204144914.104028-8-wander@redhat.com>
In-Reply-To: <20260204144914.104028-1-wander@redhat.com>
References: <20260204144914.104028-1-wander@redhat.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
X-Mimecast-MFC-PROC-ID: QUf-M9bapDvRoFA7O6CTclVGvXw2HHn8ScEne0kEuZE_1770216727
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

Fix two typos in the Automata class documentation that have been
present since the initial implementation. Fix the class
docstring: "part it" instead of "parses it". Additionally, a
comment describing transition labels contained the misspelling
"lables" instead of "labels".

Fix a typo in the comment describing the insertion of the initial
state into the states list: "bein og" should be "beginning of".

Fix typo in the module docstring: "Abtract" should be "Abstract".

Signed-off-by: Wander Lairson Costa <wander@redhat.com>
---
 tools/verification/rvgen/rvgen/automata.py  | 6 +++---
 tools/verification/rvgen/rvgen/generator.py | 2 +-
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/tools/verification/rvgen/rvgen/automata.py b/tools/verification/rvgen/rvgen/automata.py
index 1feb5f0c0bc3e..0d7cbd0c634a9 100644
--- a/tools/verification/rvgen/rvgen/automata.py
+++ b/tools/verification/rvgen/rvgen/automata.py
@@ -18,7 +18,7 @@ class AutomataError(Exception):
     """
 
 class Automata:
-    """Automata class: Reads a dot file and part it as an automata.
+    """Automata class: Reads a dot file and parses it as an automata.
 
     Attributes:
         dot_file: A dot file with an state_automaton definition.
@@ -113,7 +113,7 @@ class Automata:
         states = sorted(set(states))
         states.remove(initial_state)
 
-        # Insert the initial state at the bein og the states
+        # Insert the initial state at the beginning of the states
         states.insert(0, initial_state)
 
         if not has_final_states:
@@ -134,7 +134,7 @@ class Automata:
                 line = self.__dot_lines[cursor].split()
                 event = line[-2].replace('"','')
 
-                # when a transition has more than one lables, they are like this
+                # when a transition has more than one labels, they are like this
                 # "local_irq_enable\nhw_local_irq_enable_n"
                 # so split them.
 
diff --git a/tools/verification/rvgen/rvgen/generator.py b/tools/verification/rvgen/rvgen/generator.py
index ee75e111feef1..a3fbb1ac74916 100644
--- a/tools/verification/rvgen/rvgen/generator.py
+++ b/tools/verification/rvgen/rvgen/generator.py
@@ -3,7 +3,7 @@
 #
 # Copyright (C) 2019-2022 Red Hat, Inc. Daniel Bristot de Oliveira <bristot@kernel.org>
 #
-# Abtract class for generating kernel runtime verification monitors from specification file
+# Abstract class for generating kernel runtime verification monitors from specification file
 
 import platform
 import os
-- 
2.52.0

