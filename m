Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.41
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794333975;
	b=02Km4q9RuOXjGCiBVjsf4xJyiEid2ThbQc0kt1Dj0MQZw5R57UGQgmQIjQPSzD36QqZ+
	 UqHiiwujhCQlyee0TSQMEU87aR52qS2HqeO9yN5CmY4fzBuXkTjRBacW0ciC/pmGQE/v3
	 5o543tMb/Mq1qXtfQGFDXEKhkMYU98EcuWleyspiqXzAPMLvxYD1M62wp6kfBFWbAMwym
	 HnNaVIxSZDyBKU+/1xF75bS/rhjsnxMw+mj53sv3flNVsTVzxsN3mFBNj8YCm9YtjgHvg
	 Ow+HELpC7U7Ylf5CPBa5pJpIhCOOeEOk9xeL5iLEZ3JXAWByZ6ShKCdJom7B/EdEt+g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794333975;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=kh/vtHBDVyy6lDmv/ABEp8V4+nHln7H1JafS5dcRL2k=;
	b=MJ8eroh0dMJ43QFMgwZ9MxAYKP12t0sVUFBDkeX7jIUU7OL1QQptc/IaaFkOZxnKXWbS
	 G0HaCCHcSEe7oL0SFfFAe5JYOF20I2cyqlSQjIsCUgP5AZicOV+0zLT8/v5rGMqZ2ImIX
	 cQbkGwSq4SnHzrr3Gi0KjI/LM6qmPzlsMVvJXGMpFmRuQyY4ymLPRwFaIkXxPxIG79sty
	 NtGTToMCehjJ387zbiJ64YJlRm6I7U9mkY5ddLvrtck5mJnISUOUU3lr46RBDA4GyOpJT
	 A7yfgqRK4rFVjABZtbzWB2d+Xf3jtIu7L27RIb7KIl1iBmIhUmQ4ZzoyXHTx0t1aAeA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Qn7PoTYa;
	arc=none smtp.remote-ip=209.85.128.41
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88FBE606A337
	for <linux-trace-kernel@vger.kernel.org>; Tue, 10 Nov 2026 18:06:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 88FBE606A337
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Qn7PoTYa
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4a210470b49so18605215e9.2
        for <linux-trace-kernel@vger.kernel.org>; Tue, 10 Nov 2026 10:06:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794333974; x=1794938774; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=kh/vtHBDVyy6lDmv/ABEp8V4+nHln7H1JafS5dcRL2k=;
        b=Qn7PoTYaQaGcb6bzyVHmgPuaMfD6+Nc6gXjR/4fcXdcc4SBBjva73z9UJkxkt2u49+
         sWigh7L+1aJQudacLTniAUiNp6VooLmlAfEfikul11tqcHm29f2aDH+rTKtZwK26AOw2
         NRZCxLSS6ltvuTEdWW0IVsTR0xh0CIL31oPFtt988t9SZnTtwUdwEykcXw58VDYII75j
         gdAvP8cPNdKyRnM7t/+XeRAyZiDSPzGqPN1+WMvsvUcK7b9Gk3/R7Tc25xlcBtBJmBFO
         DO2SSahp/JyqYjXZw5Q02XiXJZP6aao/w2321UdbC1AHBmhY53gyAeJXbxn0GefSaWm8
         8I0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794333974; x=1794938774;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=kh/vtHBDVyy6lDmv/ABEp8V4+nHln7H1JafS5dcRL2k=;
        b=Ij4wt+N7jFxN3pk08ORCOUKHC+N/YY/lPiYVVD+P8VQWa17BrLDMWpPGQ/iFsvIyfy
         Gbo8S2ldLlgBot5vkUQFZwkaCNYVmTgDx6Nc9IVjv2XTW3eo+SEBPkE+3W+VWnz0tgDu
         v9HSYQS93cbmTfweSlmuK/T4EKRLMMLYJv50O57uZLfDJxG6VEeKJrsM8PTBpXOdkRpO
         p3Xg8lDIrvW77MoTsyEIe+znuJ0KWA5/MVgsO09npjwhZnqxLqNJmEQDa4TjqVsPn50U
         M28A7t0A52Xk+tQSMIQCxZk/pwLv9RYoHFSfB3tGn4AhwC4kD9v1ZZLRn3H7Q5UVCdft
         wQ1Q==
