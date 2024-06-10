Received: from mail-lj1-f202.google.com (mail-lj1-f202.google.com [209.85.208.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3C248563F
	for <linux-trace-kernel@vger.kernel.org>; Mon, 10 Jun 2024 14:01:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718028111; cv=none; b=Fz2xheMimhoQs8KuVx8XeAC6yFuGumgwhndSfDD4d6YAeEPVHhtDWDkOUrhoAUR+6d+RFCb5X81iunF8BD8zMcY+UqtyXIkMRiKhSCuBPt9DVvv+cQjtaVU2osqAsCckYGJ8odthpOEV9quUfZCsJZJM5zn7jVfWkwcNIZAO10A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718028111; c=relaxed/simple;
	bh=9vYGSS2BmEd2xDDj2+LOFjdqN6wry32Wd02DytPyAGM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=MkphSg01Noy+j7ygBwm4u8YlisXdRq9B7FutPBEpOBtYsJFtjweZfEhx5ekoD6c9AocIr/QKwjwVgKyUN0iS8RVGAre59U0iRtFxm8vSZYu+yzeywkHeeoj6qcX9pN87L2TAxChrIFMrzdtIyiS074XK9lCEhQlb0XcinWUpsmw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=a+6kbwzk; arc=none smtp.client-ip=209.85.208.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="a+6kbwzk"
Received: by mail-lj1-f202.google.com with SMTP id 38308e7fff4ca-2eaafba0579so24332491fa.1
        for <linux-trace-kernel@vger.kernel.org>; Mon, 10 Jun 2024 07:01:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1718028108; x=1718632908; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=gqi0Ch+WHXCymy1FXRv5YloHXZpb5Bjpuk0IhhxS8JI=;
        b=a+6kbwzkQjAl+c3pZcGg+sgjnG6PZ15AUHbBgphw8LXwaMNAr8f8yyYUAk7KtUdeab
         +nKZfMPyehXmWmVn8xvO76tm+k3zXWNWAsg3Q+1/MVEBVht5wd+A2I0WCZn+MHuoyot/
         RdivqAO+LRBhiU6wNUXEmag5XjUD1T7t+LlulmR+TtkJ2+wClMb4H+uYI2bvNTBkwdJ+
         aHnpdtZvwcuoRSldSZcJ5gCMSnwfwRnA13Ltoazu2HBb0kkyQd5MlrwxDDelaQAWvdPZ
         iFVVnM6dhD81TUwRIa2dX4dQeLeHJouHdkDSF7Ir/e1eETtLM9OfjQyiRqT984y0+ohg
         G6Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718028108; x=1718632908;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gqi0Ch+WHXCymy1FXRv5YloHXZpb5Bjpuk0IhhxS8JI=;
        b=FvwBuG6aiq4OeXZmk98wxDYqgbX3Rw4fRcnJR1o9CedT/GjK6xwO3ZjTuHVDanqJms
         ytY7tQc4ZFSYQ5ktaIJJuw2+wy5ZH9v3XJpp5r3y+v3Bi5qGR6oMUrIeYS/HkbtgGQdf
         liaxZmU1mOroTXX7LIRXKbOJgi0ZD4tld51a5sFJZ2XSlJ5iHXM5hNeIZg/yRm0f1uPA
         15eDwIellyMP70Ebi1WZ8EJLH2F5TqyPvyCtZMwzPO38CwiQYglQfvM+uQdG1vRypHD/
         of/DHioWhytdz8r7VCVZatDXpEI3ABDAgo+XWnp2EOq8G9t1Ql3JIP3Suf+lQQHX+hZr
         Oetw==
X-Gm-Message-State: AOJu0Ywf0QFaJnV2+dldflB+rP0mip9qlxth7SxNZZvGw7lKrVFVw/Lx
	/OgVqsV1hbpS1p+jWUmPsDCMb6J2IvNd24yQ5DryHLbfwfOLZ+14gl6xxVO206ztnihulRiv6cX
	s19ylO1qC4BMzjQ==
X-Google-Smtp-Source: AGHT+IHmESnzCQ1ZJ5vYbTFugTYk4eNBgny8iUT+z4SkkUunHjrOJQIWIMsPkpYFThPLRJmh2nIwyqCWIX2G2Ok=
X-Received: from aliceryhl2.c.googlers.com ([fda3:e722:ac3:cc00:68:949d:c0a8:572])
 (user=aliceryhl job=sendgmr) by 2002:a05:6512:2c0d:b0:52c:8eff:ecf6 with SMTP
 id 2adb3069b0e04-52c8effef73mr1599e87.5.1718028108013; Mon, 10 Jun 2024
 07:01:48 -0700 (PDT)
Date: Mon, 10 Jun 2024 14:01:04 +0000
In-Reply-To: <20240610-tracepoint-v2-0-faebad81b355@google.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240610-tracepoint-v2-0-faebad81b355@google.com>
X-Developer-Key: i=aliceryhl@google.com; a=openpgp; fpr=49F6C1FAA74960F43A5B86A1EE7A392FDE96209F
X-Developer-Signature: v=1; a=openpgp-sha256; l=4510; i=aliceryhl@google.com;
 h=from:subject:message-id; bh=9vYGSS2BmEd2xDDj2+LOFjdqN6wry32Wd02DytPyAGM=;
 b=owEBbQKS/ZANAwAKAQRYvu5YxjlGAcsmYgBmZwdEPykOiap15c/fLpyNtrxN5Tig8vcli+THt
 9+Kjoo82q2JAjMEAAEKAB0WIQSDkqKUTWQHCvFIvbIEWL7uWMY5RgUCZmcHRAAKCRAEWL7uWMY5
 RlZUEACvE9nXD8ucFeS4gyrBRW8aiQYMALTJ1gxduY1c5sqM8XqcB25c0eZu5m4HDkU9MMyAtfX
 BPiuO8DHV2wO93rAEKZsGjPU/ocSKwt/LD1YmSEp3xfklG1nT6q9DOzn74sfaRH/+ILuhU6Tg6s
 BJ31tjZqbOAo2R0n+jMvA5tNFhf4j98gye+pEYcVI+aEzYyVampkt0KzHI3wEYB53cKM6D0QEr3
 Nq3xp6IwHcX1bQ05dXpT9MXn48BEmb9yHoNEIjiKahN9o1vqbXD4fWOyLDPDkbaZYx0Dp/JJOW9
 gz1K+7w12sKb+yj3Q0A5jLnWiEU/VmerzhYJvoqR5mEpSBP/WGvpob2+d1qJOhAvpJMKg1jvteX
 p4YlFkMfoPP6FSnfoUPVaOxgfXuseC9QXqLt90fw+Z8A7CeA+CLDgyGLrt9SFj8UXcRSPoA8wi+
 g4/jdnVsTekzD4hHWr24ydThH/JdyyyiP5LgQy4ceSTrPbCkPabKJ6cezKzCJRhAXTCCCjIUpP9
 5wIyWYSFIRw8xm1+LAwOIt5EAKDunrE8YI6vmqE3fSAsDpd5atJAeINpoW/eKfcw0TSm1+KLquB
 JOab7zCkOrc+KSH2ge1ekNNNGb2nXLvTHitXnCTkMf7jr6Sk2e18J/lf3Q9XCSwHQXvIamfGBm/ LuGEn3Xmspv2gnA==
X-Mailer: b4 0.13-dev-26615
Message-ID: <20240610-tracepoint-v2-1-faebad81b355@google.com>
Subject: [PATCH v2 1/2] rust: add static_key_false
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
 rust/kernel/lib.rs        |  1 +
 rust/kernel/static_key.rs | 87 +++++++++++++++++++++++++++++++++++++++++++++++
 scripts/Makefile.build    |  2 +-
 3 files changed, 89 insertions(+), 1 deletion(-)

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
index 000000000000..6c3dbe14c98a
--- /dev/null
+++ b/rust/kernel/static_key.rs
@@ -0,0 +1,87 @@
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
+        $crate::static_key::_static_key_false! { $key, $keytyp, $field }
+    }};
+}
+
+pub use {_static_key_false, static_key_false};
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
2.45.2.505.gda0bf45e8d-goog

