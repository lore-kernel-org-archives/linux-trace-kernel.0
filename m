Received: from sender-of-o57.zoho.eu (sender-of-o57.zoho.eu [136.143.169.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA3AF19E7F7;
	Sun, 15 Mar 2026 12:20:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.169.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773577229; cv=pass; b=Y3HhfSoCi4YgIFnZh91/VpILJHDm1YSPdyldOt46cehupuWll7OA4F+7NvvXeKU0Ov05CQGqK/AwWEgJt7lXE/e+GxJ/jtQcrm7xmjj1EZ3+IxEsnWTL9aan10wrK1tUbXHlumq42DjUxRC2GjImEl8/2HAP9H29iKqNx7UBjJ4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773577229; c=relaxed/simple;
	bh=DFtsWXhu7WY2Q60SMdFq/s+h1uNuJCnaKyoXh112Wmo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=NNnK/IZJxXVyR3rAFupuCl/Lyi76mks96dJbv6quA4gh+xh79ZYfo0ik1F3PY/UOAnALhTH8ZW/xVvSeW7A9GM1zL/7Vqm+Djbs/ib50NwTfgUi1G8GECTiCOXg8EgICChwN1EETULoRgZUcp36WD4lJz/PqV0+weYyGy/t7Geo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=objecting.org; spf=pass smtp.mailfrom=objecting.org; dkim=pass (1024-bit key) header.d=objecting.org header.i=objecting@objecting.org header.b=kV6P52eo; arc=pass smtp.client-ip=136.143.169.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=objecting.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=objecting.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=objecting.org header.i=objecting@objecting.org header.b="kV6P52eo"
ARC-Seal: i=1; a=rsa-sha256; t=1773577218; cv=none; 
	d=zohomail.eu; s=zohoarc; 
	b=YRTjhBMy1gqitu2SABG4zKJ0Yfk+oRiwk568TG4LUECE8unkBDx4ekCfF4dEPJ/zfxsiYA2e0Yu2eIRGFGB145HlgUQDpJeFauSc6K3grcHJVslf8GohBKI15Z1ppx6GzVIApqem2oWrUTyYFCXfcL+JlWJbYGY0oPXL9cRfMHk=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.eu; s=zohoarc; 
	t=1773577218; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=Hgc3AIMs3c6N3nC5UsfZXg5P+TWd80IV0wUDCID9vTo=; 
	b=h3+AsYC4epo/Eom4HVJi9Q6R9aLjsp4oXjr9r4E/G9kC3nbRDTC2n4i5WNe2U1BZJsfpDDIdEOPvtpWT6deZSB9zrI9O9JaAY3syMNUFMfUAvij1MbK4SgxWKJ5izn8MBAP2dU9BLueWPjrHl5lKndEq43xW4BOKO6Wd5pYOXyk=
ARC-Authentication-Results: i=1; mx.zohomail.eu;
	dkim=pass  header.i=objecting.org;
	spf=pass  smtp.mailfrom=objecting@objecting.org;
	dmarc=pass header.from=<objecting@objecting.org>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1773577218;
	s=zmail; d=objecting.org; i=objecting@objecting.org;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-Id:Message-Id:MIME-Version:Content-Transfer-Encoding:Reply-To;
	bh=Hgc3AIMs3c6N3nC5UsfZXg5P+TWd80IV0wUDCID9vTo=;
	b=kV6P52eo/YhtNHM611lhUpmfJH3mBZLFHbjNW0gUTEArl69KDRXCn8TZry4qi1PL
	4CyXaV3xWMWEfz71K/5oZEStl37lIr0Mq4Lk0Nqk8lVMIjEUxYoG7qtcMMAO3ZWU7/f
	eqbkheYfH7fV5569qPw+uOGZv8qC5g4mGleNTcpo=
Received: by mx.zoho.eu with SMTPS id 1773577216436183.08431296575372;
	Sun, 15 Mar 2026 13:20:16 +0100 (CET)
From: Josh Law <objecting@objecting.org>
To: Masami Hiramatsu <mhiramat@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>
Cc: Steven Rostedt <rostedt@goodmis.org>,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	Josh Law <objecting@objecting.org>
Subject: [PATCH v6 00/17] bootconfig: fixes, cleanups, and modernization
Date: Sun, 15 Mar 2026 12:19:58 +0000
Message-Id: <20260315122015.55965-1-objecting@objecting.org>
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
ranging from off-by-one errors and unchecked return values to coding
style, signedness/type cleanup, and API modernization.

Changes since v5:
  - Folded typo fixes, kerneldoc blank line, and inconsistent bracing
    patches (v5 02-05, 07) into a single patch (patch 2).
  - Dropped "use __packed macro for struct xbc_node" (v5 11) and
    "add __packed definition to tools/bootconfig shim header" (v5 14)
    per review feedback.
  - Added Fixes: tag to "check xbc_init_node() return in override
    path" (patch 10).
  - Added Fixes: tag to "fix fd leak in load_xbc_file() on fstat
    failure" (patch 11).

Changes since v4:
  - Added six follow-up patches found via static analysis with strict
    GCC warnings (patches 12-17).
  - Added "fix signed comparison in xbc_node_get_data()" -- switch the
    masked offset variable to unsigned int and compare against
    XBC_DATA_MAX to avoid a signed comparison and make the mask
    self-documenting (patch 12).
  - Added "use size_t for strlen result in xbc_node_match_prefix()"
    and "use size_t for key length tracking in xbc_verify_tree()" to
    match strlen() return types (patches 13, 15).
  - Added "narrow offset type in xbc_init_node()" -- use a validated
    unsigned int temporary for the stored 15-bit data offset
    (patch 14).
  - Added "fix sign-compare in xbc_node_compose_key_after()" -- cast
    the checked snprintf() return when comparing and subtracting
    against a size_t buffer length (patch 16).
  - Added "change xbc_node_index() return type to uint16_t" -- match
    the 16-bit storage fields and XBC_NODE_MAX bounds (patch 17).

Changes since v3:
  - Added commit descriptions to all patches that were missing them.
  - Added real-world impact statements to all bug-fix patches.

Changes since v2:
  - Added "validate child node index in xbc_verify_tree()" (patch 9).
  - Added "check xbc_init_node() return in override path" (patch 10).
  - Added "fix fd leak in load_xbc_file() on fstat failure" (patch 11).

Changes since v1:
  - Dropped "return empty string instead of NULL from
    xbc_node_get_data()" -- returning "" causes false matches in
    xbc_node_match_prefix() because strncmp(..., "", 0) always
    returns 0.

Bug fixes:
  - Fix off-by-one in xbc_verify_tree() where a next-node index equal
    to xbc_node_num passes the bounds check despite being out of range;
    a malformed bootconfig could cause an out-of-bounds read of kernel
    memory during tree traversal at boot time (patch 4).
  - Move xbc_node_num increment to after xbc_init_node() validation
    so a failed init does not leave a partially initialized node
    counted in the array; on a maximum-size bootconfig, the
    uninitialized node could be traversed leading to unpredictable
    boot behavior (patch 5).
  - Validate child node indices in xbc_verify_tree() alongside the
    existing next-node check; without this, a corrupt bootconfig could
    trigger an out-of-bounds memory access via an invalid child index
    during tree traversal (patch 9).
  - Check xbc_init_node() return value in the ':=' override path; a
    bootconfig using ':=' near the 32KB data limit could silently
    retain the old value, meaning a security-relevant boot parameter
    override would not take effect (patch 10).
  - Fix file descriptor leak in tools/bootconfig load_xbc_file()
    when fstat() fails (patch 11).

Correctness:
  - Add missing __init annotations to skip_comment() and
    skip_spaces_until_newline() so their memory can be reclaimed
    after init (patch 1).
  - Narrow the flag parameter in node creation helpers from uint32_t
    to uint16_t to match the xbc_node.data field width (patch 3).
  - Constify the xbc_calc_checksum() data parameter since it only
    reads the buffer (patch 7).
  - Fix strict-GCC signedness and narrowing warnings by aligning local
    types with strlen()/snprintf() APIs and the 16-bit node index/data
    storage in xbc_node_get_data(), xbc_node_match_prefix(),
    xbc_init_node(), xbc_verify_tree(), xbc_node_compose_key_after(),
    and xbc_node_index() (patches 12-17).

Cleanups:
  - Fix comment typos, missing blank line before kerneldoc,
    inconsistent if/else bracing (patch 2).
  - Drop redundant memset after memblock_alloc which already returns
    zeroed memory; switch the userspace path from malloc to calloc
    to match (patch 6).

Modernization:
  - Replace the catch-all linux/kernel.h include with the specific
    headers needed: linux/cache.h, linux/compiler.h, and
    linux/sprintf.h (patch 8).

Build-tested with both the in-kernel build (lib/bootconfig.o,
init/main.o) and the userspace tools/bootconfig build. All 70
tools/bootconfig test cases pass.

Josh Law (17):
  lib/bootconfig: add missing __init annotations to static helpers
  lib/bootconfig: fix typos, kerneldoc, and inconsistent if/else bracing
  lib/bootconfig: narrow flag parameter type from uint32_t to uint16_t
  lib/bootconfig: fix off-by-one in xbc_verify_tree() next node check
  lib/bootconfig: increment xbc_node_num after node init succeeds
  lib/bootconfig: drop redundant memset of xbc_nodes
  bootconfig: constify xbc_calc_checksum() data parameter
  lib/bootconfig: replace linux/kernel.h with specific includes
  lib/bootconfig: validate child node index in xbc_verify_tree()
  lib/bootconfig: check xbc_init_node() return in override path
  tools/bootconfig: fix fd leak in load_xbc_file() on fstat failure
  lib/bootconfig: fix signed comparison in xbc_node_get_data()
  lib/bootconfig: use size_t for strlen result in
    xbc_node_match_prefix()
  lib/bootconfig: narrow offset type in xbc_init_node()
  lib/bootconfig: use size_t for key length tracking in
    xbc_verify_tree()
  lib/bootconfig: fix sign-compare in xbc_node_compose_key_after()
  lib/bootconfig: change xbc_node_index() return type to uint16_t

 include/linux/bootconfig.h |  6 ++--
 lib/bootconfig.c           | 71 ++++++++++++++++++++++----------------
 tools/bootconfig/main.c    |  4 ++-
 3 files changed, 47 insertions(+), 34 deletions(-)

-- 
2.34.1

