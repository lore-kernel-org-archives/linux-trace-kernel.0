Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1969C2ECD2A
	for <linux-trace-kernel@vger.kernel.org>; Mon, 19 Jan 2026 21:05:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768856739; cv=none; b=jQrEel3rS+ep2DchXqlMlwgBINNOc8FXUv0kRUMJAXkxYSRfDdAuXhRyb7P3d2mEAtmfuXhx4QMFCbG+NYuqOkhcdzv7mE1ubNsjmo0fLXijHhqGnw1Eg7C3YjLTdmt83XKbKQ44lqG61lMQAoKPHkNlQnhtTrB9fH16OC/WA1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768856739; c=relaxed/simple;
	bh=PAHEmTW6Z2vUfhafVBk2ibm6WyXb1Mlln0+M7rJ5Y5g=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Z58STVGmYHk7X43ZqjF0zQrVyUSui815Sl9KGgNSmkexrcKYoTD17yO7peCdnrClPsb6MWrfXbURsBsJoSpHzJZJJwk/Izx+XPeEDQfjTD4ULSFTSwCN9En4UIYUEHI2t2F+CMHSEH8v6jpxzVBENtKSysVx5wwbYHEVRFl6BeU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YKfxA3mj; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YKfxA3mj"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1768856737;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AIXE+V/XZ3+xHzcF1ucLUFfUEL28iKIkkgtbegxGVzU=;
	b=YKfxA3mjP8dfOYnuWCJk7sdcELKr+wxI3T+J0ElKaxkPTZO+q1X1bi90JBavUSx6wpp1sh
	pJpQXRjKdk3Qk8hKnd4PEx9ioJpgoZWopvwKDqfY5wVyCal1JMfGL0sZPHrbJEFdAvrMZF
	G6QNNMR2pZartDrzQPYetmKzrs57ZGQ=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-618-5DQVV7zBO_eftzcHD3OmEg-1; Mon,
 19 Jan 2026 16:05:33 -0500
X-MC-Unique: 5DQVV7zBO_eftzcHD3OmEg-1
X-Mimecast-MFC-AGG-ID: 5DQVV7zBO_eftzcHD3OmEg_1768856732
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 8A0F3195605A;
	Mon, 19 Jan 2026 21:05:32 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.22.80.137])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 0FA5919560AB;
	Mon, 19 Jan 2026 21:05:29 +0000 (UTC)
From: Wander Lairson Costa <wander@redhat.com>
To: Steven Rostedt <rostedt@goodmis.org>,
	Gabriele Monaco <gmonaco@redhat.com>,
	Nam Cao <namcao@linutronix.de>,
	Wander Lairson Costa <wander@redhat.com>,
	linux-kernel@vger.kernel.org (open list),
	linux-trace-kernel@vger.kernel.org (open list:RUNTIME VERIFICATION (RV))
Subject: [PATCH 17/26] rv/rvgen: fix possibly unbound variable in ltl2k
Date: Mon, 19 Jan 2026 17:45:53 -0300
Message-ID: <20260119205601.105821-18-wander@redhat.com>
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

Initialize loop variable `i` before the for loop in abbreviate_atoms
function to fix pyright static type checker error. The previous code
left `i` potentially unbound in edge cases where the range could be
empty, though this would not occur in practice since the loop always
executes at least once with the given range parameters.

The initialization to zero ensures that `i` has a defined value before
entering the loop scope, satisfying static analysis requirements
while preserving the existing logic. The for loop immediately assigns
i to the first value from the range, so the initialization value is
never actually used in normal execution paths.

This change resolves the pyright reportPossiblyUnbound error without
altering the function's behavior or performance characteristics.

Signed-off-by: Wander Lairson Costa <wander@redhat.com>
---
 tools/verification/rvgen/rvgen/ltl2k.py | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/verification/rvgen/rvgen/ltl2k.py b/tools/verification/rvgen/rvgen/ltl2k.py
index fa9ea6d597095..94dc64af1716d 100644
--- a/tools/verification/rvgen/rvgen/ltl2k.py
+++ b/tools/verification/rvgen/rvgen/ltl2k.py
@@ -45,6 +45,7 @@ def abbreviate_atoms(atoms: list[str]) -> list[str]:
 
     abbrs = []
     for atom in atoms:
+        i = 0
         for i in range(len(atom), -1, -1):
             if sum(a.startswith(atom[:i]) for a in atoms) > 1:
                 break
-- 
2.52.0

