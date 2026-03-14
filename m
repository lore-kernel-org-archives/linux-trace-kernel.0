Received: from sender-of-o55.zoho.eu (sender-of-o55.zoho.eu [136.143.169.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2E53823DD;
	Sat, 14 Mar 2026 22:34:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.169.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773527677; cv=pass; b=FkkvZ6IH8Hk4efxxRserdxZmhT3KpNo+SPYqm3Yt+elRqRSH7Sz0I79h/bTJYDWd/Lf+vLnxI5zgd1B0HRQgJjuf3uNeGJ0tbCbQXGicB9PxIKof0e/bkQ6Ty228ihvpdNYIiBe74Qk5FfzEqJR7yd0jxgfd1Xv8n9r55XaD8/k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773527677; c=relaxed/simple;
	bh=3/m1ShXVA5apgwAVMqjB/Ax2w6Am4cEUVJgVZGKYRb8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=qCIDHpJQjTcrzCGy8mhybuNxc0MO2GogNhdxqfUDtuLXa/6BO/yJfuRlFi7X6QQVZg+ZeRJDq3JiTpxugqUf/fcUMY57Fe4z9qkfDZytUb9/BDcshjS31QvMZs7H9Ac56ahBDabXdhlOptCnQLM6Gq6nmcZR2iE9EYjJpAU8J34=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=objecting.org; spf=pass smtp.mailfrom=objecting.org; dkim=pass (1024-bit key) header.d=objecting.org header.i=objecting@objecting.org header.b=Y+TZlvi/; arc=pass smtp.client-ip=136.143.169.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=objecting.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=objecting.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=objecting.org header.i=objecting@objecting.org header.b="Y+TZlvi/"
ARC-Seal: i=1; a=rsa-sha256; t=1773527668; cv=none; 
	d=zohomail.eu; s=zohoarc; 
	b=iqj4oE+mgkakQyePQRc0drDFfXLJd1NNeffIJUy3rBBVSVtIunmha6AH/LDjR3zvG9DxO1Shcnt4NSZ+oTD0drR5PwZx/LlRjECHYg4UL1CFoePdSeZIKzRqo/AAgsczDurtciR9O3rCrcP7txkGUOKutB17a8GEVghxEL1Q8VM=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.eu; s=zohoarc; 
	t=1773527668; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=qr1+MLV5eMkzgWdhIUzIGQg/+Of48nbrAs0Er7fk5/M=; 
	b=ZI0Q19/Oow1Gdt3qIisYWdsmtnNnjSCygydwIG69cNFnq4I7vVuVQiSpxGhYSVfag5arH2eX9BYE3NKRpB8ZM+Y23emqtFv4kB/pviC+y8NXm9hyV7BjNyBJ750rD758UPtEIrTJJSPysL8SJa2EuQ9jGu73RK8W4761nFUNtgI=
ARC-Authentication-Results: i=1; mx.zohomail.eu;
	dkim=pass  header.i=objecting.org;
	spf=pass  smtp.mailfrom=objecting@objecting.org;
	dmarc=pass header.from=<objecting@objecting.org>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1773527668;
	s=zmail; d=objecting.org; i=objecting@objecting.org;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-Id:Message-Id:MIME-Version:Content-Type:Content-Transfer-Encoding:Reply-To;
	bh=qr1+MLV5eMkzgWdhIUzIGQg/+Of48nbrAs0Er7fk5/M=;
	b=Y+TZlvi/3V1683auutc0D5W3Lvkv2xhe9sBDcyOn7+1PBxNJfM7GpKl3SPkd12Bh
	tHBf575Wb8NrJVCmuG5Hv7vpi6XgPv/bpa7BRX4e9+VFj6uKQP9UklGRQoeUVlZmxlA
	8obyNlBE2LVzHeJMnnfPvI7W06AiU8cM8MqrBGJA=
Received: by mx.zoho.eu with SMTPS id 1773527666230613.518836350212;
	Sat, 14 Mar 2026 23:34:26 +0100 (CET)
From: Josh Law <objecting@objecting.org>
To: Masami Hiramatsu <mhiramat@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>
Cc: linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Josh Law <objecting@objecting.org>
Subject: [PATCH v3 00/17] bootconfig: fixes, cleanups, and modernization
Date: Sat, 14 Mar 2026 22:34:08 +0000
Message-Id: <20260314223425.142966-1-objecting@objecting.org>
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
    to xbc_node_num passes the bounds check despite being out of range
    (patch 8).
  - Move xbc_node_num increment to after xbc_init_node() validation
    so a failed init does not leave a partially initialized node
    counted in the array (patch 9).
  - Validate child node indices in xbc_verify_tree() alongside the
    existing next-node check (patch 15).
  - Check xbc_init_node() return value in the ':=' override path
    to avoid silently continuing with stale data (patch 16).
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

