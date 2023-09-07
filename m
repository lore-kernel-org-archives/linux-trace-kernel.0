Return-Path: <linux-trace-kernel-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35DDDEE14C3
	for <linux-trace-kernel@archiver.kernel.org>; Thu,  7 Sep 2023 02:29:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237659AbjIGC3h (ORCPT
        <rfc822;linux-trace-kernel@archiver.kernel.org>);
        Wed, 6 Sep 2023 22:29:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbjIGC3h (ORCPT
        <rfc822;linux-trace-kernel@vger.kernel.org>);
        Wed, 6 Sep 2023 22:29:37 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D746C12C;
        Wed,  6 Sep 2023 19:29:32 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A58E7C433C8;
        Thu,  7 Sep 2023 02:29:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694053772;
        bh=4jvhHwmojf1N1ScmiTRSf81bUPIFUZAdFcnyTSgTh30=;
        h=From:To:Cc:Subject:Date:From;
        b=dp5fJs4bWQca4lDJUBnJZn7y/0m70XnX03LEKYPGjcmIO/TJ76AkgpmSJH369axGd
         ofP7ksIhxB3n1u4kO3nkzyC7pN0y8NbgQntwcqfqWJpPt0lvSFI8k9EIwKnnYOt/Tr
         jFBBAKaSwjJ2PxXF2naDgZcFJxN2QHtXrFCyNZrBh0UmTGa7HAQbQPY7KMlEKPSkPk
         KGGwo+uYKxfd9NwBmgZqSGfyzG7kSPeBOlb6uhcdOabuawy27ruTmVbWl6VZLSfT/y
         FEKDUGZHH4/RahCdsa8bgxaFqe+EFdUzYq9de/UwZU4H6+LZKu2ttvEw5+7zqWfpal
         Xwzh0lpSPHWeg==
From:   SeongJae Park <sj@kernel.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     SeongJae Park <sj@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
        Steven Rostedt <rostedt@goodmis.org>, damon@lists.linux.dev,
        linux-mm@kvack.org, linux-doc@vger.kernel.org,
        linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 00/11] mm/damon: misc fixups for documents, comments and its tracepoint
Date:   Thu,  7 Sep 2023 02:29:18 +0000
Message-Id: <20230907022929.91361-1-sj@kernel.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-trace-kernel.vger.kernel.org>
X-Mailing-List: linux-trace-kernel@vger.kernel.org

This patchset contains miscellaneous simple fixups for documents, comments and
tracepoint of DAMON.

SeongJae Park (11):
  Docs/admin-guide/mm/damon/usage: fixup missed :ref: keyword
  Docs/admin-guide/mm/damon/usage: place debugfs usage at the bottom
  Docs/admin-guide/mm/damon/usage: move debugfs intro to the bottom of
    the section
  Docs/mm/damon/design: explicitly introduce ``nr_accesses``
  Docs/admin-guide/mm/damon/usage: explain the format of damon_aggregate
    tracepoint
  Docs/mm/damon/design: add a section for kdamond and DAMON context
  Docs/admin-guide/mm/damon/usage: link design doc for details of
    kdamond and context
  mm/damon/core: fix a comment about damon_set_attrs() call timings
  mm/damon/core: add more comments for nr_accesses
  mm/damon/core: remove duplicated comment for watermarks-based
    deactivation
  mm/damon/core: remove 'struct target *' parameter from
    damon_aggregated tracepoint

 Documentation/admin-guide/mm/damon/usage.rst | 86 +++++++++++---------
 Documentation/mm/damon/design.rst            | 23 +++++-
 include/linux/damon.h                        | 22 ++---
 include/trace/events/damon.h                 |  6 +-
 mm/damon/core.c                              |  8 +-
 5 files changed, 90 insertions(+), 55 deletions(-)


base-commit: ac8e8303c9c11b5c2e1d2e110866eb66c9fd771e
-- 
2.25.1

