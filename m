Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2926B328638
	for <linux-trace-kernel@vger.kernel.org>; Fri,  5 Dec 2025 13:16:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764940621; cv=none; b=lzJtUn6PopZEi0/B71f1m9lNyBOVUdKJrvzT1O6ZmhquhY2SqvUenBqf8cq1VExzn8/P7Z05hrY9w3LMSaq7yKFTauwkXxGKn5ftfBnQhdsmEDZv60YnQIcUNXaJ1THRwAIrtTOk+QzUgV7oLWX0PeZRc78c6yK65RbkPlNsJ40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764940621; c=relaxed/simple;
	bh=Hp1UUc//HkW6+lKEgtSCyi+d4ZcTEwDVx10LTVXpvzg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Y7IJl8xc8xoY1GXBQ655TC8Oy4SM+aEGEzlVTpumJcWHS9JtO+wbvX7PIqlZfvrsCC5CkrgQqC62K86Tko3SiyImhQzJWHK5E1KLUQBabTG2vOIl36/BFe3LsoKkuexk2AZceuI9Txe+tTkfVngAIiyIVU87A8tibzSB3m7jD7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NlLdI5FK; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NlLdI5FK"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1764940613;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SqglkPDvlxAEmEtclUgwCg2/uHzDAdN41CTr/RpBOsc=;
	b=NlLdI5FKwb7OhJd+0iReyyXjMpEyDrTHBmnaUDUAlPtkgnG2pevpzYe/UGe9d2YNmNpScN
	cf1QjX6pHg3SxIuQlsg4Uirplw2IfQ9Fwrh8wJR2ag0NOaW78uBNdDL38JUs2jF9BVxCJO
	s3ZuPO9UmVozsYaSI/YSTc/s5Lfwx4Y=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-562-wQd3jWLiNk6wiBn20eiToA-1; Fri,
 05 Dec 2025 08:16:50 -0500
X-MC-Unique: wQd3jWLiNk6wiBn20eiToA-1
X-Mimecast-MFC-AGG-ID: wQd3jWLiNk6wiBn20eiToA_1764940609
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 337091800342;
	Fri,  5 Dec 2025 13:16:49 +0000 (UTC)
Received: from gmonaco-thinkpadt14gen3.rmtit.csb (unknown [10.45.226.23])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 3303C180045B;
	Fri,  5 Dec 2025 13:16:44 +0000 (UTC)
From: Gabriele Monaco <gmonaco@redhat.com>
To: linux-kernel@vger.kernel.org,
	Steven Rostedt <rostedt@goodmis.org>,
	Nam Cao <namcao@linutronix.de>,
	Gabriele Monaco <gmonaco@redhat.com>,
	linux-trace-kernel@vger.kernel.org
Cc: Tomas Glozar <tglozar@redhat.com>,
	Juri Lelli <jlelli@redhat.com>,
	Clark Williams <williams@redhat.com>,
	John Kacur <jkacur@redhat.com>
Subject: [PATCH v3 03/13] verification/rvgen: Allow spaces in and events strings
Date: Fri,  5 Dec 2025 14:16:11 +0100
Message-ID: <20251205131621.135513-4-gmonaco@redhat.com>
In-Reply-To: <20251205131621.135513-1-gmonaco@redhat.com>
References: <20251205131621.135513-1-gmonaco@redhat.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

Currently the automata parser assumes event strings don't have any
space, this stands true for event names, but can be a wrong assumption
if we want to store other information in the event strings (e.g.
constraints for hybrid automata).

Adapt the parser logic to allow spaces in the event strings.

Reviewed-by: Nam Cao <namcao@linutronix.de>
Signed-off-by: Gabriele Monaco <gmonaco@redhat.com>
---
 tools/verification/rvgen/rvgen/automata.py | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/tools/verification/rvgen/rvgen/automata.py b/tools/verification/rvgen/rvgen/automata.py
index 3f06aef8d4fd..977ba859c34e 100644
--- a/tools/verification/rvgen/rvgen/automata.py
+++ b/tools/verification/rvgen/rvgen/automata.py
@@ -127,14 +127,13 @@ class Automata:
             #  ------------ event is here ------------^^^^^
             if self.__dot_lines[cursor].split()[1] == "->":
                 line = self.__dot_lines[cursor].split()
-                event = line[-2].replace('"','')
+                event = "".join(line[line.index("label")+2:-1]).replace('"','')
 
                 # when a transition has more than one lables, they are like this
                 # "local_irq_enable\nhw_local_irq_enable_n"
                 # so split them.
 
-                event = event.replace("\\n", " ")
-                for i in event.split():
+                for i in event.split("\\n"):
                     events.append(i)
             cursor += 1
 
@@ -167,8 +166,8 @@ class Automata:
                 line = self.__dot_lines[cursor].split()
                 origin_state = line[0].replace('"','').replace(',','_')
                 dest_state = line[2].replace('"','').replace(',','_')
-                possible_events = line[-2].replace('"','').replace("\\n", " ")
-                for event in possible_events.split():
+                possible_events = "".join(line[line.index("label")+2:-1]).replace('"','')
+                for event in possible_events.split("\\n"):
                     matrix[states_dict[origin_state]][events_dict[event]] = dest_state
             cursor += 1
 
-- 
2.52.0

