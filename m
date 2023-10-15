Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92F831878
	for <linux-trace-kernel@vger.kernel.org>; Sun, 15 Oct 2023 05:33:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="OOTsVBFP"
Received: from mail-oo1-xc2d.google.com (mail-oo1-xc2d.google.com [IPv6:2607:f8b0:4864:20::c2d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DDE6E5
	for <linux-trace-kernel@vger.kernel.org>; Sat, 14 Oct 2023 22:33:36 -0700 (PDT)
Received: by mail-oo1-xc2d.google.com with SMTP id 006d021491bc7-57b8cebf57dso1853844eaf.0
        for <linux-trace-kernel@vger.kernel.org>; Sat, 14 Oct 2023 22:33:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1697348016; x=1697952816; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eW5Gw9lfx88ca1Dfq2MtXvfhvw7cUu9QhwY8xI1fswY=;
        b=OOTsVBFP4oWmk+2kz41hYADJ0T6odHFSxmF4RASbq8wl7ZKg+I0M6O/c1Nc8Qr4kzx
         i0sxYr0c9CHLkALas/ltv3BxVXNdthKRUGV6HMXpDpJz3oJVHz3ftpWl9cGfJTeVSzXL
         nsbCWxLBcPNNOeej1A4GaE13Ui64nd5pRBofqYi4R6v8GbW+USl7JBEto2/GAgblocS9
         ZzPdMS3sssqIGIuZ7jOW+Q/HJydmwPCcfTDjDJ1cvZK4ldRcC3GKOqkpGGBJyTZmBZca
         +y03BsjrTsZLzu6nwhD8e47Ohf1gkwkyi1BYX/dQkHKl97e+nV8w/KjdBaob9ElDY+9s
         jr+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697348016; x=1697952816;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eW5Gw9lfx88ca1Dfq2MtXvfhvw7cUu9QhwY8xI1fswY=;
        b=fwBlDnccEUMvzP+18cQAOF3Ak52X8SsOajM3+4fyk912vrlSMOX79+I3XUDOxD8MYx
         Jgzo5H8M1iu6xwkoIt4jcIQ16yXToAQu7w6VH1TOb1pnDQBIcw60CClez8H8tDPBDkb6
         CqDUd6qrXi1TOH+WQS1dT5nQvC6EnxXukwCV9TtKYwkswmEEQsLs05WIbQlIHcBUNdUS
         XL1U7nuNC8l9t3Z44+4LMk8BIURgM6Velb3cmHXzkJqB3AIBHs73ng+0FkDxape9Nis8
         nua0nVdP3AGUFiYRFV16kYYcMIYePTyCUasfEtncCGVSLJQtDh6YaUMJE02b/Lo9M6aZ
         KmUQ==
X-Gm-Message-State: AOJu0YzePn1dz/MPv2gquIW4TEpVtMX1EwR7ry8elVWGn3QR5dlfx+BM
	FUYKd+z9lXuW8OhGN2A5lS8IcHeQzheeXLnFpSfFNA==
X-Google-Smtp-Source: AGHT+IGZwVfLeI1AyGtyBJxKcT0Y5BvLq3O9dnBCaDHueY5UYLzqrCWi05KyK0QUHLr6I+1FO95MuA==
X-Received: by 2002:a05:6358:3396:b0:132:d32d:d929 with SMTP id i22-20020a056358339600b00132d32dd929mr34182114rwd.20.1697348015684;
        Sat, 14 Oct 2023 22:33:35 -0700 (PDT)
Received: from devz1.bytedance.net ([203.208.167.147])
        by smtp.gmail.com with ESMTPSA id u22-20020a62ed16000000b00690fe1c928csm16187368pfh.147.2023.10.14.22.33.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Oct 2023 22:33:35 -0700 (PDT)
From: "wuqiang.matt" <wuqiang.matt@bytedance.com>
To: linux-trace-kernel@vger.kernel.org,
	mhiramat@kernel.org,
	davem@davemloft.net,
	anil.s.keshavamurthy@intel.com,
	naveen.n.rao@linux.ibm.com,
	rostedt@goodmis.org,
	peterz@infradead.org,
	akpm@linux-foundation.org,
	sander@svanheule.net,
	ebiggers@google.com,
	dan.j.williams@intel.com,
	jpoimboe@kernel.org
Cc: linux-kernel@vger.kernel.org,
	lkp@intel.com,
	mattwu@163.com,
	"wuqiang.matt" <wuqiang.matt@bytedance.com>
Subject: [PATCH v10 5/5] MAINTAINERS: objpool added
Date: Sun, 15 Oct 2023 13:32:51 +0800
Message-Id: <20231015053251.707442-6-wuqiang.matt@bytedance.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231015053251.707442-1-wuqiang.matt@bytedance.com>
References: <20231015053251.707442-1-wuqiang.matt@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

objpool, a scalable and lockless ring-array based object pool, was
introduced to replace the original freelist (a LIFO queue based on
singly linked list) to improve kretprobe scalability.

Signed-off-by: wuqiang.matt <wuqiang.matt@bytedance.com>
---
 MAINTAINERS | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 48abe1a281f2..1c0a38d763a2 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -15328,6 +15328,13 @@ F:	include/linux/objagg.h
 F:	lib/objagg.c
 F:	lib/test_objagg.c
 
+OBJPOOL
+M:	Matt Wu <wuqiang.matt@bytedance.com>
+S:	Supported
+F:	include/linux/objpool.h
+F:	lib/objpool.c
+F:	lib/test_objpool.c
+
 OBJTOOL
 M:	Josh Poimboeuf <jpoimboe@kernel.org>
 M:	Peter Zijlstra <peterz@infradead.org>
-- 
2.40.1

