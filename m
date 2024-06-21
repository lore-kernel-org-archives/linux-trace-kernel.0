Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA1FD171676
	for <linux-trace-kernel@vger.kernel.org>; Fri, 21 Jun 2024 10:35:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718966137; cv=none; b=my3CGQbhD5l/y8Yrzyp2ziXBi+M5q+PYlCaEbvAiPjZe4FjmYHAjCzJuk+RRPUAgS+7LrOQv2hS+mwK39wtM1WVGyiWUmcYvN94SFp6ep+xY4TJmaK9NeHkYon+hLXJfLkHgeZANYwx7rUdvnxZrF3du8eClYw2Osx+o38lm3Go=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718966137; c=relaxed/simple;
	bh=6wWzVlFR1VHADGH+6BePWydBpBp6gryq9IdChcDcKU8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=F0vBG5dTtsG7uEBbcA8r7zTaIQnR1pGR6GzPXxwwtP8JeQVR7iMoJVrYU5k3VXYjpW+zhzMP62ArudCFzsLCjOBZvYvvDCEqGGOtgtl7/4l16gvB9zQkyGvQiTcIMMpFH1EAg8XCaBv7d4+66SROL4V+QLzce0DYHihQHr0JeNw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=WOqjIGx9; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="WOqjIGx9"
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-627f43bec13so34418647b3.0
        for <linux-trace-kernel@vger.kernel.org>; Fri, 21 Jun 2024 03:35:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1718966135; x=1719570935; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=CrOCucYoXI5A0zFoBN/LEOcGTzj1eDJ5JNGNyCICG4w=;
        b=WOqjIGx9AgPHEbgJiOX2VDwLi0vtz64YFROeDTh3nu3M84ApJKRD8giUmtjIbh2pDD
         zR94ccUdKpwK+iWxrilp3edZm4XwZtDTDo77Xp0Y7662TfQJimRq5iBVWEjB0egFvNSl
         VcziKGD/JOzz+LJcT29ZZWhZ98MncJEjTCfx6xH/OKjVTxIpLpH8PcUfy8A/e573xtEk
         ap974m1E/R85oqToANRP5GGDXxpIKvTM49xRjaCiyATE6idBOS8c7v2EAD3xgLhKehJ0
         Yp9Rv9IN5yCfprL0q2vr6Xn0FWpz6IPz5NmonykArckO/2Edfp4FgxVfY1LN102EaUkw
         tCgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718966135; x=1719570935;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CrOCucYoXI5A0zFoBN/LEOcGTzj1eDJ5JNGNyCICG4w=;
        b=Ajv70PgQZEqGqoLTF2Ks/k/V6m42TmOtBsaPPagsogDRutoihvN94V31GwDZRHcsao
         7E/Bz7cJDAxqb//SQjQj3xP366wMBezqmaU5LQAuM/ix6IeW7QM1MkSi3u9CJXvEysSU
         ZHCzRKsYLXD451Cc4tST8xGjGuEVRfy9bqql4/P3a1p6KFD90p+nzLY9o1wSLIN2mKm6
         lOVliTwYRNc/wcR8Yqxv4bUq/AdhO/UudwfzCAlhkiS6BHPy9kMeDV8oygBp/Uoa1UPe
         v+ziUAWHJjOAdFQrAcxdT0JGidElGXMXaRfu4uve8WVuTtmXbYX5L3+LMqhhRy1sjW1J
         wyAA==
X-Gm-Message-State: AOJu0Yw3EJl4/cb2zmjrJBc1R5BHLD294JcOnzEGcNle2RhtKPvlJREJ
	1ilnB27v4tRdce6jX9XH8Jv4w//kVKiwpdWPW9/ZSyEovtAnz3Jh/+UgekEyyiUIOg4HHzq4U7g
	PlsBV8tbu+gczvw==
X-Google-Smtp-Source: AGHT+IGVPYWO/IU1ZjZdU5tBe8plUiU3EKikmKQ+F6kZ+2U8VVqNPl/NGi/EZ0pSAI0i9VOJqPEAwp8eflEuhWE=
X-Received: from aliceryhl2.c.googlers.com ([fda3:e722:ac3:cc00:68:949d:c0a8:572])
 (user=aliceryhl job=sendgmr) by 2002:a05:6902:1003:b0:e02:bd4f:def2 with SMTP
 id 3f1490d57ef6-e02be20b2ccmr1838087276.11.1718966134957; Fri, 21 Jun 2024
 03:35:34 -0700 (PDT)
