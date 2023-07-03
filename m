Return-Path: <linux-trace-kernel-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E458C3063F
	for <linux-trace-kernel@archiver.kernel.org>; Mon,  3 Jul 2023 17:22:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231233AbjGCRWn (ORCPT
        <rfc822;linux-trace-kernel@archiver.kernel.org>);
        Mon, 3 Jul 2023 13:22:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231234AbjGCRWl (ORCPT
        <rfc822;linux-trace-kernel@vger.kernel.org>);
        Mon, 3 Jul 2023 13:22:41 -0400
Received: from mail-io1-xd30.google.com (mail-io1-xd30.google.com [IPv6:2607:f8b0:4864:20::d30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6268E6A;
        Mon,  3 Jul 2023 10:22:38 -0700 (PDT)
Received: by mail-io1-xd30.google.com with SMTP id ca18e2360f4ac-78374596182so241887939f.0;
        Mon, 03 Jul 2023 10:22:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688404958; x=1690996958;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=71P5sk6d5rd4mVTjd7s26EdFOUH8GbUugHD/ZQkvLi0=;
        b=YI1nDEuWvfhVDStC4WVyszos+58EhLGNLUmsGPCQFHa2V8DTVXwRdvhfMLy2Mc02Wf
         e3TMrMknQmDHAzsu87TcBRENLOfM/bMvo2YXZ+RusWZEqS2SLBcDVc2vGwL37Oz7bZCd
         XPXm2z4U7LI4DIzp2zeqMpk6/JqtYt6nrs8qot4xVfEAeqtpD8OW9DI00/bsa9yFO3cj
         w3gq5ulo4Wf/2T3Jdf/iOQZJ2ebyo5gZRq0lHdRd7Zy6rZJ1ftmxEYNwScDP2hOMLqJ8
         xSTCsV0sQTaU5U53r1iDtOJMnUGpCpwpbGPfEmCGcARskEWb22DO/vQTkdtMhyVYXt36
         eM3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688404958; x=1690996958;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=71P5sk6d5rd4mVTjd7s26EdFOUH8GbUugHD/ZQkvLi0=;
        b=K+imddWv1ZkXWoh/xZv9FsqRQk/ICoA86cazU4DHOLTtA8fjJzoOl8oI8enc0hwoQo
         eDvRDZlxnv2RoQebvjg5BiYH+nTeSs29eBJD920kewp/Vj6vsu+HRCDYBdmw+VglqRee
         W48qYQWFxM2pyNg0HucS58ayYOcK9LnO8JMd0gA4qcRofajKkVtR6aB7NtY+Yd413bUF
         VD9+8zIpsp599cRSXHHqnA6kQCcDBnLSuASGfwAE+I4E848C3lwZ8zL9pU2dLiXV7c0u
         ssDd6WvcEUObNioV2V2cUyr9myUY7HjxBmAPzDonTtyIzRyDzep7MEQ3lWi/XRRAyHZv
         LjdA==
X-Gm-Message-State: AC+VfDzX9OPcrSgUcEcYkdmzxYaO+R74ZZBF7uRnV2wUtdXiqJV79nva
        MeAI4Fp1+xY/0uWQ49pSjeg=
X-Google-Smtp-Source: ACHHUZ4jWiHR2lJJipGu/ya+3GxsrbatXsRP6Eu3U1KI0KYzliau59NFXhM430ZMPO+2zRck/9ciyA==
X-Received: by 2002:a5e:aa0a:0:b0:785:cfa1:fcac with SMTP id s10-20020a5eaa0a000000b00785cfa1fcacmr11078471ioe.20.1688404957946;
        Mon, 03 Jul 2023 10:22:37 -0700 (PDT)
Received: from azeems-kspp.c.googlers.com.com (54.70.188.35.bc.googleusercontent.com. [35.188.70.54])
        by smtp.gmail.com with ESMTPSA id ed22-20020a056638291600b0042b3e2e5ca1sm1033860jab.122.2023.07.03.10.22.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Jul 2023 10:22:37 -0700 (PDT)
From:   Azeem Shaikh <azeemshaikh38@gmail.com>
To:     Kees Cook <keescook@chromium.org>, Jens Axboe <axboe@kernel.dk>
Cc:     linux-hardening@vger.kernel.org,
        Azeem Shaikh <azeemshaikh38@gmail.com>,
        linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
        Steven Rostedt <rostedt@goodmis.org>
Subject: [PATCH 1/2] kyber: Replace strlcpy with strscpy
Date:   Mon,  3 Jul 2023 17:21:58 +0000
Message-ID: <20230703172159.3668349-2-azeemshaikh38@gmail.com>
X-Mailer: git-send-email 2.41.0.255.g8b1d071c50-goog
In-Reply-To: <20230703172159.3668349-1-azeemshaikh38@gmail.com>
References: <20230703172159.3668349-1-azeemshaikh38@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-trace-kernel.vger.kernel.org>
X-Mailing-List: linux-trace-kernel@vger.kernel.org

strlcpy() reads the entire source buffer first.
This read may exceed the destination size limit.
This is both inefficient and can lead to linear read
overflows if a source string is not NUL-terminated [1].
In an effort to remove strlcpy() completely [2], replace
strlcpy() here with strscpy().
No return values were used, so direct replacement is safe.

[1] https://www.kernel.org/doc/html/latest/process/deprecated.html#strlcpy
[2] https://github.com/KSPP/linux/issues/89

Signed-off-by: Azeem Shaikh <azeemshaikh38@gmail.com>
---
 include/trace/events/kyber.h | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/include/trace/events/kyber.h b/include/trace/events/kyber.h
index bf7533f171ff..9d44781efc1c 100644
--- a/include/trace/events/kyber.h
+++ b/include/trace/events/kyber.h
@@ -31,8 +31,8 @@ TRACE_EVENT(kyber_latency,
 
 	TP_fast_assign(
 		__entry->dev		= dev;
-		strlcpy(__entry->domain, domain, sizeof(__entry->domain));
-		strlcpy(__entry->type, type, sizeof(__entry->type));
+		strscpy(__entry->domain, domain, sizeof(__entry->domain));
+		strscpy(__entry->type, type, sizeof(__entry->type));
 		__entry->percentile	= percentile;
 		__entry->numerator	= numerator;
 		__entry->denominator	= denominator;
@@ -59,7 +59,7 @@ TRACE_EVENT(kyber_adjust,
 
 	TP_fast_assign(
 		__entry->dev		= dev;
-		strlcpy(__entry->domain, domain, sizeof(__entry->domain));
+		strscpy(__entry->domain, domain, sizeof(__entry->domain));
 		__entry->depth		= depth;
 	),
 
@@ -81,7 +81,7 @@ TRACE_EVENT(kyber_throttled,
 
 	TP_fast_assign(
 		__entry->dev		= dev;
-		strlcpy(__entry->domain, domain, sizeof(__entry->domain));
+		strscpy(__entry->domain, domain, sizeof(__entry->domain));
 	),
 
 	TP_printk("%d,%d %s", MAJOR(__entry->dev), MINOR(__entry->dev),
-- 
2.41.0.255.g8b1d071c50-goog

