Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C7802405E1
	for <linux-trace-kernel@vger.kernel.org>; Tue,  9 Dec 2025 12:13:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765282440; cv=none; b=IntUNlkGKHJ6PDWRd0Gpz4YmYDtL2Pdq+VftjuY1yHyYXyVMJQfecFITgIMy58BeHUP0ohWkbhmCBCAIsyxCM4nseeJo3apGFwUeM3A+bvtq3jso2b809VsKNAlgJ8AfAS7aEW6tXU/IGFEQ4X6yKs5U2BJ8eJLSeZWdq+mpmPc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765282440; c=relaxed/simple;
	bh=hqZJhBlk8E0uWqAszsGWdn6uwEpnAkl70yRVFX1r8vQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=HISXXOqUV7nDeIjvdw9uBndMYr0G9sM0WXAw2AYA99P0EhCUUT58qD0/ECoBDsbShQWE4WuFQO/q5/94z7bhKhlJvwqyxCiYPFt8Pc6mjcyY5Cc1iQyWJMiY7QiFbw80i88PV7qaz/6FybPHd5E0AXoxXWpg3ys6edv2jGMmQcs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T0SDXiqS; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T0SDXiqS"
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-7bb3092e4d7so5862477b3a.0
        for <linux-trace-kernel@vger.kernel.org>; Tue, 09 Dec 2025 04:13:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765282438; x=1765887238; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=U9P06umUEfXCiGuidNyWvy9LA75ynGEE6DkaxamGroo=;
        b=T0SDXiqSwMJ6sxz/ksgjMVlehLw1p+VauuDE6+Dw7vPGhEsGN2Wmwn6/dhb22VSX6S
         KuM+2b8QTsspPdoTJYXvVymfo5f1LMI97AjnGQ3dWuB+KsH7Ri5xiNjZBktM+TUuHJqq
         LuHwNl/rw26tAYWazveTjLWufLNpf5bn5yNFMnbNXjbRj8uhtvgty2icYruuenItKTCO
         pjRFqP1vMnbQmBjxAvFAotVqmYqH8BdBwRiD2fJEjXoooOiyAPNVEDzgQikk2g3CGCji
         IYOoq4arBnrs3TOfYgnl6nlCkqh2qVt4OIetPZu5MBu5W56O+kixI5qv8lWOZZgk2zZi
         yldw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765282438; x=1765887238;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=U9P06umUEfXCiGuidNyWvy9LA75ynGEE6DkaxamGroo=;
        b=YMnNdqrOt/wRNkFIslHBEhxj9OG8GcPihpAg0x8LrK2L8Ybsigq29spR7SbVyXy6UB
         e6bUWKuun+8pNOszZ4peqyWD6IyyPJtqz01aNxmNkYi7ZKLj3eCMrthIEMmeIxbG5AB1
         IKBCHHLS+njAK/dlXrkyh2U9BWUmOJ9PUDnI2tL35Wr6VVzok2yHX4wFk1xBiBOU2s/M
         tjOP04MKwLKO0517O41jriCMnIGziODDQozs2yhEh7lceAhLsh7BVfAMXCoSpuW8BIQO
         F6fg3r4wvapwV1BoLlJVC57uCDeME793jZ8lqHdhbQeFX5J4gj1kqfgALf3x+Fu6d026
         GSHA==
X-Forwarded-Encrypted: i=1; AJvYcCUPX3ikJGvC+8akGy6Pu9HKkKZYgvv84aLhKlmL8QWrHlgU+u7rIA+fklQdLmQwSaSP7/cQY+YjftPG53UKmMlA3OE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxSkLK4XcfGopc2FwK9huJL5bJWItQ9PIYytNKT1LvCQkcn2MJg
	A5bRps4v0AF5i1DfKZZ5vjMvE0/3HiaUtwDBL8+eaKnUbZFJWAqmozce
X-Gm-Gg: ASbGncuUOwf1t+Nk6DngWWwlxgDmUNEcPj5NMsEoLP9QZuCXQv9cERE1aFBIf+5PShw
	NQPSRXzrtmK2gMQ9xJUEni3R76DQOwEwvbMnNcvnBo3yj2+TQK+3lrjlIoRUt90U1oCgBQaGArX
	rfB/ZdbSfL8ETVjnHSDURDfS33LEYiPRO5UdsQE7GR80E+63e/gs1yqrNm0l+eTn6Sh7l+q7lRV
	ppGfrzhfUOSZsdpJkpMrO1fYSH1KkD4oJsBvCZcOZZl7lzPpwcMBmyaxtr2JZFZmpWPlVx9bXyu
	lfD8KH1qV/AULITRAsg6DKxQSwe/uJEyHzqMdMWKqLTC0Us0TCKwyDqEPz+1PDLZ0X0+7ibjdbs
	PW19F3R11y9YKdGrLzx7wMG1Na3gBHzP8tQsCc8lX+uNsK6cRjJPjCdUl3WIwBPO0l7RNaK/F0A
	ETGhauPCdspOesg75n0tu/Er6PkrTaitevKbsG+w==
