Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0490E29D288
	for <linux-trace-kernel@vger.kernel.org>; Mon, 19 Jan 2026 21:02:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768856572; cv=none; b=erQzM4hKdX5TWjk9N8zaYQK9w0vkvG3Y2S+Z/53SR8t46fkMNA7EJX5JMz+GwmPmEjqC2PixwAoebiPDSU9e4KB4c6TBEpivuuzzv1Vlk8ImhgTzbZ4BHRR04dci0QLB7LdGUBn+rcOexK/9S48ZRQcbF0yq9xtjI9NkQC1Gi/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768856572; c=relaxed/simple;
	bh=MWKRrN0Rehb4ipv99vA6QFypK3/oOBFrT3rJbmagcRw=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TI3UeuWVbYS1uxNdsFBTAq4g9ur6a0aLqArJ/afI0KqDd4gf8GzkAfpuKL0k3hVtn+mUR4pLOy4yTBoaJy25tIsPfZC4CYTCHl9PIWw6MuqqchonyxILKKhGf74EDy5ny+BFtrL/TFNqWQ+lAZSX0rM6/dseJzBglG7jwCwZvuA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KkbT0OYH; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KkbT0OYH"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1768856570;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KSwc3LNix1F915NPLbGd4d4ei3SN/jCoSbkqD7jEgyY=;
	b=KkbT0OYHlEbVxjymMFjR4M16viZhaSHAYEu7j4a/dTDM5SrA8cRQKiZCflOrvPm67jS+VN
	vUj8oP9EQ1vXu4M0/v9ZLy6tu9k5gqt9uOdLloicdmDID2Wqvira43zHw+2WB701nnGXUd
	cxrvKX/19DjJ4+bOe8Fld479c6OOvSE=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-658-XNpoyFmMNOOdM6c9gkUMKw-1; Mon,
 19 Jan 2026 16:02:44 -0500
X-MC-Unique: XNpoyFmMNOOdM6c9gkUMKw-1
X-Mimecast-MFC-AGG-ID: XNpoyFmMNOOdM6c9gkUMKw_1768856563
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id E70E91956088;
	Mon, 19 Jan 2026 21:02:42 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.22.80.137])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 6C18A19560AB;
	Mon, 19 Jan 2026 21:02:40 +0000 (UTC)
From: Wander Lairson Costa <wander@redhat.com>
To: Steven Rostedt <rostedt@goodmis.org>,
	Gabriele Monaco <gmonaco@redhat.com>,
	Nam Cao <namcao@linutronix.de>,
	Wander Lairson Costa <wander@redhat.com>,
	linux-kernel@vger.kernel.org (open list),
	linux-trace-kernel@vger.kernel.org (open list:RUNTIME VERIFICATION (RV))
Subject: [PATCH 10/26] rv/rvgen: fix typos in automata docstring and comments
Date: Mon, 19 Jan 2026 17:45:46 -0300
Message-ID: <20260119205601.105821-11-wander@redhat.com>
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

Fix two typos in the Automata class documentation that have been
present since the initial implementation. The class docstring
incorrectly stated "part it" instead of "parses it" when
describing how the class processes DOT files. Additionally, a
comment describing transition labels contained the misspelling
"lables" instead of "labels".

Fix a typo in the comment describing the insertion of the initial
state into the states list: "bein og" should be "beginning of".

Signed-off-by: Wander Lairson Costa <wander@redhat.com>
---
 tools/verification/rvgen/rvgen/automata.py | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/tools/verification/rvgen/rvgen/automata.py b/tools/verification/rvgen/rvgen/automata.py
index 70ff98abea751..c0c8d13030007 100644
--- a/tools/verification/rvgen/rvgen/automata.py
+++ b/tools/verification/rvgen/rvgen/automata.py
@@ -18,7 +18,7 @@ class AutomataError(OSError):
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
 
-- 
2.52.0

