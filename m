Received: from sender-of-o55.zoho.eu (sender-of-o55.zoho.eu [136.143.169.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEEFC2F6160;
	Tue, 17 Mar 2026 16:09:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.169.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773763783; cv=pass; b=o3bcbPXIiAWgjz5u6DK69jl2td/NRQVRnU4X+yGx9pvtWCXvJJS+oQN9rlBS1C9Yy6vCt4KX/9pSHrCl4zW+E3gN0bifA+zMKMK7sPZA+APcc4frDtPaWBabJUIOyvMLg5i2GEMiHnIwl41YOONGYmbZO8a/VO6GBzPqAm9x2P8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773763783; c=relaxed/simple;
	bh=ePggypmd+yKvuDWT97gJ/gVPmGcHwVUfPihqUjlTzZI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=q+i6X3yvAu94QVPSpnR7U5Er8s9n0f142gQKqYbDdGcNAjXQIlQDSXpQCcyyG4U9YEwFCh5omRoDnFXq6OA8IrXUGOG0pDWRHSb1UJEMLwlO7Kcq3LHnCdj/X3kzdqzyu69/zV/4dRwuyKnGfu/RSmvdLZlwqWp66KY7f6EkpF8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=objecting.org; spf=pass smtp.mailfrom=objecting.org; dkim=pass (1024-bit key) header.d=objecting.org header.i=objecting@objecting.org header.b=B/Y4fhHp; arc=pass smtp.client-ip=136.143.169.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=objecting.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=objecting.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=objecting.org header.i=objecting@objecting.org header.b="B/Y4fhHp"
ARC-Seal: i=1; a=rsa-sha256; t=1773763759; cv=none; 
	d=zohomail.eu; s=zohoarc; 
	b=BaxWRJf+6FHFhs42+8px58VkjgN3/h33r7uRrVgaqi7vVRG4aLMgFG15LY6peK/9ev88mA+3thiFS208mNhZDTY9alcSF44q2wzbcjCQsjYVV+Y8OQsfIl1d9ijOW+iQoBmNZnjWxQ/l5B62LuCfq6OwnBeUtlA72WsFNfo4ftA=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.eu; s=zohoarc; 
	t=1773763759; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=CPbGub9zpXdv6d8uzZoVaxPJqT2C4RduifFngtCq08k=; 
	b=HYEuMBftF45GmmFpegODWrQxrg7xCjOOW3XQnpmCZEhfp9NfVR/Ht3D5xeoz4qoLFX1RWG9eHjBmfP4H8FzPMB37HaRODB100HGkgIlHLcm5LHUQo+MN0WCgH00SHKyANZbFSo/tQSYi7K8KCIA9rBuMCxDFBJSlOEesJNLnzbQ=
ARC-Authentication-Results: i=1; mx.zohomail.eu;
	dkim=pass  header.i=objecting.org;
	spf=pass  smtp.mailfrom=objecting@objecting.org;
	dmarc=pass header.from=<objecting@objecting.org>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1773763759;
	s=zmail; d=objecting.org; i=objecting@objecting.org;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-Id:Message-Id:MIME-Version:Content-Transfer-Encoding:Reply-To;
	bh=CPbGub9zpXdv6d8uzZoVaxPJqT2C4RduifFngtCq08k=;
	b=B/Y4fhHp4Dy9V7njN7iE8ueyDvhdCiayfIMBZPsqroRUFj96m+d7p0c7HOrqhPrW
	xmWY67oOq7R5F6DkN29swt2Z7JrMVEFJU9v1oVPe9D8OjdTM4984zZXAXnn3fFXBUoH
	y6tfYIQbMfzd8Dti2W+YE6BRhx0EOQwGpST8r+So=
Received: by mx.zoho.eu with SMTPS id 1773763757578365.13658509170693;
	Tue, 17 Mar 2026 17:09:17 +0100 (CET)
From: Josh Law <objecting@objecting.org>
To: Masami Hiramatsu <mhiramat@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>
Cc: Steven Rostedt <rostedt@goodmis.org>,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH v7 00/15] bootconfig: fixes, cleanups, and modernization
Date: Tue, 17 Mar 2026 16:09:01 +0000
Message-Id: <20260317160916.33576-1-objecting@objecting.org>
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

Changes since v6:
  - Dropped "add missing __init annotations to static helpers"
    (v6 patch 1).
  - Dropped "fix sign-compare in xbc_node_compose_key_after()"
    (v6 patch 16).
  - Updated "fix fd leak in load_xbc_file() on fstat failure" to save
    errno before close(), since close() may overwrite it before the
    error is returned (patch 10).
  - Updated "fix signed comparison in xbc_node_get_data()" to use
    size_t for the local offset variable, matching the warning and
    xbc_data_size (patch 11).
  - Updated "use signed type for offset in xbc_init_node()" to use a
    signed long and explicitly check offset < 0 in WARN_ON(), making
    the pre-base pointer case explicit instead of relying on unsigned
    wraparound (patch 13).

Changes since v5:
  - Folded typo fixes, kerneldoc blank line, and inconsistent bracing
    patches (v5 02-05, 07) into a single patch (patch 1).
  - Dropped "use __packed macro for struct xbc_node" (v5 11) and
    "add __packed definition to tools/bootconfig shim header" (v5 14)
    per review feedback.
  - Added Fixes: tag to "check xbc_init_node() return in override
    path" (patch 9).
  - Added Fixes: tag to "fix fd leak in load_xbc_file() on fstat
    failure" (patch 10).

Changes since v4:
  - Added six follow-up patches found via static analysis with strict
    GCC warnings (patches 11-15, plus the now-dropped v6 patch 16).
  - Added "fix signed comparison in xbc_node_get_data()" to match the
    local offset type to xbc_data_size and eliminate the sign-compare
    warning (patch 11).
  - Added "use size_t for strlen result in xbc_node_match_prefix()"
    and "use size_t for key length tracking in xbc_verify_tree()" to
    match strlen() return types (patches 12, 14).
  - Added "use signed type for offset in xbc_init_node()" to make the
    offset bounds check explicit and avoid sign-conversion warnings
    from pointer subtraction (patch 13).
  - Added "change xbc_node_index() return type to uint16_t" to match
    the 16-bit storage fields and XBC_NODE_MAX bounds (patch 15).

Changes since v3:
  - Added commit descriptions to all patches that were missing them.
  - Added real-world impact statements to all bug-fix patches.

Changes since v2:
  - Added "validate child node index in xbc_verify_tree()" (patch 8).
  - Added "check xbc_init_node() return in override path" (patch 9).
  - Added "fix fd leak in load_xbc_file() on fstat failure" (patch 10).

Changes since v1:
  - Dropped "return empty string instead of NULL from
    xbc_node_get_data()" -- returning "" causes false matches in
    xbc_node_match_prefix() because strncmp(..., "", 0) always
    returns 0.

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
  - Check xbc_init_node() return value in the ':=' override path; a
    bootconfig using ':=' near the 32KB data limit could silently
    retain the old value, meaning a security-relevant boot parameter
    override would not take effect (patch 9).
  - Fix file descriptor leak in tools/bootconfig load_xbc_file() when
    fstat() fails, and preserve errno across close() on that error path
    (patch 10).

Correctness:
  - Narrow the flag parameter in node creation helpers from uint32_t to
    uint16_t to match the xbc_node.data field width (patch 2).
  - Constify the xbc_calc_checksum() data parameter since it only reads
    the buffer (patch 6).
  - Fix strict-GCC signedness and narrowing warnings by aligning local
    types with strlen() APIs and the node index/data storage in
    xbc_node_get_data(), xbc_node_match_prefix(), xbc_init_node(),
    xbc_verify_tree(), and xbc_node_index() (patches 11-15).

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

Josh Law (15):
  lib/bootconfig: clean up comment typos and bracing
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
  lib/bootconfig: use signed type for offset in xbc_init_node()
  lib/bootconfig: use size_t for key length tracking in
    xbc_verify_tree()
  lib/bootconfig: change xbc_node_index() return type to uint16_t

 include/linux/bootconfig.h |  6 ++--
 lib/bootconfig.c           | 65 ++++++++++++++++++++++----------------
 tools/bootconfig/main.c    |  7 ++--
 3 files changed, 46 insertions(+), 32 deletions(-)

-- 
2.34.1
