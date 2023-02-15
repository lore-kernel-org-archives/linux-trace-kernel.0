Return-Path: <linux-trace-kernel-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8B15C636D6
	for <linux-trace-kernel@archiver.kernel.org>; Wed, 15 Feb 2023 22:34:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229828AbjBOWeP (ORCPT
        <rfc822;linux-trace-kernel@archiver.kernel.org>);
        Wed, 15 Feb 2023 17:34:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229852AbjBOWeD (ORCPT
        <rfc822;linux-trace-kernel@vger.kernel.org>);
        Wed, 15 Feb 2023 17:34:03 -0500
Received: from mail-io1-xd29.google.com (mail-io1-xd29.google.com [IPv6:2607:f8b0:4864:20::d29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FEFD3BD96
        for <linux-trace-kernel@vger.kernel.org>; Wed, 15 Feb 2023 14:34:02 -0800 (PST)
Received: by mail-io1-xd29.google.com with SMTP id w3so11905iox.6
        for <linux-trace-kernel@vger.kernel.org>; Wed, 15 Feb 2023 14:34:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9UkAnigxc8vfiP/xy4xUkyYLWp1v2oMPjYmrZI7ozKg=;
        b=fNhSR/DpdhPdDoI56A3EhCdY7JWbS58+aiEICYVlA7gl+AWkUTNbIG/atjNRcl+sje
         lyIqK6JaonmY3oxhEbmQPSEmpM0sQJdCA79+tz5MYxEs4BBI4xZSHObsXn9o/f+ekcvK
         +jiV7lGBfGkDEmPwMzlaSo6sNkVwuy9caydNo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9UkAnigxc8vfiP/xy4xUkyYLWp1v2oMPjYmrZI7ozKg=;
        b=ggEzrPQV/bASUol3SVEPl0G9nYUipT0LFeGIqfIAQrDIQuvcHFzpOaa4jEi42xzdLB
         ldYrr+Zp6ebVmwEG4bj79Hq645DfGIcshSCbG4UBS7Ubugp/zgFsadiAxjHlNQd1b0Ke
         OVrkYb53I7fE4CPsomtTDwcM/RqgWjXT0QA8NeAvEfpO3oRAU83SVRj+6a7Q5iQALZNA
         mwxYk3bIktf8nfi5Rk/L5qYr62hoZcgRP9Z4Nu1MDTkwLQh4FL3/wOpusU1FM5mPTHCy
         2Yzt/y2D75zhrqYpzHojyF/J6RAl0boyPuYzk/buZNMCHE4BXKZYduo/D/huAzjlyJYW
         paIw==
X-Gm-Message-State: AO0yUKW8BSeGW7wi6Pj22HTXVKvcVvfiUx3Dsrl6C3q4nqhwXSUoFE/r
        k9iUmNBuGaEDrwBWE+ukIcZT89CiLZFNd4xb
X-Google-Smtp-Source: AK7set/e91kNoaIzB6xxvRfuTyHdyHPXybCM8qCEGiQAIuXpdlJLh2rV23A7rHMn8ApT6OzRpPB0MQ==
X-Received: by 2002:a5d:890d:0:b0:71c:cf2e:92ec with SMTP id b13-20020a5d890d000000b0071ccf2e92ecmr3047559ion.0.1676500441795;
        Wed, 15 Feb 2023 14:34:01 -0800 (PST)
Received: from ravnica.bld.corp.google.com ([2620:15c:183:200:6299:179b:a6e4:be59])
        by smtp.gmail.com with ESMTPSA id b15-20020a92c14f000000b003141eddd283sm1131489ilh.22.2023.02.15.14.34.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Feb 2023 14:34:01 -0800 (PST)
From:   Ross Zwisler <zwisler@chromium.org>
X-Google-Original-From: Ross Zwisler <zwisler@google.com>
To:     linux-kernel@vger.kernel.org
Cc:     Ross Zwisler <zwisler@google.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        virtualization@lists.linux-foundation.org,
        linux-trace-kernel@vger.kernel.org,
        Steven Rostedt <rostedt@goodmis.org>
Subject: [PATCH v2 6/6] tools/virtio: fix typo in README instructions
Date:   Wed, 15 Feb 2023 15:33:50 -0700
Message-Id: <20230215223350.2658616-7-zwisler@google.com>
X-Mailer: git-send-email 2.39.1.637.g21b0678d19-goog
In-Reply-To: <20230215223350.2658616-1-zwisler@google.com>
References: <20230215223350.2658616-1-zwisler@google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-trace-kernel.vger.kernel.org>
X-Mailing-List: linux-trace-kernel@vger.kernel.org

We need to have a unique chardev for each data path, else the chardevs
will collide and qemu will die with this message:

  qemu-system-x86_64: -device
  virtserialport,bus=virtio-serial0.0,nr=2,chardev=charchannel0,
  id=channel1,name=trace-path-cpu0:
  Property 'virtserialport.chardev' can't take value 'charchannel0':
  Device 'charchannel0' is in use

Signed-off-by: Ross Zwisler <zwisler@google.com>
---
 tools/virtio/virtio-trace/README | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/virtio/virtio-trace/README b/tools/virtio/virtio-trace/README
index cea29a2a4c0a..0127ff0c54b0 100644
--- a/tools/virtio/virtio-trace/README
+++ b/tools/virtio/virtio-trace/README
@@ -61,7 +61,7 @@ and
       id=channel0,name=agent-ctl-path\
  ##data path##
      -chardev pipe,id=charchannel1,path=/tmp/virtio-trace/trace-path-cpu0\
-     -device virtserialport,bus=virtio-serial0.0,nr=2,chardev=charchannel0,\
+     -device virtserialport,bus=virtio-serial0.0,nr=2,chardev=charchannel1,\
       id=channel1,name=trace-path-cpu0\
       ...
 
-- 
2.39.1.637.g21b0678d19-goog

