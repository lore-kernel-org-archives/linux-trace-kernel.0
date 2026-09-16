Received: from mail-pz2-f12.google.com (mail-pz2-f12.google.com [74.125.228.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B93D4E80BF
	for <linux-trace-kernel@vger.kernel.org>; Wed, 16 Sep 2026 13:32:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789565548; cv=none; b=doOxTKTCHobC8TX4ECc34WApM66pWK9dfKTvOOE26Hwh5FJCWCLQaoX4JsAgS27+mHOIx8k7KJ2J2LcfPiYSpOUMQs1GBvYtwNFJJ+glCXYd2hkChF43q5N2WOIDyxPrRjguAfyz5n6nP1a4rTkBeEMbokyOeS7Vn2GXpvP4WJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789565548; c=relaxed/simple;
	bh=VSE7ughsVCLfAxaSUazHFkNKgqHxJdQC6PgVN3x0ggA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=phLG9LBqD88frHknIQWpZs0RwB/eb+YhDeUN2JvHgEH2cJrKJPK5n3EFxClxoMRRv46KCQgM4jTz71acz0brCFem/oR+C2MNFkyRLSR1tItmXkp4Nwz7PISm2Na3+wjm5C0tdh6pHk7zr5W9mkYGFkbeSYymM7RXawNTrnu9sOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iRfnM7Yk; arc=none smtp.client-ip=74.125.228.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iRfnM7Yk"
Received: by mail-pz2-f12.google.com with SMTP id d2e1a72fcca58-85469f204f6so552605b3a.2
        for <linux-trace-kernel@vger.kernel.org>; Wed, 16 Sep 2026 06:32:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789565544; x=1790170344; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=0ysi9KLY4VdiB72ZoOBv6+SkqYouNrH6Fs2Nh1fo2zo=;
        b=iRfnM7Yk27AD1RUWSkcjUwmvGefcWKJQunqKh74vqAa4eG9AMNEuCyjsUVfHFZ6M6k
         gMLVy6QNDyAk6dhxRpVxu9eqzJ/z3U4sDSsccDZ6H+JHVpYqJDidfGWjKtRxf13szzAu
         D8UplxGrdgepPVRTixRiMoNVGLJfhW5F523hfUsN9yqXcb9+p7wlk7lh2wWLzjbd9QgZ
         i4PGDOygpM22yVQ4e2Kfh5vWBJApHxq0FKo/FbXV33zBnoWY1kKe9dkAA9lmRrovGOvT
         LXtLU+kCGs7tTq7jnTkaZFfGFSwR8iHJYnNugCcp6nFnBZ6zgb6IZ+3FHoF/KPN2U5jB
         vshA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789565544; x=1790170344;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=0ysi9KLY4VdiB72ZoOBv6+SkqYouNrH6Fs2Nh1fo2zo=;
        b=eOhNf7/ESkCUML70ohvqvQvSXY5mN2ZH61HO7DGPUhNnLv6La4zccYcXympLktfS4X
         eXvF7xqMEVoiHEtyT2bOH8HSbxNf+epU9uRnxBCldSV01eY/rfMjdbI+dizASsyIGGu0
         Xp31HhGepuw+d9KdvSIixUoOyrGU4+A0qoVPt+oMbuAoc3jgJvf9NuMG/ZyCOiEn8Pu2
         trozmjFOJgDNlNnGSydxCfjsW/ZCGvVYaujMD/4Rb3Goiw4oBPf3RVkp6hyEgpoSCiCY
         bacwJ39ceNFDz3wIjDFy3QgjGTkfeSDV2XA0569Xgbo7nRhkN0H8Jj+KhLVU4xQ5ojgC
         7zOg==
X-Forwarded-Encrypted: i=1; AKwUvByuV9LxLD8rG4XYsDvhnSfHLMNlgzCz6U5GfhFAv5MWFrtHCw7dpMY2e34CMUuPDvhwM26J2lGzlRYnwa95FMO9Fpo=@vger.kernel.org
X-Gm-Message-State: AFuF++ksbJkkxpSNPhJEOQ5dbtWNs6dkm+fXqCEtg7puA1sqSRIyMwL/
	zA6oXV2rb45TnkWb0QldizT1Fo7Ub/d8WjixibLkOa3jDNBVSfSpIa/Q
X-Gm-Gg: AYBFou2tWJCpufEIJLMHaX7GoJE41v7sNp9XRAjc/5lc4QfkTOjaVFq4QpxIuWXdmgi
	m13hScyFpDPTqTGjFcIbI3nwAPvJB0RfpXqqRZUO0rZQftW3pq+61POzZKx4ol/5v5Myzp/Mev6
	I1kxo0FnyMRo1NQxm/1tObiqNva6lY/u72N13l/qNly7+i898//1126K7nbJ1mYp4qNZtPb7ZoG
	EhOSVB42lCFhWNphO8OcxWgUVpp2syJIqeK9qJqEpjCuCJzuhqG+L83BzEoJpweiZfgP31CNXc6
	6s0muCA5UHyEgkfe2H2jRqZTpKkOWlBG+OiIQV0uQA/oeffi2lUN/CWonLOJ4I3dnFeAbMM0JrI
	KZyIelm3IEiPnYog6ldzhCCy75lMOHZ9s+vEc5Y2IDzzOpo96scShKeyD4mBHzv3g4UhJVHhYZM
	RfdwYojqvQK33Gp6poF1PYBk5/lEbHXvk0h8RtJyth4S+TsmkH4rDqX9X0rGBbGZgG43q2SV7sQ
	7WhqTu3GpFVx6556AXKDHLrZQ==
X-Received: by 2002:a05:6a20:94ca:b0:3d3:b00b:26e8 with SMTP id adf61e73a8af0-3dd5f8123f7mr6558490637.28.1789565544152;
        Wed, 16 Sep 2026 06:32:24 -0700 (PDT)
Received: from pengdl-pc.mioffice.cn ([43.224.245.249])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cc50ab960edsm1651702a12.20.2026.09.16.06.32.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Sep 2026 06:32:23 -0700 (PDT)
From: Donglin Peng <dolinux.peng@gmail.com>
To: rostedt@goodmis.org
Cc: mhiramat@kernel.org,
	dolinux.peng@gmai.com,
	linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	pengdonglin <pengdonglin@xiaomi.com>
Subject: [PATCH v6 0/4] Use BTF to trim return values
Date: Wed, 16 Sep 2026 21:32:14 +0800
Message-Id: <20260916133218.1282590-1-dolinux.peng@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: pengdonglin <pengdonglin@xiaomi.com>

The funcgraph-retval option currently records one machine-word return
value without considering the function's declared return type. As a
result, void-returning functions can produce meaningless output, and
return values narrower than a general-purpose register can include
undefined high bits.

This series uses kernel BTF to identify the return type of traced
functions and to improve funcgraph-retval output:

  - Do not print a return value for functions with a void return type.
  - Trim integer, enum, struct, and union values to the available return
    value width when the BTF type provides suitable size information.
  - Format integer, enum, and boolean values according to their BTF
    encoding.
  - Mark values as "(trunc)" when the return type is wider than the value
    captured by the function graph tracer.

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
 2)   0.312 us    |       } /* current_time ret=0x69380649 (trunc) */
 2)   0.753 us    |     } /* atime_needs_update ret=false */
 2)   0.899 us    |   } /* touch_atime */

