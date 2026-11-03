Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.70.43.101
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793711280;
	b=bKJYlCfz8lDtAvKi/TXFAi5maDsEXp7b8lxIiR7N4agAZPOHZgh7iyLLuhDExO1uVL1D
	 4IDLVq/wGp5lCrWff1zJUgHO64k8UhuVgKg7y0Y6V+hDwuFs29Vi/PXmgzt0JGIkMTk/K
	 8pDwxwWkU9hm5ayD4n/3aj38113tJGMHkEv2EuHM0ItdFskyWq39mVS1DsUHRUai8kIPq
	 9r1BxrEYyleVZ6xz7PE1xHGBKa/3gy3rTD9UogUnWUxlxhB6mQiX1ug8pxf5/NV2LsG8X
	 VMYYzjy7TFfQUiF3sdt4Jcs9kD+48NUs0i8soP2soHV6YAJv6t4hy/qS800sT7uuPWw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793711280;
	h=DMARC-Filter:DKIM-Signature:Date:To:From:Cc:Subject:Message-ID:
	 In-Reply-To:References:Feedback-ID:X-Pm-Message-ID:MIME-Version:
	 Content-Type:Content-Transfer-Encoding;
	bh=MYoRPDO2ldHCIxVRmX3/6hlZLkNTnG6TdvBQMsOgf4o=;
	b=t2K6sK1x4K2Afa1Nv8mqzGAAfaJbIONxgLgos/hDoNYIeE5peLl6h5+3avgIKUyaCRsb
	 g9/iIKT76HnVT6zHGwbwH8mOu3TyfZGLki8+gMYH3kBaBy6v+rO3bfq7xzueVni7z6Umd
	 Og6MRoCJuC4G2anhzoPsY7WTfBl2Sg2fXJ5jZI1gUWjE9iI+HQQQQpvR349793v4q1QrJ
	 MNbtL5FLisIWGejFRqBVwoC5epyTtEU3dwr1Umue1IAdjKXcpu4HzX77oyScKxuXCzu0R
	 L+SnK1wPX/pFkvK9v0zscnBvJ92yiaXFZw2DbUvj8Z/WoQqt/ty4WGMAhnh2LwJjh1A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=proton.me;
	spf=pass smtp.mailfrom=proton.me;
	dkim=pass header.d=proton.me header.i=@proton.me header.a=rsa-sha256 header.s=protonmail2 header.b=fLhOBE6A;
	arc=none smtp.remote-ip=185.70.43.101
Received: from mail-43101.protonmail.ch (mail-43101.protonmail.ch [185.70.43.101])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33A16606D821
	for <linux-trace-kernel@vger.kernel.org>; Tue,  3 Nov 2026 13:07:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 33A16606D821
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=proton.me header.i=@proton.me header.a=rsa-sha256 header.s=protonmail2 header.b=fLhOBE6A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail2; t=1793711277; x=1793970477;
	bh=MYoRPDO2ldHCIxVRmX3/6hlZLkNTnG6TdvBQMsOgf4o=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=fLhOBE6AFg3XWS36/vKh6bMXv3GdufcKcBir46hWFdiMN051iR0bysnC1QRzvwWHd
	 7YxWvFVLxdu62amRoAYorKShfKUd+DF/d+BMNm2m5cFdwmbIm7ri5br63e/F46HrUR
	 CyspmqC7WgBZiHxi1Lus4oX2rPaK4dT1Rwl0ixbSvrw2P8aZ5VDDsbFzvRE6jc9m0X
	 Su6c6owfYYdk609hsTsVUqWPuLDq2M3XN0XTcdxUVnsg02b7GHxXh30D5a62aXsSNx
	 hDItWg89a9WBoTzstcs9C3tVJJEo0H2vsdv+NkSlgRqpU5hXfXUBrxExG8Dc21hAvf
	 GXcGSmNzLJIww==
Date: Tue, 03 Nov 2026 13:07:53 +0000
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>
From: Paolo Bertinetti <paolobertinetti200f4@proton.me>
Cc: Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, James Clark <james.clark@linaro.org>, Kan Liang <kan.liang@linux.intel.com>, Leo Yan <leo.yan@arm.com>, Francesco Nigro <nigro.fra@gmail.com>, Sumanth Korikkar <sumanthk@linux.ibm.com>, linux-perf-users@vger.kernel.org, linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org, regressions@lists.linux.dev
Subject: [PATCH 2/2] perf/hw_breakpoint: Clear stop state in hw_breakpoint_add()
Message-ID: <20261103130732.764081-3-paolobertinetti200f4@proton.me>
In-Reply-To: <20261103130732.764081-1-paolobertinetti200f4@proton.me>
References: <20261103130732.764081-1-paolobertinetti200f4@proton.me>
Feedback-ID: 117280896:user:proton
X-Pm-Message-ID: 23b129853125ff2a3bd4b098af01727aed75e499
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Post: <mailto:linux-trace-kernel@vger.kernel.org>
List-Help: <mailto:linux-trace-kernel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-trace-kernel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Since commit 18dbcbfabfff ("perf: Fix the POLL_HUP delivery breakage"),
__perf_event_overflow() stops the event with pmu->stop() and disables
it when the PERF_EVENT_IOC_REFRESH limit is reached. When userspace
re-arms the event with PERF_EVENT_IOC_REFRESH, the event is enabled
again and pmu->add() is called with PERF_EF_START.

hw_breakpoint_add() sets PERF_HES_STOPPED when PERF_EF_START is
missing, but never clears it. The flag set by pmu->stop() stays, and
perf_bp_event() drops every later hit, so a breakpoint re-armed this
way delivers only its first overflow.

Set the state from PERF_EF_START on every add, as perf_swevent_add()
does.

Fixes: 18dbcbfabfff ("perf: Fix the POLL_HUP delivery breakage")
Assisted-by: LLM
Signed-off-by: Paolo Bertinetti <paolobertinetti200f4@proton.me>
Cc: stable@vger.kernel.org
---
 kernel/events/hw_breakpoint.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/kernel/events/hw_breakpoint.c b/kernel/events/hw_breakpoint.c
index 789add0c185a..7a606213f33d 100644
--- a/kernel/events/hw_breakpoint.c
+++ b/kernel/events/hw_breakpoint.c
@@ -968,8 +968,7 @@ static int hw_breakpoint_event_init(struct perf_event *=
bp)
=20
 static int hw_breakpoint_add(struct perf_event *bp, int flags)
 {
-=09if (!(flags & PERF_EF_START))
-=09=09bp->hw.state =3D PERF_HES_STOPPED;
+=09bp->hw.state =3D (flags & PERF_EF_START) ? 0 : PERF_HES_STOPPED;
=20
 =09if (is_sampling_event(bp)) {
 =09=09bp->hw.last_period =3D bp->hw.sample_period;
--=20
2.53.0


