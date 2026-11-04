Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.169
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793777964;
	b=1V2aHbUcH7drSat3MaUBO76bn00cs9KflR6jQIAhqy9r4u+S0affHYe4xDrTh8KBC0xF
	 GZPA2JNbw3miAPL+I05jVhFSJC2H+YpooR3xeBcHrh6Xi6XzAmBt3uMnDfzjHA6yMYTbW
	 f5g96BSj5VY9NmohiDfc1lO2Pb0yH6Ne2D91yJIHTAjRmHDQRjQIVUJZv3v+1O51NcWDE
	 i1bQyjAIweXTWEDkyHeNgBkt47Vi0H0tFQcQKtxYd986PGfOkZP2/Zbj9OMM+YWsNCm9x
	 eqX5rOAiAYYk24OoRnZpv37Oeya+4/euA6nZBJRLhr2e4CLK8WnMZ7UpXcWBpuB/Kgg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793777964;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=siWU9HM2qbRbWZV4CvMwdmGRzsKBMI32Ha2fsv+L+xE=;
	b=saDjpUzts7Ygj2StqGuWpqE+IsORzoXQC6J/kEr2+YT2RBPyQxJZqTxYyNIEnrvkrwU8
	 nfEZ9Og5W5eYjSP/5UBvyagof0nL928Q9JGZyNfBMc9ZfbxfF9ViF+9sBQWT7dA3eUg4n
	 DankQfCyKHipHSIJ4LUC0x56r26rlEe1da3kB+WVLvfGCyMYkQAKCN2fWRFEUmbi7YY32
	 QofG+73PZq+C2i+7rHOIuJJtOY4RMSuGQQosldW7bAF3QjgRVRDtB4OgBNxMm+ieEiT2e
	 aUIiM2AIKrppniey06Z7/gaHFc/OyK5nDvTTc6kHTspXAevCP1ha4ZbHAfGo8imDHDg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=At4LbaYQ;
	arc=none smtp.remote-ip=209.85.210.169
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1113F606A330
	for <linux-trace-kernel@vger.kernel.org>; Wed,  4 Nov 2026 07:39:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1113F606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=At4LbaYQ
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-89ff475a152so179328b3a.3
        for <linux-trace-kernel@vger.kernel.org>; Tue, 03 Nov 2026 23:39:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793777963; x=1794382763; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=siWU9HM2qbRbWZV4CvMwdmGRzsKBMI32Ha2fsv+L+xE=;
        b=At4LbaYQAeXdYiJeFFtgJLN7xypecI5bSn1fPH7MOMfUivowUxA/aw3ybq75wKzNhQ
         fCxhpYoTtBwL//aIUXN8ksH/+eyP+FW9b27uaZZZ/IAfujp8hSOi5EViow8TGiDqesHZ
         0RkaPpaY2CAK3gtg3wBOLNAEXi7tTI7E9ZK8KnbjImnA1ukjWf0PdizDpxXAUtom8A1q
         Z+0ZT7SN0X5U3Ygh3xby23DLPfCbFyHFi+WV+yWCfBsrMVfvgYEvMPO5NR1zAmQy2WSy
         kKrPsIDp/rIFVphRprqodjxZLll95ywot6zC+NRoaT12NdSwgoGcKHemx+5sUQwjc7Mk
         nt7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793777963; x=1794382763;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=siWU9HM2qbRbWZV4CvMwdmGRzsKBMI32Ha2fsv+L+xE=;
        b=tbiQ8Ql+ag2jm5K+FkrpzOoGcq1qRSx22ILrLlP1ploSnr6R4lNf88+vWrIa/KN0+M
         DbVSztLLIGMdCArbx0e6qD3Du8aQG0eWj//Vjx1ZIK7CO1sLvMSdDsF7Y3NrkpNXr0/F
         IqimFrXEWufuzAzYFldDJUx7KD6DjySrZazoyPvQcvGv1NLQPf9RsqZns+C19cbkYe7W
         hgCAvlGs4PwG8S6gWV9jkpVFbppw7AV7sVeJn605CB/9q6h7n4I3CqRBrTUptgbLGG3a
         UuLG4On2u4aJUuY0PdHAUNZX6vMMAcgqYXksfNNVirkt1rxy7NdnF4ZgVFH2v9J/tVYA
         W6fg==
X-Forwarded-Encrypted: i=1; AKwUvBxqYsnz+fJOM7aqfZNlRNhCogzjqWg2yUVjcNOG2Un6eslPKEhUud8aN/z+IRFJBQPQquBJJban8tAVI4IlaJW/BQ0=@vger.kernel.org
X-Gm-Message-State: APuU4Z8HWCe7ZzZHGl3U19VnV04ll6aFrxxPCNLru92mbsYLRaB4y+7z
	ZRTwI49xegecRaq+1f8EjmfCc3OfhU7E6NxRA2kNNPOPFHK43X/PwEql
