Return-Path: <linux-trace-kernel-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48FB2C38142
	for <linux-trace-kernel@archiver.kernel.org>; Sat, 21 Jan 2023 14:23:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229493AbjAUOX0 (ORCPT
        <rfc822;linux-trace-kernel@archiver.kernel.org>);
        Sat, 21 Jan 2023 09:23:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229756AbjAUOXZ (ORCPT
        <rfc822;linux-trace-kernel@vger.kernel.org>);
        Sat, 21 Jan 2023 09:23:25 -0500
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72DDC303DE
        for <linux-trace-kernel@vger.kernel.org>; Sat, 21 Jan 2023 06:23:19 -0800 (PST)
Received: by mail-wm1-x333.google.com with SMTP id c10-20020a05600c0a4a00b003db0636ff84so5592180wmq.0
        for <linux-trace-kernel@vger.kernel.org>; Sat, 21 Jan 2023 06:23:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=smile-fr.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=0IbE0dMBKZffB7ab8rBuBnzdcQMX7/mvB3hes7Ga9po=;
        b=pI17k/hAAhd83va63585rxYCPll4vFhHmdcQ14wH2Nr4A6Mgq3QTUyBW9vYjv603f9
         zkGOrOZ93yf82FTosE2IvqfVZFyaCqiRoryKniUeXTgIJZzELUAAlKgoFD14QOsWBLEb
         sbaaxruiIsz0YGbDLLYNRHCLnfNk0jR0A8XIEOVq7Oe/BLj4Zjc1j9yB3G64z2nyJLmH
         smXHugHhWLThzVK24N9X3Rt7vGVwi0IupzcyvIGELRNK0yE6HSo84OZpEpeI0/KTCVL9
         AZw3q2G0MQhzus4mt70DG3ojDfY2e553LyBx/v8zAiG3tbuk9eAWmpCxLTyXHiNRBZE5
         NJ0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0IbE0dMBKZffB7ab8rBuBnzdcQMX7/mvB3hes7Ga9po=;
        b=m+wOjRXpFOdu1Had3Y83OvslG9LxnRxykr53VKpbVNLZVtWlm6bF4BGFUqwlE1XfDm
         s2KJP2A+IESsth9JLU6qZyaqX7rZBYnmnBKFaIYIC2MfPVS9n6ElWxf6NSboutYNeYgX
         i0aTWeS0MYrdUKzakfB7mFh8qLtcz11EkyYi7wkL8rJXRxzZ4gKUfQ7Y2NCkRPjNM1Ft
         gcidvQV9XukcIgZ1tSPEyBNto1kZ7CIWrrMxhF8AcKgj9wK3SfpVpFVnEnJfOWe5wxE0
         NprAq4/4a0hwf6pl56jarX8XrA74SabTS5rQG8squdpotXnm62yhZhWd3OJ4LoKjmtPZ
         t5Ww==
X-Gm-Message-State: AFqh2kqBlJDVfE0fJayVqvz8zFnF7uBSE7hbajJzHxCAd/wI4pIvFGkr
        Pr9KcrIH5l00JtsDbWR+8fAuGdlYFpUIFc0V
X-Google-Smtp-Source: AMrXdXsTDPZYnPLTM5/fnX3dQehzX2OGWZ2r1XZjd56nmeJH1uJrFkERXgfzWzdcSpZ7hgia5LTFtw==
X-Received: by 2002:a05:600c:1c23:b0:3db:b9f:f2e with SMTP id j35-20020a05600c1c2300b003db0b9f0f2emr16143654wms.14.1674310997707;
        Sat, 21 Jan 2023 06:23:17 -0800 (PST)
Received: from P-ASN-ECS-830T8C3.mpl.intranet (89-159-1-53.rev.numericable.fr. [89.159.1.53])
        by smtp.gmail.com with ESMTPSA id fm17-20020a05600c0c1100b003db06224953sm6360122wmb.41.2023.01.21.06.23.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Jan 2023 06:23:17 -0800 (PST)
From:   Yoann Congal <yoann.congal@smile.fr>
To:     linux-trace-kernel@vger.kernel.org
Cc:     Yoann Congal <yoann.congal@smile.fr>,
        Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org
Subject: [PATCH v2 0/3] Documentation: kprobetrace: Improve readability
Date:   Sat, 21 Jan 2023 15:22:40 +0100
Message-Id: <20230121142242.1706081-1-yoann.congal@smile.fr>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-trace-kernel.vger.kernel.org>
X-Mailing-List: linux-trace-kernel@vger.kernel.org

Hi,

This is the v2 of a "markup heavy" patch that was nacked because of it.
v1 was 1 patch but this v2 this split hence this coverletter.

v1: https://lore.kernel.org/linux-doc/20220915153358.813993-1-yoann.congal@smile.fr/

Changelog v1 -> v2 :
* Removed all ``markup`` additions
* Split commits

Regards,

Yoann Congal (3):
  Documentation: kprobetrace: Fix some typos
  Documentation: kprobetrace: Fix code block markup
  Documentation: kprobetrace: Split paragraphs

 Documentation/trace/kprobetrace.rst | 23 +++++++++++++----------
 1 file changed, 13 insertions(+), 10 deletions(-)

-- 
2.30.2

