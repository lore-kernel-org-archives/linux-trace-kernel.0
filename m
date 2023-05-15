Return-Path: <linux-trace-kernel-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E543C7EE25
	for <linux-trace-kernel@archiver.kernel.org>; Mon, 15 May 2023 18:32:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242642AbjEOScb (ORCPT
        <rfc822;linux-trace-kernel@archiver.kernel.org>);
        Mon, 15 May 2023 14:32:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243510AbjEOScR (ORCPT
        <rfc822;linux-trace-kernel@vger.kernel.org>);
        Mon, 15 May 2023 14:32:17 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46127189AF
        for <linux-trace-kernel@vger.kernel.org>; Mon, 15 May 2023 11:31:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1684175486;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=MOj6t1AMbPCvGUuEBcmtwWAQ86XL4E71akbkpHomH5I=;
        b=X0adX01D6iRZLbcVXwOl84J849hSrKE1ltG6cxZqirY643uf25CerOIOCqQE9P8P5Qz444
        YIuqUDt51WlnglnCYuqHE/WtpZK0PvE/UzEZtDsf13tX2FJSZWmRUnZ0xpQHRRPBDt1hCH
        1uuKrNkarHo/dRPWp5dPOeK0hUpBTQI=
Received: from mail-oa1-f69.google.com (mail-oa1-f69.google.com
 [209.85.160.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-670-yzfG_6VTP2OeSEyetGMuzQ-1; Mon, 15 May 2023 14:31:19 -0400
X-MC-Unique: yzfG_6VTP2OeSEyetGMuzQ-1
Received: by mail-oa1-f69.google.com with SMTP id 586e51a60fabf-18efc03cbcaso8557923fac.1
        for <linux-trace-kernel@vger.kernel.org>; Mon, 15 May 2023 11:31:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684175479; x=1686767479;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MOj6t1AMbPCvGUuEBcmtwWAQ86XL4E71akbkpHomH5I=;
        b=jXp2nAfWfWH3EK2Z0Xbls0L/n0hUCSF37cfMmyC/VdSbrIk9hXffzUF7P2bgVuURir
         dSsyUvUIjJwlBtIlbyL2cVeKeMqaopC3uv8IXG5vCNQe66J/YB1EugSmGOru5CER4BZZ
         b5Mk7UPBtrNIlfKscJBDhjwqC4PlUk5dqsVgYGMFhkDcLRC1gKn+oQH4bYx9uhFbVAlB
         RDu9vconzAox3anPA1rynGKXlaKoOVzjGqcMlOxzovFdAdVIjrV4EwDzwMcMIE5gTGqf
         Nvf5WOP/ejPUKi8aLlBEankRo2bjdiEaDMvHBvUMSBUQaXW2MR/m3bZJkusJ9VL7f0ZS
         zmrA==
X-Gm-Message-State: AC+VfDz/2uebstEbrA9B+hczIGU8ZiKxQHuen4n2DhyE5Hxu8uD41BP5
        t6tHa60Mjn1UDumxFg2y2TWoAr/pJSjplPuE154u1B14BrchP1ajtkm+yHnryEbNJyeMJvBW0kP
        aG504osIs8ydYD/KrrMZ615sbmoepXVdL
X-Received: by 2002:a05:6870:6255:b0:195:fe38:3b91 with SMTP id r21-20020a056870625500b00195fe383b91mr12443392oak.40.1684175479081;
        Mon, 15 May 2023 11:31:19 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ442pvdikS2ZMXzMgyzrVm2wRGicD8EmqCx96Wc9UrLDq3ZNgPqozxnFHfDNm2b2bXgWuUKqA==
X-Received: by 2002:a05:6870:6255:b0:195:fe38:3b91 with SMTP id r21-20020a056870625500b00195fe383b91mr12443378oak.40.1684175478802;
        Mon, 15 May 2023 11:31:18 -0700 (PDT)
Received: from localhost.localdomain ([2804:1b3:a803:46cc:5b68:5c23:dd7a:8cb3])
        by smtp.gmail.com with ESMTPSA id ea20-20020a056870071400b001964dc3dadesm6094075oab.45.2023.05.15.11.31.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 May 2023 11:31:18 -0700 (PDT)
From:   Leonardo Bras <leobras@redhat.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Nadav Amit <namit@vmware.com>,
        Chen Zhongjin <chenzhongjin@huawei.com>,
        Daniel Bristot de Oliveira <bristot@kernel.org>,
        Marcelo Tosatti <mtosatti@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Leonardo Bras <leobras@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Juergen Gross <jgross@suse.com>,
        Valentin Schneider <vschneid@redhat.com>,
        Yury Norov <yury.norov@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Subject: [RFC PATCH v4 0/2] trace,smp: Add tracepoints for csd
Date:   Mon, 15 May 2023 15:30:44 -0300
Message-Id: <20230515183045.654199-1-leobras@redhat.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"; x-default=true
Precedence: bulk
List-ID: <linux-trace-kernel.vger.kernel.org>
X-Mailing-List: linux-trace-kernel@vger.kernel.org

Changes since RFCv3:
- Split the patch in 2: entry/exit and queue
- Fix 'struct __call_single_data' & call_single_data_t alignment issue
- Made all TP_printk follow the same pattern

Changes since RFCv2:
- Fixed some spacing issues and trace calls

Changes since RFCv1:
- Implemented trace_csd_queue_cpu() as suggested by Valentin Schneider
- Using EVENT_CLASS in order to avoid duplication
- Introduced new helper: csd_do_func()
- Name change from smp_call_function_* to csd_function_*
- Rebased on top of torvalds/master

Leonardo Bras (2):
  trace,smp: Add tracepoints around remotelly called functions
  trace,smp: Add tracepoints for scheduling remotelly called functions

 include/trace/events/smp.h | 72 ++++++++++++++++++++++++++++++++++++++
 kernel/smp.c               | 41 +++++++++++++---------
 2 files changed, 96 insertions(+), 17 deletions(-)
 create mode 100644 include/trace/events/smp.h

-- 
2.40.1

