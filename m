Received: from sender-of-o55.zoho.eu (sender-of-o55.zoho.eu [136.143.169.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4859533120C;
	Wed, 18 Mar 2026 15:59:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.169.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773849575; cv=pass; b=M6sYr3orX+6BWSewS2osqDnAVGKUJTOWo6vIkEg7t1zam8gzMr4E9hdrAUlAAEJOkLpkDW2H99M1cxMhXZV0WuCpWcg9GDe6+sgkPkprcfYFHxY4o6vPxOJcb9sAYz5dn7BeoA+5ZTd1XjqCbFLga7sEVfso3LjIRzkZgHsIG3E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773849575; c=relaxed/simple;
	bh=qRNFjJS/5sa9mTjqJSCQhAmPsrz8/MNtCZkXa8WajGQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=sBHppWSB6REXMl8GEvZSRKBIILpxOKcYbpE4i6Ako7xwUwliuhEpZTi5HwRtJuYGU/PMMRKwNowTzno8vqamm9O5/eX9B2W49dIhQHVHotQrukGuDMjLrhoOQ9SdCW0xioVnz54I2vPPRShLKopSUhzbFDXyGSTqJbss0WxHVBU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=objecting.org; spf=pass smtp.mailfrom=objecting.org; dkim=pass (1024-bit key) header.d=objecting.org header.i=objecting@objecting.org header.b=So6xn4Zk; arc=pass smtp.client-ip=136.143.169.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=objecting.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=objecting.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=objecting.org header.i=objecting@objecting.org header.b="So6xn4Zk"
ARC-Seal: i=1; a=rsa-sha256; t=1773849561; cv=none; 
	d=zohomail.eu; s=zohoarc; 
	b=GnxFhs9bPR8qV22ja4ZhsgAx63gTi2DoojUpcADgno9WWMyI61h/VYfUdvNmYDfAcYWnO8UpI4Eml1tBTE9mvdDiTlN4WcWpJFYn4JFGZf1jnKldcOau73dIzO7bZHaQ8U4eD2NmcRsVbd+bgLlZHIpZ1RZF5hIDiPFlnDxX2bE=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.eu; s=zohoarc; 
	t=1773849561; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=kQXauh2o5o5CBIrqPPj630zAvi0I6udapAZ7KPX8akg=; 
	b=afFdbDFy13ODdq5gm39URQKlUz0a0ozDoM7WyMtG/AirCazwD5ONdV51ReH9XXLrZ668rHsKpP4eLpJweFuivfkcNi9crCepBeOJECqIVGIKleJYhAPKM9SOaUob20WFE+Byacf2lzJQ6LccwyF8KDNzliT8o3yxuMzLSor2udk=
ARC-Authentication-Results: i=1; mx.zohomail.eu;
	dkim=pass  header.i=objecting.org;
	spf=pass  smtp.mailfrom=objecting@objecting.org;
	dmarc=pass header.from=<objecting@objecting.org>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1773849561;
	s=zmail; d=objecting.org; i=objecting@objecting.org;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-Id:Message-Id:MIME-Version:Content-Transfer-Encoding:Reply-To;
	bh=kQXauh2o5o5CBIrqPPj630zAvi0I6udapAZ7KPX8akg=;
	b=So6xn4ZkTemNILHWRr9K7uH/qVeavJmvwqvYpcNezxIOXdQ9fzhFPEXwiDSCD5Mw
	g0Vm96vys7FV24qjuDothDvantcE3b53LE+sWwIG7zYiqDCqdo/RgD7DZDJ6HboM5r8
	8ZNcYa7EQljrZJVU9H+I0wXRQY+dW5h8jLMTSbtk=
Received: by mx.zoho.eu with SMTPS id 1773849560087797.4970366547406;
	Wed, 18 Mar 2026 16:59:20 +0100 (CET)
From: Josh Law <objecting@objecting.org>
To: Masami Hiramatsu <mhiramat@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	Josh Law <objecting@objecting.org>
Subject: [PATCH v8 00/13] bootconfig: cleanups, correctness, and modernization
Date: Wed, 18 Mar 2026 15:59:06 +0000
Message-Id: <20260318155919.78168-1-objecting@objecting.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

This series addresses a collection of issues found during a review of
lib/bootconfig.c, include/linux/bootconfig.h, and tools/bootconfig,
covering off-by-one errors, coding style, signedness/type cleanup, and
API modernization.

The two patches with Fixes tags (xbc_init_node() override check and
load_xbc_file() fd leak) have been split into a separate series for
bootconfig/fixes per Masami's request.

Changes since v7:
  - Split fixes from cleanups/improvements into separate series per
    maintainer request, so fixes can go into bootconfig/fixes and the
    rest (this series) into bootconfig/for-next.

Bug fixes:
  - Fix off-by-one in xbc_verify_tree() where a next-node index equal
    to xbc_node_num passes the bounds check despite being out of range;
    a malformed bootconfig could cause an out-of-bounds read of kernel
    memory during tree traversal at boot time (patch 3).
  - Move xbc_node_num increment to after xbc_init_node() validation so
    a failed init does not leave a partially initialized node counted
    in the array; on a maximum-size bootconfig, the uninitialized node
    could be traversed leading to unpredictable boot behavior (patch 4).
  - Validate child node indices in xbc_verify_tree() alongside the
    existing next-node check; without this, a corrupt bootconfig could
    trigger an out-of-bounds memory access via an invalid child index
    during tree traversal (patch 8).

Correctness:
  - Narrow the flag parameter in node creation helpers from uint32_t to
    uint16_t to match the xbc_node.data field width (patch 2).
  - Constify the xbc_calc_checksum() data parameter since it only reads
    the buffer (patch 6).
  - Fix strict-GCC signedness and narrowing warnings by aligning local
    types with strlen() APIs and the node index/data storage in
    xbc_node_get_data(), xbc_node_match_prefix(), xbc_init_node(),
    xbc_verify_tree(), and xbc_node_index() (patches 9-13).

Cleanups:
  - Fix comment typos, missing blank line before kerneldoc, and
    inconsistent if/else bracing (patch 1).
  - Drop redundant memset after memblock_alloc which already returns
    zeroed memory; switch the userspace path from malloc to calloc to
    match (patch 5).

Modernization:
  - Replace the catch-all linux/kernel.h include with the specific
    headers needed: linux/cache.h, linux/compiler.h, and
    linux/sprintf.h (patch 7).

Build-tested with both the in-kernel build (lib/bootconfig.o,
init/main.o) and the userspace tools/bootconfig build. All 70
tools/bootconfig test cases pass.

Josh Law (13):
  lib/bootconfig: clean up comment typos and bracing
  lib/bootconfig: narrow flag parameter type from uint32_t to uint16_t
  lib/bootconfig: fix off-by-one in xbc_verify_tree() next node check
  lib/bootconfig: increment xbc_node_num after node init succeeds
  lib/bootconfig: drop redundant memset of xbc_nodes
  bootconfig: constify xbc_calc_checksum() data parameter
  lib/bootconfig: replace linux/kernel.h with specific includes
  lib/bootconfig: validate child node index in xbc_verify_tree()
  lib/bootconfig: fix signed comparison in xbc_node_get_data()
  lib/bootconfig: use size_t for strlen result in
    xbc_node_match_prefix()
  lib/bootconfig: use signed type for offset in xbc_init_node()
  lib/bootconfig: use size_t for key length tracking in
    xbc_verify_tree()
  lib/bootconfig: change xbc_node_index() return type to uint16_t

 include/linux/bootconfig.h |  6 ++--
 lib/bootconfig.c           | 62 ++++++++++++++++++++++----------------
 2 files changed, 39 insertions(+), 29 deletions(-)

--
2.34.1