X-Forwarded-Encrypted: i=1; AL+hErG5u0OMf/DwcJUvkWY0M/YyGONOnPCvRXUd4DFEAraXmBuHK6+b/SFT1GnbcArBK/7L4088+YqxlvgpqxVKUh8Bi+s=@vger.kernel.org
X-Gm-Message-State: APuU4Z8WiKu9FqyClZucl7iKqPHzONNup95eX9Shn1/b2ZrdTV5KeCLe
	/cgg2HOJU0hG8uMYo67iUCwA5ZfjiM2gr5yGRR2NGnpSSH3drawbTrjq
X-Gm-Gg: AYBFou0UxT8it4ksfVQQjrog5LwK6pOZ4fdgKOlX8PVUC53H+nGKX6SjaeHDwhzJ115
	S2iG8muQCe8bXFzFbXIXfrXDa+hLsh9bZ5GKZ7OAcH5jZOZxkI/qzehJNJ4HAsNgbOSp/bvR+1D
	Y4nXBSp1CQiqn3fkbYJNqCM7CQAmLg6UhZiIVahFJKYUymHvfNIwAZDkiJlDMjAooGzMW+5wDlC
	o3gRsk6FMD+ZY4aA1Ygv/3LsAjla1KngfJr3b/GsYwJm+4MEfXIeZanfMypZ9BiWMA8n9cbctkW
	qDNZaVSUYg46sasilHxS6WjTALQ0iZQGofE8w6WCWJd46gPbDxaYBSm3oAPfd+wSx2Y+XnjV6aO
	swkIt05ljDU2ZRrg3MagIlGLvlBKYPn2Sggsd0H5VEHAzlatJmp/dW2u7VYJVA8QVwZ1Z884m3m
	URNEAuUlldEaSoK22Fowe283p9drAvAx5vmXv5GQT7p4BwlCa/BiUR45zlz2ElM7qIo9bR+wmuX
	ppDqMX0OmmSD4unRAjl/J8U0h7DZ7dQcc1Es4pNoPeIrhDUYN3515BI0IzqFSz9QN1jo1L9BsII
	Pb78oUYEgZXlPE4gJpVAevJ+hnGzQD8ESqmxxTAjsY7eSZuICEfj4aD6FTchpE++C3t0mv9U8tr
	LtodakXZpysWJGt7QcIPudwfvZDAkA79y5O5SG7nuhuksIZB9FnW9G2uk9IpHQnv7vazg3IfrXD
	G6WgZJlPCztKoYZCpOMFf900rINvten2qRyTX8vXma9YFm/a+I+9GwTrPKBd5bwfFmOx0aWnLds
	RdF00soZu95+4SWug==
X-Received: by 2002:a05:600c:190f:b0:4a6:30c3:1114 with SMTP id 5b1f17b1804b1-4ba0233c53fmr57779775e9.12.1794333973819;
        Tue, 10 Nov 2026 10:06:13 -0800 (PST)
Received: from longitude (2a02-8434-fda5-4201-64a2-5e9b-f89e-f448.rev.sfr.net. [2a02:8434:fda5:4201:64a2:5e9b:f89e:f448])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-498366c500asm6270450f8f.48.2026.11.10.10.06.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Nov 2026 10:06:12 -0800 (PST)
From: Eduardo Mucelli Rezende Oliveira <edumucelli@gmail.com>
To: mhiramat@kernel.org
Cc: akpm@linux-foundation.org,
	rostedt@goodmis.org,
	linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/3] tools/bootconfig: Close only opened braces in compact output
Date: Tue, 10 Nov 2026 19:05:59 +0100
Message-ID: <f2bad80ef771708417b75bf7f1286f9f2521ee97.1794333957.git.edumucelli@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1794333957.git.edumucelli@gmail.com>
References: <cover.1794333957.git.edumucelli@gmail.com>
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Post: <mailto:linux-trace-kernel@vger.kernel.org>
List-Help: <mailto:linux-trace-kernel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-trace-kernel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A key may have both a value and subkeys. When it has only one subkey,
xbc_show_compact_tree() can print that subkey using dotted notation
without opening a brace. During backtracking, however, it treats the
value node followed by a subkey as evidence that a brace was opened.