Note that funcgraph-retval still captures only the return value exposed
by ftrace_regs_get_return_value(). Return values that require multiple
registers are therefore still incomplete and are marked "(trunc)" when
the BTF type indicates that the declared type is wider than one machine
word.

Changelog:

v6:
  - Avoid BTF lookup in atomic context or with interrupts disabled
  - Add the atomic-context fix as a separate patch.

v5:
  - Link: https://lore.kernel.org/linux-trace-kernel/20260901134604.4052265-1-dolinux.peng@gmail.com/
  - Add an inline fallback for btf_trim_retval() when
    CONFIG_DEBUG_INFO_BTF is disabled.
  - Release the BTF reference after return type lookup.

v4:
  - Link: https://lore.kernel.org/all/20251215034153.2367756-1-dolinux.peng@gmail.com/
  - Build trace_btf.c when CONFIG_DEBUG_INFO_BTF is enabled.
  - Remove the redundant BPF_SYSCALL dependency from
    CONFIG_PROBE_EVENTS_BTF_ARGS.
  - Update the funcgraph-retval documentation and cover letter.

v3:
  - Link: https://lore.kernel.org/all/20251209121349.525641-1-dolinux.peng@gmail.com/
  - Print the return value based on its type for human readability,
    thanks Masami.
  - Update the documentation and cover letter.

v2:
  - Link: https://lore.kernel.org/all/20251208131917.2444620-1-dolinux.peng@gmail.com/
  - Update the funcgraph-retval documentation.
  - Revise the cover letter.

v1:
  - Link: https://lore.kernel.org/all/20251207142742.229924-1-dolinux.peng@gmail.com/

pengdonglin (4):
  tracing: Avoid BTF lookup in atomic context
  ftrace: Build trace_btf.c when CONFIG_DEBUG_INFO_BTF is enabled
  fgraph: Enhance funcgraph-retval with BTF-based type-aware output
  tracing: Update funcgraph-retval documentation

 Documentation/trace/ftrace.rst       | 96 +++++++++++++++++-----------
 kernel/trace/Kconfig                 |  2 +-
 kernel/trace/Makefile                |  2 +-
 kernel/trace/trace_btf.c             | 86 +++++++++++++++++++++++++
 kernel/trace/trace_btf.h             | 18 ++++++
 kernel/trace/trace_functions_graph.c | 56 ++++++++++++----
 6 files changed, 207 insertions(+), 53 deletions(-)

-- 
2.34.1
