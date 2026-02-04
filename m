Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B4EA4219F6
	for <linux-trace-kernel@vger.kernel.org>; Wed,  4 Feb 2026 14:56:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770216961; cv=none; b=fYB7KdMsilvIGJpWi2JFnjEUeSQgzXzXBYfDkzce40i3z8gwSVif/P+KNkPdInMmX+tWrNKFc+bkS+aJnuafzL3fe+eoN4Em46jflE/udZ0HWi3EOx3rilQnHOPJga3ZKEzhxiqutBehXTuytCAK4GKijx4Z60qOSAttjYOyIQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770216961; c=relaxed/simple;
	bh=aqVw+KwudE2PMyQ5c7D0mNKToCJ+MFm+4+/iUzlVPSg=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=XO69xPtgT4AfjsONwdKQnI3d2UpyOAHdNEEK8lneKoY/qvh4UPJRb0qf+WYaTkmHyDZKBXH9bLb8YLWiBF5IjCLj2W/WGOn018xPz/SFWiY6J0tl5+03nI3Z7zAmlyzFuIblyq95fbqF2q2ToibsBhHRA/YMUNlGL+Cs+nTyERc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UXuFPuvr; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UXuFPuvr"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1770216960;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=i4PzDDOnMDtmDhq8eE10nYEtt4SKmr4xmRLUOnegfHQ=;
	b=UXuFPuvrn5BznDFmSfXElmt9B2fWwN+idAHlwstI/dh3BMLLEVD0fZCzOnfZ80q769YVTI
	KV0gGVVyw9b3IRpZ3Tj5CJsIDRLRps3RNoYN3QS2GJWp7mShKBiuC0INC6eAVlXTYzb2jZ
	twAYAEQ7l/eTSit3Be54sQU90Un6poE=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-18-vyQApY_iPmC5BsT3-3wMQQ-1; Wed,
 04 Feb 2026 09:55:55 -0500
X-MC-Unique: vyQApY_iPmC5BsT3-3wMQQ-1
X-Mimecast-MFC-AGG-ID: vyQApY_iPmC5BsT3-3wMQQ_1770216954
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id EC60E180063A;
	Wed,  4 Feb 2026 14:55:53 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.22.88.140])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 746A530001A5;
	Wed,  4 Feb 2026 14:55:51 +0000 (UTC)
From: Wander Lairson Costa <wander@redhat.com>
To: Steven Rostedt <rostedt@goodmis.org>,
	Gabriele Monaco <gmonaco@redhat.com>,
	Nam Cao <namcao@linutronix.de>,
	Wander Lairson Costa <wander@redhat.com>,
	linux-trace-kernel@vger.kernel.org (open list:RUNTIME VERIFICATION (RV)),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v2 18/20] rv/rvgen: fix unbound loop variable warning
Date: Wed,  4 Feb 2026 11:42:44 -0300
Message-ID: <20260204144914.104028-19-wander@redhat.com>
In-Reply-To: <20260204144914.104028-1-wander@redhat.com>
References: <20260204144914.104028-1-wander@redhat.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
X-Mimecast-MFC-PROC-ID: y-oxCh3mVWIQTklvkTYy8A-zGcUFbzJf4EHpKZwI43M_1770216954
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
---
 tools/verification/rvgen/rvgen/ltl2k.py | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/tools/verification/rvgen/rvgen/ltl2k.py b/tools/verification/rvgen/rvgen/ltl2k.py
index fa9ea6d597095..2c564cc937235 100644
--- a/tools/verification/rvgen/rvgen/ltl2k.py
+++ b/tools/verification/rvgen/rvgen/ltl2k.py
@@ -43,13 +43,17 @@ def abbreviate_atoms(atoms: list[str]) -> list[str]:
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
2.52.0

