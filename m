Return-Path: <linux-trace-kernel-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF39CC76196
	for <linux-trace-kernel@archiver.kernel.org>; Sat, 25 Mar 2023 17:34:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231817AbjCYReG (ORCPT
        <rfc822;linux-trace-kernel@archiver.kernel.org>);
        Sat, 25 Mar 2023 13:34:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231740AbjCYReF (ORCPT
        <rfc822;linux-trace-kernel@vger.kernel.org>);
        Sat, 25 Mar 2023 13:34:05 -0400
Received: from mail-qv1-xf29.google.com (mail-qv1-xf29.google.com [IPv6:2607:f8b0:4864:20::f29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45B8C93E4
        for <linux-trace-kernel@vger.kernel.org>; Sat, 25 Mar 2023 10:33:58 -0700 (PDT)
Received: by mail-qv1-xf29.google.com with SMTP id oe8so3783703qvb.6
        for <linux-trace-kernel@vger.kernel.org>; Sat, 25 Mar 2023 10:33:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google; t=1679765637;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UZ68ufo3dlSNYy/wHT1VSjdWSVn/9QVi14RF92IRYWI=;
        b=rewB8GWRioBBXQ0+OtU3LnwuoNElryIFbsJ7aKxQ3weFJvUOxiEB/P7UxUewPyMZSL
         0r1HOCc3xjU0O2QHqnA+X150fPaSTJMKWlTF94ORW6ja26gZ/PHxJeG7i9BdXKBpJKvN
         b0lzksxsctNEHyjKRiwt0rOdpfybqKxHJnJAk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679765637;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UZ68ufo3dlSNYy/wHT1VSjdWSVn/9QVi14RF92IRYWI=;
        b=1dEyAwnpQ0rNsa+kSBPby9kYqHywqKfLEroq23Gm1oMY6USyK5UeKNLfphB4tV/R7i
         SPGgv0qAa3GSqW65aoKPP0vcRLtjmAFIQVmOiXDpqMaT0pAQ4qUjYLMcs9ZoE+BsNA1V
         hJiFNjT+FtDBa39jkqxxIEThpvipF0JuYpN+1F+/X3uHfP6im/23cD9V0ZLHZE0zzb+G
         j2hvYRchOeF3knz0qxh//A71C4Zc4gFyVal05MimqwIqKNGZ4R2Yn6dZGwtteEJzgagn
         g6YWGV6QLqHORBEb8E14lDq1xRYpDTMTm2vb7YY/vRN14FnUNY92hBigaiq05p2rCdSX
         W09g==
X-Gm-Message-State: AAQBX9ceLEUCVKFfF/30ETdwTNX7jWxAZ5SwGXQ3E3rP8I5ietpKlh/y
        z/+bhOgD4mIJKDV5BUDjjngNlg==
X-Google-Smtp-Source: AKy350aTrLiI8kfNmZT8CKQUIMZMtL6HaP1ctOnIYeWyXkMh+nzfrI2SF5jO9G2RsYkp9onL7ngpPw==
X-Received: by 2002:a05:6214:2604:b0:5ab:e259:b2a9 with SMTP id gu4-20020a056214260400b005abe259b2a9mr13217724qvb.14.1679765637340;
        Sat, 25 Mar 2023 10:33:57 -0700 (PDT)
Received: from joelboxx.c.googlers.com.com (129.239.188.35.bc.googleusercontent.com. [35.188.239.129])
        by smtp.gmail.com with ESMTPSA id m4-20020ac84444000000b003e37ee54b5dsm6762764qtn.90.2023.03.25.10.33.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Mar 2023 10:33:56 -0700 (PDT)
From:   "Joel Fernandes (Google)" <joel@joelfernandes.org>
To:     linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Xu Panda <xu.panda@zte.com.cn>, Yang Yang <yang.yang29@zte.com.cn>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        linux-trace-kernel@vger.kernel.org
Subject: [PATCH v2 05/13] rcu/trace: use strscpy() to instead of strncpy()
Date:   Sat, 25 Mar 2023 17:33:08 +0000
Message-Id: <20230325173316.3118674-6-joel@joelfernandes.org>
X-Mailer: git-send-email 2.40.0.348.gf938b09366-goog
In-Reply-To: <20230325173316.3118674-1-joel@joelfernandes.org>
References: <20230325173316.3118674-1-joel@joelfernandes.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-trace-kernel.vger.kernel.org>
X-Mailing-List: linux-trace-kernel@vger.kernel.org

From: Xu Panda <xu.panda@zte.com.cn>

This commit saves a line of code by switching from strncpy() to strscpy()
by permitting the later NUL assignment to be removed.  While in the area,
save another line by taking advantage of 100 characters.

Signed-off-by: Xu Panda <xu.panda@zte.com.cn>
Signed-off-by: Yang Yang <yang.yang29@zte.com.cn>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
---
 include/trace/events/rcu.h | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/include/trace/events/rcu.h b/include/trace/events/rcu.h
index 90b2fb0292cb..c19ac1fa8a60 100644
--- a/include/trace/events/rcu.h
+++ b/include/trace/events/rcu.h
@@ -776,9 +776,7 @@ TRACE_EVENT_RCU(rcu_torture_read,
 	),
 
 	TP_fast_assign(
-		strncpy(__entry->rcutorturename, rcutorturename,
-			RCUTORTURENAME_LEN);
-		__entry->rcutorturename[RCUTORTURENAME_LEN - 1] = 0;
+		strscpy(__entry->rcutorturename, rcutorturename, RCUTORTURENAME_LEN);
 		__entry->rhp = rhp;
 		__entry->secs = secs;
 		__entry->c_old = c_old;
-- 
2.40.0.348.gf938b09366-goog

