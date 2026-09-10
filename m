Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 253A04BB291
	for <linux-trace-kernel@vger.kernel.org>; Thu, 10 Sep 2026 16:30:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789057861; cv=none; b=buIruKxt0+IUfGWtzfzJt/EOAy8mI/VRSh0DGlvOJ4v1V2zqKfA6RDgIUuK0yk/xlXougL0AUxHM+ej3NG8piExoYSCh/Si2CdUayUkU2l03D3iW0HqX5LkOqLfHeLfKSgF2efGgS9hnOrUcJr/du9FuDILGvZZaRYlEBo5sfho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789057861; c=relaxed/simple;
	bh=DQmmGe16PUNLbKn+5eDhR3jk3It4f1OLBgDBkeDmcCs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=EoFto13LOlWItCK/ZwRh4DFn1WefxrFLV9Q2Iq8gA1hMDIeaX3iT0dlpO+ap7zrwAmCpgn1x/T3bV7Jx/xZnS9l8/ymwaScOThH4528VzDP2qSIGbU/dRLxryoVRlAjfY5wymgCeVruywNl09epn1qZObMGllv/7L0DrQ1VGxLo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gRi1oU7Q; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gRi1oU7Q"
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-869ac301739so704557b3a.1
        for <linux-trace-kernel@vger.kernel.org>; Thu, 10 Sep 2026 09:30:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789057858; x=1789662658; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Qyj0GyoBST2G2eSacIyvXgzt3OFSiF4nRJRJizlpUmk=;
        b=gRi1oU7QkkiyG0RGSoVRRTxyKRuP17VnIlIf2jUhxUM8o0a9IscrqoxdHnKwdymSFv
         vNepRHsNnQMA2gkgOLrGL5S0WKQzFFaAIWafxlalmxWgTfUyfYBA+HduZu2M1Tf0ypwr
         S38WVNq9xDuS66STbYO9+JVrMHosstDR3PKZIGZ8LKAzVHVjnBLM/WIlczafLy9FkEcT
         OeUuY2dsPYg04hhTodLdXOqpBzQiZYRYrfMwOm2zPeDxnw5gY6qeFEh9GQjXfB7Zo3YH
         xEiPQdkY32dkQ6wh9InIIx163fNG1PW5+yS0N3l7SFAgOLoayzvXaL0XCm5OhfTSc2Gr
         v/pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789057858; x=1789662658;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Qyj0GyoBST2G2eSacIyvXgzt3OFSiF4nRJRJizlpUmk=;
        b=mtPCSaLEsIzBmbVeDqYcVxsuZf2ymZKEDDcligsJSX/EJh62smbj8Ixx5lewPbEsIZ
         f9wU+/CHxuoqvIazTf8jw2DuaEq+7uNPSBEZ0GO1xBuAyKN2u3QqXG8LZjBMpF3yNtAa
         lsxb6JlAb/vFCfCc/ZJz4whT82GL+MDsUo+WErJAPnccIxwB1i60wFDK6IzOed64FBFl
         5MM9P+hjzMMi/QWybFrjKtZ402R/U0H8Q/HBs0rNtcf+C3jtylOYpBWgSoy6Yh9o48k8
         Wrfdo9KVb0Jp/i5uSAVG5Fp+1NBDQG8vlDWs/9k5ip6nyFl6EV7GwE44CI87kEjKlpGB
         9t6w==
X-Gm-Message-State: AFuF++lx/lalLjm+BDhBk+iatJZNAdDqahONl82z+ps3e7oE1693b0Y5
	2FojijPSIRpBOGTG6hE45W27l+t0AarpMMgUyUj3V41e4GgdzIt8sCf5
X-Gm-Gg: AYBFou1GnA9Ok+s+vHTA94uzIQVS13MadnPjB3cqYm74XJRLf328u1LurTYLqxEfupj
	HCH7ln7De1IBMlq0xanZ7JJ9k7h0f5ec0FYCbJzhw77Hw6Mm6AeMn+jwaQ7godIXLWs0s/gBt/C
	HKmTSP24vseJA7iNDz6VBVoMNmfYcpds0jo+9SFu31IcyCTtpIXv1//8WXr9SrPHviKs/o18aKR
	VDRL6KxdK46HhEbSIwtWa6/7ekIxBS9fTISL1HdeaiklQzENSP4HvRtr0b3/0GP44kuyKlGTzhW
	TzJx40f3sXwZEx3S9+P2cinOHkdMqAUxIPX8pyxyb7UEedSCnqCBB1r02kKQ6jxAlB65oo06Ixm
	/pnW3WefyTVocYUqn4O6PrPJDvizpECl9tYSTiEJLZQ/2QH056DK6jTvEM3KXX5N43US1Kgg+cH
	BzSFp16Hc4lmlS7wN797RF30ltOLNOwj3/oKOkhzHW1n0M9iamw45twCH2T2i9eeXmtA==
X-Received: by 2002:a05:6a00:13a8:b0:869:c368:3675 with SMTP id d2e1a72fcca58-869c36851edmr5290100b3a.17.1789057856215;
        Thu, 10 Sep 2026 09:30:56 -0700 (PDT)
Received: from ubuntu.. ([110.9.142.4])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-86aa00a4c22sm666467b3a.41.2026.09.10.09.30.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Sep 2026 09:30:55 -0700 (PDT)
From: Sang-Heon Jeon <ekffu200098@gmail.com>
To: Andrew Morton <akpm@linux-foundation.org>,
	Masami Hiramatsu <mhiramat@kernel.org>
Cc: linux-trace-kernel@vger.kernel.org
Subject: [PATCH] bootconfig: remove redundant assignment in xbc_parse_array()
Date: Fri, 11 Sep 2026 01:30:48 +0900
Message-ID: <20260910163051.1973775-1-ekffu200098@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

After the loop, node is the last array value that xbc_add_child()
added, and xbc_parse_array() sets node->child to 0.

xbc_init_node() already set node->child to 0 when the value was
added, and node->child is not modified after that, so the assignment
is redundant.

So remove the assignment.

No functional change.

Signed-off-by: Sang-Heon Jeon <ekffu200098@gmail.com>
---
 lib/bootconfig.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/lib/bootconfig.c b/lib/bootconfig.c
index aba11caf6903..12dd259d490e 100644
--- a/lib/bootconfig.c
+++ b/lib/bootconfig.c
@@ -833,7 +833,6 @@ static int __init xbc_parse_array(char **__v)
 			return -ENOMEM;
 		*__v = next;
 	} while (c == ',');
-	node->child = 0;
 
 	return c;
 }

base-commit: 13e8b7707efcea3a401d242958ba0a392f227847
-- 
2.43.0