Date: Fri, 21 Jun 2024 10:35:26 +0000
In-Reply-To: <20240621-tracepoint-v3-0-9e44eeea2b85@google.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240621-tracepoint-v3-0-9e44eeea2b85@google.com>
X-Developer-Key: i=aliceryhl@google.com; a=openpgp; fpr=49F6C1FAA74960F43A5B86A1EE7A392FDE96209F
X-Developer-Signature: v=1; a=openpgp-sha256; l=5918; i=aliceryhl@google.com;
 h=from:subject:message-id; bh=6wWzVlFR1VHADGH+6BePWydBpBp6gryq9IdChcDcKU8=;
 b=owEBbQKS/ZANAwAKAQRYvu5YxjlGAcsmYgBmdVdwWHR38Id2Y1qI7zKbIntmDpdG2XqgVF2X9
 Pf7bNMKSfaJAjMEAAEKAB0WIQSDkqKUTWQHCvFIvbIEWL7uWMY5RgUCZnVXcAAKCRAEWL7uWMY5
 Rm0kEAC0vvj6AE4i4zy0e5goiDGQ1miDq/5MGdB+jxfbD9hho/GGNUobR2VV0zVUu9wxLRmoA/4
 NKx7emh8PfAA5wI3i0i3SN29Z3bIEl5/TnoAO8j848tBnzNJDMAxTaSwgEntSuk1eZC2VJTFobd
 j4P1EGP06EhipWKPROT0ioujoB8oHmo47fC/NLSYdd8s8f3ToWYHGyaMdZbu54kaqwTcUQpWOR7
 j1m7sS9o4glt/wpz/7lvmCOlcs22IIDYR8VzP8eH0MgbIYWpnkY27pFGfDoms3Jf4D/gzK5q1kW
 J5R5maMNT1VX9uGbg6z6lR/CbYgMjhElPospfQmamRqUJN3TkfZSGExaswS0syMtfLHKvoC2xBr
 pEzEcqvcjArWvSapahCk5dTdtopIg9hEEimEsPI3+x1nOsv1AOVzkJL/94964U+4sWTOMmzPxMH
 9JLUkoLxl2tTx3uPlZ9VNSFNMIDC98FgIlJOFywZKn0UODwVpL4ZoKwkrPA7kTecKAy5Bz8qn2h
 bzMpljBeRNhRDLHdEknLlpsyLy0MuLFBXtpMWns5FkGpb2oMeaTaEcrb0Vb0Sewv9uhYSV/sPpr
 HEvRKk6j17ZcDCq1n/IXwxYeNKxptYFJej0Zw0Xoruoi/oIcuk5XW+0rLdOLP+JvocuA2GBrH/7 zNeFgSDFbaEWQiQ==
X-Mailer: b4 0.13-dev-26615
Message-ID: <20240621-tracepoint-v3-1-9e44eeea2b85@google.com>
Subject: [PATCH v3 1/2] rust: add static_key_false
From: Alice Ryhl <aliceryhl@google.com>
To: Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Peter Zijlstra <peterz@infradead.org>, 
	Josh Poimboeuf <jpoimboe@kernel.org>, Jason Baron <jbaron@akamai.com>, 
	Ard Biesheuvel <ardb@kernel.org>, Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Wedson Almeida Filho <wedsonaf@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	"=?utf-8?q?Bj=C3=B6rn_Roy_Baron?=" <bjorn3_gh@protonmail.com>, Benno Lossin <benno.lossin@proton.me>, 
	Andreas Hindborg <a.hindborg@samsung.com>
Cc: linux-trace-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Alice Ryhl <aliceryhl@google.com>
Content-Type: text/plain; charset="utf-8"

Add just enough support for static key so that we can use it from
tracepoints. Tracepoints rely on `static_key_false` even though it is
deprecated, so we add the same functionality to Rust.

It is not possible to use the existing C implementation of
arch_static_branch because it passes the argument `key` to inline
assembly as an 'i' parameter, so any attempt to add a C helper for this
function will fail to compile because the value of `key` must be known
at compile-time.

Signed-off-by: Alice Ryhl <aliceryhl@google.com>
---
 rust/kernel/lib.rs        |   1 +
 rust/kernel/static_key.rs | 143 ++++++++++++++++++++++++++++++++++++++++++++++
 scripts/Makefile.build    |   2 +-
 3 files changed, 145 insertions(+), 1 deletion(-)

diff --git a/rust/kernel/lib.rs b/rust/kernel/lib.rs
index fbd91a48ff8b..a0be9544996d 100644
--- a/rust/kernel/lib.rs
+++ b/rust/kernel/lib.rs
@@ -38,6 +38,7 @@
 pub mod prelude;
 pub mod print;
 mod static_assert;
+pub mod static_key;
 #[doc(hidden)]
 pub mod std_vendor;
 pub mod str;
