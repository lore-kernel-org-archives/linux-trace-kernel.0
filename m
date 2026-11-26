Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.72
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795729073;
	b=in8cdDwiLqVYkCAOuN52vH6pqbxlIzDXE+rz320MXZkUZg6lUSbfgUQ6dinuF5rAqcM8
	 T0531mA7C5akKN7fG5EnI/zKSalKgpbsLRdbyqgWk1G9YC469jVcRZOWcnPxZN24DBOCx
	 6ngWwBVFIR2UBYoeeFjFToZckQoZSV2N5hBR6tZMBu3aKxHTkMO6DB7vrY9SlX/b+EY+9
	 MYnrG27QXNWdGKRQM/v71VjGEWZhIpZMp3jW1uTUrB/y1b42cZgBcpHP1A6e3Vi/h49os
	 08rox6dwm0V0smXHHKapBMrL5Q1C/JJKwBpOQ1S1JccGV9TGg1Xl/6kL3+fiMOLZxJQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795729073;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=Pf1Iv+5ca8YRb5pDxLLHR9feXnZofasjqRfhcx/I4d4=;
	b=iiYSxk20rsnAMfk6hAAGRROdU8Kkxg6CVUEVmx75DH1ynf9igvIEFnB+5aRM/i7jmyNK
	 VXkiR/iIFeZrnfaXL2UbpId+cGQugMnVv4+1DK8+Zr0/yNOw6UStReVD/sLN45MDCbco0
	 vr+eGrgrwcTQmMvajqQF4y+h9uONYw4zeT9chXKkDZ+b1FvtwSLNmxEhmGpGdN3IMRnkh
	 +RXmz6tl68Itokr5+qXdZqUJIcRa6Svuwno1L9VSaLfnQjfh4MWpokZNQRlLIBcaqYNuW
	 J5QEryWCkSLSXe7nlJ148/5ZGtSPcDOo8qN+ljNPcN+IH3cwLua4yCGlvD1Y5M3isfg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=Mw7p9x2E;
	arc=none smtp.remote-ip=209.85.128.72
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com [209.85.128.72])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFFBB606A33D
	for <linux-trace-kernel@vger.kernel.org>; Thu, 26 Nov 2026 21:37:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EFFBB606A33D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=Mw7p9x2E
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-4bb67b2c00cso42506115e9.1
        for <linux-trace-kernel@vger.kernel.org>; Thu, 26 Nov 2026 13:37:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1795729071; x=1796333871; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Pf1Iv+5ca8YRb5pDxLLHR9feXnZofasjqRfhcx/I4d4=;
        b=Mw7p9x2EZ9pfyVczwC81vadEIVNDo6/huFqtYIA1nDTuI3L1QnCY+kNqYpar0saKX3
         7HeuP/+fgNyMZMQflAF25wPBgDYb9deavQn8tIMfrKlg31YGtoolHGUpc6V1Hn+eu+Cy
         YA6YIxPonBvcj1UXnhSrXVCILy9lf4HSJU8/phuZxiq08fWOYXtTnytBoF8m8B+CTbyT
         WirFS5V9LDOTOHF7FSBSPTYH2jtRf4vqtB9d6XKvDHRy36eJHEeCqJlm1JixXmDLNXLE
         0Colw0uxWS8UJqiEE0g84scccvFDZ7i9EX/uY/7PFhb0vJzo3f4C8VJEhBL/NqY8M+QL
         Yi4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795729071; x=1796333871;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Pf1Iv+5ca8YRb5pDxLLHR9feXnZofasjqRfhcx/I4d4=;
        b=DezHwHNLGv8Do+wbIhrf9CypDSKGtygsQNixCnMRbJomXHGyUC8KO+1Sw/BLzuRpmE
         qryNV1MHSswmoyU0TaCcAFp6eXtwiwqkFdMbAt7FZs7Jaaw4VgZlORyqed9h9IvDXXlM
         Da5r3HZTOaxw4wltfbRKJbA6bzdDq/5VczQ2FimB8OPMP5JUfJYSJNQ+3E5hvAzU17wA
         0vhmoc2WpJscjEJMbdhnyhCnuk8ZDHufTfmN2akftiWUfuMUrJt82WasYIQl0rZ3gsQy
         GPs30NVqVu25tWJQQJ65+NC8L3yjXKVupYtJQL7l/77PNmLLSnUBNt40i65zOZej4kvG
         FB1w==
