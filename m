Return-Path: <linux-trace-kernel-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23414C001DE
	for <linux-trace-kernel@archiver.kernel.org>; Mon, 31 Jul 2023 14:11:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230096AbjGaOLj (ORCPT
        <rfc822;linux-trace-kernel@archiver.kernel.org>);
        Mon, 31 Jul 2023 10:11:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229744AbjGaOLh (ORCPT
        <rfc822;linux-trace-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 10:11:37 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 494C5B8
        for <linux-trace-kernel@vger.kernel.org>; Mon, 31 Jul 2023 07:11:36 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id ffacd0b85a97d-31771bb4869so4812560f8f.0
        for <linux-trace-kernel@vger.kernel.org>; Mon, 31 Jul 2023 07:11:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1690812695; x=1691417495;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rC2zK4NcUsZC4+qZKQca2Iea5mRr2pKcQlzwUOf0h4o=;
        b=uN2rKP6JXOza5oQxD0QvB77/Rt2ZeWgJkxwbUnFWoyZ1pl6Gth8Z0T712MBlkXPbl3
         jTt/BAVeqUzRgD9k6KvBuvKHafMJwFEtDODH7DzquAuNlGLuC6XVHx9qxmFyzIUtIooD
         8FabD1c5thv+OeagkQ/tGLfd/1ir9byp++uH8uuvCEIJ03+p80GDMQDULapZqoOAqKx/
         GqLkwBQ6Ysd8SCFTZFqyUCrdQDN20zTMZtcE6ERaippdpeXYGfEa0h9ILxh2BAbkWmjS
         CvB043qQyQ9tVk5pc6L4IYomRkAb9GmM0jpaO+OWLEHFD39zzccaGLlWZUkwfloMvro9
         R4bA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690812695; x=1691417495;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rC2zK4NcUsZC4+qZKQca2Iea5mRr2pKcQlzwUOf0h4o=;
        b=CFfz6sGcShjky2/U5GMLr23IZaJL5aj1cMkYWIzqZgAr3nbILeM3kiQOJWeqfoeXX/
         ptbDItaFZG+k3XIKzSCjt8Srb6M5w7P0zOYwE2TilB4nuyZJd680DEulAbVgakxwpSy5
         /qGxRsmMfhADwxJ4Q+B9fpRQSKSlTohjTOMMBRhPuN3JHx2XvwCaHQkGbvCrytIm5ORu
         S+zt3J7wWRDr9mx1TAgjKL/xlDxZ6L0lA95T+Sxv08hBgM21Y8tLXyUDSIt5otuzBZBy
         CpB7y4kB+7ZrtDHKwXyAbe5juPzQZzZbZvAH4tRrd+goxMrTrI/m+a9sVrfoPMcXdso7
         uw4Q==
X-Gm-Message-State: ABy/qLbTSHH2tN0Z5DhAczL1zrd5AwqgqlmBjLzep1vgWX/z4I9A55jq
        wEap85JzNsv5qxfSODxW3kiYTg==
X-Google-Smtp-Source: APBJJlGZd2QHUxkOChrPjXKCouJujAEsUhQ877e1v/ljOHUUWRAcsfif8AbU6BxLTvCFUH0zMpF3Sg==
X-Received: by 2002:adf:e70d:0:b0:317:6704:72c with SMTP id c13-20020adfe70d000000b003176704072cmr6444080wrm.52.1690812694710;
        Mon, 31 Jul 2023 07:11:34 -0700 (PDT)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id d4-20020adfe884000000b003144b95e1ecsm13287752wrm.93.2023.07.31.07.11.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Jul 2023 07:11:34 -0700 (PDT)
Date:   Mon, 31 Jul 2023 17:11:31 +0300
From:   Dan Carpenter <dan.carpenter@linaro.org>
To:     Daniel Bristot de Oliveira <bristot@kernel.org>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Andreas Schwab <schwab@suse.de>,
        linux-trace-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: [PATCH] rtla: Uninitialized variable in find_mount()
Message-ID: <53066ac3-523a-4db9-a636-9c99ef56c7c1@moroto.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding
Precedence: bulk
List-ID: <linux-trace-kernel.vger.kernel.org>
X-Mailing-List: linux-trace-kernel@vger.kernel.org

The "found" variable needs to be set to 0/false at the start.

Fixes: a957cbc02531 ("rtla: Add -C cgroup support")
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
 tools/tracing/rtla/src/utils.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/tracing/rtla/src/utils.c b/tools/tracing/rtla/src/utils.c
index 623a38908ed5..c769d7b3842c 100644
--- a/tools/tracing/rtla/src/utils.c
+++ b/tools/tracing/rtla/src/utils.c
@@ -538,7 +538,7 @@ static const int find_mount(const char *fs, char *mp, int sizeof_mp)
 {
 	char mount_point[MAX_PATH];
 	char type[100];
-	int found;
+	int found = 0;
 	FILE *fp;
 
 	fp = fopen("/proc/mounts", "r");
-- 
2.39.2

