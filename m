Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795309287;
	b=a4i6xr7J9aF80yRY2n8CshexqvWp4Fl+mr37upnmvXPTmtppS8xsW6M1AcnOlbhD63/o
	 v5yjQy3t/jmLEoQRSL+M38rI2DYrJub3oAgcH7PBAiyDYujoWey5ZruiLHOQarw/N+sVm
	 8SlqskMMaL2atyyl1PvdxoHud2AcVXG/mNvRN3dyhEbfE3uTgEgVwWyHmTBrPpNSdBoGO
	 rvekzRVVqqtc8dfI3Vm8F+ElkfVhNh81Y2J6U6V/1LFejueVc5ns/LBBVk6ByjvsNNokg
	 LOBq4EqLEaeUOxCb6Nw9Mx6MrcZGVYWAmd6cmBV95XphvJ8tb9iG2e4hUvoIKnsFQ7g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795309287;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 User-Agent:MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=s5HP2F5BLo9a2Hz9pzFFEwWqo1HnIu7Du6LYcxBpVfo=;
	b=t0vatbS0OOeVhoJNukVHAsotDUxhiCisyMkxUbvWSOGmH8xGG/vpWNGx4v6vNBCurnrh
	 BUe5omXiYMU5eHx8HpzAUyYK1dfAeDVt8l/6ctMW3aBXckog92PQ2VFSoYRgrvllYjjWU
	 KdOHFARg84JtRqCk5tD/6goy+FPS8SC+W0Lq/5Sin5IU1dxxUfZXevtU4LuupIRPtLCjw
	 QFrQ8OndAudLvZnlotPJHvPZ0EYTvMdb7o5N6cgJTMkvTaLoVnhVA7NxxFr9YYoGPAVfp
	 w41B/DillzgbcN6vABPJcJqWXbvDuahg+/tDVBOllf4g6YSJoxcVuuCfBTUFnvgeLBw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=m6hczndX;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 005BF606A320;
	Sun, 22 Nov 2026 01:01:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=m6hczndX
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8075C1F000E1;
	Sun, 22 Nov 2026 01:01:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795309286;
	bh=s5HP2F5BLo9a2Hz9pzFFEwWqo1HnIu7Du6LYcxBpVfo=;
	h=From:To:Cc:Subject:Date;
	b=m6hczndXWrg0oa4u9Vy2d+QLTQVQLIHtbw1Lq4D9y9qpkg9hu3MCW2icjSfsEMBke
	 knEY/btA0gCASU5hVniIjqOmqSiGbc6C9dqxrcwU8NT/NLNW89SI5nB8bH5agiZjWb
	 Svernse8ETCbh8bIS/dTrnHfnj5yJDKKUnow8jCmjp/sc4qb+jR2ahCG3oN90pt3aL
	 wZEzEpdc9GHZM0WzoWlM9CmIKV50yvwS1D7+wPMJT5mXmuhXa33Tv6jxcEKP+cYY54
	 dxqGD1Z7TxucpbWqDxpZriveE/qNG/l0+8j0jWredLEQH5Jul3qsACC9vmKsV3Fykq
	 JbkocCxwMDgRw==
From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To: Masami Hiramatsu <mhiramat@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Andrew Morton <akpm@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH 0/4] bootconfig: Fix tree verification, key composition, and cmdline rendering bugs
Date: Sun, 22 Nov 2026 10:01:23 +0900
Message-ID: <179530928294.109991.3079999508446852151.stgit@devnote2>
X-Mailer: git-send-email 2.43.0
User-Agent: StGit/0.19
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Post: <mailto:linux-trace-kernel@vger.kernel.org>
List-Help: <mailto:linux-trace-kernel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-trace-kernel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

Hi,

This series fixes bugs in the Extra Boot Config (bootconfig) parser and
tree query/rendering API (`lib/bootconfig.c`), and adds regression tests
to `tools/bootconfig/test-bootconfig.sh`. These issues were found while
formally modeling and verifying the bootconfig parser in Lean 4.

Summary of changes:

1. Fix `xbc_verify_tree()` to use `xbc_node_get_subkey()` instead of
   `xbc_node_get_child()` when descending the key tree. Previously, if a
   key node had both a value and subkeys, its first child was the value
   node, causing `xbc_verify_tree()` to skip all subkeys under it and
   bypass both `XBC_DEPTH_MAX` (16) and `XBC_KEYLEN_MAX` (256) checks.

2. Fix `xbc_node_compose_key_after()` for value nodes: climb all parent
   value nodes in a loop (`while (node && xbc_node_is_value(node))`) so
   that 2nd+ array value nodes resolve to their owning key node, and
   perform `if (!node || node == root)` after climbing so that passing a
   value node belonging to the subtree `@root` key node itself (e.g.
   `foo = "val"` with `@root = xbc_find_node("foo")`) returns `-EINVAL`
   rather than `0` with an untouched buffer.

3. Fix `xbc_snprint_cmdline_filter()` to pass
   `buf && len < size ? buf + len : NULL` to `snprintf()`, avoiding
   out-of-bounds pointer arithmetic (`buf + len` with `len > size`) when
   `@buf` is non-NULL and the rendered output exceeds `@size`.

4. Add regression tests to `tools/bootconfig/test-bootconfig.sh` for
   unclosed brace error position reporting and mixed value+subkey
   depth/length limit enforcement.

Thank you,

---

Masami Hiramatsu (Google) (4):
      bootconfig: Fix xbc_verify_tree() to check subkeys of valued keys
      bootconfig: Fix xbc_node_compose_key_after() for value nodes
      bootconfig: Avoid out-of-bounds pointer arithmetic in xbc_snprint_cmdline_filter()
      tools/bootconfig: Add tests for unclosed brace position and mixed-kv limits


 lib/bootconfig.c                    |   17 +++++++++--------
 tools/bootconfig/test-bootconfig.sh |   33 +++++++++++++++++++++++++++++++++
 2 files changed, 42 insertions(+), 8 deletions(-)

--
Masami Hiramatsu (Google) <mhiramat@kernel.org>
