Return-Path: <linux-trace-kernel-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5880EC6FD1F
	for <linux-trace-kernel@archiver.kernel.org>; Thu, 16 Mar 2023 11:57:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230020AbjCPL5m (ORCPT
        <rfc822;linux-trace-kernel@archiver.kernel.org>);
        Thu, 16 Mar 2023 07:57:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229896AbjCPL5l (ORCPT
        <rfc822;linux-trace-kernel@vger.kernel.org>);
        Thu, 16 Mar 2023 07:57:41 -0400
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97482BCB9B
        for <linux-trace-kernel@vger.kernel.org>; Thu, 16 Mar 2023 04:57:39 -0700 (PDT)
Received: by mail-pg1-x52e.google.com with SMTP id x37so761079pga.1
        for <linux-trace-kernel@vger.kernel.org>; Thu, 16 Mar 2023 04:57:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678967859;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=rFMAEXsZgHzxGGY3mzN1fthO5aDSe+XlGsM+XeWX2NU=;
        b=biyMpws1BZKTLbO5m37bj2Tmu7VrNHcDfdSX9U9IcW1DmJjRLOcOv7LeqaW2akbokG
         JZTNAyS1LX2PHZIlvR5Gf1Zk0D7kLkJ3yD7ztkbvlK8odHJ8Qfc+CxuVmPp1TVZ/tbEL
         1NMnlaMyp01jCOQV3tHy89V9sB/QCm1kOOLg/FGORR9vaHHVkZmC6uZPKs8ROY/AbyD3
         x1sv4smogXe3JyNv7fkSpGuFlEikFs7b+VC8hvxvvpR6N0ZJBgG1vQ1IIBS6k4nVWx6L
         jxfRVOauoVpBN2AcaQf0DqtlX4aaq92ilymi873mufHSAV3S/+JSH3Ch0RuOEBGBlZ3z
         5tyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678967859;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rFMAEXsZgHzxGGY3mzN1fthO5aDSe+XlGsM+XeWX2NU=;
        b=Ml8a9bTLWde2GQ6CoCZgtbFSvp5yu/emSnAz9U3TZO7ewipkOFp6ddeFEU/VK1+jYQ
         eh3OMMLBTmvY1xsgflIhxsAkrEyJx1Kd+Fb/jSvR3QC5T0my7zhwBf1R+JKIL+7FMVsY
         MuLyonhFq4HJAN2MEyr+pqVaAWCVJGqKKw8BhEOaXdYGDS+TCEfuJDqgDjBqezC3Iill
         90utuiRAVpQAu92npMrTq/Jo05DwD/t9OF2fxYdZVXEkv99aZ6Imr1VMLZyO/RbRV8Pa
         FadkE5m80Kn0Ns38PwaIibUK1EApoBOallHWIr6dmvTZ0d8/gWYFGCvk7gP98UhqXpw+
         Hyrg==
X-Gm-Message-State: AO0yUKWWFFgTzphzHqIWfcxMFiGTb2pNS6yz22Afwl7uBBvN8WmpZuqi
        CASiK71j4VsGWbXQ/ERAF6A=
X-Google-Smtp-Source: AK7set+GPKFiDbwcvV/HtDgR0MbbyILUXi8vl6irr60G/cH2cm4rjKR298l11Zae93/Ld2RD/jIXVg==
X-Received: by 2002:a62:1953:0:b0:622:9e34:11f1 with SMTP id 80-20020a621953000000b006229e3411f1mr2996544pfz.17.1678967859106;
        Thu, 16 Mar 2023 04:57:39 -0700 (PDT)
Received: from localhost.localdomain ([114.206.94.139])
        by smtp.gmail.com with ESMTPSA id 36-20020a631264000000b004fbfefd5183sm4592033pgs.80.2023.03.16.04.57.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Mar 2023 04:57:38 -0700 (PDT)
From:   Gildong Hong <roaming2man@gmail.com>
To:     rostedt@goodmis.org, mhiramat@kernel.org, delyank@fb.com,
        peterz@infradead.org
Cc:     linux-trace-kernel@vger.kernel.org,
        Gildong Hong <roaming2man@gmail.com>
Subject: [PATCH] trace/events/sched: Remove unit on printing vruntime value
Date:   Thu, 16 Mar 2023 20:56:55 +0900
Message-Id: <20230316115655.66639-1-roaming2man@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-trace-kernel.vger.kernel.org>
X-Mailing-List: linux-trace-kernel@vger.kernel.org

vruntime is not actual time so remove unit on printing

Signed-off-by: Gildong Hong <roaming2man@gmail.com>
---
 include/trace/events/sched.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/trace/events/sched.h b/include/trace/events/sched.h
index fbb99a61f714..26ef85a8d3cd 100644
--- a/include/trace/events/sched.h
+++ b/include/trace/events/sched.h
@@ -511,7 +511,7 @@ DECLARE_EVENT_CLASS(sched_stat_runtime,
 		__entry->vruntime	= vruntime;
 	),
 
-	TP_printk("comm=%s pid=%d runtime=%Lu [ns] vruntime=%Lu [ns]",
+	TP_printk("comm=%s pid=%d runtime=%Lu [ns] vruntime=%Lu",
 			__entry->comm, __entry->pid,
 			(unsigned long long)__entry->runtime,
 			(unsigned long long)__entry->vruntime)
-- 
2.25.1

