Return-Path: <linux-trace-kernel-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 537FAEB64DC
	for <linux-trace-kernel@archiver.kernel.org>; Thu, 15 Jun 2023 07:01:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244380AbjFOHBK (ORCPT
        <rfc822;linux-trace-kernel@archiver.kernel.org>);
        Thu, 15 Jun 2023 03:01:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244464AbjFOHBG (ORCPT
        <rfc822;linux-trace-kernel@vger.kernel.org>);
        Thu, 15 Jun 2023 03:01:06 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19FC4189
        for <linux-trace-kernel@vger.kernel.org>; Thu, 15 Jun 2023 00:00:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1686812419;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=OThjLmbvI6Zpg0mK9QSJewa4TGDoveYEJmGg/Gpz19Y=;
        b=a7AgCQ8tYRk7lIKN7GUo0ph1fcf9p+LzPZaYWFCvQ3nWYgY6lsTp32gbGWkpKkpyTCsn5R
        fdpu5UgNReQnhOMdbgkRJbaH70qAS/TQcqisc6+3EfnJSP0z9x1p6uJa7yiTml14TMOR8i
        5tx8oNzJoSj9fIxIfjPYY+NVp0Ph+xs=
Received: from mail-ot1-f71.google.com (mail-ot1-f71.google.com
 [209.85.210.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-191-CWPQNBGpNg2lzRQdrsrRCg-1; Thu, 15 Jun 2023 03:00:17 -0400
X-MC-Unique: CWPQNBGpNg2lzRQdrsrRCg-1
Received: by mail-ot1-f71.google.com with SMTP id 46e09a7af769-6b15dcc80c6so370208a34.1
        for <linux-trace-kernel@vger.kernel.org>; Thu, 15 Jun 2023 00:00:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686812417; x=1689404417;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OThjLmbvI6Zpg0mK9QSJewa4TGDoveYEJmGg/Gpz19Y=;
        b=RUoea5po4s97jLfwBZKVxlZ6kMxwCj2z7ngqDRlv97jpUsH11VslLneF68qt5T16Vy
         RyODpzFji5bPcZTHWwAjNGYJHO+wBfN9nSkzMR9OaN1zZ2+qyrL89HAorwZXgomjR2g0
         uAkbrXdvhCbV0OPaitcSDDqC0FzNHKd06WADEtthcAo5J2hZpJFmQ0ppJVZIQ3R7wIMt
         Hb715rnkiTwp+3CNrDRfha4X0U1V9hTFYxgZ/Hl9eyJ1v7FzLYC0bgzhJwe7Rh5D5+Lt
         a3y3njphd29UpqhRviJdVFdlZEtTaHfGxX1JZHDXzm/0Dm8LNy4izIkOlXUvQDF6gMbV
         Rt1g==
X-Gm-Message-State: AC+VfDxsvfjwBD3syR6/b2LXXZ+anPrubbfkF54ff3gzaOZOJ1AKFcfX
        FY/O29jQbJ7R/rYXPgCVZOjRIl9my0GvS7keaM3nR05zUksN1K7oSt5jvLfscoIIzZRCHey4qhd
        e2fIWXyadb+NNr658BdU5fYqHnMGxamjC
X-Received: by 2002:a05:6830:4865:b0:6b4:39e7:578e with SMTP id dx5-20020a056830486500b006b439e7578emr375179otb.6.1686812417229;
        Thu, 15 Jun 2023 00:00:17 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7JFZym9YWY4SWWz2Zn7e4z04gbS62xCM/8gAHNSJXHNpERTLzqrjaJyctqTIs9qYe8XmHn1g==
X-Received: by 2002:a05:6830:4865:b0:6b4:39e7:578e with SMTP id dx5-20020a056830486500b006b439e7578emr375165otb.6.1686812416876;
        Thu, 15 Jun 2023 00:00:16 -0700 (PDT)
Received: from localhost.localdomain ([2804:1b3:a800:60ac:48e:4eb0:11b4:f1e8])
        by smtp.gmail.com with ESMTPSA id d4-20020a0568301b6400b006b2b51fd2ebsm6472317ote.81.2023.06.15.00.00.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Jun 2023 00:00:16 -0700 (PDT)
From:   Leonardo Bras <leobras@redhat.com>
To:     Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Leonardo Bras <leobras@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Valentin Schneider <vschneid@redhat.com>,
        Juergen Gross <jgross@suse.com>,
        Yury Norov <yury.norov@gmail.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Subject: [RFC PATCH v5 0/2] trace,smp: Add tracepoints for csd
Date:   Thu, 15 Jun 2023 03:59:43 -0300
Message-ID: <20230615065944.188876-3-leobras@redhat.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"; x-default=true
Precedence: bulk
List-ID: <linux-trace-kernel.vger.kernel.org>
X-Mailing-List: linux-trace-kernel@vger.kernel.org

Changes since RFCv4:
- Moved from trace/events/smp.h to trace/events/csd.h
- Using TRACE_SYSTEM csd, instead of smp
- generic_exec_single() trace uses NULL instead of csd for current cpu.
- Trace function csd type moved from call_single_data_t to 
  struct __call_single_data to avoid alignment errors on blk code.

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

 include/trace/events/csd.h | 72 ++++++++++++++++++++++++++++++++++++++
 kernel/smp.c               | 41 +++++++++++++---------
 2 files changed, 96 insertions(+), 17 deletions(-)
 create mode 100644 include/trace/events/csd.h

-- 
2.41.0

