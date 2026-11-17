Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=45.157.188.9
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794910882;
	b=nVVPJPpZIyKcEf8L/PXB+KxKvuL5+1ev3dgBEfKV3WG3yJ4JF4fDkWMGOOonyAAE0z5O
	 VJpxHlr/NQbpXlNr7o3I5AT6hj7TLYHfx4TEzl3q6/6QbRTml9aB6PlOe02qrtUFAbJev
	 Asp4rUxYgpZaYAOPAlYU3xOAl25ppKuydA2FmD9tcMPnv5Lq03jd7s/HwJp9wbP7q3SmN
	 9oeGmHG8cJ4rmoK3LiEW9sW51E15mODHvOhgPTt4oR2Li3QIYxSnOBzYiQNmR/Ez+hhoJ
	 EYOF9sNglb6PMc90s48FOGwAyym4xnqD3tY9EAKTd0vTRKA5OPdQ5EvED2EYz9lYUAg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794910882;
	h=DMARC-Filter:Received:DKIM-Signature:Received:From:To:Cc:Subject:
	 Date:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-Infomaniak-Routing;
	bh=Iiv/cJO0pBonTymFc7ctl7IU2+wBhxtuntDoc8g/SJ0=;
	b=tKChbn8oy/zOARofIfcoM3YqRrupDd36iMfls4gTWjjCljtMAgbNpEXiIpC8iZwowPq4
	 RP3P7+Kc59qQEspVYWhhWdfxZgzYPDjYR3OoxkRqLvSy4e8KnMT7NfMWc/YKlmvBuFbd1
	 pyJdQcwQdYJfkCre6VX9KBVqkPYQ1GG2uQh9dQ0pLCIC4GqrSHhelywI/jxPEpiOj0EDA
	 V7PO6rVkCigrcacctdRDhrqnlfe4wCywIlRky/K4Z8nhtd7lnbljUGWZSLo7sdhmV7kbM
	 ru0STBBByHpx2XpkWLP0t4VFoQxo2EyDRM5aYKKnS4MHN5WlV+ZhKG1qGNphWbG9EQQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=digikod.net;
	spf=pass smtp.mailfrom=digikod.net;
	dkim=pass header.d=digikod.net header.i=@digikod.net header.a=rsa-sha256 header.s=20191114 header.b=mXeqEexc;
	arc=none smtp.remote-ip=45.157.188.9
Received: from smtp-bc09.mail.infomaniak.ch (smtp-bc09.mail.infomaniak.ch [45.157.188.9])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0D9E606A333
	for <linux-trace-kernel@vger.kernel.org>; Tue, 17 Nov 2026 10:21:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F0D9E606A333
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.a=rsa-sha256 header.s=20191114 header.b=mXeqEexc
Received: from smtp-4-0000.mail.infomaniak.ch (smtp-4-0000.mail.infomaniak.ch [10.7.10.107])
	by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4jTLNt6W0fzZC3;
	Tue, 17 Nov 2026 11:21:18 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1794910878;
	bh=Iiv/cJO0pBonTymFc7ctl7IU2+wBhxtuntDoc8g/SJ0=;
	h=From:To:Cc:Subject:Date:From;
	b=mXeqEexcXJxoEjyMssJUIhpL7MeBzIdnyWabLguFkyRtWR106pqOCMFMSXoC0//C3
	 OdYbJjT8C5jseT5iTQrAGG+VC/+r6E7TmtgbK1gRCP0qGHd7ORHVXw+DDHiyNo9XDs
	 iakd+i3NF+NJp5PdRN+c41dlPpbgF1QGdEgvcOug=
Received: from unknown by smtp-4-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4jTLNs3FDkzMSZ;
	Tue, 17 Nov 2026 11:21:17 +0100 (CET)
From: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>
To: =?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack@google.com>
Cc: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
	Christian Brauner <brauner@kernel.org>,
	Eric Paris <eparis@redhat.com>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Paul Moore <paul@paul-moore.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	audit@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH 0/4] Landlock: Fix namespace and capability denials
Date: Tue, 17 Nov 2026 11:21:03 +0100
Message-ID: <20261117102110.2524197-1-mic@digikod.net>
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Post: <mailto:linux-trace-kernel@vger.kernel.org>
List-Help: <mailto:linux-trace-kernel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-trace-kernel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Infomaniak-Routing: alpha

Hi,

Landlock namespace denial records identify the namespace type and ID but
do not say whether the hook denied creation or entry.  The ID is object
context rather than an operation discriminator: after allocating IDs
before the namespace_init hook, construction carries an ID for a new
namespace that never becomes reachable, whereas entry carries the
existing target ID.

Capability denial tracepoints have the complementary problem.  They
report the capability number but omit the exact credentials and target
user namespace checked by the capable hook.  Either argument can differ
from current state, so reconstructing them from the tracing task can
misidentify the security relationship being checked.

Fix both denial interfaces without changing Landlock policy or UAPI.
Namespace denials gain distinct internal CREATE and ENTER request tags
and print namespace_op=create or namespace_op=enter after the common
blockers field and before the namespace type and ID.  Both operations
remain context for the same namespace.use blocker and describe semantic
hooks rather than exact syscall provenance.

Capability denial tracepoints gain the authoritative checked cred and
target user_ns as synchronous BTF-only arguments.  They are not copied
into the raw ring buffer, printed, audited, retained, or used for the
Landlock verdict.  Capability options remain omitted: CAP_OPT_NOAUDIT
suppresses the denial record, while the remaining bits do not explain a
Landlock decision.

Paul and Eric, please review the audit record addition and field
ordering.  The new namespace_op field is Landlock-local because Landlock
is currently the only LSM_AUDIT_DATA_NS emitter; it can move to the
generic formatter if another LSM later needs the same contract.

The base includes Christian's namespace-ID allocation fix.  Patch 1
distinguishes namespace creation and entry in audit and trace output.
Patch 2 supplies the checked capability objects to typed trace consumers.
Patch 3 completes quiet ENTER coverage in the Landlock selftests.  Patch
4 documents the namespace operation field.

Mickaël

Mickaël Salaün (4):
  landlock: Distinguish namespace creation and entry denials
  landlock: Add capability objects to denial tracing
  selftests/landlock: Test namespace denial operations
  landlock: Document namespace denial operations

 Documentation/admin-guide/LSM/landlock.rst | 21 +++++++------
 Documentation/trace/events-landlock.rst    | 20 ++++++++-----
 include/trace/events/landlock.h            | 35 +++++++++++++++-------
 security/landlock/audit.c                  | 10 +++++--
 security/landlock/cap.c                    | 11 +++++--
 security/landlock/log.c                    |  6 ++--
 security/landlock/log.h                    | 12 +++++++-
 security/landlock/ns.c                     | 10 ++++---
 security/landlock/trace.c                  | 12 ++++++--
 tools/testing/selftests/landlock/ns_test.c | 25 ++++++++++++----
 tools/testing/selftests/landlock/trace.h   |  1 +
 11 files changed, 118 insertions(+), 45 deletions(-)


base-commit: aebb7274476403040d582c61478df8f4a7bf9cd3
-- 
2.56.0

