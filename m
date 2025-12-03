Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75E4C30147E
	for <linux-trace-kernel@vger.kernel.org>; Wed,  3 Dec 2025 14:48:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764773304; cv=none; b=MA+6DjVnwvElgOy9+yzySgjK6LnAXge2p29+2OeRBUPKcqbvDHtZDfMXLBqWdF6gyGYqBNc2WU3v+d9QLHNTWlR5GeBnbC/oxsytbpxWFQElgwjTZcEF60XbtmjxwAcS6znf/roXlllHPk+IkQWeicJIjuwiTMzANsLgLBsuOXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764773304; c=relaxed/simple;
	bh=olnH5YETSchoWfW4eXNpzYuZguSxzG935v3fEmxsmwI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=BpfZ8nQAznODL51E4zqpwn71wZw0dEL1c4GcxvyQ6VizFLpKDXCo5Bg+d1AW59XhcGE6w76ZyX9VkIqidjQxcvGrTRoI0LOL6ZZ0q1dSJEr+GWKi2Whe4A+U/l+olFpkjGsFXz61Py/ykLK2RDTajUhga+tUYKCUhFTBpztxfuc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ErVG7R36; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ErVG7R36"
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-47799717212so50317395e9.3
        for <linux-trace-kernel@vger.kernel.org>; Wed, 03 Dec 2025 06:48:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1764773300; x=1765378100; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=KgQO/RKm33Ct3E94qzLO0Z9kCba8cyghV+1zPxuiX6c=;
        b=ErVG7R36WcxGa+tKbxN9NnoYt1gVqFq0LAMljfFwPiQ5V06zljPuPkDmOE6CXod92s
         vFeQFbT9AgVObxZRjItSsuFFgHCaNuXeKz6yps4XhtvtuxtS9rBBNHFSPMRHY1nHp6RV
         8cgZZdYRcHvnSywaNEcTLVwgWoJEobM+hkPwINxD4dOSv8mOmoRor/e9H9bw35g4OzVd
         4ScPEExMm9NwCh+AnKH3XhD3s6IOO8UYfANacxx4L+Edw4Pe8YiiakmsYwZ4MEyWXSy+
         FzVQ/3Uea6Mkji1VMfKbMU2XwpO9WLWpdrFQOxuUN4iHv6C3j2Wp+zTaYa5hIlfXBGQe
         rraA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764773300; x=1765378100;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KgQO/RKm33Ct3E94qzLO0Z9kCba8cyghV+1zPxuiX6c=;
        b=wgaTcp0rrUjx5SRf6mdfM0VCAIr/p/RSdo5D3tWEy4JAyGC81LU0IH8VrXYDMJgnj5
         snVcVYGnNlqMsYQZ48EDU/BU2/CIgzwS9KjvPeHqP/smmwmRVFKizimDyqwNjxOWPRRb
         GKBRiOEnXur9FYkvgJt7jujtD7/kG2agRZDG5v9qie4Y9W9ZOhqH3UcxO4Sr5F64ZLf2
         6LU9IlI3+qDS38Ri0gbvh0xPuuoALP9My2BlunEDvJLxJxuZ7VvWqybpH+V4AtKwJyqt
         RJ2yXNle+lcyUPP+FLPfydbLP3sRtJyLUOW7o+/5Ng/33WFBajtrq2Tu5VrW5PHHEqyV
         tYqw==
X-Forwarded-Encrypted: i=1; AJvYcCVi+J9i8gi8eRKEqcmETIjSYmFmdp/vphKGqioTyGQOaH1MBdlDxx/rUoLPsN38MvqpdFOS8ovTYyiGTSSjghAHPJs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw3o18LW/rY5J30qNEBuCfm15d450PNqF4QoE6zTpNPDYAM8mwb
	Wxig5C4DeqpID+dfahwVAPSXNPGeZR04ePxeBiQXGPUEqhLOS8Y0bvVyMUjEQsycC4XCeRZnOck
	jOs58fxSV9pMHxyzDyw==
X-Google-Smtp-Source: AGHT+IGc0cYyki8k/OJB1kgKye7QlKFFb2A2oXwvpN/U8/8XOsbYC3faMiqMIxyPsnhgPjvmr7AlBJPCnK1Bm0Q=
X-Received: from wmco13.prod.google.com ([2002:a05:600c:a30d:b0:477:7f1b:5f89])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:3152:b0:477:7b16:5f9f with SMTP id 5b1f17b1804b1-4792af403c5mr30063255e9.31.1764773299805;
 Wed, 03 Dec 2025 06:48:19 -0800 (PST)
