Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=168.119.38.16
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795103503;
	b=xyu2IAlbm7SBR8t7cj1bF9EAYhTa+qbGUIYe5RsRBpH6YWR2yUOrHmda+DPQc66YQmE3
	 87Ba3pIWXmcl/i8/tFTt5FL3nQW0fo6DD//9KBdju93jLBRur42HcWQeJfRX7vPRq1+n3
	 niatqNtXOSWKLvlmsXQoSBRXERIUBD8v6SXGw4JCoNWMhoukZIHFVF2KhdV77gMudn1Xp
	 7Su/g7a1ph/ap8fnjmW0SFED46KRdegUsJ5t6PrSz9Kj9YoXzJJ/FTA3lpWt+mY+Gufnj
	 hkVg49VHqyJJO6skU5LZvUECfQV145RoJP0gPdc0fLdRIfmtkxqa6E+cseYTZBxBsRQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795103503;
	h=DKIM-Signature:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=oldfSV8z6n572HTJ8Ch6mwfdA74UTjNoU7vXZNbGaho=;
	b=flF+sM8TpCuhLsToObY5/6p7iOQ/eN2BUYouq+v5Ms4jQQWi5ECmYBR9Ss8vHS8fgzTr
	 oZpdm8y1xtrA5eUleaFbHU64aQ7TsH3CQ/QdHfGp0fnbfzqpsQ2Ta35q7jW5FbmAcQ/2h
	 28yRBJeRvBsFU+Q842fQwMZ477HVROsW2wMngcAnA7N/6JU4xnML+aJR9WMCL9NMNpdLw
	 s4kYs+vKgr1o33gdDpxNiYSdSRYwg+OBt5g7tNYmZRGD0K/Cp+mkL7zx8hf/QAl3THtLA
	 Ilj5g3rycvl+HgUmR70GCyl7gK7xUl6i0ITmPorxbHVJzM2YvJv8ONA83qfUA3Pp3eQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=permerror header.from=sipsolutions.net;
	spf=pass smtp.mailfrom=sipsolutions.net;
	dkim=pass header.d=sipsolutions.net header.i=@sipsolutions.net header.a=rsa-sha256 header.s=mail header.b=r+NP1eky;
	arc=none smtp.remote-ip=168.119.38.16
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B808560A2609;
	Thu, 19 Nov 2026 15:51:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=permerror header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.a=rsa-sha256 header.s=mail header.b=r+NP1eky
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=oldfSV8z6n572HTJ8Ch6mwfdA74UTjNoU7vXZNbGaho=;
	t=1795103502; x=1796313102; b=r+NP1ekyKvawEww3USUwLHPwF0pAQdWDf8WHu57zg0GpOfM
	LGDRk4MC1MJ4/4GUpuxrUmCzxf4DyQTmpAHUhchdRD4xbFfYA/Zg9TgQ2kW0ub/1vmQcCIzRy3fkh
	fNQUU1yIKlFZwO4Obl4b773DGroynASROFft2xA7VoNRhP98lfv4btcf9DUQXpssN0raT2V5AI/Rh
	qXfiuU6tjgyiyzNICy/VwYVrdvhp7dIrmoBK1BGopO6EaR1vjYh4wY97ojXWasYJODi4pmdn/NjG0
	MAvjkKpgSdSXQ8S4iLq2NgXiO0yDOZtfMSVxB8OPdMANZWkXoP+ROdRxS9j9Jpew==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__ECDSA_SECP256R1_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1xU4QE-00000004ZOV-3NK2;
	Thu, 19 Nov 2026 16:51:39 +0100
From: Johannes Berg <johannes@sipsolutions.net>
To: linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org
Cc: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Ilya Maximets <i.maximets@ovn.org>,
	Matthieu Baerts <matttbe@kernel.org>,
	Aaron Conole <aconole@redhat.com>,
	Eelco Chaudron <echaudro@redhat.com>,
	dev@openvswitch.org,
	Adrian Moreno <amorenoz@redhat.com>,
	Antoine Tenart <atenart@kernel.org>,
	Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH v8 2/4] tracing/timer: use __print_sym()
