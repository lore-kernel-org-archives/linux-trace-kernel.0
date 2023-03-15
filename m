Return-Path: <linux-trace-kernel-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A369AC74A5B
	for <linux-trace-kernel@archiver.kernel.org>; Wed, 15 Mar 2023 18:19:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231774AbjCOSTb (ORCPT
        <rfc822;linux-trace-kernel@archiver.kernel.org>);
        Wed, 15 Mar 2023 14:19:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232399AbjCOSTa (ORCPT
        <rfc822;linux-trace-kernel@vger.kernel.org>);
        Wed, 15 Mar 2023 14:19:30 -0400
Received: from mail-qv1-xf2b.google.com (mail-qv1-xf2b.google.com [IPv6:2607:f8b0:4864:20::f2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 880CD5BCBB
        for <linux-trace-kernel@vger.kernel.org>; Wed, 15 Mar 2023 11:19:28 -0700 (PDT)
Received: by mail-qv1-xf2b.google.com with SMTP id op8so17205855qvb.11
        for <linux-trace-kernel@vger.kernel.org>; Wed, 15 Mar 2023 11:19:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google; t=1678904367;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8z1V24My5EukKvP2tBVF8l+SikUfpmtGJWjB50uVIOg=;
        b=gJL6xjY5J2VB+tgs7f4PKBmC6aJ6vF1TWCTHcKQSQeXddqkVkKHy4ky/vJZtWMfi1o
         uOBvR7syUfnwN1QoGa1eAGsFwODy02Qau5v8CRaDi+6RCsH9b1haKNaZ+fbdnRhLv0Rx
         VZK+iIEW4txFkIEOJqJ11RttHfWWpcIa5GTPw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678904367;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8z1V24My5EukKvP2tBVF8l+SikUfpmtGJWjB50uVIOg=;
        b=vGG1DA6K+tHGw8Pgxtx1MQ7A3H0y0O8WDYZXgNebdIuyu7mOZAc/ahHDMChe7DJwD5
         b/KoB8/3L+tSIfX7sgXzhfR5UW2v7P2Hgec9nzqi3ouUc5+ssEPhnpKvvI1sfdf/Cbiu
         gxkrab7sU6DAzPG44pumegYmK90F5Ei5K2mMxLTYRO47xBntx868BUMJQI9YMg0H/5yI
         fcZiYYaYeTYin8RSB+rHy7s3T5T7CvuARGgRhccMvILja8uWOma3FfjERC9G3e0S6Kbg
         a0vbFchVwVaGMDOYDTIV7G1MbJpv2XPOPgo8dbSt97Co4z8316cpeQZWXEDOoIVOXwW7
         4QVg==
X-Gm-Message-State: AO0yUKURkoNCGOaB0r6HvD7nfb6XMtgqy8hAAE18lN2/C0gvd47dIfHt
        BX14g4nG3S6Gp/aXN1qG0t2UyZ5jdlaN4lgb0ts=
X-Google-Smtp-Source: AK7set8coNV2PCiddxtok30tFqWS0F5BBEEcIkmqhxeatRAX+cmZTCY9Dq8Q7VYbYbwbGSn1bAem5A==
X-Received: by 2002:a05:6214:1cc8:b0:5ac:58cc:69d1 with SMTP id g8-20020a0562141cc800b005ac58cc69d1mr12603637qvd.31.1678904367609;
        Wed, 15 Mar 2023 11:19:27 -0700 (PDT)
Received: from joelboxx.c.googlers.com.com (129.239.188.35.bc.googleusercontent.com. [35.188.239.129])
        by smtp.gmail.com with ESMTPSA id v125-20020a379383000000b007458ae32290sm4113974qkd.128.2023.03.15.11.19.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Mar 2023 11:19:27 -0700 (PDT)
From:   "Joel Fernandes (Google)" <joel@joelfernandes.org>
To:     Steven Rostedt <rostedt@goodmis.org>,
        Daniel Bristot de Oliveira <bristot@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>
Cc:     "Uladzislau Rezki (Sony)" <urezki@gmail.com>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Subject: [PATCH v2 03/14] tracing: Rename kvfree_rcu() to kvfree_rcu_mightsleep()
Date:   Wed, 15 Mar 2023 18:18:50 +0000
Message-Id: <20230315181902.4177819-3-joel@joelfernandes.org>
X-Mailer: git-send-email 2.40.0.rc1.284.g88254d51c5-goog
In-Reply-To: <20230315181902.4177819-1-joel@joelfernandes.org>
References: <20230315181902.4177819-1-joel@joelfernandes.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-trace-kernel.vger.kernel.org>
X-Mailing-List: linux-trace-kernel@vger.kernel.org

From: "Uladzislau Rezki (Sony)" <urezki@gmail.com>

The kvfree_rcu() macro's single-argument form is deprecated.  Therefore
switch to the new kvfree_rcu_mightsleep() variant. The goal is to
avoid accidental use of the single-argument forms, which can introduce
functionality bugs in atomic contexts and latency bugs in non-atomic
contexts.

Cc: Steven Rostedt (VMware) <rostedt@goodmis.org>
Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
---
 kernel/trace/trace_osnoise.c | 2 +-
 kernel/trace/trace_probe.c   | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/trace/trace_osnoise.c b/kernel/trace/trace_osnoise.c
index 04f0fdae19a1..f68ca1e6460f 100644
--- a/kernel/trace/trace_osnoise.c
+++ b/kernel/trace/trace_osnoise.c
@@ -159,7 +159,7 @@ static void osnoise_unregister_instance(struct trace_array *tr)
 	if (!found)
 		return;
 
-	kvfree_rcu(inst);
+	kvfree_rcu_mightsleep(inst);
 }
 
 /*
diff --git a/kernel/trace/trace_probe.c b/kernel/trace/trace_probe.c
index 20d0c4a97633..2d2616678295 100644
--- a/kernel/trace/trace_probe.c
+++ b/kernel/trace/trace_probe.c
@@ -1172,7 +1172,7 @@ int trace_probe_remove_file(struct trace_probe *tp,
 		return -ENOENT;
 
 	list_del_rcu(&link->list);
-	kvfree_rcu(link);
+	kvfree_rcu_mightsleep(link);
 
 	if (list_empty(&tp->event->files))
 		trace_probe_clear_flag(tp, TP_FLAG_TRACE);
-- 
2.40.0.rc1.284.g88254d51c5-goog

