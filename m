Return-Path: <linux-trace-kernel-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C639CA0FE2
	for <linux-trace-kernel@archiver.kernel.org>; Tue,  5 Sep 2023 16:19:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244372AbjIEQTN (ORCPT
        <rfc822;linux-trace-kernel@archiver.kernel.org>);
        Tue, 5 Sep 2023 12:19:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245172AbjIEBxc (ORCPT
        <rfc822;linux-trace-kernel@vger.kernel.org>);
        Mon, 4 Sep 2023 21:53:32 -0400
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9277CC6
        for <linux-trace-kernel@vger.kernel.org>; Mon,  4 Sep 2023 18:53:06 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id d2e1a72fcca58-68c0cb00fb3so1641609b3a.2
        for <linux-trace-kernel@vger.kernel.org>; Mon, 04 Sep 2023 18:53:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1693878786; x=1694483586; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=et7SVZmA/lkLwp7uaeKPmxJeL3RQa87Ve6JoBbZWATw=;
        b=HaADGH+/Axclgv9vuJP4UqZvz6+nh2Y8hV1tmkTHuz+BXvO8XUh+bFZV1IKIfkqvEP
         fhCmISznxDhV7sXe+qmvaSvHkEZUe0THq4tUWhZ14In/KIUBMLCUQ9kYoHiokcWxUs8Q
         o/WeUsEkiTT3unBsHXyDX5kiLC8d5to251MW2O3BW78gQYswXAYXARixgcfmR9U3mKR2
         95eq2gUEWLm583mpsJtcmvbJx4tzXbUgVVUg8we31Br6LtDsBymEtEFmed0feVKTsxji
         d8KlDmZbh1+JhZCJ1I0l5mWm/FoY7Auv1UR0pOnDH3klFMj7NXwuaXVRbagtE1P4zRLO
         AroA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693878786; x=1694483586;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=et7SVZmA/lkLwp7uaeKPmxJeL3RQa87Ve6JoBbZWATw=;
        b=GnARvqoN+GEK9Ro7JfDCzfsYEUH4C0WCEsUVOyJtz87MuAxuokT2F3ItGNlua1ni7S
         tccyyadKKHwR07XkDoaoSPZzVXcWpfW4eFj2tH5jag9LIVdOq70MSePG3K4qKWowCGw4
         V+aFWa3ZIivV6iBkOuSKoC4J9AiQCLFQltIJt4czbxeyymgY0gbVahA2NKm9AKPN7dtx
         VEMoryNeGaq2mVC5to/1e/bHvgn8BcPFIsif+Me38CYgkMOb3rNlUlVzZwCuOB65vm9Q
         mcSBtVlYdmZB5tk8KaVu1nQQULv0is3S+X6Z/hLJdS3SOA/Ia1It+EIVdpx6Lpg28hXd
         eYRA==
X-Gm-Message-State: AOJu0YzfJPLj+x6bGZR4w69eNLCRbT4BXz4lPc3T5HBEA6FEbnfvx82U
        iGq90Zs8lLoUeu6JWiJfCsSyT6VdSkqv1LtRiE0=
X-Google-Smtp-Source: AGHT+IFzzd5Pf43c6tFiGVQEQmRfu/Fd/DBJi/+PqODcfb+FYiZ25XQC9nwA1rXeNOWLfAscB5nD0w==
X-Received: by 2002:a05:6a00:985:b0:68b:e29c:b5d with SMTP id u5-20020a056a00098500b0068be29c0b5dmr15855959pfg.33.1693878786121;
        Mon, 04 Sep 2023 18:53:06 -0700 (PDT)
Received: from devz1.bytedance.net ([203.208.167.146])
        by smtp.gmail.com with ESMTPSA id y5-20020aa78045000000b0064d74808738sm7910483pfm.214.2023.09.04.18.53.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Sep 2023 18:53:05 -0700 (PDT)
From:   "wuqiang.matt" <wuqiang.matt@bytedance.com>
To:     linux-trace-kernel@vger.kernel.org, mhiramat@kernel.org,
        davem@davemloft.net, anil.s.keshavamurthy@intel.com,
        naveen.n.rao@linux.ibm.com, rostedt@goodmis.org,
        peterz@infradead.org, akpm@linux-foundation.org,
        sander@svanheule.net, ebiggers@google.com,
        dan.j.williams@intel.com, jpoimboe@kernel.org
Cc:     linux-kernel@vger.kernel.org, lkp@intel.com, mattwu@163.com,
        "wuqiang.matt" <wuqiang.matt@bytedance.com>
Subject: [PATCH v9 0/5] lib,kprobes: kretprobe scalability improvement
Date:   Tue,  5 Sep 2023 09:52:50 +0800
Message-Id: <20230905015255.81545-1-wuqiang.matt@bytedance.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-trace-kernel.vger.kernel.org>
X-Mailing-List: linux-trace-kernel@vger.kernel.org

This patch series introduces a scalable and lockless ring-array based
object pool and replaces the original freelist (a LIFO queue based on
singly linked list) to improve scalability of kretprobed routines.

v9:
  1) objpool: raw_local_irq_save/restore added to prevent interruption

     To avoid possible ABA issues, we must ensure objpool_try_add_slot
     and objpool_try_add_slot are uninterruptible. If these operations
     are blocked or interrupted in the middle, other cores could overrun
     the same slot's ages[] of uint32, then after resuming back, the
     interrupted pop() or push() could see same value of ages[], which
     is a typical ABA problem though the possibility is small.

     The pair of pop()/push() costs about 8.53 cpu cycles, measured
     by IACA (Intel Architecture Code Analyzer). That is, on a 4Ghz
     core dedicated for pop() & push(), theoretically it would only
     need 8.53 seconds to overflow a 32bit value. Testings upon Intel
     i7-10700 (2.90GHz) cost 71.88 seconds to overrun a 32bit integer.

  2) codes improvements: thanks to Masami for the thorough inspection

v8:
  1) objpool: refcount added for objpool lifecycle management

wuqiang.matt (5):
  lib: objpool added: ring-array based lockless MPMC
  lib: objpool test module added
  kprobes: kretprobe scalability improvement with objpool
  kprobes: freelist.h removed
  MAINTAINERS: objpool added

 MAINTAINERS              |   7 +
 include/linux/freelist.h | 129 --------
 include/linux/kprobes.h  |  11 +-
 include/linux/objpool.h  | 174 ++++++++++
 include/linux/rethook.h  |  16 +-
 kernel/kprobes.c         |  93 +++---
 kernel/trace/fprobe.c    |  32 +-
 kernel/trace/rethook.c   |  90 +++--
 lib/Kconfig.debug        |  11 +
 lib/Makefile             |   4 +-
 lib/objpool.c            | 338 +++++++++++++++++++
 lib/test_objpool.c       | 689 +++++++++++++++++++++++++++++++++++++++
 12 files changed, 1320 insertions(+), 274 deletions(-)
 delete mode 100644 include/linux/freelist.h
 create mode 100644 include/linux/objpool.h
 create mode 100644 lib/objpool.c
 create mode 100644 lib/test_objpool.c

-- 
2.40.1

