Received: from sender-of-o55.zoho.eu (sender-of-o55.zoho.eu [136.143.169.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82D11381B15;
	Sat, 14 Mar 2026 21:46:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.169.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773524774; cv=pass; b=SJFbRB435vmzexetHch5cb6FVvazQPTuQFEPqoKF7qeT36vqtdEfEcviA7+gcCwELHAZpYp1r1pn+dPkQQ3MMF41OBKTn68WZjzaU1W8TmF1Yq2W5ItARmld8QDIN9CR5DKUl0CG0QCwBdCPTM1J/5thzv5rPH/GnMEgh/Yk+94=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773524774; c=relaxed/simple;
	bh=Dm8oB16a9fBGqZeef8wOJ/vBDz4RlP6QASJ4ms1+9+w=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ArYjWjAXRvJ1Gg9OgUDV1x16HIscd/IXGmLMgjC04+CNrViQ2oxZHhUjoU865rCuvMJRXJhv317awacuc3a5Yhg2m/wqF3ZpqJ+OOTBBvlBuKm+qnCjU0c0mzBC0AZEjXGNsdLYBfTK5DTkESmMV15NmLAprXXiUxLrKMUPXmIM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=objecting.org; spf=pass smtp.mailfrom=objecting.org; dkim=pass (1024-bit key) header.d=objecting.org header.i=objecting@objecting.org header.b=CHeE9808; arc=pass smtp.client-ip=136.143.169.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=objecting.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=objecting.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=objecting.org header.i=objecting@objecting.org header.b="CHeE9808"
ARC-Seal: i=1; a=rsa-sha256; t=1773524759; cv=none; 
	d=zohomail.eu; s=zohoarc; 
	b=H0oR6PTb9FdcBv6zKNgd6JqooZ/5/D5fEyH95ZyWLS7NIzwlD3Pz/zm1qjDzFO+IHETEQyc5L9lcpmk3ZBv1swkUoXCtSkORkVRDo/lemUfKrQ1Quvn13TuTSunACVVvonZyBn18QCGtpgHue9AdLiFvQ5jN0RisFD8lKnqX1uo=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.eu; s=zohoarc; 
	t=1773524759; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=3L14l4PR5mVlwoQQu1qK6JgTf7yJ2ZOHoK2SSHmJDOk=; 
	b=jBSex0Xb+h3XlYbKOPe5pLfzwlnEHsNU8qlaxnybG+497ytGYbLNFHnW6ijSP5BaKATj/YFiw6bZCX0ugaK0nD1OCsJ7EjjYFJ6ODbBPW51o8vI+BM5fwTOJ0Fd9s6te3rNlwarunpqgYC5ezxVJA9usBexsywUTD6+KZ6lAeEo=
ARC-Authentication-Results: i=1; mx.zohomail.eu;
	dkim=pass  header.i=objecting.org;
	spf=pass  smtp.mailfrom=objecting@objecting.org;
	dmarc=pass header.from=<objecting@objecting.org>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1773524759;
	s=zmail; d=objecting.org; i=objecting@objecting.org;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-Id:Message-Id:MIME-Version:Content-Transfer-Encoding:Reply-To;
	bh=3L14l4PR5mVlwoQQu1qK6JgTf7yJ2ZOHoK2SSHmJDOk=;
	b=CHeE9808aUZV9vt4AuDB9Ri0qZJBYoNI+XDvCECWGLqHvy91C3xtb0r8cgXD+vid
	j0VNfpkmGEfyIDKo1E/SXJIIVUm6YtvjXBuc5t7gDzutpxgZ+8+NxrNNwTOtHItFBlG
	WvOar+IddUiLIdvB22fcfIqqo26hTXvS+145oYDU=
Received: by mx.zoho.eu with SMTPS id 1773524757160616.1572655479313;
	Sat, 14 Mar 2026 22:45:57 +0100 (CET)
From: Josh Law <objecting@objecting.org>
To: Masami Hiramatsu <mhiramat@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>
Cc: linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Josh Law <objecting@objecting.org>
Subject: [PATCH 00/15] bootconfig: fixes, cleanups, and modernization
Date: Sat, 14 Mar 2026 21:45:40 +0000
Message-Id: <20260314214555.96217-1-objecting@objecting.org>
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
lib/bootconfig.c and include/linux/bootconfig.h, ranging from a
potential crash to coding style and API modernization.

Bug fixes:
  - Fix off-by-one in xbc_verify_tree() where a next-node index equal
    to xbc_node_num passes the bounds check despite being out of range
    (patch 8).
  - Fix xbc_node_get_data() returning NULL on WARN_ON, which causes
    NULL dereferences in callers that pass the result to strlen() or
    strcmp() without checking. Return an empty string instead so the
    WARN_ON remains non-fatal as intended (patch 15).
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

Josh Law (15):
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
  lib/bootconfig: return empty string instead of NULL from
    xbc_node_get_data()

 include/linux/bootconfig.h                  |  6 +--
 lib/bootconfig.c                            | 51 +++++++++++----------
 tools/bootconfig/include/linux/bootconfig.h |  1 +
 3 files changed, 32 insertions(+), 26 deletions(-)

--
2.34.1

