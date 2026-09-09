Received: from fout-b3-smtp.messagingengine.com (fout-b3-smtp.messagingengine.com [202.12.124.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75EAB545DAB;
	Wed,  9 Sep 2026 12:02:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788955353; cv=none; b=C3ud1VFL6tEMHoCDpqPOtY5CpTiZdX6rqLx8EUNmiHtOjDNNPvwIOh3y8mM37Dgzi+KV+sANTDn+DxXdoINXDJJTjAE2I/szbNWmoPbZujFrEMZcvNX0nrTpZnLVW0MxLxzIOvCBUQcXSu6XTUhIxxQ1x8oZsN04wAhblJJOtdg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788955353; c=relaxed/simple;
	bh=K/tG6mLi7kaBxy1QZ1ckLxO6z1brlEG4Dja18T4gOnE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=WWfNZB5nJRbEO+iGud7Wi0R2KtfKEwSAlYUA1TWW/vHpAxdrgagMMvxGfOyErvH5c0fq1gC04/kVrhaj2CUTqxC+KG1oHcFLVQc5p5fBI8P2aSpUAXNWkop25ZqCfeXWeH/GeFvdGlH6GoWSpKULHWGusHbX4QJfs4b3cszo5Lc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=flapping.org; spf=pass smtp.mailfrom=flapping.org; dkim=pass (2048-bit key) header.d=flapping.org header.i=@flapping.org header.b=Gt5VfsOG; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=U0G2Bu/m; arc=none smtp.client-ip=202.12.124.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=flapping.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flapping.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=flapping.org header.i=@flapping.org header.b="Gt5VfsOG";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="U0G2Bu/m"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.stl.internal (Postfix) with ESMTP id 1C8381D00060;
	Wed,  9 Sep 2026 08:02:30 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-03.internal (MEProxy); Wed, 09 Sep 2026 08:02:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flapping.org; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to; s=fm3; t=1788955349; x=1789041749; bh=bVY1yWQUiCsPGp2dXwrxQ
	STFwCySs8TKGWg3lCvR4EI=; b=Gt5VfsOGdSidpqDTNMzZTOKTlLeh+bGKRxUJj
	GdYtYoocfUbRYOLvzMOwemaYzW137LJQWwWXLUm+L0ZS/H6GfWNmQEcAaodvbGoX
	7LFB8f2wT+/imWDySy5SJPVb4wVEIOjnO3s17vHlZo6AcBtpCay5Rvq4i9KsHGsE
	vplRWY0KpccQ4w09215pPsSjKU5Ud8xMG5Qm+FF+s4L9aIWwLEqTqlYMJsGoDrmH
	WEBas9KbpBWSrNPRUYOw2lPPbDOZ9zHsuNG3kxyjC+0+wxI/mj21Sil6j7iUW9gd
	7c87jH4VS3FIORlSauotKR555kVo3xu04c5ENvRnB95R8HFmg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1788955349; x=1789041749; bh=bVY1yWQUiCsPGp2dXwrxQSTFwCySs8TKGWg
	3lCvR4EI=; b=U0G2Bu/mv2PSW2dlbxNPTDlbs5ZXDqpJnJgRDByxQ/KNkS4qaig
	GJD/48fZJM/gV/QxDuVc8hx0SzlbOLcjx1SYw/NSmHw5OpHB/cCc/NCZg9ZeBQid
	3xR2exW/1fLwNzOJ/3zCq9RZJt27GG/luxHit9tN5U19IYLD/UesOPh3HJqBAOCE
	auAObcUoljsqeVqfL7crPVCKhrViYOZDUl41k4DVVezbHOVvxH/Am+gYSbYtN02Y
	eZHb551GtvAqV5PPll2z9A/1amkpzglEb+XTd4xpRodZ2yaWegIP7XL7gf4hiM0P
	zMlVYCbdDM+ho4nSKUD+R6Kp5ox+wIuz1ew==
X-ME-Sender: <xms:1Uqhas3MfwoXN69VMffgmbbi_Ci4WQg6wd2TV8k1ySo-3Ph_v4dECQ>
    <xme:1Uqhaof4gD8qNS8WPW6TtfI04zWMnuhuBNqLmSvk4ReV_rSCaeL5v333w_C-r8_V2
    I0mSDtpIBcbJH7pij5FqZjVKulwU1JX3c_mK7qzhNI8KZE49jNBygG8>
X-ME-Received: <xmr:1UqhauLaXbOtC5S4cwE2T3M9-WTCu_bYKMqRCA9aqG6oTNyYqi9muwO8UJrSJaDOqkja6eXfKo4ngUJZp08>
X-ME-Proxy-Cause: dmFkZTF8JotZO26WxgsmnG/Ajp996d2BGwdmvKHi3HvquRZbstdGZv6p0PnalyffemgUkf
    l4IoXZSfXnqHN0sLv16x3nazy9VtB6ClR7WdvLQ2hGWMBbooTHb1OV2R1PgG/Fa02lDWgi
    Ku7E1kXG1AwNFJq26Qh0YSBRQ15KTCRsmZwVC+hg+tTu6tiBpRsKbWbXLZpzOtqDS54fLC
    WCaLMEaG4DrtaPGgY70hwOkSes3xO3WKMxsHaSXiwzuYLMoTRkr4WAmual9XxhnRcNc3dZ
    0HzMmJJYBndfov33+yudsJRAfNj5ni2PI3JQy7Im/BPaI7fbIe8EFPs4+Zyxcac3A1hCpz
    3+8iMYHuJ9sjE12MwTrwKWq0RvcP+Hz10OGBtxPNkGukUmQ90ZDVoak8fP3629cuY3yh5q
    Yy8Oaah8KxFNi2KqGd6THi8yMMCuKnMKrRSTwyifgQEhV3KFBAlgNkWtQF4N5vcN1xLm/t
    +RIfZaLJcn697115vxIykMXznABL77ZDqWIAT3sVW6y58XiNche4s3hXsBsZVsqxEJpKdg
    kSaNXcd/yM66Vcyc01U0MIhCrcqbrpZ8A8InsbRp8VSkgfMy4qptR8cTsnGlG+o/hgGhp9
    +c5fJQ7lgbH4BWVyoCQG3KV/wETbDxzQjjewmcnCiQiEGTJUs9I2fHr/oQfg
X-ME-Proxy: <xmx:1UqhauH063nL6GPDfCT7dzo6XqV_czpw009f_mNAVlqiAgduluPCqA>
    <xmx:1Uqhal5zi9q8KgRGoHWa0kYPelBbbpU67QDCNs5fwulV10JAhdjBkw>
    <xmx:1Uqhap3wkUqXVPl6tF-j4Nfxm7dzmHawPP-GEK-YiGA3agLae4igmQ>
    <xmx:1UqhahjT-4aUBswukYV3H_UfH_sEk1Ttf01l3lzxiZcG6a6Hxxzl5w>
    <xmx:1Uqhak2PGRdPj348L4sSAHufacTtpI0SZTdMaW5YFFKRf0z-3DW9ckgb>
Feedback-ID: i51fe4b43:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 9 Sep 2026 08:02:25 -0400 (EDT)
From: FUJITA Tomonori <tomo@flapping.org>
To: aliceryhl@google.com,
	gary@garyguo.net,
	ojeda@kernel.org,
	rostedt@goodmis.org
Cc: a.hindborg@kernel.org,
	acourbot@nvidia.com,
	bjorn3_gh@protonmail.com,
	boqun@kernel.org,
	dakr@kernel.org,
	daniel.almeida@collabora.com,
	lossin@kernel.org,
	mathieu.desnoyers@efficios.com,
	mhiramat@kernel.org,
	tamird@kernel.org,
	tmgross@umich.edu,
	work@onurozkan.dev,
	linux-trace-kernel@vger.kernel.org,
	rust-for-linux@vger.kernel.org,
	FUJITA Tomonori <fujita.tomonori@gmail.com>
Subject: [PATCH v2] rust: add mark_used macro
Date: Wed,  9 Sep 2026 21:02:10 +0900
Message-ID: <20260909120210.2488674-1-tomo@flapping.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

From: FUJITA Tomonori <fujita.tomonori@gmail.com>

Macros whose expansion depends on the kernel configuration end up
ignoring some of their arguments, resulting in unused warnings.

Add a macro for the `if false { _ = ...; }` idiom used to avoid them,
and convert the existing open-coded users in `warn_flags!` and
`declare_trace!`.

Reviewed-by: Gary Guo <gary@garyguo.net>
Signed-off-by: FUJITA Tomonori <fujita.tomonori@gmail.com>
---
v2:
- Drop the comment in `declare_trace!`. The macro name says the same thing.
- Add Gary's Reviewed-by.
- Rebase on rust-next.
v1: https://lore.kernel.org/rust-for-linux/20260810075144.1245761-1-tomo@flapping.org/
---
 rust/kernel/bug.rs        | 18 ++++--------------
 rust/kernel/lib.rs        | 12 ++++++++++++
 rust/kernel/tracepoint.rs |  4 +---
 3 files changed, 17 insertions(+), 17 deletions(-)

diff --git a/rust/kernel/bug.rs b/rust/kernel/bug.rs
index 3566f0234ca4..c1e4eb7d4a70 100644
--- a/rust/kernel/bug.rs
+++ b/rust/kernel/bug.rs
@@ -55,9 +55,7 @@ macro_rules! warn_flags {
     ($file:expr, $flags:expr) => {
         const FLAGS: u32 = $crate::bindings::BUGFLAG_WARNING | $flags;
 
-        if false {
-            _ = $file;
-        }
+        $crate::mark_used!($file);
 
         // SAFETY:
         // - `flags` and `size` are all compile-time constants, preventing
@@ -83,9 +81,7 @@ macro_rules! warn_flags {
 #[cfg(all(CONFIG_BUG, CONFIG_UML))]
 macro_rules! warn_flags {
     ($file:expr, $flags:expr) => {
-        if false {
-            _ = $file;
-        }
+        $crate::mark_used!($file);
 
         // SAFETY: It is always safe to call `warn_slowpath_fmt()`
         // with a valid null-terminated string.
@@ -106,10 +102,7 @@ macro_rules! warn_flags {
 #[cfg(all(CONFIG_BUG, any(CONFIG_LOONGARCH, CONFIG_ARM)))]
 macro_rules! warn_flags {
     ($file:expr, $flags:expr) => {
-        if false {
-            _ = $file;
-            _ = $flags;
-        }
+        $crate::mark_used!($file, $flags);
 
         // SAFETY: It is always safe to call `WARN_ON()`.
         unsafe { $crate::bindings::WARN_ON(true) }
@@ -121,10 +114,7 @@ macro_rules! warn_flags {
 #[cfg(any(testlib, not(CONFIG_BUG)))]
 macro_rules! warn_flags {
     ($file:expr, $flags:expr) => {
-        if false {
-            _ = $file;
-            _ = $flags;
-        }
+        $crate::mark_used!($file, $flags);
     };
 }
 
diff --git a/rust/kernel/lib.rs b/rust/kernel/lib.rs
index 4d5c96ddc49c..3b38e6b8196b 100644
--- a/rust/kernel/lib.rs
+++ b/rust/kernel/lib.rs
@@ -227,6 +227,18 @@ macro_rules! container_of {
 #[doc(hidden)]
 pub fn assert_same_type<T>(_: T, _: T) {}
 
+/// Marks the given expressions as used.
+///
+/// This avoids "unused" warnings in kernel configurations that do not otherwise use them.
+#[macro_export]
+macro_rules! mark_used {
+    ($($e:expr),* $(,)?) => {
+        if false {
+            $( _ = $e; )*
+        }
+    };
+}
+
 /// Helper for `.rs.S` files.
 #[doc(hidden)]
 #[macro_export]
diff --git a/rust/kernel/tracepoint.rs b/rust/kernel/tracepoint.rs
index c6e80aa99e8e..29d2d2d0aca8 100644
--- a/rust/kernel/tracepoint.rs
+++ b/rust/kernel/tracepoint.rs
@@ -38,9 +38,7 @@ macro_rules! declare_trace {
 
             #[cfg(not(CONFIG_TRACEPOINTS))]
             {
-                // If tracepoints are disabled, insert a trivial use of each argument
-                // to avoid unused argument warnings.
-                $( let _unused = $argname; )*
+                $crate::mark_used!($($argname),*);
             }
         }
     )*}

base-commit: 28924df2a08f440c73991b83028032c901de2ae4
-- 
2.43.0

