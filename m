Return-Path: <linux-trace-kernel-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82686C636D4
	for <linux-trace-kernel@archiver.kernel.org>; Wed, 15 Feb 2023 11:56:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233010AbjBOL4r (ORCPT
        <rfc822;linux-trace-kernel@archiver.kernel.org>);
        Wed, 15 Feb 2023 06:56:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231269AbjBOL4q (ORCPT
        <rfc822;linux-trace-kernel@vger.kernel.org>);
        Wed, 15 Feb 2023 06:56:46 -0500
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCA6A265B9;
        Wed, 15 Feb 2023 03:56:44 -0800 (PST)
Received: from kwepemm600003.china.huawei.com (unknown [172.30.72.54])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4PGxJD6B99zFqKt;
        Wed, 15 Feb 2023 19:51:56 +0800 (CST)
Received: from ubuntu1804.huawei.com (10.67.174.61) by
 kwepemm600003.china.huawei.com (7.193.23.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.17; Wed, 15 Feb 2023 19:56:40 +0800
From:   Yang Jihong <yangjihong1@huawei.com>
To:     <tglx@linutronix.de>, <mingo@redhat.com>, <bp@alien8.de>,
        <dave.hansen@linux.intel.com>, <x86@kernel.org>, <hpa@zytor.com>,
        <naveen.n.rao@linux.ibm.com>, <anil.s.keshavamurthy@intel.com>,
        <davem@davemloft.net>, <mhiramat@kernel.org>, <ast@kernel.org>,
        <peterz@infradead.org>, <linux-kernel@vger.kernel.org>,
        <linux-trace-kernel@vger.kernel.org>
CC:     <yangjihong1@huawei.com>
Subject: [PATCH 0/3] kprobes: Fix issues related to optkprobe
Date:   Wed, 15 Feb 2023 19:54:27 +0800
Message-ID: <20230215115430.236046-1-yangjihong1@huawei.com>
X-Mailer: git-send-email 2.30.GIT
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.67.174.61]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 kwepemm600003.china.huawei.com (7.193.23.202)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-trace-kernel.vger.kernel.org>
X-Mailing-List: linux-trace-kernel@vger.kernel.org

Fixed several optkprobe issues, mainly related to the x86 architecture.

Yang Jihong (3):
  kprobes: Fixed probe nodes not correctly removed when forcibly
    unoptimized
  x86/kprobes: Fix __recover_optprobed_insn check optimizing logic
  x86/kprobes: Fix arch_check_optimized_kprobe check within
    optimized_kprobe range

 arch/x86/kernel/kprobes/opt.c | 6 +++---
 include/linux/kprobes.h       | 1 +
 kernel/kprobes.c              | 7 +++----
 3 files changed, 7 insertions(+), 7 deletions(-)

-- 
2.30.GIT