Date: Wed, 03 Dec 2025 14:48:08 +0000
In-Reply-To: <20251203-binder-trace1-v1-0-22d3ffddb44e@google.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251203-binder-trace1-v1-0-22d3ffddb44e@google.com>
X-Developer-Key: i=aliceryhl@google.com; a=openpgp; fpr=49F6C1FAA74960F43A5B86A1EE7A392FDE96209F
X-Developer-Signature: v=1; a=openpgp-sha256; l=958; i=aliceryhl@google.com;
 h=from:subject:message-id; bh=olnH5YETSchoWfW4eXNpzYuZguSxzG935v3fEmxsmwI=;
 b=owEBbQKS/ZANAwAKAQRYvu5YxjlGAcsmYgBpME2x1G/TRt7z6UAKUDD8HZvJemxzpA7iTVT9m
 ND+NbaUP7aJAjMEAAEKAB0WIQSDkqKUTWQHCvFIvbIEWL7uWMY5RgUCaTBNsQAKCRAEWL7uWMY5
 RpRpD/4ycmVSA29L7VAouHz0CZrZOwMAXS0lO6KSs8C6pH9GDvWktpr8neYng/zkAkI8aI1Resc
 m8C71CCe6gkHHkT5bmPvj3+PDkF18Kgu1ya2drFPHHxOi6973Wh3CGGughX8RPEQ9oNgJkTYBkm
 ONxnTD5J5/wE1AwL3NEAuYRMFYTHXS2ho7WcV5LRmOhPXEPetZfudxmkIvn7JnsDpk86qp6vhaP
 8/2qSqADa/gVy1K5X18SR3IqTiCTDudOskqcvhuxsf6TjdBHB3ywc2l1K9GbhjLrFARp1C/qAZu
 97A1O6srzp1Fk/PqMF6rhLAASMZE2MMN3zn0JdilqqFaLY1P3M9Hf49sJGO1DoEYTZVF0g66JxE
 6bzIuOzNyi+wlygmqqg4IcAQo/8NrXnFS8dmNB+1RITwmtVfhF973zrzoViAG5xCWaXSZoL8rfX
 RQgEgEbxiKOlf9eR8fh4yLPmeFlltDDW/5g8o71sxHusb/esPMUEtaKxOT21ARThx9+bFu6DxdX
 J6BkZdg4wGsLe2axsRQHgCLtK8QtOImp7WtLNeXpjLDiCbYgFqIOZapAuGRezaQD2JyAOqwZFsy
 pNqj0ydvAcI3mDHrwuQcONumt3fXk8/qMm9LNTatZkvZqM+aepZFY5tr94L+/d1uznsTmLNovap Jrfm+7vBd+3CXXw==
X-Mailer: b4 0.14.2
Message-ID: <20251203-binder-trace1-v1-1-22d3ffddb44e@google.com>
Subject: [PATCH 1/2] rust: sync: add Arc::DATA_OFFSET
From: Alice Ryhl <aliceryhl@google.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Carlos Llamas <cmllamas@google.com>, 
	Steven Rostedt <rostedt@goodmis.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	"=?utf-8?q?Bj=C3=B6rn_Roy_Baron?=" <bjorn3_gh@protonmail.com>, Benno Lossin <lossin@kernel.org>, 
	Andreas Hindborg <a.hindborg@kernel.org>, Trevor Gross <tmgross@umich.edu>, 
	Danilo Krummrich <dakr@kernel.org>, "=?utf-8?q?Arve_Hj=C3=B8nnev=C3=A5g?=" <arve@android.com>, Todd Kjos <tkjos@android.com>, 
	Martijn Coenen <maco@android.com>, Joel Fernandes <joelagnelf@nvidia.com>, 
	Christian Brauner <brauner@kernel.org>, Suren Baghdasaryan <surenb@google.com>, rust-for-linux@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Alice Ryhl <aliceryhl@google.com>
Content-Type: text/plain; charset="utf-8"

This constant will be used to expose some offset constants from the Rust
Binder driver to tracepoints which are implemented in C. The constant is
usually equal to sizeof(refcount_t), but may be larger if T has a large
alignment.

Signed-off-by: Alice Ryhl <aliceryhl@google.com>
---
 rust/kernel/sync/arc.rs | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/rust/kernel/sync/arc.rs b/rust/kernel/sync/arc.rs
index 289f77abf415a2a52e039a2c0291413eda01217c..921e19333b895f0d971591c4753047d0248a3029 100644
--- a/rust/kernel/sync/arc.rs
+++ b/rust/kernel/sync/arc.rs
@@ -240,6 +240,9 @@ pub fn new(contents: T, flags: Flags) -> Result<Self, AllocError> {
         // `Arc` object.
         Ok(unsafe { Self::from_inner(inner) })
     }
+
+    /// The offset that the value is stored at.
+    pub const DATA_OFFSET: usize = core::mem::offset_of!(ArcInner<T>, data);
 }
 
 impl<T: ?Sized> Arc<T> {

-- 
2.52.0.158.g65b55ccf14-goog