X-Forwarded-Encrypted: i=1; AL+hErGf0D/2kQ+V1zJSgFd7JkldIsklzuzi/oIKzLb23Bifj8eNY76Gn49dU13PY27G+ufjwAANgKHPX7SmPFEw2pJwEOM=@vger.kernel.org
X-Gm-Message-State: APuU4Z8/Lp/WW7AyZxsdJXCYygReMXsC0RJwigvmaxWUYdILzZMLkkq9
	2YCblNrVQp9OAH0shZC72nmQ8yoB1FyTSBSh+GFW5CnjkiiZbspit3rdsigOEvmT7O/IUBCOf8y
	+Z3Ry/l1HHOVLCp4mvEv2Bg==
X-Received: from wmxt6-n1.prod.google.com ([2002:a05:600d:8646:10b0:4bb:6c3d:a4ef])
 (user=vdonnefort job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:a085:b0:4bb:85d9:156e with SMTP id 5b1f17b1804b1-4bb8880fe46mr448975345e9.11.1795729071298;
 Thu, 26 Nov 2026 13:37:51 -0800 (PST)
Date: Thu, 26 Nov 2026 21:37:43 +0000
In-Reply-To: <20261126213743.3044079-1-vdonnefort@google.com>
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Post: <mailto:linux-trace-kernel@vger.kernel.org>
List-Help: <mailto:linux-trace-kernel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-trace-kernel+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261126213743.3044079-1-vdonnefort@google.com>
X-Mailer: git-send-email 2.56.1.839.g22a8290db9-goog
Message-ID: <20261126213743.3044079-3-vdonnefort@google.com>
Subject: [PATCH v2 2/2] tracing/histograms: Drop stale absolute timestamp note
 from docs
From: Vincent Donnefort <vdonnefort@google.com>
To: rostedt@goodmis.org, mhiramat@kernel.org, 
	linux-trace-kernel@vger.kernel.org
Cc: mathieu.desnoyers@efficios.com, kernel-team@android.com, 
	linux-kernel@vger.kernel.org, Vincent Donnefort <vdonnefort@google.com>
Content-Type: text/plain; charset="UTF-8"

Since commit b94bc80df648 ("tracing: Use a no_filter_buffering_ref to
stop using the filter buffer") stopped using absolute timestamp for the
histograms, the paragraph about timestamps has been stale. Update it.

Signed-off-by: Vincent Donnefort <vdonnefort@google.com>
---
 Documentation/trace/histogram.rst | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/Documentation/trace/histogram.rst b/Documentation/trace/histogram.rst
index 97b67f05f5ea..9b301b86a4df 100644
--- a/Documentation/trace/histogram.rst
+++ b/Documentation/trace/histogram.rst
@@ -1676,12 +1676,11 @@ features have been added to the hist trigger support:
 
 A note on inter-event timestamps: If common_timestamp is used in a
 histogram, the trace buffer is automatically switched over to using
-absolute timestamps and the "global" trace clock, in order to avoid
-bogus timestamp differences with other clocks that aren't coherent
-across CPUs.  This can be overridden by specifying one of the other
-trace clocks instead, using the "clock=XXX" hist trigger attribute,
-where XXX is any of the clocks listed in the tracing/trace_clock
-pseudo-file.
+the "global" trace clock, in order to avoid bogus timestamp
+differences with other clocks that aren't coherent across CPUs. This
+can be overridden by specifying one of the other trace clocks instead,
+using the "clock=XXX" hist trigger attribute, where XXX is any of the
+clocks listed in the tracing/trace_clock pseudo-file.
 
 These features are described in more detail in the following sections.
 
-- 
2.56.1.839.g22a8290db9-goog

