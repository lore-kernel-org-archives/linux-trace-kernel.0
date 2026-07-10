Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9024137AA81;
	Fri, 10 Jul 2026 05:31:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783661476; cv=none; b=us0gwEihAR9vNoT5H6RLvhJb0sNN7Dy2LmuG/3kySrgH52DdvUTaWcl0DVl1gYXkAhx9tst7pLpV7W1aNQgGjpj8ImuI6yySDJpIC+HIGJdbbxEGtixrXotTEztj1JIP3eU6Qe8dzJsodywy4XNjCtK4m4wg9Nx3R9zqlBKJ7so=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783661476; c=relaxed/simple;
	bh=N3UNjWOifoQciMT8bRgQar7ekquskU0egj4OqvXH15w=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Ng86Nd1hJ8V269RYMr55EGwbrXcCMnn0hd1jFuZHTbv4TSEcsYnOH7KEK/+dimiiE8Xdl+RpvSnESRj6CDgoky7ejnCfHUqr/XrrfyrjV4fWRJxuvLCyfRE26aha1LiQEJDpvKwDysuJNIKpAMZAlivzGjDLCCSkDdGGCqv6aaA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WTwPePKK; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WTwPePKK"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 4A299C2BCFC;
	Fri, 10 Jul 2026 05:31:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1783661476;
	bh=N3UNjWOifoQciMT8bRgQar7ekquskU0egj4OqvXH15w=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=WTwPePKKIBMnJ83AaPUEC7cUUPfM//rKzNoWC2n47+rKDIXlR9KkD2IYKRCa1mz/t
	 y9TvjYaISfnHmEzXrvxC49FYTriD4f+whjvU8AyYf82kRqMBsFeEOiBcRtqNoiQ5e1
	 8g+G2cJ4MMTnvsPAN+bomjEMkWbeakkfHK1C5Gz2/FxmRJ96C40aYePCDqbMgDLXQF
	 2BtA7Dfmgy3giEep4D9XWCziwp/vVufH/gqoaDCc7aYuMHuHI9bQMYOGQpL+zKdO7c
	 3S8FOvIFMxr3JSxDePMPirSxpLd/iEGDFTcDTKtyL92FLuEICXxPsZDilaR59PDYPO
	 Zu+kyupNOvSPg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 313EFC43458;
	Fri, 10 Jul 2026 05:31:16 +0000 (UTC)
From: Eugene Mavick via B4 Relay <devnull+m.mavick.dev@kernel.org>
Date: Fri, 10 Jul 2026 13:30:43 +0800
Subject: [PATCH v2 5/5] MAINTAINERS: add entries for ref_trace_final_put
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260710-refcount-final-put-trace-v2-5-557cfce860a2@mavick.dev>
References: <20260710-refcount-final-put-trace-v2-0-557cfce860a2@mavick.dev>
In-Reply-To: <20260710-refcount-final-put-trace-v2-0-557cfce860a2@mavick.dev>
To: Will Deacon <will@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
 Boqun Feng <boqun@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
 Gary Guo <gary@garyguo.net>, Steven Rostedt <rostedt@goodmis.org>, 
 Masami Hiramatsu <mhiramat@kernel.org>, 
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
 Andrew Morton <akpm@linux-foundation.org>, Dennis Zhou <dennis@kernel.org>, 
 Tejun Heo <tj@kernel.org>, Christoph Lameter <cl@gentwo.org>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
 linux-mm@kvack.org, Eugene Mavick <m@mavick.dev>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=665; i=m@mavick.dev;
 h=from:subject:message-id;
 bh=qY0jw9qG8rTERqF+Mm/JywN3bXE+e644UzadbgoAM88=;
 b=owGbwMvMwCU2V/5U3e1aE3/G02pJDFkBzT1/DcKkKm17S69+OZR4JdNRoG2tTpF8UDNXWP7Mx
 Uyp9nkdpSwMYlwMsmKKLDVZCe4ZK2clGh+d1AMzh5UJZAgDF6cATCR6NcM/I6ODKmyXLLZ/eT5J
 9dAyI6OMB79Djq3a8L/smAyrtc/jXkaGdfeUHiw5E3Xwy0SZeqWnt9eVFZw1Wb+ssaP0hajyx/y
 1XAA=
X-Developer-Key: i=m@mavick.dev; a=openpgp;
 fpr=7C6A604768A99A6133C5928C9D1FCA7EDB7D344F
X-Endpoint-Received: by B4 Relay for m@mavick.dev/default with auth_id=850
X-Original-From: Eugene Mavick <m@mavick.dev>
Reply-To: m@mavick.dev

From: Eugene Mavick <m@mavick.dev>

Add new files added in the patch series to MAINTAINERS

Signed-off-by: Eugene Mavick <m@mavick.dev>
---
v2:
This patch was added in v2
---
 MAINTAINERS | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 10e8253181d3..2dbb7441906e 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -4210,7 +4210,10 @@ S:	Maintained
 F:	Documentation/atomic_*.txt
 F:	arch/*/include/asm/atomic*.h
 F:	include/*/atomic*.h
+F:	include/linux/ref_trace.h
 F:	include/linux/refcount.h
+F:	lib/ref_trace.c
+F:	lib/tests/ref_trace_kunit.c
 F:	scripts/atomic/
 F:	rust/kernel/sync/atomic.rs
 F:	rust/kernel/sync/atomic/

-- 
2.51.2