Date: Thu, 19 Nov 2026 16:48:42 +0100
Message-ID: <20261119155133.355849-8-johannes@sipsolutions.net>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261119155133.355849-6-johannes@sipsolutions.net>
References: <20261119155133.355849-6-johannes@sipsolutions.net>
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Post: <mailto:linux-trace-kernel@vger.kernel.org>
List-Help: <mailto:linux-trace-kernel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-trace-kernel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Johannes Berg <johannes.berg@intel.com>

Use the new __print_sym() in the timer tracing, just to show
how to convert something. This adds ~80 bytes of .text for a
saving of ~1.5K of data in my builds.

Note the format changes from

print fmt: "success=%d dependency=%s", REC->success, __print_symbolic(REC->dependency, { 0, "NONE" }, { (1 << 0), "POSIX_TIMER" }, { (1 << 1), "PERF_EVENTS" }, { (1 << 2), "SCHED" }, { (1 << 3), "CLOCK_UNSTABLE" }, { (1 << 4), "RCU" }, { (1 << 5), "RCU_EXP" })

to

print fmt: "success=%d dependency=%s", REC->success, __print_symbolic(REC->dependency, { 0, "NONE" }, { 1, "POSIX_TIMER" }, { 2, "PERF_EVENTS" }, { 4, "SCHED" }, { 8, "CLOCK_UNSTABLE" }, { 16, "RCU" }, { 32, "RCU_EXP" })

since the values are now just printed in the show function as
pure decimal values.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 include/trace/events/timer.h | 18 +++++-------------
 1 file changed, 5 insertions(+), 13 deletions(-)

diff --git a/include/trace/events/timer.h b/include/trace/events/timer.h
index 3aa0608c6361..d45259d96069 100644
--- a/include/trace/events/timer.h
+++ b/include/trace/events/timer.h
@@ -441,26 +441,18 @@ TRACE_EVENT(itimer_expire,
 #undef tick_dep_mask_name
 #undef tick_dep_name_end
 
-/* The MASK will convert to their bits and they need to be processed too */
-#define tick_dep_name(sdep) TRACE_DEFINE_ENUM(TICK_DEP_BIT_##sdep); \
-	TRACE_DEFINE_ENUM(TICK_DEP_MASK_##sdep);
-#define tick_dep_name_end(sdep)  TRACE_DEFINE_ENUM(TICK_DEP_BIT_##sdep); \
-	TRACE_DEFINE_ENUM(TICK_DEP_MASK_##sdep);
-/* NONE only has a mask defined for it */
-#define tick_dep_mask_name(sdep) TRACE_DEFINE_ENUM(TICK_DEP_MASK_##sdep);
+#define tick_dep_name(sdep) { TICK_DEP_MASK_##sdep, #sdep },
+#define tick_dep_mask_name(sdep) { TICK_DEP_MASK_##sdep, #sdep },
+#define tick_dep_name_end(sdep) { TICK_DEP_MASK_##sdep, #sdep }
 
-TICK_DEP_NAMES
+TRACE_DEFINE_SYM_LIST(tick_dep_names, TICK_DEP_NAMES);
 
 #undef tick_dep_name
 #undef tick_dep_mask_name
 #undef tick_dep_name_end
 
-#define tick_dep_name(sdep) { TICK_DEP_MASK_##sdep, #sdep },
-#define tick_dep_mask_name(sdep) { TICK_DEP_MASK_##sdep, #sdep },
-#define tick_dep_name_end(sdep) { TICK_DEP_MASK_##sdep, #sdep }
-
 #define show_tick_dep_name(val)				\
-	__print_symbolic(val, TICK_DEP_NAMES)
+	__print_sym(val, tick_dep_names)
 
 TRACE_EVENT(tick_stop,
 
-- 
2.56.1

