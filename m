Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1F2F1ADC7E;
	Wed, 18 Mar 2026 15:34:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773848072; cv=none; b=TjMafT8DWlm7xyOSYkWDjsvXnDdwBBGTe8KVpUM5EH9ls3u6WlrVwoVSlH63FolJn5yH0XUShbxW6YWuLNeso3Gn8Xyx0A90CYv/gGlqbXCf1GIy414EmyTm2mF8inOMgptAIVfx78C1bGtfZNaCSOPzVuDwToAAwlJXkoTgGXs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773848072; c=relaxed/simple;
	bh=rVTlQefuITADyaNzM6aWO6QlSclDkSmr0Z77CkSpP3c=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=AZhWQBbJb2vL27RGapB4dag3O/5t8Cx7kxPnOoZq6jVNXKkL2MWYcrMYZh2ca2swK3zFxQM/CrP7J+lM2XUYcNaZj6Cyla6A6FgfYjaFVhVerS9ZbZjmmUaGgLKHWc+7/aKIsVSG9S0RZlEF0uTEjLILgZi925puBlplsLsOpis=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c0hlX6S8; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c0hlX6S8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3969C2BC87;
	Wed, 18 Mar 2026 15:34:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773848071;
	bh=rVTlQefuITADyaNzM6aWO6QlSclDkSmr0Z77CkSpP3c=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=c0hlX6S8h63ktvu5fILka49De6Ut7Ru1Jlinq3m68Sxb1bpnEstnbrPLdccsiLrEl
	 EmCflEgZBFcnw+aQbQ4fXyttSS0bG2F6cWYkY0RQwxcBD0FbmXSNVTQKPbskYLuaHh
	 b/aAFo0PZIYetYZFo1622Zn4KgKBgzwCMU6oKW956RXa3Q+GP6VesSi4zsuUSfkJZT
	 lxCB/1UCHOw0jrOLYEyA8FrOC6+xwJxp8aFxfrdDxnypb4C5NT0FyxEO3911WeFmiH
	 VgniLpo40ZgMnel4/LeNKqJ7vpfb/ngO+MF+0RKn2EPE/yZcfwNEgYmpaSHi2c25Bf
	 S6kBD8ijzNYsw==
Date: Thu, 19 Mar 2026 00:34:29 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Josh Law <objecting@objecting.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, Steven Rostedt
 <rostedt@goodmis.org>, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH v7 00/15] bootconfig: fixes, cleanups, and modernization
Message-Id: <20260319003429.c006cc1df0ccb4a5f307d4a7@kernel.org>
In-Reply-To: <20260317160916.33576-1-objecting@objecting.org>
References: <20260317160916.33576-1-objecting@objecting.org>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Hi Josh,

It is mostly OK, but can you reorder this series as the fixes (which
has "Fixes" tag, [9/15] and [10/15]) first and others second, so that
I can cleanly merge it to bootconfig/fixes and bootconfig/for-next?

The patches which has Fixes tag should go into stable tree, but other
improvements/cleanups should go to next merge window.

Thank you,


On Tue, 17 Mar 2026 16:09:01 +0000
Josh Law <objecting@objecting.org> wrote:

> This series addresses a collection of issues found during a review of
> lib/bootconfig.c, include/linux/bootconfig.h, and tools/bootconfig,
> ranging from off-by-one errors and unchecked return values to coding
> style, signedness/type cleanup, and API modernization.
> 
> Changes since v6:
>   - Dropped "add missing __init annotations to static helpers"
>     (v6 patch 1).
>   - Dropped "fix sign-compare in xbc_node_compose_key_after()"
>     (v6 patch 16).
>   - Updated "fix fd leak in load_xbc_file() on fstat failure" to save
>     errno before close(), since close() may overwrite it before the
>     error is returned (patch 10).
>   - Updated "fix signed comparison in xbc_node_get_data()" to use
>     size_t for the local offset variable, matching the warning and
>     xbc_data_size (patch 11).
>   - Updated "use signed type for offset in xbc_init_node()" to use a
>     signed long and explicitly check offset < 0 in WARN_ON(), making
>     the pre-base pointer case explicit instead of relying on unsigned
>     wraparound (patch 13).
> 
> Changes since v5:
>   - Folded typo fixes, kerneldoc blank line, and inconsistent bracing
>     patches (v5 02-05, 07) into a single patch (patch 1).
>   - Dropped "use __packed macro for struct xbc_node" (v5 11) and
>     "add __packed definition to tools/bootconfig shim header" (v5 14)
>     per review feedback.
>   - Added Fixes: tag to "check xbc_init_node() return in override
>     path" (patch 9).
>   - Added Fixes: tag to "fix fd leak in load_xbc_file() on fstat
>     failure" (patch 10).
> 
> Changes since v4:
>   - Added six follow-up patches found via static analysis with strict
>     GCC warnings (patches 11-15, plus the now-dropped v6 patch 16).
>   - Added "fix signed comparison in xbc_node_get_data()" to match the
>     local offset type to xbc_data_size and eliminate the sign-compare
>     warning (patch 11).
>   - Added "use size_t for strlen result in xbc_node_match_prefix()"
>     and "use size_t for key length tracking in xbc_verify_tree()" to
>     match strlen() return types (patches 12, 14).
>   - Added "use signed type for offset in xbc_init_node()" to make the
>     offset bounds check explicit and avoid sign-conversion warnings
>     from pointer subtraction (patch 13).
>   - Added "change xbc_node_index() return type to uint16_t" to match
>     the 16-bit storage fields and XBC_NODE_MAX bounds (patch 15).
> 
> Changes since v3:
>   - Added commit descriptions to all patches that were missing them.
>   - Added real-world impact statements to all bug-fix patches.
> 
> Changes since v2:
>   - Added "validate child node index in xbc_verify_tree()" (patch 8).
>   - Added "check xbc_init_node() return in override path" (patch 9).
>   - Added "fix fd leak in load_xbc_file() on fstat failure" (patch 10).
> 
> Changes since v1:
>   - Dropped "return empty string instead of NULL from
>     xbc_node_get_data()" -- returning "" causes false matches in
>     xbc_node_match_prefix() because strncmp(..., "", 0) always
>     returns 0.
> 
> Bug fixes:
>   - Fix off-by-one in xbc_verify_tree() where a next-node index equal
>     to xbc_node_num passes the bounds check despite being out of range;
>     a malformed bootconfig could cause an out-of-bounds read of kernel
>     memory during tree traversal at boot time (patch 3).
>   - Move xbc_node_num increment to after xbc_init_node() validation so
>     a failed init does not leave a partially initialized node counted
>     in the array; on a maximum-size bootconfig, the uninitialized node
>     could be traversed leading to unpredictable boot behavior (patch 4).
>   - Validate child node indices in xbc_verify_tree() alongside the
>     existing next-node check; without this, a corrupt bootconfig could
>     trigger an out-of-bounds memory access via an invalid child index
>     during tree traversal (patch 8).
>   - Check xbc_init_node() return value in the ':=' override path; a
>     bootconfig using ':=' near the 32KB data limit could silently
>     retain the old value, meaning a security-relevant boot parameter
>     override would not take effect (patch 9).
>   - Fix file descriptor leak in tools/bootconfig load_xbc_file() when
>     fstat() fails, and preserve errno across close() on that error path
>     (patch 10).
> 
> Correctness:
>   - Narrow the flag parameter in node creation helpers from uint32_t to
>     uint16_t to match the xbc_node.data field width (patch 2).
>   - Constify the xbc_calc_checksum() data parameter since it only reads
>     the buffer (patch 6).
>   - Fix strict-GCC signedness and narrowing warnings by aligning local
>     types with strlen() APIs and the node index/data storage in
>     xbc_node_get_data(), xbc_node_match_prefix(), xbc_init_node(),
>     xbc_verify_tree(), and xbc_node_index() (patches 11-15).
> 
> Cleanups:
>   - Fix comment typos, missing blank line before kerneldoc, and
>     inconsistent if/else bracing (patch 1).
>   - Drop redundant memset after memblock_alloc which already returns
>     zeroed memory; switch the userspace path from malloc to calloc to
>     match (patch 5).
> 
> Modernization:
>   - Replace the catch-all linux/kernel.h include with the specific
>     headers needed: linux/cache.h, linux/compiler.h, and
>     linux/sprintf.h (patch 7).
> 
> Build-tested with both the in-kernel build (lib/bootconfig.o,
> init/main.o) and the userspace tools/bootconfig build. All 70
> tools/bootconfig test cases pass.
> 
> Josh Law (15):
>   lib/bootconfig: clean up comment typos and bracing
>   lib/bootconfig: narrow flag parameter type from uint32_t to uint16_t
>   lib/bootconfig: fix off-by-one in xbc_verify_tree() next node check
>   lib/bootconfig: increment xbc_node_num after node init succeeds
>   lib/bootconfig: drop redundant memset of xbc_nodes
>   bootconfig: constify xbc_calc_checksum() data parameter
>   lib/bootconfig: replace linux/kernel.h with specific includes
>   lib/bootconfig: validate child node index in xbc_verify_tree()
>   lib/bootconfig: check xbc_init_node() return in override path
>   tools/bootconfig: fix fd leak in load_xbc_file() on fstat failure
>   lib/bootconfig: fix signed comparison in xbc_node_get_data()
>   lib/bootconfig: use size_t for strlen result in
>     xbc_node_match_prefix()
>   lib/bootconfig: use signed type for offset in xbc_init_node()
>   lib/bootconfig: use size_t for key length tracking in
>     xbc_verify_tree()
>   lib/bootconfig: change xbc_node_index() return type to uint16_t
> 
>  include/linux/bootconfig.h |  6 ++--
>  lib/bootconfig.c           | 65 ++++++++++++++++++++++----------------
>  tools/bootconfig/main.c    |  7 ++--
>  3 files changed, 46 insertions(+), 32 deletions(-)
> 
> -- 
> 2.34.1


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