For example, a.b=v, a.b.c=w and a.z=q are printed with the brace for a
closed before z. Reading that output back changes a.z into the root key
z, silently changing the configuration.

Remember the nodes for which opening braces were actually printed and
close a brace only when backtracking through the matching node. Extend
the existing mixed-value/subkey sample to cover a sibling after a valued
parent with one subkey.

Fixes: e5efaeb8a8f5 ("bootconfig: Support mixing a value and subkeys under a key")
Signed-off-by: Eduardo Mucelli Rezende Oliveira <edumucelli@gmail.com>
---
With this valid configuration:

  a.b = v
  a.b.c = w
  a.z = q

the original compact output closes the brace for a before printing z.
Reparsing it turns a.z into the root key z. Values and subkeys under
the same key are allowed by the documented syntax:
https://docs.kernel.org/admin-guide/bootconfig.html#same-key-values

I checked parser round trips for valued parents, bare subkeys, arrays,
deeper trees and a test initrd image. All 94 focused checks pass with
the fix, independently and in the combined series. The full bootconfig
test suite also passes.

 tools/bootconfig/main.c                           | 15 +++++++--------
 tools/bootconfig/samples/exp-good-mixed-kv1.bconf |  5 +++++
 tools/bootconfig/samples/good-mixed-kv1.bconf     |  5 +++++
 3 files changed, 17 insertions(+), 8 deletions(-)

diff --git a/tools/bootconfig/main.c b/tools/bootconfig/main.c
index 56d76bdeaa09..1bab0e685e2d 100644
--- a/tools/bootconfig/main.c
+++ b/tools/bootconfig/main.c
@@ -71,6 +71,7 @@ static int xbc_show_value(struct xbc_node *node, bool semicolon)
 static void xbc_show_compact_tree(void)
 {
 	struct xbc_node *node, *cnode = NULL, *vnode;
+	struct xbc_node *parent[XBC_DEPTH_MAX];
 	int depth = 0, i;
 
 	node = xbc_root_node();
@@ -100,7 +101,7 @@ static void xbc_show_compact_tree(void)
 		}
 		if (cnode && xbc_node_is_key(cnode)) {
 			printf("%s {\n", xbc_node_get_data(node));
-			depth++;
+			parent[depth++] = node;
 			node = cnode;
 			cnode = NULL;
 			continue;
@@ -128,14 +129,12 @@ static void xbc_show_compact_tree(void)
 			node = xbc_node_get_parent(node);
 			if (!node)
 				return;
-			if (!xbc_node_get_child(node)->next)
+			if (!depth || parent[depth - 1] != node)
 				continue;
-			if (depth) {
-				depth--;
-				for (i = 0; i < depth; i++)
-					printf("\t");
-				printf("}\n");
-			}
+			depth--;
+			for (i = 0; i < depth; i++)
+				printf("\t");
+			printf("}\n");
 		}
 		node = xbc_node_get_next(node);
 	}
diff --git a/tools/bootconfig/samples/exp-good-mixed-kv1.bconf b/tools/bootconfig/samples/exp-good-mixed-kv1.bconf
index 8346287d9251..0b8b2f59da31 100644
--- a/tools/bootconfig/samples/exp-good-mixed-kv1.bconf
+++ b/tools/bootconfig/samples/exp-good-mixed-kv1.bconf
@@ -1,2 +1,7 @@
 key = "value";
 key.subkey = "another-value";
+a {
+	b = "v";
+	b.c = "w";
+	z = "q";
+}
diff --git a/tools/bootconfig/samples/good-mixed-kv1.bconf b/tools/bootconfig/samples/good-mixed-kv1.bconf
index 1761547dd05c..35442ee62b75 100644
--- a/tools/bootconfig/samples/good-mixed-kv1.bconf
+++ b/tools/bootconfig/samples/good-mixed-kv1.bconf
@@ -1,3 +1,8 @@
 # value -> subkey pattern
 key = value
 key.subkey = another-value
+
+# A valued parent with one subkey must not close its enclosing brace.
+a.b = v
+a.b.c = w
+a.z = q
-- 
2.53.0

