Return-Path: <linux-trace-kernel-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F6EECA0FF3
	for <linux-trace-kernel@archiver.kernel.org>; Tue,  5 Sep 2023 16:19:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233405AbjIEQTE (ORCPT
        <rfc822;linux-trace-kernel@archiver.kernel.org>);
        Tue, 5 Sep 2023 12:19:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245226AbjIEBx5 (ORCPT
        <rfc822;linux-trace-kernel@vger.kernel.org>);
        Mon, 4 Sep 2023 21:53:57 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34E9DCC6
        for <linux-trace-kernel@vger.kernel.org>; Mon,  4 Sep 2023 18:53:35 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id d2e1a72fcca58-68c0d262933so1056297b3a.0
        for <linux-trace-kernel@vger.kernel.org>; Mon, 04 Sep 2023 18:53:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1693878814; x=1694483614; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eW5Gw9lfx88ca1Dfq2MtXvfhvw7cUu9QhwY8xI1fswY=;
        b=cEkFZlAiFFAfCFNylE/JG5GVfeqbg8cHop9ks5qJIEzA8r8kq8JdNYI3/ER0mTd39A
         RaxPQKt1+UmvZvh1JOOxGI0CUrkjFG0uhs199x3YNjVFIj5iEhzAdzga+cJqNIQBLS6c
         sl2srVJLM/bKHh6sfSLdvrqOApck6ioJxhpsoGlxnD71CQd2e/S3mBa7D3n4u4xbdDF3
         vuw3c0RRGWOYcIADnRD+aNG6S+WZCEpQRw5dIRxzchIHHqz6ti/ZlS1vwO3mSgSmRL24
         BLgijAdcPL1tAdTjS1+6oM+0kMr7sPGNbxBghKHSPwampYewpe69Mo4GHYISrMY+MQuv
         oHsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693878814; x=1694483614;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eW5Gw9lfx88ca1Dfq2MtXvfhvw7cUu9QhwY8xI1fswY=;
        b=kOzgybI9sQC40eAeCYognoEqz07rZDmQksh+7+wXVFgL0rtIXVKf914AUsyqj3W6Tc
         2sYwP0+cChV2HP8qZrBHq/aKymKFrmTb28evqSyBPPWeE+0RX1it0wVd73sQxyTuMAC6
         HpmUWymIEq1GkGJV2fAC58AzRnGlnn5CaatokM7NHEhIDUJSD/zcR5TcwmuY5XrX1KoD
         R1B6A0FRNIdmsElPyjl1FMFZQWiKdX0pPAj8+6v+Nrj1Gb2qKFjtbAUNryBfR4dLu1wb
         Hk5LK4J2sHjn2m2aUQ/eJTDhjdIgxsrJ1g8wb5O+LUWnWlOtJ8W6DmbIgN5w20/LzUd8
         1YoA==
X-Gm-Message-State: AOJu0Yya0dy3sWQ+u80pbsPl+SlRYZ/7SaFFy2rhWVPNvuHXluPujsKy
        +Xwxugb2y5xcGZD4+VTF53bGIDo1D3N1ehrwRR8=
X-Google-Smtp-Source: AGHT+IFPRLMPPittNPbLARa/xaabWtmV32rvjPcjRdHbe3f9dKJ55stslpiC2Fy94Jw1DqmXP4jCjw==
X-Received: by 2002:a05:6a00:844:b0:682:b6c8:2eb with SMTP id q4-20020a056a00084400b00682b6c802ebmr10352183pfk.1.1693878814666;
        Mon, 04 Sep 2023 18:53:34 -0700 (PDT)
Received: from devz1.bytedance.net ([203.208.167.146])
        by smtp.gmail.com with ESMTPSA id y5-20020aa78045000000b0064d74808738sm7910483pfm.214.2023.09.04.18.53.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Sep 2023 18:53:34 -0700 (PDT)
From:   "wuqiang.matt" <wuqiang.matt@bytedance.com>
To:     linux-trace-kernel@vger.kernel.org, mhiramat@kernel.org,
        davem@davemloft.net, anil.s.keshavamurthy@intel.com,
        naveen.n.rao@linux.ibm.com, rostedt@goodmis.org,
        peterz@infradead.org, akpm@linux-foundation.org,
        sander@svanheule.net, ebiggers@google.com,
        dan.j.williams@intel.com, jpoimboe@kernel.org
Cc:     linux-kernel@vger.kernel.org, lkp@intel.com, mattwu@163.com,
        "wuqiang.matt" <wuqiang.matt@bytedance.com>
Subject: [PATCH v9 5/5] MAINTAINERS: objpool added
Date:   Tue,  5 Sep 2023 09:52:55 +0800
Message-Id: <20230905015255.81545-6-wuqiang.matt@bytedance.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230905015255.81545-1-wuqiang.matt@bytedance.com>
References: <20230905015255.81545-1-wuqiang.matt@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-trace-kernel.vger.kernel.org>
X-Mailing-List: linux-trace-kernel@vger.kernel.org

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

