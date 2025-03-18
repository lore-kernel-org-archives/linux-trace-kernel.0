Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BBE7206F31
	for <linux-trace-kernel@vger.kernel.org>; Tue, 18 Mar 2025 22:15:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742336104; cv=none; b=jo8wM/WjZvQlm6dkD3XqugXO+Ovw/NTII6HTLTtzY/rVqStc7Vy8W57Nl4gtH6gW7eO3+8j33oqpHm3VrnR4kNuOwH2RNgwCpTh71uew/8BeB7QU4WduV/7lGCLZrNrGuBH+MLMx6fwvLs4aE0m9p4+GmRAv3wqK5013OMtiF4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742336104; c=relaxed/simple;
	bh=43Ej9z5Ojm/OhbwP/uBJBlEK5SjjkYgcU4ivfBLfqAI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:content-type; b=e+BKsl6GJgLUKt+GnGVT3zAYDMpiBIIDMpleWkFcroOUBSNQp+61vglEbGgS/ujjP+0ZSx3z5LnGPBK5C+lBIyKzp2uyCSlcet2W5HQsREYciP3UbDk1Q6VIJNvMqjX6CH8J6VEm9a5DbO5dkKTdzLZqumq005Ors/c8swJgQu0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TVEDB5S3; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TVEDB5S3"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1742336102;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=k/UAkoyXYAAAj8ppLHSspsrG6Ksk9pE1Zj0H/JtivFc=;
	b=TVEDB5S3Ol6wuiAM5ezMUsr2nrTq3GB2RXaWPF7grLZvGLEQa3gVps4HWUs+oRHqW7pSzZ
	j2IgR0Wc+t5/TeVD2/N7IwdEOSJoNGCGz/UytIlK3lQWNieJw+ukocE9eBUb2vci7C7/4v
	X1znz5IEHMsCjFGCoHaO/GlOFu2xEpw=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-422-rcHaQ4SYPmehsH9izOTEcQ-1; Tue, 18 Mar 2025 18:15:01 -0400
X-MC-Unique: rcHaQ4SYPmehsH9izOTEcQ-1
X-Mimecast-MFC-AGG-ID: rcHaQ4SYPmehsH9izOTEcQ_1742336100
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-43947a0919aso26434565e9.0
        for <linux-trace-kernel@vger.kernel.org>; Tue, 18 Mar 2025 15:15:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742336100; x=1742940900;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=k/UAkoyXYAAAj8ppLHSspsrG6Ksk9pE1Zj0H/JtivFc=;
        b=atfWVrjTNu/xVU0q6ZaiVFIDr3obl/QXNLg16EUPuE2WeLdDjE2Yr4scGwoH9Wujgq
         +fiCZLLJMqlfi7BFdUZcgtdnC2KCr1o9lqu5zi3uKPiPzxUfKAAXODyp9DgxnNx0FuFX
         lqr54J+YLtHtRiWE/tgp/Ai6YDIkAVVGbI1uGhAXq7zsilWCJ1LQTpqFUSLUYBV+Heew
         EOH0ZtqDK2i+Zg4uDfn+kwlUVtu08rXy6uRhmsTBvw2ZF49IhUwFrrd6Jyjp1+FI2zWB
         3uYg0taJshE0xe7QYhtR1cSgWAChkKXziDoDHir6CqJfIg86e1KwuQ/DNFX32ZgZHhzq
         M9sg==
X-Forwarded-Encrypted: i=1; AJvYcCUGIJNp0gtqseVSWQydUiaiD1sIY8kVUHVToTS3lA0PynVPBbo5knHxTUOGAottQq08gvWny5pj7QNfgBmWpDUrWYs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw5VoxWnYVr6mtNhSZNB/jkZuzTYJfpDN2bYIMyewHvebEkMoLO
	GedzVYrhUMyerDgGHYu0Mtqc6Q6xJMxaA3+Rvt0adj9o0pTzwTyWbaxaqPqG0qMZfrA9HOG7jdf
	p8OBCQvVWNGl9OQ8LpTOmEJf6jB00kMXtLfT5WPZPfBA2tTX2jhIdBXa1Ws8hysetz24erw==
X-Gm-Gg: ASbGnct2Gotz4qW8aYAMcAxcfr1CSyvh4iMVpogJQqNCJrIBlu6m8b6UN5atOmsQyxg
	8a2LXAyp/I32hfF4/po2c0I6MNcsNil+M4ex5EKSalLBG3lUE2QEm5SpX0j3u/3HdIbbuyZiFpD
	rAjIW0Fv/D8lNaPEHYBMQgOe4297W5A+8gN7p3EJzNPYAmiU9/sxsUM+3yVqx7+y00kMDHH+EJU
	9Hdmw5uE+jk+ys6nGitSvrHoofr0S4l7BjgXVn8HpextIv7LtUYMX61FZwLjDzNIEkEZ2sk1c49
	IrYRPpUUsGQ+4msVV+50lJ0X1EQd+F9/I1lHEy9ACqu/wmCMccqd/bD2fN9sFTUj1L8NXPUJNg+
	X
