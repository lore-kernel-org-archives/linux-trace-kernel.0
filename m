Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21220436BB
	for <linux-trace-kernel@vger.kernel.org>; Tue, 17 Oct 2023 13:57:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="fwtZhN5K"
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23F1510E
	for <linux-trace-kernel@vger.kernel.org>; Tue, 17 Oct 2023 06:57:38 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id d9443c01a7336-1c9d922c039so45753275ad.3
        for <linux-trace-kernel@vger.kernel.org>; Tue, 17 Oct 2023 06:57:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1697551058; x=1698155858; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eW5Gw9lfx88ca1Dfq2MtXvfhvw7cUu9QhwY8xI1fswY=;
        b=fwtZhN5K9FT9toa56UrJZ5QMkXyIQyGnQvN45xRL9ZU+X/PlfepOs58IFyhvwBxaNP
         jmxa7jhk6QgM2NSqlDHjHr76fsth1xt6NT2lKJvx4PU2Z4nTWwb3Y/AxOzJ9RgoNkKSM
         YeAQbHjafbSaDmCacJjLnxbn1m9kduSA/P7eYlasVGLPiHa1zRKQM1TjIeVWu8FNLk3y
         SNzmGBbX+Xm9FzUfAEdCgka1b7lTUj72nTN0AC7EysE4MVkA//1JFSCAGM8AqBeWuh6Z
         e6H2XpUYTqAmh2bWkgDxDj3otcAjt+b1ox3F0UBpD02/3Vzk+V8uFmLsYk2IiK1mHnJT
         1nlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697551058; x=1698155858;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eW5Gw9lfx88ca1Dfq2MtXvfhvw7cUu9QhwY8xI1fswY=;
        b=VVM2BN++0f+V0T4oebnBcn1SMinEKzx+JLnAb5SeetqDEVdg9obk9sv+suGoMakzOj
         NwcG0N+TC5QiZMGeuQM343EJ9MREXQ3FSRrnUQJzLlYGJDWkVyZXx+diDP5Y1SGk0ki0
         ZR1eA8nKsvt1NX/9VSvn7T2mBAzIeq78K0ZdOHt3VnBB2aenz2C13dIX0Ia/dwrACZkv
         bq29mYqLDmU3CUaf8TLuLZ/xdlOz0tFLty0I42ZrVclO7coRhZpUWEHarx1cOiLkaqfa
         4paoFhjkbhgvr5rKTQcB53lVyujOsUG1lnIxasp56O3Ig+iM2MO69mDOs2pcOqWiC3JT
         /VWA==
X-Gm-Message-State: AOJu0YxKACfwgXzs+7glw+9YzInuFdbWuWZzJvXNVVj47c4c9P/ww12n
	91e49HfLjxzHqM3oQDe7UgfF4GorKlnOuesw7K4=
X-Google-Smtp-Source: AGHT+IHpKgRBA8ZM+uMeoha8LLvSfXNFnKnpOzRcQHmNdHaCoUv70KRV4I33W7Rv+6GsoAEvvSh7MQ==
X-Received: by 2002:a17:902:ef8c:b0:1c3:4565:22f with SMTP id iz12-20020a170902ef8c00b001c34565022fmr2057058plb.21.1697551058231;
        Tue, 17 Oct 2023 06:57:38 -0700 (PDT)
Received: from devz1.bytedance.net ([203.208.167.147])
        by smtp.gmail.com with ESMTPSA id b9-20020a170903228900b001b9e9edbf43sm1566634plh.171.2023.10.17.06.57.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Oct 2023 06:57:38 -0700 (PDT)
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
Subject: [PATCH v11 5/5] MAINTAINERS: objpool added
Date: Tue, 17 Oct 2023 21:56:54 +0800
Message-Id: <20231017135654.82270-6-wuqiang.matt@bytedance.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231017135654.82270-1-wuqiang.matt@bytedance.com>
References: <20231017135654.82270-1-wuqiang.matt@bytedance.com>
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