diff --git a/rust/kernel/static_key.rs b/rust/kernel/static_key.rs
new file mode 100644
index 000000000000..9c844fe3e3a3
--- /dev/null
+++ b/rust/kernel/static_key.rs
@@ -0,0 +1,143 @@
+// SPDX-License-Identifier: GPL-2.0
+
+// Copyright (C) 2024 Google LLC.
+
+//! Logic for static keys.
+
+use crate::bindings::*;
+
+#[doc(hidden)]
+#[macro_export]
+#[cfg(target_arch = "x86_64")]
+macro_rules! _static_key_false {
+    ($key:path, $keytyp:ty, $field:ident) => {'my_label: {
+        core::arch::asm!(
+            r#"
+            1: .byte 0x0f,0x1f,0x44,0x00,0x00
+
+            .pushsection __jump_table,  "aw"
+            .balign 8
+            .long 1b - .
+            .long {0} - .
+            .quad {1} + {2} - .
+            .popsection
+            "#,
+            label {
+                break 'my_label true;
+            },
+            sym $key,
+            const ::core::mem::offset_of!($keytyp, $field),
+        );
+
+        break 'my_label false;
+    }};
+}
+
+#[doc(hidden)]
+#[macro_export]
+#[cfg(target_arch = "aarch64")]
+macro_rules! _static_key_false {
+    ($key:path, $keytyp:ty, $field:ident) => {'my_label: {
+        core::arch::asm!(
+            r#"
+            1: nop
+
+            .pushsection __jump_table,  "aw"
+            .align 3
+            .long 1b - ., {0} - .
+            .quad {1} + {2} - .
+            .popsection
+            "#,
+            label {
+                break 'my_label true;
+            },
+            sym $key,
+            const ::core::mem::offset_of!($keytyp, $field),
+        );
+
+        break 'my_label false;
+    }};
+}
+
+#[doc(hidden)]
+#[macro_export]
+#[cfg(target_arch = "loongarch64")]
+macro_rules! _static_key_false {
+    ($key:path, $keytyp:ty, $field:ident) => {'my_label: {
+        core::arch::asm!(
+            r#"
+            1: nop
+
+            .pushsection __jump_table,  "aw"
+            .align 3
+            .long 1b - ., {0} - .
+            .quad {1} + {2} - .
+            .popsection
+            "#,
+            label {
+                break 'my_label true;
+            },
+            sym $key,
+            const ::core::mem::offset_of!($keytyp, $field),
+        );
+
+        break 'my_label false;
+    }};
+}
+
+#[doc(hidden)]
+#[macro_export]
+#[cfg(target_arch = "riscv64")]
+macro_rules! _static_key_false {
+    ($key:path, $keytyp:ty, $field:ident) => {'my_label: {
+        core::arch::asm!(
+            r#"
+            .align  2
+            .option push
+            .option norelax
+            .option norvc
+            1: nop
+            .option pop
+            .pushsection __jump_table,  "aw"
+            .align 3
+            .long 1b - ., {0} - .
+            .dword {1} + {2} - .
+            .popsection
+            "#,
+            label {
+                break 'my_label true;
+            },
+            sym $key,
+            const ::core::mem::offset_of!($keytyp, $field),
+        );
+
+        break 'my_label false;
+    }};
+}
+
+/// Branch based on a static key.
+///
+/// Takes three arguments:
+///
+/// * `key` - the path to the static variable containing the `static_key`.
+/// * `keytyp` - the type of `key`.
+/// * `field` - the name of the field of `key` that contains the `static_key`.
+#[macro_export]
+macro_rules! static_key_false {
+    // Forward to the real implementation. Separated like this so that we don't have to duplicate
+    // the documentation.
+    ($key:path, $keytyp:ty, $field:ident) => {{
+        // Assert that `$key` has type `$keytyp` and that `$key.$field` has type `static_key`.
+        //
+        // SAFETY: We know that `$key` is a static because otherwise the inline assembly will not
+        // compile. The raw pointers created in this block are in-bounds of `$key`.
+        static _TY_ASSERT: () = unsafe {
+            let key: *const $keytyp = ::core::ptr::addr_of!($key);
+            let _: *const $crate::bindings::static_key = ::core::ptr::addr_of!((*key).$field);
+        };
+
+        $crate::_static_key_false! { $key, $keytyp, $field }
+    }};
+}
+
+pub use static_key_false;
diff --git a/scripts/Makefile.build b/scripts/Makefile.build
index efacca63c897..60197c1c063f 100644
--- a/scripts/Makefile.build
+++ b/scripts/Makefile.build
@@ -263,7 +263,7 @@ $(obj)/%.lst: $(obj)/%.c FORCE
 # Compile Rust sources (.rs)
 # ---------------------------------------------------------------------------
 
-rust_allowed_features := new_uninit
+rust_allowed_features := asm_const,asm_goto,new_uninit
 
 # `--out-dir` is required to avoid temporaries being created by `rustc` in the
 # current working directory, which may be not accessible in the out-of-tree

-- 
2.45.2.741.gdbec12cfda-goog

