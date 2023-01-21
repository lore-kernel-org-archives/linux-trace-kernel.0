Return-Path: <linux-trace-kernel-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2932C54EAA
	for <linux-trace-kernel@archiver.kernel.org>; Sat, 21 Jan 2023 22:54:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229947AbjAUWx7 (ORCPT
        <rfc822;linux-trace-kernel@archiver.kernel.org>);
        Sat, 21 Jan 2023 17:53:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229938AbjAUWx6 (ORCPT
        <rfc822;linux-trace-kernel@vger.kernel.org>);
        Sat, 21 Jan 2023 17:53:58 -0500
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A4FF27985
        for <linux-trace-kernel@vger.kernel.org>; Sat, 21 Jan 2023 14:53:57 -0800 (PST)
Received: by mail-wr1-x434.google.com with SMTP id y1so3245624wru.2
        for <linux-trace-kernel@vger.kernel.org>; Sat, 21 Jan 2023 14:53:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=smile-fr.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aQcpnm+xegArshUikS17fvnxeK/s1SURloIYiePDHH8=;
        b=pxWOq0gY0m6If8+BESkb18dLeXB30J0Rrv4c9mWOpPfKCYIx5ofswf59f0awHMdgzN
         p510juAtaCTTUmVYdK097MMHRQGRVxcjqCb9XmBnh8noYE3l1AhCLzyeM3HBsG0bnmyS
         Vn8cNKMD/AbjC6bZRHHG52Wg+z9z3iaE8wU0XYx55ZNeD6PyRkXCh3sfgVd5izNE+d7n
         UWg2LOSZz//MAy2SmZuzxVAFKuQTSO96da+5Yf2O298InzP4c2vffGLhwAKmTRFWqseW
         m7xGq4l06HP4n5YNGCuwfw/B2m4Lte1S51fp6Ml+e2sy4aBwhIZt3OV1vPO3wy7qK/mz
         Z8ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aQcpnm+xegArshUikS17fvnxeK/s1SURloIYiePDHH8=;
        b=yVcc9CYX/fW42CbPUYJivb7CFptEhemML27IJ3b0qEr7s6dLVEZH8myCFLc9neBKXb
         sNKVn92pDK2rFFf5WnYi+LzWAxIflPkPvlIQMbEPselrJZeANehMThejVtFjaLLGUude
         w3NudH+G1XkZKMwHaCsvtQUOgCUfwfJeSnXlh/9OfcyzvsCtBIDIxryOWFJO1Gsoc/lW
         yEQu7eC/huLdciu3ZpCGKQNX9Gfu644GmaXC4ogEQ3ucrB5jGd+8Kd3z00qAcZarn/Et
         /eX9YenX7fZhkgzbu9u7pbP6f4x01Elcc4qwKBCa6YwYta04gWB4OuA9c0ZJEKhAfJe2
         yafA==
X-Gm-Message-State: AFqh2krfJtyPy/HVbhuxFCO+n/WipRcMivaMZ/hju568pZg59R0C6y5E
        B6V6G2qmx6AJoBk9kLKl677WvyC/SojCHy4m
X-Google-Smtp-Source: AMrXdXvPsVR0dVyVgDw3pg5O7qtGEll/ZdyXwLp1JvsEm1eetPg9wBiHRUJUvi22jMomHTDcSc9eDg==
X-Received: by 2002:adf:cd83:0:b0:2bd:d839:9918 with SMTP id q3-20020adfcd83000000b002bdd8399918mr17399387wrj.64.1674341635599;
        Sat, 21 Jan 2023 14:53:55 -0800 (PST)
Received: from P-ASN-ECS-830T8C3.mpl.intranet (89-159-1-53.rev.numericable.fr. [89.159.1.53])
        by smtp.gmail.com with ESMTPSA id q16-20020adff950000000b002bcaa47bf78sm29531001wrr.26.2023.01.21.14.53.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Jan 2023 14:53:55 -0800 (PST)
From:   Yoann Congal <yoann.congal@smile.fr>
To:     linux-trace-kernel@vger.kernel.org
Cc:     Yoann Congal <yoann.congal@smile.fr>,
        Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org
Subject: [PATCH v3 2/3] Documentation: kprobetrace: Fix code block markup
Date:   Sat, 21 Jan 2023 23:53:04 +0100
Message-Id: <20230121225304.1711635-3-yoann.congal@smile.fr>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230121225304.1711635-1-yoann.congal@smile.fr>
References: <20230121225304.1711635-1-yoann.congal@smile.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-trace-kernel.vger.kernel.org>
X-Mailing-List: linux-trace-kernel@vger.kernel.org

This display the following code extract as a code block instead of a
normal paragraph.

Signed-off-by: Yoann Congal <yoann.congal@smile.fr>
---
 Documentation/trace/kprobetrace.rst | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/trace/kprobetrace.rst b/Documentation/trace/kprobetrace.rst
index 5c49cdc8f8323..febfd3792854f 100644
--- a/Documentation/trace/kprobetrace.rst
+++ b/Documentation/trace/kprobetrace.rst
@@ -161,11 +161,11 @@ You can add and enable new kprobe events when booting up the kernel by
 "kprobe_event=" parameter. The parameter accepts a semicolon-delimited
 kprobe events, which format is similar to the kprobe_events.
 The difference is that the probe definition parameters are comma-delimited
-instead of space. For example, adding myprobe event on do_sys_open like below
+instead of space. For example, adding myprobe event on do_sys_open like below::
 
   p:myprobe do_sys_open dfd=%ax filename=%dx flags=%cx mode=+4($stack)
 
-should be below for kernel boot parameter (just replace spaces with comma)
+should be below for kernel boot parameter (just replace spaces with comma)::
 
   p:myprobe,do_sys_open,dfd=%ax,filename=%dx,flags=%cx,mode=+4($stack)
 
-- 
2.30.2

