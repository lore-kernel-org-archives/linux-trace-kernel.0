Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00AEF313532
	for <linux-trace-kernel@vger.kernel.org>; Mon, 23 Feb 2026 16:31:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771864276; cv=none; b=LDzNwcmVXEw8xTfcT+7helBjTQxSXkVqFfZJVcuxZU1EmMRB7BhKA32/LJ9mttStW6Er9BxuEFMemFRfl7tsDt7caB5v7xCm4aCR5zC0rnjGrwLcJvDj8HnU+hushjBn43vUQ8xjX1G3wn3BQzV21C+aSfRV5ZBJu7+wimaORWs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771864276; c=relaxed/simple;
	bh=0fVlBJQm+igAU5t1TvfWsxMcVM5Q0TPaMEDt9Vk5wnM=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=tYgKT2hCRHU/o5cytjhjcAAaeE+TN8C7cVDVdjLMNm+2xvEOwF/Xd1TsNpmO9tgzBAOp/kIBMu6ZbkwJWuQJtRxbSbM2eXv7+IAJpoBRiuTleDT1xz42dLkv16dLoM5jM8ekr4uqkugE4k7qmLLaBljOJMcWihqD+ilbGE6RmBg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BMV6bRhb; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BMV6bRhb"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1771864274;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dCAIlwTWFIiBKB7lUUOxEwC4wlCG1Kk+xafXT1zGEqU=;
	b=BMV6bRhbphIbVwUw90MJKha9NeAk/GpAN+5P4tkY0CH4TjWJ6RK+aXymkpC857OQ2g2E7o
	9vFt+Cfq69SMLa/GykB5jNk8KROQdZRkCtgAZDjpfIJRhTQGkn8Hd8Z8L71drGYACv0tEW
	e3euLN79ceweb34opepXfANviQ4Aq3s=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-639-WdGEk8MEPXOTd9SEuYNzXw-1; Mon,
 23 Feb 2026 11:31:10 -0500
X-MC-Unique: WdGEk8MEPXOTd9SEuYNzXw-1
X-Mimecast-MFC-AGG-ID: WdGEk8MEPXOTd9SEuYNzXw_1771864269
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 67D7A1800464;
	Mon, 23 Feb 2026 16:31:09 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.22.88.94])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 4D74A1800370;
	Mon, 23 Feb 2026 16:31:07 +0000 (UTC)
From: Wander Lairson Costa <wander@redhat.com>
To: Steven Rostedt <rostedt@goodmis.org>,
	Gabriele Monaco <gmonaco@redhat.com>,
	Nam Cao <namcao@linutronix.de>,
	Wander Lairson Costa <wander@redhat.com>,
	linux-trace-kernel@vger.kernel.org (open list:RUNTIME VERIFICATION (RV)),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v3 18/19] rv/rvgen: fix unbound loop variable warning
Date: Mon, 23 Feb 2026 13:18:01 -0300
Message-ID: <20260223162407.147003-19-wander@redhat.com>
In-Reply-To: <20260223162407.147003-1-wander@redhat.com>
References: <20260223162407.147003-1-wander@redhat.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
X-Mimecast-MFC-PROC-ID: R4UXNU7-b0ykW_7xSZZ2zbUj9cESz-sdEnAd6AfWiro_1771864269
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

Pyright static analysis reports a "possibly unbound variable" warning
for the loop variable `i` in the `abbreviate_atoms` function. The
variable is accessed after the inner loop terminates to slice the atom
string. While the loop logic currently ensures execution, the analyzer
flags the reliance on the loop variable persisting outside its scope.

Refactor the prefix length calculation into a nested `find_share_length`
helper function. This encapsulates the search logic and uses explicit
return statements, ensuring the length value is strictly defined. This
satisfies the type checker and improves code readability without
altering the runtime behavior.

Signed-off-by: Wander Lairson Costa <wander@redhat.com>
Reviewed-by: Gabriele Monaco <gmonaco@redhat.com>
---
 tools/verification/rvgen/rvgen/ltl2k.py | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/tools/verification/rvgen/rvgen/ltl2k.py b/tools/verification/rvgen/rvgen/ltl2k.py
index b6300c38154dc..b8ac584fe2504 100644
--- a/tools/verification/rvgen/rvgen/ltl2k.py
+++ b/tools/verification/rvgen/rvgen/ltl2k.py
@@ -44,13 +44,17 @@ def abbreviate_atoms(atoms: list[str]) -> list[str]:
         skip = ["is", "by", "or", "and"]
         return '_'.join([x[:2] for x in s.lower().split('_') if x not in skip])
 
-    abbrs = []
-    for atom in atoms:
+    def find_share_length(atom: str) -> int:
         for i in range(len(atom), -1, -1):
             if sum(a.startswith(atom[:i]) for a in atoms) > 1:
-                break
-        share = atom[:i]
-        unique = atom[i:]
+                return i
+        return 0
+
+    abbrs = []
+    for atom in atoms:
+        share_len = find_share_length(atom)
+        share = atom[:share_len]
+        unique = atom[share_len:]
         abbrs.append((shorten(share) + shorten(unique)))
     return abbrs
 
-- 
2.53.0

