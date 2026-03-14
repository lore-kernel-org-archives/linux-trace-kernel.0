Received: from sender-of-o55.zoho.eu (sender-of-o55.zoho.eu [136.143.169.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 469473845D9;
	Sat, 14 Mar 2026 21:55:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.169.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773525337; cv=pass; b=oX+xrz7LIXKZ4m7G/vgNbUss76agArPhgDRI8qM/ORKlehTK2w5j5B5U4pvzj4xtVw+fT0qvRpXURoPOZQ1xwhp8LibUcItiqR691IIniDdfGBkKD+v3PcJIJXxbe/q1XvQDncT/V+pLsVXBoQU3c40pibF4V8ef9UXueLmKG4E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773525337; c=relaxed/simple;
	bh=Q45iq/wxF1Dnl6QhLSIHVxE6eD2VVajMxPU16AzBfNc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=bQgNoyu06wzOtiVl38K3nHF6bBUoICg78FHULYl/yMuPpu9p0E16FJ62b3jgfy6diqwzGthL1D8zqlqwVFzJRLhFnk9sD0PRiTE4wyWc3352+aG6QT1tfths0RC1Idpt33YAff3PTITaYQzdq39IBmhaEwFBV6k5JC2AuCMZQtA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=objecting.org; spf=pass smtp.mailfrom=objecting.org; dkim=pass (1024-bit key) header.d=objecting.org header.i=objecting@objecting.org header.b=TVE2dAkK; arc=pass smtp.client-ip=136.143.169.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=objecting.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=objecting.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=objecting.org header.i=objecting@objecting.org header.b="TVE2dAkK"
ARC-Seal: i=1; a=rsa-sha256; t=1773525329; cv=none; 
	d=zohomail.eu; s=zohoarc; 
	b=go7iUpxc8K1hsgT+jKcZQi33InXIQ7ad5sS4ajN8kySidVZEZrfjTxy160Gg1ePUe4cTzSGPkrRPpE2Zj22MMyD+hoQf5xVhJQbZIYFldfVTHKbvKvigU/JrkLjgGr3BaPz2kb7gcWcYxo3iGOcrb+Re0Ym8qZ6NZZFcJYqmJz4=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.eu; s=zohoarc; 
	t=1773525329; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=2uTxDXblaPLqr75f1B+ZMH4X1jJ/D2HQ4R6nxbYYTqw=; 
	b=Tq1DP1EMycG1TLpUUiGlTnimmOeGZLXva0kZz7mvBwZiMZmn/vLdcfeZupmghdP8px1ftPbI8pcMVvBU3Y8C3KzU7qC5Fa5PV47+c5Ek7nE5jOUn0pxPoZI7nTESC3whQgdCWbMVA61jZleUUVGpwN5jQOCmsxu4KlGH2e+fxng=
ARC-Authentication-Results: i=1; mx.zohomail.eu;
	dkim=pass  header.i=objecting.org;
	spf=pass  smtp.mailfrom=objecting@objecting.org;
	dmarc=pass header.from=<objecting@objecting.org>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1773525329;
	s=zmail; d=objecting.org; i=objecting@objecting.org;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-Id:Message-Id:MIME-Version:Content-Type:Content-Transfer-Encoding:Reply-To;
	bh=2uTxDXblaPLqr75f1B+ZMH4X1jJ/D2HQ4R6nxbYYTqw=;
	b=TVE2dAkKk4xDpgkbiuV51765e6+00/QeKQbrGoZc9w3fQKmSGUJCSBghqjc+nIeX
	nnzDNIjJsFxOnLjwecqbo6irteAfXnFDWhoQ9kksydnCO3d8HyzViqYn77nOGLyF/jS
	6TFmkkInGdEvt2YJmLnmgZfNNDFxIgtfsOWMXIaQ=
Received: by mx.zoho.eu with SMTPS id 1773525327480446.2996912539701;
	Sat, 14 Mar 2026 22:55:27 +0100 (CET)
From: Josh Law <objecting@objecting.org>
To: Masami Hiramatsu <mhiramat@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>
Cc: linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Josh Law <objecting@objecting.org>
Subject: [PATCH v2 00/14] bootconfig: fixes, cleanups, and modernization
Date: Sat, 14 Mar 2026 21:55:12 +0000
Message-Id: <20260314215526.108651-1-objecting@objecting.org>
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
lib/bootconfig.c and include/linux/bootconfig.h, ranging from an
off-by-one in a bounds check to coding style and API modernization.

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

Josh Law (14):
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

 include/linux/bootconfig.h                  |  6 +--
 lib/bootconfig.c                            | 47 ++++++++++++---------
 tools/bootconfig/include/linux/bootconfig.h |  1 +
 3 files changed, 30 insertions(+), 24 deletions(-)

--
2.34.1

