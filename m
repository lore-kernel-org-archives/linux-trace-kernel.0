Received: from mail-ed1-f74.google.com (mail-ed1-f74.google.com [209.85.208.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38E792FFF81
	for <linux-trace-kernel@vger.kernel.org>; Wed,  3 Dec 2025 14:48:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764773302; cv=none; b=BqpHeVGUkwvDboNk5+zJpqQQfwmxa/tzRdPgJBN/MJSN69IDBmROHSO6wO7YE1EVjU7pcGeExkkSnMsihXLUzSdCrxudsxyyd7NeWBxcL42Stwe9bmtdP0iMIOgdEyVnopBzOCrWRFircGi6d5X6+/QD/Laaeodb7oY74H98M8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764773302; c=relaxed/simple;
	bh=vFB2acYC6UTXJg6iXZzHyk84lfxBya/wDI98yOVq4Q4=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=UGV5/jA5xc6w8+GJOUnICEl15+AbZbUFZpuEfXhXUmVFJM8FLUlAFigCzsRx+pEcMuc/uA5v97zzgIY8WzjBYoVfloHtocExe6rZ2xspfmqZrz+xANJbr5OZl8cGZJ74EJBFljEGYcObGtAAo6BU8MpMNcriS2fkW5D74m8mbsk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=WoluHTsL; arc=none smtp.client-ip=209.85.208.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="WoluHTsL"
Received: by mail-ed1-f74.google.com with SMTP id 4fb4d7f45d1cf-6407e61783fso6556586a12.0
        for <linux-trace-kernel@vger.kernel.org>; Wed, 03 Dec 2025 06:48:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1764773298; x=1765378098; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=R083YyKkmXAmCxeRjmCF4aawwgPM5D8Vwqqo+kBw6zI=;
        b=WoluHTsLKEwcsmZFOK9v0ZjWml/9HyKS8LhYvORJ7bCI7KSbkHY+SdXT5u40ywcAlb
         b6B7Icc+SNJomF6KbozL4r3WyvvU91dlN6uSjsFiGl/Qp6W39cS/ZchLiiY4sJDkjY2F
         mtcRB+ZY9nX17HKsAXM9S/Oqu9PUTnMWEtZ6q9EQvbjrLxTsCqM1DjKznv8/cK0VBizT
         80Cq2zgMQN1T09/7h19K6cSK4L+Ysk5oxxJoXstTLBXnEXiE+NEKwodxWaAGWlKIGTbR
         Fbm8jaPBTu161yZ5OTeQ931Ymvbfa/mROCvaKHxA76QyIXnjyM9CRtRN0T3xQhkbp/yw
         Y9hQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764773298; x=1765378098;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=R083YyKkmXAmCxeRjmCF4aawwgPM5D8Vwqqo+kBw6zI=;
        b=a9YybWEJ8xR7oOPACwa3uWx73PsgZ9ZgJY75/mjUYtBd11AFuiS6+LGvE9Ka2OIvW7
         goI9xPRL0QafoY6Oy+6h8OkBZBhz5VLcRRgYncvnfUnDjwdFvQSJOTzN54P13PVnQJQC
         5EoRlKY5TQpHZRAS94+AGUw5+g+NrDUT5InOUPw9jDy7ZCi/DO8736t8jbIw2Cm8cTnl
         N5D/NyriGOln7p6j2y4eTA3VATNw9nSWQK8Dtai3YKCjk1ZLb08zig0W6X1nTMBes9gu
         fWfxgODxT3iuVgCvfb+O13aByypYL/fWPdszmVu3uhVLkDZpG2Zi/+65OFAKBZEOR1UK
         2/6w==
X-Forwarded-Encrypted: i=1; AJvYcCVERi6AgeqTx6fXEXjs8PFQvN5PC5d4RUzEB8Lr29XYwII6wCfCvN9BZLwjuGhVu6suUa88+NszJa0AlKWbDTM1y70=@vger.kernel.org
X-Gm-Message-State: AOJu0YzdA901GuhIbxgT3BsfaG9brxAz/QAzSsxni7M+Nfaa+bxYeis1
	Q3RwlDziKS616Oupfrr6lJia7VR+yfUlFiK4YRpM48cbFZC2WK+Vtl/hH+SSWVoEoqDeK3rwJPt
	puMNwQcObCJooJnVhCA==
X-Google-Smtp-Source: AGHT+IEOBrAUlvapQuOyBy5jLmZU8vMlqp6OWY7wtvuY1C4CBIRQn9B9eNChTLF1OBbMVW1ZRA4jP3gDO07ldLs=
X-Received: from ejctb5.prod.google.com ([2002:a17:907:8b85:b0:b73:7130:388f])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:907:3da1:b0:b73:6c97:af4b with SMTP id a640c23a62f3a-b79dc761116mr253949466b.45.1764773298562;
 Wed, 03 Dec 2025 06:48:18 -0800 (PST)
Date: Wed, 03 Dec 2025 14:48:07 +0000
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAKdNMGkC/x3MQQqAIBBA0avErBMcJaGuEi0sx5qNxRgRiHdPW
 r7F/wUyCVOGqSsg9HDmMzVg38F2+LST4tAMRpsBEa1aOQUSdYvfCNVqgnVjdJashtZcQpHf/zc vtX6ifxjIXwAAAA==
X-Change-Id: 20251113-binder-trace1-b2d369f63e30
X-Developer-Key: i=aliceryhl@google.com; a=openpgp; fpr=49F6C1FAA74960F43A5B86A1EE7A392FDE96209F
X-Developer-Signature: v=1; a=openpgp-sha256; l=1251; i=aliceryhl@google.com;
 h=from:subject:message-id; bh=vFB2acYC6UTXJg6iXZzHyk84lfxBya/wDI98yOVq4Q4=;
 b=owEBbQKS/ZANAwAKAQRYvu5YxjlGAcsmYgBpME2q3rzX3kZ/g2sO46GEgDlqP/69bBV5ZQAjj
 YNx+34KjjqJAjMEAAEKAB0WIQSDkqKUTWQHCvFIvbIEWL7uWMY5RgUCaTBNqgAKCRAEWL7uWMY5
 Rl9PEACfjHXgsSQs1n2Agm9h7nDpT9RCupir36hDaGt15q2kZU14zBE9ojt8gzeFWWFyQajGbVa
 tRdZOkktVnqjZYAoNdufX07/XLD2Qw2ItItsYYf302fNsc7HKToL4qBc2Uy1n+D8WEc4L7DkWw+
 kypM/O6cLFXeWzhneVRJerJen03UZ0tCbvuqFFjpxe3l8Klr3G633ciYnrWyfwqd/WBMWIQ1Mpb
 lNDV+Yxv031WD36KQLwP5HLwTjRc0Dqg+RaO5LUKjgVVekofm+/lQ4LrYTiGdah0RsCRPy+ltUQ
 SifBXS+t+a+ZrGxfoItxbNZK3kgzgB+HHcokH6by1EeBn7gzxlyWfeEQ5gyu8khxxuBhopFQsZ0
 1WUq86Vt3xlNP/HasmFB+Upn4vSdByHyG1GGYksWRirMpVCHKIt5hVgTLAtPp4c6Q7XhVRXgUHm
 +WKSWJLSadavjuimRXBQg46llVRqg8bRMxkRRby3+Uwgi8fqVN6zpsmZ2BxGn27h28rvGqxorIr
 KCaRjR31rsQ6qQj/Yme253wnPtDsrClDQkU552SpTzW7X6yp0msA6wcpTl9mD1YwJRERCQMU5J7
 2zcDekDvTeYl7FevQpHKI99C4FtVhfD5k2uB9/WPzqa0yB5tfUQ5tdtgjRbC0qpu74ogpuvxMBk PXnNOno5o+3Cefw==
X-Mailer: b4 0.14.2
Message-ID: <20251203-binder-trace1-v1-0-22d3ffddb44e@google.com>
Subject: [PATCH 0/2] Access Rust fields from TP_fast_assign in TRACE_EVENT
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

This patch shows one possible mechanism for accessing Rust fields from
the TP_fast_assign() body of a trace event. The idea is to have the
driver expose the offsets of the relevant fields, and to have the C code
use those offsets to access the data.

I'm currently using this mechanism in the Rust Binder driver on
Android's fork of 6.12.

Signed-off-by: Alice Ryhl <aliceryhl@google.com>
---
Alice Ryhl (2):
      rust: sync: add Arc::DATA_OFFSET
      rust_binder: add binder_transaction tracepoint

 drivers/android/binder/node.rs              |  8 +++
 drivers/android/binder/process.rs           |  7 +++
 drivers/android/binder/rust_binder.h        | 79 +++++++++++++++++++++++++++++
 drivers/android/binder/rust_binder_events.h | 30 +++++++++++
 drivers/android/binder/rust_binder_main.rs  |  8 +++
 drivers/android/binder/thread.rs            |  1 +
 drivers/android/binder/trace.rs             | 21 ++++++++
 drivers/android/binder/transaction.rs       | 14 +++++
 rust/kernel/sync/arc.rs                     |  3 ++
 9 files changed, 171 insertions(+)
---
base-commit: 211ddde0823f1442e4ad052a2f30f050145ccada
change-id: 20251113-binder-trace1-b2d369f63e30

Best regards,
-- 
Alice Ryhl <aliceryhl@google.com>

