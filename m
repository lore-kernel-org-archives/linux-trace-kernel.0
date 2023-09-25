Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66CF41B281
	for <linux-trace-kernel@vger.kernel.org>; Mon, 25 Sep 2023 23:08:36 +0000 (UTC)
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by lindbergh.monkeyblade.net (Postfix) with ESMTP id 1E643101;
	Mon, 25 Sep 2023 16:08:35 -0700 (PDT)
Received: from localhost.localdomain (unknown [4.155.48.113])
	by linux.microsoft.com (Postfix) with ESMTPSA id 82132212C81C;
	Mon, 25 Sep 2023 16:08:34 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 82132212C81C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1695683314;
	bh=WGDr+0JsXreUEVyfzTBHxnHOYS93XAqsVjTMSDqYl4w=;
	h=From:To:Cc:Subject:Date:From;
	b=Fdv3QOueUxSXZd/3+0t9KbsGME99vaUuIjsVeI2PRhTYK6pO+CPO5Inx0dvnud7Yq
	 NXZmQ6jwfqPx4cq04uKVAxktDWUj6YA7rp7BTYhoqzOqEwKkl1F4Bx3FjFmckhFN0b
	 ZyeypgHF8a/9pBEIjWXM3ow1o92ndIdNp730coIs=
From: Beau Belgrave <beaub@linux.microsoft.com>
To: rostedt@goodmis.org,
	mhiramat@kernel.org
Cc: linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	cleger@rivosinc.com,
	linux-kselftest@vger.kernel.org
Subject: [PATCH 0/2] tracing/user_events: Fix alignment issues for 32 on 64-bit and BE
Date: Mon, 25 Sep 2023 23:08:27 +0000
Message-Id: <20230925230829.341-1-beaub@linux.microsoft.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-17.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_PASS,SPF_PASS,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

All architectures should use a long aligned address passed to set_bit().
User processes can pass either a 32-bit or 64-bit sized value to be
updated when tracing is enabled when on a 64-bit kernel. Both cases are
ensured to be naturally aligned, however, that is not enough. The
address must be long aligned without affecting checks on the value
within the user process which require different adjustments for the bit
for little and big endian CPUs.

32 bit on 64 bit, even when properly long aligned, still require a 32 bit
offset to be done for BE. Due to this, it cannot be easily put into a
generic method.

The abi_test also used a long, which broke the test on 64-bit BE machines.
The change simply uses an int for 32-bit value checks and a long when on
64-bit kernels for 64-bit specific checks.

I've run these changes and self tests for user_events on ppc64 BE, x86_64
LE, and aarch64 LE. It'd be great to test this also on RISC-V, but I do
not have one.

Clément Léger originally put a patch together for the alignment issue, but
we uncovered more issues as we went further into the problem. Clément felt
my version was better [1] so I am sending this series out that addresses
the selftest, BE bit offset, and the alignment issue.

1. https://lore.kernel.org/linux-trace-kernel/713f4916-00ff-4a24-82d1-72884500a2d3@rivosinc.com/

Beau Belgrave (2):
  tracing/user_events: Align set_bit() address for all archs
  selftests/user_events: Fix abi_test for BE archs

 kernel/trace/trace_events_user.c              | 58 ++++++++++++++++---
 .../testing/selftests/user_events/abi_test.c  | 16 ++---
 2 files changed, 60 insertions(+), 14 deletions(-)


base-commit: fc1653abba0d554aad80224e51bcad42b09895ed
-- 
2.34.1

