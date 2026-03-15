Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A90142AA9;
	Sun, 15 Mar 2026 08:30:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773563459; cv=none; b=jYmW1Ct1u/tzegjxInAU6iKjpDDG/A8IEK2d8iZjsEOiFt+42V3M1X0m2qmM7uEwRXpBf50nI+kybW6bdZxrvApRDbtOLK3EH7QAGQ3oQXmXwB8AUkcq3Ap08JtPQ2hrsRe5vdaV0vEhx9xy+2vdxOUQAY0zHw1Bspva4WV31Dg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773563459; c=relaxed/simple;
	bh=HBCDktemkHJjhpmssHcfJFMEMqeKwjVCKh/GK+qCYjc=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=akcWMIe1CccP/EMIKDVJfxcWckGlwI6S4bPfG4GZsYIkzRmhjD7EAmDWaqrJt9DqO9w4jg5YzhyHffwPgwskYMH0nUkbIZWcfUGpXt9vuRd89oncZLslJnTdDI0BLi2FgFiYknJ+XEaI/WevNfspKgtYpLPtsBTmMMEzEuSara8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AeI5Eo/k; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AeI5Eo/k"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE144C19424;
	Sun, 15 Mar 2026 08:30:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773563459;
	bh=HBCDktemkHJjhpmssHcfJFMEMqeKwjVCKh/GK+qCYjc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=AeI5Eo/kJxxJBpexkeHTLTPx4PTc+sLyxEMxZNaYHiroItfcCRB6kl62VHsUK2bhZ
	 7vD8sZm0TQG06HK7LZDlp6pPWvruSm9qzeG+ID3Q4+f4mJ1c7cN6j2BsTWhV7Q5DEL
	 qtdB7cKxAUNjkh5rAjEJ1guXjUusJf0szrlVXiHvWGGEw+w6lLgJlr5K8DKiZPe9Ij
	 uZ/nxyQ0GZ+jtfFakVER/OM7T2UoyIRlYyTeY4R8AhJJHwFrXNVIrDF7d8tdcuY0FA
	 TGB1/wuCbjdpbKF3D8nbQB26+E6DVrfQTg7b0gOtSmr4LCk0ZUtNUnXvaVDE0GOyxm
	 CG4jfI4Bj2CZA==
Date: Sun, 15 Mar 2026 17:30:55 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Josh Law <objecting@objecting.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
 linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 00/17] bootconfig: fixes, cleanups, and modernization
Message-Id: <20260315173055.a25d5737cb3efd840fbc2b37@kernel.org>
In-Reply-To: <20260314230155.155777-1-objecting@objecting.org>
References: <20260314230155.155777-1-objecting@objecting.org>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Josh,

Thanks for cleaning up. I had some comments. Please check my reply.
Basically, I don't see any urgent bugfixes in this series. In summary;

OK for-next: [01][06][08][09][10][12][13][15]
Need Fixed taa: [16][17]
Request to fold:[02][03][04][05][07]
NACK: [11][14]

Thank you,

On Sat, 14 Mar 2026 23:01:38 +0000
Josh Law <objecting@objecting.org> wrote:

> This series addresses a collection of issues found during a review of
> lib/bootconfig.c, include/linux/bootconfig.h, and tools/bootconfig,
> ranging from off-by-one errors and unchecked return values to coding
> style and API modernization.
> 
> Changes since v3:
>   - Added commit descriptions to all patches that were missing them
>     (patches 2, 3, 4, 7).
>   - Added real-world impact statements to all bug-fix patches
>     (patches 8, 9, 15, 16).
> 
> Changes since v2:
>   - Added "validate child node index in xbc_verify_tree()" —
>     xbc_verify_tree() validated next-node indices but not child indices;
>     an out-of-bounds child would cause xbc_node_get_child() to access
>     memory beyond the xbc_nodes array (patch 15).
>   - Added "check xbc_init_node() return in override path" — the ':='
>     override path in xbc_parse_kv() ignored xbc_init_node()'s return
>     value, silently continuing with stale node data on failure
>     (patch 16).
>   - Added "fix fd leak in load_xbc_file() on fstat failure" — if
>     fstat() failed after open() succeeded, the file descriptor was
>     leaked (patch 17).
> 
> Changes since v1:
>   - Dropped "return empty string instead of NULL from
>     xbc_node_get_data()" — returning "" causes false matches in
>     xbc_node_match_prefix() because strncmp(..., "", 0) always
>     returns 0.
> 
> Bug fixes:
>   - Fix off-by-one in xbc_verify_tree() where a next-node index equal
>     to xbc_node_num passes the bounds check despite being out of range;
>     a malformed bootconfig could cause an out-of-bounds read of kernel
>     memory during tree traversal at boot time (patch 8).
>   - Move xbc_node_num increment to after xbc_init_node() validation
>     so a failed init does not leave a partially initialized node
>     counted in the array; on a maximum-size bootconfig, the
>     uninitialized node could be traversed leading to unpredictable
>     boot behavior (patch 9).
>   - Validate child node indices in xbc_verify_tree() alongside the
>     existing next-node check; without this, a corrupt bootconfig could
>     trigger an out-of-bounds memory access via an invalid child index
>     during tree traversal (patch 15).
>   - Check xbc_init_node() return value in the ':=' override path; a
>     bootconfig using ':=' near the 32KB data limit could silently
>     retain the old value, meaning a security-relevant boot parameter
>     override would not take effect (patch 16).
>   - Fix file descriptor leak in tools/bootconfig load_xbc_file()
>     when fstat() fails (patch 17).
> 
> Correctness:
>   - Add missing __init annotations to skip_comment() and
>     skip_spaces_until_newline() so their memory can be reclaimed
>     after init (patch 1).
>   - Narrow the flag parameter in node creation helpers from uint32_t
>     to uint16_t to match the xbc_node.data field width (patch 6).
>   - Constify the xbc_calc_checksum() data parameter since it only
>     reads the buffer (patch 12).
> 
> Cleanups:
>   - Fix comment typos (patches 2-3), missing blank line before
>     kerneldoc (patch 4), inconsistent if/else bracing (patches 5, 7).
>   - Drop redundant memset after memblock_alloc which already returns
>     zeroed memory; switch the userspace path from malloc to calloc
>     to match (patch 10).
> 
> Modernization:
>   - Replace open-coded __attribute__((__packed__)) with the __packed
>     macro, adding the definition to the tools/bootconfig shim header
>     (patches 11, 14).
>   - Replace the catch-all linux/kernel.h include with the specific
>     headers needed: linux/cache.h, linux/compiler.h, and
>     linux/sprintf.h (patch 13).
> 
> Build-tested with both the in-kernel build (lib/bootconfig.o,
> init/main.o) and the userspace tools/bootconfig build. All 70
> tools/bootconfig test cases pass.
> 
> Josh Law (17):
>   lib/bootconfig: add missing __init annotations to static helpers
>   lib/bootconfig: fix typo "initiized" in xbc_root_node() kerneldoc
>   lib/bootconfig: fix typo "uder" in xbc_node_find_next_leaf()
>   lib/bootconfig: add blank line before xbc_get_info() kerneldoc
>   lib/bootconfig: fix inconsistent if/else bracing
>   lib/bootconfig: narrow flag parameter type from uint32_t to uint16_t
>   lib/bootconfig: fix inconsistent if/else bracing in __xbc_add_key()
>   lib/bootconfig: fix off-by-one in xbc_verify_tree() next node check
>   lib/bootconfig: increment xbc_node_num after node init succeeds
>   lib/bootconfig: drop redundant memset of xbc_nodes
>   bootconfig: use __packed macro for struct xbc_node
>   bootconfig: constify xbc_calc_checksum() data parameter
>   lib/bootconfig: replace linux/kernel.h with specific includes
>   bootconfig: add __packed definition to tools/bootconfig shim header
>   lib/bootconfig: validate child node index in xbc_verify_tree()
>   lib/bootconfig: check xbc_init_node() return in override path
>   tools/bootconfig: fix fd leak in load_xbc_file() on fstat failure
> 
>  include/linux/bootconfig.h                  |  6 +--
>  lib/bootconfig.c                            | 54 ++++++++++++---------
>  tools/bootconfig/include/linux/bootconfig.h |  1 +
>  tools/bootconfig/main.c                     |  4 +-
>  4 files changed, 39 insertions(+), 26 deletions(-)
> 
> -- 
> 2.34.1
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