X-Received: by 2002:a05:600c:5250:b0:43c:fc0c:7f33 with SMTP id 5b1f17b1804b1-43d43781e4emr2289965e9.2.1742336099689;
        Tue, 18 Mar 2025 15:14:59 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE4p4iEcIpIkoqdTFEFOZVeOZYDgFaQD/Z05qK3YULm0myWGBlzWfRjIZbHbmsiH0EHYYUrsQ==
X-Received: by 2002:a05:600c:5250:b0:43c:fc0c:7f33 with SMTP id 5b1f17b1804b1-43d43781e4emr2289795e9.2.1742336099275;
        Tue, 18 Mar 2025 15:14:59 -0700 (PDT)
Received: from localhost (p200300cbc72d250094b54b7dad4afd0b.dip0.t-ipconnect.de. [2003:cb:c72d:2500:94b5:4b7d:ad4a:fd0b])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-43d43f556a4sm317825e9.22.2025.03.18.15.14.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Mar 2025 15:14:58 -0700 (PDT)
From: David Hildenbrand <david@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: linux-mm@kvack.org,
	linux-arm-kernel@lists.infradead.org,
	linux-trace-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	David Hildenbrand <david@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Andrii Nakryiko <andrii.nakryiko@gmail.com>,
	Matthew Wilcox <willy@infradead.org>,
	Russell King <linux@armlinux.org.uk>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Oleg Nesterov <oleg@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	"Liang, Kan" <kan.liang@linux.intel.com>,
	Tong Tiangen <tongtiangen@huawei.com>
Subject: [PATCH v2 0/3] kernel/events/uprobes: uprobe_write_opcode() rewrite
Date: Tue, 18 Mar 2025 23:14:54 +0100
Message-ID: <20250318221457.3055598-1-david@redhat.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: u4lty6su5slR3nB6agSob1xgXMheh71f_p97RGUr5Ew_1742336100
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

Based on mm/unstable.

Currently, uprobe_write_opcode() implements COW-breaking manually, which is
really far from ideal. Further, there is interest in supporting uprobes on
hugetlb pages [1], and leaving at least the COW-breaking to the core will
make this much easier.

Also, I think the current code doesn't really handle some things
properly (see patch #3) when replacing/zapping pages.

Let's rewrite it, to leave COW-breaking to the fault handler, and handle
registration/unregistration by temporarily unmapping the anonymous page,
modifying it, and mapping it again. We still have to implement
zapping of anonymous pages ourselves, unfortunately.

We could look into not performing the temporary unmapping if we can
perform the write atomically, which would likely also make adding hugetlb
support a lot easier. But, limited (e.g., only PMD/PUD) hugetlb support
could be added on top of this with some tweaking.

Note that we now won't have to allocate another anonymous folio when
unregistering (which will be beneficial for hugetlb as well), we can simply
modify the already-mapped one from the registration (if any). When
registering a uprobe, we'll first trigger a ptrace-like write fault to
break COW, to then modify the already-mapped page.

Briefly sanity tested with perf probes and with the bpf uprobes
selftest.

v1 -> v2:
* "kernel/events/uprobes: uprobe_write_opcode() rewrite"
 -> hold GUP reference longer so we can see if the page is still
    mapped when performing the folio_walk
 -> Move anon-folio check
 -> Reshuffle / cleanup some related things

RFC -> v1:
* Use folio_walk and simplify the logic

Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Matthew Wilcox <willy@infradead.org>
Cc: Russell King <linux@armlinux.org.uk>
Cc: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Oleg Nesterov <oleg@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Ian Rogers <irogers@google.com>
Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: "Liang, Kan" <kan.liang@linux.intel.com>
Cc: Tong Tiangen <tongtiangen@huawei.com>

[1] https://lkml.kernel.org/r/ZiK50qob9yl5e0Xz@bender.morinfr.org

David Hildenbrand (3):
  kernel/events/uprobes: pass VMA instead of MM to remove_breakpoint()
  kernel/events/uprobes: pass VMA to set_swbp(), set_orig_insn() and
    uprobe_write_opcode()
  kernel/events/uprobes: uprobe_write_opcode() rewrite

 arch/arm/probes/uprobes/core.c |   4 +-
 include/linux/uprobes.h        |   6 +-
 kernel/events/uprobes.c        | 356 +++++++++++++++++----------------
 3 files changed, 186 insertions(+), 180 deletions(-)


base-commit: 40caf747267c18b6206e26a37d6ea6b695236c11
-- 
2.48.1