X-Gm-Gg: AYBFou0iV9H3yMDLW0sM8kHs/V+a2ZOAEwinCDtOMG3qHZYhpBi8YN5kN70VPMIAkRD
	X1rYp4VyRDfuTy4ESGVd0KBFyTbjQ4Ola7BSUxBKTRhCvusZwxyfDEyCaT5d61OMd4F5hS+uJuJ
	cPLRxMaaBdxUumah4z+u7KYUfJB532iKETPtU6jg6mzj+AOgk0GHMruUQil5W31QcO9LSlB3UN0
	2CO4gerZbsi+9LvrOugNsZKpNi9ym8I3qV1laXqJv2NOQ5lYjdhg209hJo+dZT83+UD0Ke8aE+c
	i77oUYf2DlSEJdcucfaSdfyDfohXjsL/gXp2vEU3xJKAGf2Lpe6FuEJVEBuf5otf1a1G3cFZ9FQ
	WlR8VMtwOM0KcZac/iarERYm4awgiyQcqlev2nBEsb+JdK7v5FVAqBE4n5Ud9O2zT13y+yUVskF
	ofAc7J6lKGYJNlqLBU4D7iKvQ+hYqWZLMJb2/qWZAPwG8723mw7f3NWBpOd8VGQCOPQiZgI2Ee/
	YOONIUj5F6zzMi4qiH3ShpnwAKDwXIunjEU0rhSTWutaG08BHNBRPo0WDjrdg0ezKDzdF/KTlgR
	ulUQ+iT4NRRzkNS6cJUOBtlTaIuPHhkMOFokRlYMtq1X9erCgQl94dz1rc3JU/DOn/rjxX6bDo0
	lBtUfmPwiFWPeB7A5rSPoZf0=
X-Received: by 2002:a05:6a00:bd02:b0:89f:d620:226 with SMTP id d2e1a72fcca58-8a9bea66f1emr10716702b3a.24.1793777963298;
        Tue, 03 Nov 2026 23:39:23 -0800 (PST)
Received: from localhost ([103.109.144.14])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8b09af91d32sm543783b3a.25.2026.11.03.23.39.17
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 03 Nov 2026 23:39:22 -0800 (PST)
From: Zhiqi Zhang <zhiqizhangg@gmail.com>
To: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Zhiqi Zhang <zhiqizhangg@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH 1/2] bootconfig: Allow keys with the maximum supported depth
Date: Wed,  4 Nov 2026 15:37:41 +0800
Message-ID: <20261104073742.21202-2-zhiqizhangg@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261104073742.21202-1-zhiqizhangg@gmail.com>
References: <20261104073742.21202-1-zhiqizhangg@gmail.com>
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

xbc_verify_tree() accepts keys with XBC_DEPTH_MAX (16) components,
but xbc_node_compose_key_after() returns -ERANGE immediately after
storing the sixteenth component. It rejects the key before discovering
that there are no more ancestors to collect.

For example, a.b.c.d.e.f.g.h.i.j.k.l.m.n.o.p = value can be attached
to an initrd successfully. However, bootconfig -l stops listing and
prints "Failed to compose key -34". In the kernel, the same error
propagates through copy_xbc_key_value_list() during its length probe,
so proc_boot_config_init() returns before creating /proc/bootconfig.

Check the array capacity before storing the next component. This lets
exactly XBC_DEPTH_MAX components be composed while retaining the check
before any out-of-bounds store.

I found this issue while reviewing bootconfig's depth handling and used
OpenAI Codex to verify the failure and develop the fix. I reviewed the
change and wrote and ran the regression tests.

Fixes: 76db5a27a827 ("bootconfig: Add Extra Boot Config support")
Cc: stable@vger.kernel.org
Signed-off-by: Zhiqi Zhang <zhiqizhangg@gmail.com>
---
 lib/bootconfig.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/bootconfig.c b/lib/bootconfig.c
index 819685d6c68d..a4aae9a9abca 100644
--- a/lib/bootconfig.c
+++ b/lib/bootconfig.c
@@ -428,9 +428,9 @@ int __init xbc_node_compose_key_after(struct xbc_node *root,
 		node = xbc_node_get_parent(node);
 
 	while (node && node != root) {
-		keys[depth++] = xbc_node_index(node);
 		if (depth == XBC_DEPTH_MAX)
 			return -ERANGE;
+		keys[depth++] = xbc_node_index(node);
 		node = xbc_node_get_parent(node);
 	}
 	if (!node && root)
-- 
2.54.0 (Apple Git-157)

