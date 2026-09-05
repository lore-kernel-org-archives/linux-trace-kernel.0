Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07B2B3769E6
	for <linux-trace-kernel@vger.kernel.org>; Sat,  5 Sep 2026 21:19:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788643170; cv=none; b=RmbiJwAOL4zZWVakKqYzAj2hpAVMv8InCRMnNsI20B3WTPW2biP5l25J9+8J+vsyPyuG1PiVcy/YNeBwq18JaJK4RtnethJwG78tg4qdqQgBhdQtcGo+Zg8nMjySLxw4wiVONMW8VV1BOxfkhKG29FDkEGcnzt15zCGORX4hwZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788643170; c=relaxed/simple;
	bh=oh7oa64ahPQJ1oY0hX/CJNl3pOM3+7GitaoWTG6lWjY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fopxXynTf2AVuWWsPXODrZexF6XAIWD7v+b+NxnFVGTwz+PP8b39VjMHwsQZXGVpwxGyHE1Gua/Zhd/AUnRQS1zvhOnqoRERVJdNnoPboaYY1HZGAsV1TNmZfQ48DF5d5CkMgzWEr4hfYxiozYvqSz1q1qdvD6xyD5L93uevOJg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NZyfGnLL; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NZyfGnLL"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2d58efc7356so27111455ad.1
        for <linux-trace-kernel@vger.kernel.org>; Sat, 05 Sep 2026 14:19:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788643168; x=1789247968; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=O10faWGDAP+xqB2dkkb1dGKdh4Nv8p4gi8rVF5o6P08=;
        b=NZyfGnLLOE1s35qWQIHFnQdnj33fvjUkOXLMQmBz+Gj6xf4VnhZ1fLz8CIxbI483ON
         CkGRVVneXELIW3TeTmb1H3SjSGEU1QHaglzFISIi1OihbLqjubhhS4TRIDL7WIZOpSC9
         NGbPVquifNWRx1/ilvgIZ4w5vy0K5tViClP5QIpeZbpDLFgqPeN5ldbbYnh2duyL9/IH
         qZYwPYvhi2I1HOEMdjBxrYa3HnlzvNodP5Yz5ibtQkZy9nqCriax9fy6CDoGz2HJJpLv
         tecy5wZb9vlsag7txgZ09PnBcd0CO1EUuEj1N2ZolWiXpmHrR+EUKsxcfk3dVKeth7Xp
         0gfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788643168; x=1789247968;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=O10faWGDAP+xqB2dkkb1dGKdh4Nv8p4gi8rVF5o6P08=;
        b=FFX0hGy08brBwjf2C17VMXD3iABv+2NdF01VM3rQtFwH75eemGv53jd4hMJcQoV5wi
         RjmpE6fRcVlxrCJmny8tYl3Yh6aQ/PBlNyjWTmJoqAwLFH/hd6p5m+AwFvLuJnoLcPYx
         XsRpj1FCaHMCOME5kubnBuClwH48lMkWauU9VUwJhS0gJM+Dxoye8x3ER94OiJ3PiSVG
         voLpu/H+JesdkaWV33YFmKCZXjhhMxI0L9oAnWCgVyyh3dCDv3VqFrsAUPXWpdwuGUND
         TCp0ipZ1aJYyQ1hY/GS1DGMMKadlZlAOhS6EMCPHkmti/8zcP5Td+JnOhheka1ViNiIa
         AT0g==
X-Forwarded-Encrypted: i=1; AKwUvBwYKTqk0zGjaAaoIQGXDQIEINpRrQbAJxwAew2D40PSDRWBbkUdvHdxHYk+ThvCwmdv6mnZFLPBgMxumsSoZlGm/I0=@vger.kernel.org
X-Gm-Message-State: AFuF++ljC62JKJGKfzGUQD132sMhtapZrSozy0yPT/Uli0LUIBFoOEKJ
	1uZ65SrbNcrapv2VB/J9biwqC2oa8HgTdMurlHGS4B2vZgrSxERhVls=