X-Google-Smtp-Source: AGHT+IHNd0JoDbjVHcFvgyK84UO3DpBZXx0uJFjuxTNHxDk4OSzSd5kiG95BNaY3jJ6b67Xqz7lfmQ==
X-Received: by 2002:a05:6a00:18a2:b0:7e8:450c:61ce with SMTP id d2e1a72fcca58-7e8c63bbfe6mr10676948b3a.62.1765282437877;
        Tue, 09 Dec 2025 04:13:57 -0800 (PST)
Received: from pengdl-pc.mioffice.cn ([43.224.245.249])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c0724e9888esm4776a12.14.2025.12.09.04.13.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Dec 2025 04:13:56 -0800 (PST)
From: Donglin Peng <dolinux.peng@gmail.com>
To: rostedt@goodmis.org
Cc: mhiramat@kernel.org,
	linux-trace-kernel@vger.kernel.org,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	pengdonglin <pengdonglin@xiaomi.com>
Subject: [PATCH v3 0/2] Use BTF to trim return values
Date: Tue,  9 Dec 2025 20:13:47 +0800
Message-Id: <20251209121349.525641-1-dolinux.peng@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: pengdonglin <pengdonglin@xiaomi.com>

This patch series addresses two limitations of the funcgraph-retval feature:

1. Void-returning functions still print a return value, creating misleading
   noise in the trace output.

2. For functions returning narrower types (e.g., char, short), the displayed
   value can be incorrect because high bits of the register may contain
   undefined data.

By leveraging BTF to obtain precise return type information, we now:

1. Void function filtering: Functions with void return type no longer
   display any return value in the trace output, eliminating unnecessary
   clutter.

2. Type-aware value formatting: The return value is now properly truncated to
   match the actual width of the return type before being displayed.
   Additionally, the value is formatted according to its type for better human
   readability.

Here is an output comparison:

Before:
 # perf ftrace -G vfs_read --graph-opts retval
 ...
 1)               |   touch_atime() {
 1)               |     atime_needs_update() {
 1)   0.069 us    |       make_vfsuid(); /* ret=0x0 */
 1)   0.067 us    |       make_vfsgid(); /* ret=0x0 */
 1)               |       current_time() {
 1)   0.197 us    |         ktime_get_coarse_real_ts64_mg(); /* ret=0x187f886aec3ed6f5 */
 1)   0.352 us    |       } /* current_time ret=0x69380753 */
 1)   0.792 us    |     } /* atime_needs_update ret=0x0 */
 1)   0.937 us    |   } /* touch_atime ret=0x0 */

After:
 # perf ftrace -G vfs_read --graph-opts retval
 ...
 2)               |   touch_atime() {
 2)               |     atime_needs_update() {
 2)   0.070 us    |       make_vfsuid(); /* ret=0x0 */
 2)   0.070 us    |       make_vfsgid(); /* ret=0x0 */
 2)               |       current_time() {
 2)   0.162 us    |         ktime_get_coarse_real_ts64_mg();
 2)   0.312 us    |       } /* current_time ret=0x69380649(trunc) */
 2)   0.753 us    |     } /* atime_needs_update ret=false */
 2)   0.899 us    |   } /* touch_atime */

Note: enabling funcgraph-retval now adds overhead due to repeated btf_find_by_name_kind()
calls during trace output. A separate series [1] optimizes this function with
binary search (O(log n) vs current O(n)), which will greatly reduce the impact.

Here is a performance comparison:

1. Original funcgraph-retval:
# time cat trace | wc -l
101024

real    0m0.682s
user    0m0.000s
sys     0m0.695s

2. Enhanced funcgraph-retval:
# time cat trace | wc -l
99326

real    0m12.886s
user    0m0.010s
sys     0m12.680s

3. Enhanced funcgraph-retval + optimizined btf_find_by_name_kind:
# time cat trace | wc -l
102922

real    0m0.794s
user    0m0.000s
sys     0m0.810s

Changelog:
v3:
- Print the return value based on its type for human readability, thanks Masami
- Update documentation and cover letter

v2:
- Link: https://lore.kernel.org/all/20251208131917.2444620-1-dolinux.peng@gmail.com/
- Update the funcgraph-retval documentation
- Revise the cover letter

v1:
- Link: https://lore.kernel.org/all/20251207142742.229924-1-dolinux.peng@gmail.com/

[1] https://lore.kernel.org/all/20251208062353.1702672-1-dolinux.peng@gmail.com/

pengdonglin (2):
  fgraph: Enhance funcgraph-retval with BTF-based type-aware output
  tracing: Update funcgraph-retval documentation

 Documentation/trace/ftrace.rst       |  78 ++++++++++-------
 kernel/trace/trace_functions_graph.c | 124 ++++++++++++++++++++++++---
 2 files changed, 156 insertions(+), 46 deletions(-)

-- 
2.34.1

