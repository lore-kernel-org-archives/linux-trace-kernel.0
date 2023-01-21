Return-Path: <linux-trace-kernel-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C3F7C38142
	for <linux-trace-kernel@archiver.kernel.org>; Sat, 21 Jan 2023 14:31:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229811AbjAUObc (ORCPT
        <rfc822;linux-trace-kernel@archiver.kernel.org>);
        Sat, 21 Jan 2023 09:31:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229789AbjAUObb (ORCPT
        <rfc822;linux-trace-kernel@vger.kernel.org>);
        Sat, 21 Jan 2023 09:31:31 -0500
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D4B221A07
        for <linux-trace-kernel@vger.kernel.org>; Sat, 21 Jan 2023 06:31:30 -0800 (PST)
Received: by mail-wr1-x430.google.com with SMTP id b7so7160735wrt.3
        for <linux-trace-kernel@vger.kernel.org>; Sat, 21 Jan 2023 06:31:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=smile-fr.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=W4TB1OEgjESNCwtQLX1L+eIOlyALE7x8aUBSmkMLwac=;
        b=2eY68x7jfYFUzdy4vGD+8Y6PmY5UJflCLKXoT6ybao1O1apQT0IcBuYar3gB02kPkT
         P+zPF9T/czfvdctu8iQy8CTtZ2XmSOJtxmEeiMLqX/PXNQGl8mXIvv0RPgabW8CB/5QH
         sDGmLd7Xsv0RvCrXlb9IQXBscSEvZ63q6ffN8erVu+MsbDKBzWyW2OIP6wxuXZ1CUQZl
         skyCvsGy+4u03Q6EN2LYdyRkQyPTvXuUWSmh1LI/0Mh4NZWC9NA9AQNoiFMiQgkOVYCg
         UpoJ1wpdyXiUlSkkzZSWsgEernRwVfumcQWDnkP5RcPeb4kXvuTK7LOnzsEUY6G8JbU1
         NofA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=W4TB1OEgjESNCwtQLX1L+eIOlyALE7x8aUBSmkMLwac=;
        b=Qh2iUCKsuRSoVHXw2Gm6QzbBOLLbek/kmqNmh69wz5L2H9mx5cuSO44AZSuX/OgfrR
         wD+HE7g6V+cWbP3x3s6EKjEph7gtOD+sctYrYTEaV17nyODnp3oifyyN3Q5l2gZqfrTu
         stjt2fq6ISiCzy39BKnbAwfWrAVfwIY8NzhpR5PBJnOE2T8X6xc3Kw5jO76xY3k71XF9
         V14x/x/bCTAoHp/LUGTl3yNWFu/0VA+cymSVljehbqSDH+f6hS7y3R3VZhfmRVq4NeC4
         mKh4uIDDUFDpHLE0djq99GgJJHyk+fji7aDL4hYywqB52S2w26FMN62afyJ7ItRZ9olP
         3nGg==
X-Gm-Message-State: AFqh2kqdK+DDV7gq0vPUIRx2r7YPZ154+mROQ95l80J4Ipr3teE6wfQ+
        NH+DJiSi9LnFF9lgDW9Lf8/VGxJPbPxyxuW5
X-Google-Smtp-Source: AMrXdXtV5msUaxX9SPw2Y4HgCWpGdruUkoVCJRTY/xXEfWaYOOBSahlX/3E3iY5CfgT3+xjTee7YWA==
X-Received: by 2002:a5d:4572:0:b0:2ba:bd95:e38e with SMTP id a18-20020a5d4572000000b002babd95e38emr15454843wrc.41.1674311490009;
        Sat, 21 Jan 2023 06:31:30 -0800 (PST)
Received: from P-ASN-ECS-830T8C3.mpl.intranet (89-159-1-53.rev.numericable.fr. [89.159.1.53])
        by smtp.gmail.com with ESMTPSA id p8-20020a5d4588000000b002bdfb97e029sm16314604wrq.19.2023.01.21.06.31.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Jan 2023 06:31:29 -0800 (PST)
From:   Yoann Congal <yoann.congal@smile.fr>
To:     linux-trace-kernel@vger.kernel.org
Cc:     Yoann Congal <yoann.congal@smile.fr>,
        Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org
Subject: [PATCH v2 2/3] Documentation: kprobetrace: Fix code block markup
Date:   Sat, 21 Jan 2023 15:31:09 +0100
Message-Id: <20230121143110.1706962-2-yoann.congal@smile.fr>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230121142242.1706081-1-yoann.congal@smile.fr>
References: <20230121143110.1706962-1-yoann.congal@smile.fr>
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
index 1eb2c68aa0a71..ad18c2fdbd153 100644
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