X-Gm-Gg: AYBFou1qRa0F9o/fw/+pIAYJolcLZ89gRjWzBAnhckM4CjGvpvcnO6Smx46Fh7leb4R
	jbOAE4593eAryC3t53z66PFwZrq1Men8RTr5lchbjwiMaticZghh4Ghyf+rGZbHenW1t5RjLMYE
	OSNbturUICRYeCjovSF0gb95CFaPEjUCEtVJHcaxvtPnLZYeOr6em8PO2UfZawgVoe3lakm2rZI
	RLtVzpydArturEp6C1ku7rBWOuQl45UXWndMzPgXbZxLdSWIUUA+b/dY+i+LOMkFvB31htjgBKc
	rbAIyljo3XD/CKmAOus7ofjaD4v4Dl5aJLLMejHpdx/rHFuSERQ5P6e0Bc2zqF6Er7OPK2vBVWY
	O/miCgipJFdwDMQUb6hNUADm5UAm7ltQmRhPAF9gwHGuYO+Bt/7TGuVKhUTc4JUg/1Zbvht7Bh4
	aIa7qEXumE6AE6dv8re5lKMH1s0aYuSKGqNW06GGZymJze7EHKFkgFggp0zvDTsCZ3bx8ZdXPPz
	8A917JGf/ntbus=
X-Received: by 2002:a17:90b:57d0:b0:395:4de0:b78f with SMTP id 98e67ed59e1d1-39b260d28eamr20673725a91.1.1788643168166;
        Sat, 05 Sep 2026 14:19:28 -0700 (PDT)
Received: from ydg-Zenbook-14-UM3406GA ([211.230.25.193])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39ae60b48a8sm6947791a91.0.2026.09.05.14.19.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Sep 2026 14:19:26 -0700 (PDT)
From: Donggeun Yoo <donggeunyoo.kernel@gmail.com>
To: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Donggeun Yoo <donggeunyoo.kernel@gmail.com>
Subject: [PATCH] fgraph: Remove unused FGRAPH_MAX_INDEX
Date: Sun,  6 Sep 2026 06:19:22 +0900
Message-ID: <20260905211922.1196366-1-donggeunyoo.kernel@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

FGRAPH_MAX_INDEX has no user, and it expands to FGRAPH_INDEX_SIZE and
FGRAPH_RET_INDEX, neither of which is defined anywhere in the tree. It
was added in that form by commit 91c46b0aa917 ("function_graph:
Implement fgraph_reserve_data() and fgraph_retrieve_data()"), which
introduced the current data word layout under new names, so anything
referencing it would have failed to build ever since.

Remove it.

Signed-off-by: Donggeun Yoo <donggeunyoo.kernel@gmail.com>
---
Found while reading the shadow stack word layout. The macro is dead in
both senses: nothing references it, and it could not be used as it is.

Compile-tested only, with CONFIG_FUNCTION_GRAPH_TRACER=y and
CONFIG_DYNAMIC_FTRACE=y. Removing an unreferenced macro cannot change
generated code, so there is nothing to test at run time.

 kernel/trace/fgraph.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/kernel/trace/fgraph.c b/kernel/trace/fgraph.c
index 40d373d65f9b..ed455b53513b 100644
--- a/kernel/trace/fgraph.c
+++ b/kernel/trace/fgraph.c
@@ -143,9 +143,6 @@ enum {
 #define FGRAPH_DATA_INDEX_MASK	GENMASK(FGRAPH_DATA_INDEX_BITS - 1, 0)
 #define FGRAPH_DATA_INDEX_SHIFT	(FGRAPH_DATA_SHIFT + FGRAPH_DATA_BITS)
 
-#define FGRAPH_MAX_INDEX	\
-	((FGRAPH_INDEX_SIZE << FGRAPH_DATA_BITS) + FGRAPH_RET_INDEX)
-
 #define FGRAPH_ARRAY_SIZE	FGRAPH_INDEX_BITS
 
 /*
-- 
2.53.0

