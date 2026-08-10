Received: from flow-b2-smtp.messagingengine.com (flow-b2-smtp.messagingengine.com [202.12.124.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5C2137E5D7;
	Mon, 10 Aug 2026 07:52:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786348327; cv=none; b=P6gpGQB2j/cebz0Oc9dIfufok7HeCjjVuW4nqS8wECXNsPIe+VjdZugJWouxMbUCklcPpFaK5eG/rPCvTV+KniJ4awQW9hMSZzGV195rH6E63MtVNjNZvSl41iyhPzkbeFm6gFqfj6rseHnWW7Pt2+4AMNF2apf2BBQrNiZeBkw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786348327; c=relaxed/simple;
	bh=5nsJRPmYnlG1W7N0Zj6R0f27BW+lbTE68Zj253FRIls=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=LbvwbcaDvzEZHW7OOUJIRqiYdE2LKSzbXcqIHJoxIQFBvobCS+MGccjbPyyE5nq0bq7Zb85AsJFxFtoNy4dVsNn4YuBaMv9UO5ywzfc0PraNdF7W0mVAJ3zX3AOMJBF88ChH5wiSw6xGakH8qUzRSacFS07fYyv5v5UpULp7tXg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=flapping.org; spf=pass smtp.mailfrom=flapping.org; dkim=pass (2048-bit key) header.d=flapping.org header.i=@flapping.org header.b=A4LvrrlP; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ANsDxWRK; arc=none smtp.client-ip=202.12.124.137
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=flapping.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flapping.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=flapping.org header.i=@flapping.org header.b="A4LvrrlP";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ANsDxWRK"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailflow.stl.internal (Postfix) with ESMTP id 4CE7D130000F;
	Mon, 10 Aug 2026 03:52:04 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Mon, 10 Aug 2026 03:52:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flapping.org; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to; s=fm2; t=1786348324; x=1786351924; bh=iz1hQTzFiKW/UJPbecKdR
	XkhuS6rZr3u9dqktxZ4RCo=; b=A4LvrrlPDT724BJSB8Wdkccb+nBDXFEo2oD1R
	24EH8PvArJns8VjIjMIIubL75OKFQclzgaI00PeMeSUsk2Vk84LKzMzw51ymyu8E
	t8Ab0DjJtEC1IJQ1FTC6VcDH00LyQTEH0Z+pFRczSWq2ND3o4UJZnU4zyVPr9aU6
	gnpLMXoIvI2YFypA+VqO5q8Ugo+MrRK1/5uNxwQtVTyKQ52Fwfu30JzzKAfRb0tT
	ESiRP1/BppDMPnRgjGmuHb11ewqS2yLnPICGKbZkOJYSb1ot2BIzK+XzpmcUjOU9
	o5ImJp4eC9P/jriNKVgC1kuzp8C/lVydtnP/PyFI5pTnZQ7Iw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1786348324; x=1786351924; bh=iz1hQTzFiKW/UJPbecKdRXkhuS6rZr3u9dq
	ktxZ4RCo=; b=ANsDxWRKoObSTZBXy3F8XVvCfXMnd9Y0eSMy9CvnmIRtCLOldfA
	C9e2wZczWMD0f94D3stdvgKfmal+JSsDRSYnBIluZUy67TAG+u4XK1+VLX/R53rR
	FKmWYoLXghmOqfO4cp0ayf4t879+HR66UqMEDXWz73mYPJKFfTgoWzj7xdSCO+lu
	SLISc6JsIZFa66ug75d4hJhLaxPtDnn34jw2YR7JqDsRbH+y3YcFVIKQOXHKjJg4
	s3qe2K05kFGPd2PV+5qYuYrVjdIBYoEMli/OjuQRiHpzcT4aBqDLwEbX1FZ5JDTm
	T2OKsDJSKvHFeBXZGPtY/i3DFCGpfQO4XCQ==
X-ME-Sender: <xms:I4N5aiMEAPs0EEudM4wc405eWkLtaMt9cLOQGPGQtzy7sD8doAUsAg>
    <xme:I4N5aiXMF28jUPcE1_NnF8S7ieRE11q1iVKZaoElSyjgu8qiYcF7Gj69PzMGCF76_
    9S-Nwpmz7Eza8-kSZBX8-YDv_AO6eNIAeX80T3R1Cg7n-4-CAWbfwI>
X-ME-Received: <xmr:I4N5aijpXZJQ40zgYNEe4rDdlg2mREAn8M3qACZpAqkcNc4Tkronq5I67vB7N-VyONePSRFn-c63MD7mTkE>
X-ME-Proxy-Cause: dmFkZTEg30fbMoIutivx8osKU0KSjAekgL1d+aiXaFyI3AFv2faqx2VVTVk5mB0nfbzfqu
    +dykEUd4cqL07t5DbDW2lz24WDNlZro6/Va6wDzL2fX1zg88oasV6hJz8GLAdnFvSrlY7N
    xWawTAvZiIvfIp6u6IrLaXq4/dhhj6XY01lK2jCdkmGhWf3qYnvuqF35JJP0RcOb8M1Rxx
    IJ0CDAkUNbGxJdbV4xye7gbBtpV1dsoXFRX8Oz+2b214sJQLkEMDcaO1BZPS7F+nFBkUFn
    Pzka3XjwXFeBMb6xjUfa673lQkGRrf8yqDhfpy/lrgLP4hSOIkHjQVqKWSDAwuD/qW4YgQ
    XZMLhE6U+xTa78KN8p1LjdqM3Xxcdu9FjS/UcVGBdAuXAeNXWXVwaHvWG1DHy3BuAg/pVI
    GBtZ8lGra4jGes5FWy7+8yp1frtmN5l6ITt6en3p7fRF2D65Am+qGXupgut7I2c1PJpAXz
    psp7BULb8oPOjx1zGIHdhf0ciWqFtT47bD531SxNFVKzErm164E78JPf4RGvqvD+4uueWf
    7ksZBZ967zzThk2LO5Bu/LESHDIxnVygfm3c8pm3ld1rv/7fAAlFerj4cbbrUlq0wUkCiU
    ERHqi0G+/LbmWU52yjAcFK/J4mOIJQ+DVy6rVAtrMie8P8cvc9Y9WROKPaSQ
X-ME-Proxy: <xmx:I4N5aq_sTFZXDhK2dpSyE3at4QysJU9oTwJLOpegipYcR00K6o1NqA>
    <xmx:I4N5ahQKYOSsrvhzz3Q399-yXoQCi6fJmtgxoZuPHpkIN89x312GSw>
    <xmx:I4N5ahugRT2U_w4UkpOyt7LEVkTk_4CdqgrEaKKH3F2PRDxbATGpOA>
    <xmx:I4N5ar6_UFlSbKWJAnN1nRHG6NcC4VBLiLhaWls5vTSi8ECULcAWrQ>
    <xmx:I4N5aru3Z24H1sw-tgJC40yMcCpdeh8cnOXPqD5ZUoZ86WBU3sqkM1O8>
Feedback-ID: i51fe4b43:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 10 Aug 2026 03:51:59 -0400 (EDT)
From: FUJITA Tomonori <tomo@flapping.org>
To: aliceryhl@google.com,
	ojeda@kernel.org,
	rostedt@goodmis.org
Cc: a.hindborg@kernel.org,
	acourbot@nvidia.com,
	bjorn3_gh@protonmail.com,
	boqun@kernel.org,
	dakr@kernel.org,
	daniel.almeida@collabora.com,
	gary@garyguo.net,
	lossin@kernel.org,
	mathieu.desnoyers@efficios.com,
	mhiramat@kernel.org,
	tamird@kernel.org,
	tmgross@umich.edu,
	work@onurozkan.dev,
	linux-trace-kernel@vger.kernel.org,
	rust-for-linux@vger.kernel.org,
	FUJITA Tomonori <fujita.tomonori@gmail.com>
Subject: [PATCH v1] rust: add mark_used macro
Date: Mon, 10 Aug 2026 16:51:44 +0900
Message-ID: <20260810075144.1245761-1-tomo@flapping.org>
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

Signed-off-by: FUJITA Tomonori <fujita.tomonori@gmail.com>
---
 rust/kernel/bug.rs        | 18 ++++--------------
 rust/kernel/lib.rs        | 12 ++++++++++++
 rust/kernel/tracepoint.rs |  5 ++---
 3 files changed, 18 insertions(+), 17 deletions(-)

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
index 9512af7156df..2f770d80bd8a 100644
--- a/rust/kernel/lib.rs
+++ b/rust/kernel/lib.rs
@@ -266,6 +266,18 @@ macro_rules! container_of {
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
index c6e80aa99e8e..cb06fec4c4d9 100644
--- a/rust/kernel/tracepoint.rs
+++ b/rust/kernel/tracepoint.rs
@@ -38,9 +38,8 @@ macro_rules! declare_trace {
 
             #[cfg(not(CONFIG_TRACEPOINTS))]
             {
-                // If tracepoints are disabled, insert a trivial use of each argument
-                // to avoid unused argument warnings.
-                $( let _unused = $argname; )*
+                // If tracepoints are disabled, the arguments are unused.
+                $crate::mark_used!($($argname),*);
             }
         }
     )*}

base-commit: d8973c47544371613313ecb9a8c3e7b244aa9bbf
-- 
2.43.0

