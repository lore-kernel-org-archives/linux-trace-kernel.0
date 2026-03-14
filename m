Received: from sender-of-o55.zoho.eu (sender-of-o55.zoho.eu [136.143.169.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7040F2264D3;
	Sat, 14 Mar 2026 23:06:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.169.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773529571; cv=pass; b=WvpTFTJUIspdaMbDicBmu57m1Ph68UfXdyzsKVwRTwyoNdkmTZBF3rxgWRkecHfHZn+gacxrhH9e2x8oaJmq4xg3YQT7wi8Cxb+MHoQH9eJ6dm1V8WFMGLqIxEKP9XHg0nZiQ0yOCjTfxyy4ecYIMIhJ5b+g3ihVf4W/cGN2LkI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773529571; c=relaxed/simple;
	bh=phdnuwMPIgCmYWlD+MtpCxgO98IrDJVdMr+mXZZFY9E=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=OaOTumXLyP7OlAAU7CMJZZl2iK+Tr6Pe2Vkk09N/V+EWSGad1l1ikSIMXwZ7fy1pWe6QXY1XPxxvHBQgaK/CNpMSkGG/ZmQ8BAWxG5m9ELoJ8c5XMe0cb4RNGQhEyXaV5i/nkWfgadMqPtc6j9KttmHygkraeNzi/HVEQqrDnk8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=objecting.org; spf=pass smtp.mailfrom=objecting.org; dkim=pass (1024-bit key) header.d=objecting.org header.i=objecting@objecting.org header.b=mw565sRo; arc=pass smtp.client-ip=136.143.169.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=objecting.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=objecting.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=objecting.org header.i=objecting@objecting.org header.b="mw565sRo"
ARC-Seal: i=1; a=rsa-sha256; t=1773529320; cv=none; 
	d=zohomail.eu; s=zohoarc; 
	b=hofNjx6m2qGkLiQxb7b4bsE1Q5lFr4LPd6Y9fNAnKZQnST3cqk8SEYJY2GLtKuAkzXuL6+oc0MFJw9IoWkf86lf7yvD0tQOgS7e1Ze+uuXo0bhpkHUZ4iMDYp81mv9pjf7zXkr+w2Hg7nsLcMcDYZV82KZMCrnvkSAcKvbwOaLY=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.eu; s=zohoarc; 
	t=1773529320; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=6uPcGZJB4S2oK5dndzjQXjhFV82VC8dC/GDzbh2sLGM=; 
	b=SNGImwqJvJ8m09CcX6GN7PE+KvhCMmXNIn0EjYzfI0b1UqPoAmdVKmgsujm1sOLdaX3ArFQY1Gs9ivWNdfPMnopIczWpmmx7e9L37Sj7QbWXS9NPGIySU1var5mJXUDk8g+2TOuFvSusnGHRbdfjXXhsemOkE0+QAz2s5wRO3xs=
ARC-Authentication-Results: i=1; mx.zohomail.eu;
	dkim=pass  header.i=objecting.org;
	spf=pass  smtp.mailfrom=objecting@objecting.org;
	dmarc=pass header.from=<objecting@objecting.org>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1773529320;
	s=zmail; d=objecting.org; i=objecting@objecting.org;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-Id:Message-Id:MIME-Version:Content-Type:Content-Transfer-Encoding:Reply-To;
	bh=6uPcGZJB4S2oK5dndzjQXjhFV82VC8dC/GDzbh2sLGM=;
	b=mw565sRoa4rKhcZyaUKFnc0qH5ncwiUMBaCi++7aIBCOd/qMGrkTwg+5iyD93m1G
	5cWFvgUOSIH8ErrT532hjYYp2hxUtP+rBQ58fzr5maX0Ndz9iDZ0Plh+crgnBJaHza8
	5eqvXiYrY/X97d/XMEfW9SxvfG1pHCHe/jdBeEvU=
Received: by mx.zoho.eu with SMTPS id 1773529317179341.37894701143045;
	Sun, 15 Mar 2026 00:01:57 +0100 (CET)
From: Josh Law <objecting@objecting.org>
To: Masami Hiramatsu <mhiramat@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>
Cc: linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Josh Law <objecting@objecting.org>
Subject: [PATCH v4 00/17] bootconfig: fixes, cleanups, and modernization
Date: Sat, 14 Mar 2026 23:01:38 +0000
Message-Id: <20260314230155.155777-1-objecting@objecting.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

This series addresses a collection of issues found during a review of
lib/bootconfig.c, include/linux/bootconfig.h, and tools/bootconfig,
ranging from off-by-one errors and unchecked return values to coding
style and API modernization.

Changes since v3:
  - Added commit descriptions to all patches that were missing them
    (patches 2, 3, 4, 7).
  - Added real-world impact statements to all bug-fix patches
    (patches 8, 9, 15, 16).

Changes since v2:
  - Added "validate child node index in xbc_verify_tree()" —
    xbc_verify_tree() validated next-node indices but not child indices;
    an out-of-bounds child would cause xbc_node_get_child() to access
    memory beyond the xbc_nodes array (patch 15).
  - Added "check xbc_init_node() return in override path" — the ':='
    override path in xbc_parse_kv() ignored xbc_init_node()'s return
    value, silently continuing with stale node data on failure
    (patch 16).
  - Added "fix fd leak in load_xbc_file() on fstat failure" — if
    fstat() failed after open() succeeded, the file descriptor was
    leaked (patch 17).

Changes since v1:
  - Dropped "return empty string instead of NULL from
    xbc_node_get_data()" — returning "" causes false matches in
    xbc_node_match_prefix() because strncmp(..., "", 0) always
    returns 0.

Bug fixes:
  - Fix off-by-one in xbc_verify_tree() where a next-node index equal
    to xbc_node_num passes the bounds check despite being out of range;
    a malformed bootconfig could cause an out-of-bounds read of kernel
    memory during tree traversal at boot time (patch 8).
  - Move xbc_node_num increment to after xbc_init_node() validation
    so a failed init does not leave a partially initialized node
    counted in the array; on a maximum-size bootconfig, the
    uninitialized node could be traversed leading to unpredictable
    boot behavior (patch 9).
  - Validate child node indices in xbc_verify_tree() alongside the
    existing next-node check; without this, a corrupt bootconfig could
    trigger an out-of-bounds memory access via an invalid child index
    during tree traversal (patch 15).
  - Check xbc_init_node() return value in the ':=' override path; a
    bootconfig using ':=' near the 32KB data limit could silently
    retain the old value, meaning a security-relevant boot parameter
    override would not take effect (patch 16).
  - Fix file descriptor leak in tools/bootconfig load_xbc_file()
    when fstat() fails (patch 17).

Correctness:
  - Add missing __init annotations to skip_comment() and
    skip_spaces_until_newline() so their memory can be reclaimed
    after init (patch 1).
  - Narrow the flag parameter in node creation helpers from uint32_t
    to uint16_t to match the xbc_node.data field width (patch 6).
  - Constify the xbc_calc_checksum() data parameter since it only
    reads the buffer (patch 12).

Cleanups:
  - Fix comment typos (patches 2-3), missing blank line before
    kerneldoc (patch 4), inconsistent if/else bracing (patches 5, 7).
  - Drop redundant memset after memblock_alloc which already returns
    zeroed memory; switch the userspace path from malloc to calloc
    to match (patch 10).

Modernization:
  - Replace open-coded __attribute__((__packed__)) with the __packed
    macro, adding the definition to the tools/bootconfig shim header
    (patches 11, 14).
  - Replace the catch-all linux/kernel.h include with the specific
    headers needed: linux/cache.h, linux/compiler.h, and
    linux/sprintf.h (patch 13).

Build-tested with both the in-kernel build (lib/bootconfig.o,
init/main.o) and the userspace tools/bootconfig build. All 70
tools/bootconfig test cases pass.

Josh Law (17):
  lib/bootconfig: add missing __init annotations to static helpers
  lib/bootconfig: fix typo "initiized" in xbc_root_node() kerneldoc
  lib/bootconfig: fix typo "uder" in xbc_node_find_next_leaf()
  lib/bootconfig: add blank line before xbc_get_info() kerneldoc
  lib/bootconfig: fix inconsistent if/else bracing
  lib/bootconfig: narrow flag parameter type from uint32_t to uint16_t
  lib/bootconfig: fix inconsistent if/else bracing in __xbc_add_key()
  lib/bootconfig: fix off-by-one in xbc_verify_tree() next node check
  lib/bootconfig: increment xbc_node_num after node init succeeds
  lib/bootconfig: drop redundant memset of xbc_nodes
  bootconfig: use __packed macro for struct xbc_node
  bootconfig: constify xbc_calc_checksum() data parameter
  lib/bootconfig: replace linux/kernel.h with specific includes
  bootconfig: add __packed definition to tools/bootconfig shim header
  lib/bootconfig: validate child node index in xbc_verify_tree()
  lib/bootconfig: check xbc_init_node() return in override path
  tools/bootconfig: fix fd leak in load_xbc_file() on fstat failure

 include/linux/bootconfig.h                  |  6 +--
 lib/bootconfig.c                            | 54 ++++++++++++---------
 tools/bootconfig/include/linux/bootconfig.h |  1 +
 tools/bootconfig/main.c                     |  4 +-
 4 files changed, 39 insertions(+), 26 deletions(-)

-- 
2.34.1

