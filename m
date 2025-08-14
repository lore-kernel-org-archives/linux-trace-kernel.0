Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C620021CA1D
	for <linux-trace-kernel@vger.kernel.org>; Thu, 14 Aug 2025 15:09:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755184163; cv=none; b=qvtZhxNsXKyRfqPyWel/AT61Kk6h4BD2ey2GP40zFKSkPVJTuu3bVhTOD6KpwcXJmas1R+MKw0J0NPBmTgFmV7LSqI+k2D0sn5kiYzHHD6qAhGh6eggeZeF5RjFspQzAqBcm24Dw2shEuIqcrTZwyib4llKqn85eLX+qUod+AFo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755184163; c=relaxed/simple;
	bh=xXDVfNgGGP7QQqfh7zOZfxCp5lm8BioslVi+eNdEt9U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=t906c6X2t1+Ylsc3rOhoYToiaKkFpmXmYLGkf1DtyKhOvPEPqnnuvZCh4wd4yiOWFNb/V6SaItZ6hgqPa82W7iTvhDM0+/ewN+jq68E8cVC7mGmIyXIfD4N4M7BjI4T6KUUXq6EyX1aDOKl6riDcLaCdblwHA0I+MKREp8LCj64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JGLCPrxI; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JGLCPrxI"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1755184160;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rNhapDhZFCMPZA/TgP7fSi8baQpPGqcLi/advpOV3TY=;
	b=JGLCPrxI3/iQqykmj2TDJiQ2Fv8f+9S7nxndCMpVbZJjz464JcF/nbzOhYeCnwDOK648ws
	fLY0ELdIyMxATt6bPIkDyLMeCbyb8UKKyrYEbQLxKQWngV8LTV96eYiVS3KBkDHPNuqg28
	h7DpfbBDRK5/ISjm66cBPPL9CbeBzgc=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-67-FWwHpVozMmierZWoRaS6nA-1; Thu,
 14 Aug 2025 11:09:18 -0400
X-MC-Unique: FWwHpVozMmierZWoRaS6nA-1
X-Mimecast-MFC-AGG-ID: FWwHpVozMmierZWoRaS6nA_1755184157
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id E57A419775E8;
	Thu, 14 Aug 2025 15:09:16 +0000 (UTC)
Received: from gmonaco-thinkpadt14gen3.rmtit.com (unknown [10.44.32.52])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id C8145180047F;
	Thu, 14 Aug 2025 15:09:12 +0000 (UTC)
From: Gabriele Monaco <gmonaco@redhat.com>
To: linux-kernel@vger.kernel.org,
	Steven Rostedt <rostedt@goodmis.org>,
	linux-trace-kernel@vger.kernel.org
Cc: Gabriele Monaco <gmonaco@redhat.com>,
	Nam Cao <namcao@linutronix.de>,
	Tomas Glozar <tglozar@redhat.com>,
	Juri Lelli <jlelli@redhat.com>,
	Clark Williams <williams@redhat.com>,
	John Kacur <jkacur@redhat.com>
Subject: [RFC PATCH 09/17] verification/rvgen: Allow spaces in and events strings
Date: Thu, 14 Aug 2025 17:08:01 +0200
Message-ID: <20250814150809.140739-10-gmonaco@redhat.com>
In-Reply-To: <20250814150809.140739-1-gmonaco@redhat.com>
References: <20250814150809.140739-1-gmonaco@redhat.com>
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

Signed-off-by: Gabriele Monaco <gmonaco@redhat.com>
---
 tools/verification/rvgen/rvgen/automata.py | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/tools/verification/rvgen/rvgen/automata.py b/tools/verification/rvgen/rvgen/automata.py
index 76d7a3cfaec6..c637cf4ee749 100644
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
2.50.1

