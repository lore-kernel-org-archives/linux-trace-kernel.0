Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=216.40.44.14
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792697649;
	b=jd3C05eY9m+1N8yZL54evCu3J8OHJZbRvdIs2I/DIwf7KsEQzBKxvUaudVmFow/QvsbM
	 aFxPbGoMjCPGvfJEOdi84AMZNsKuWzTQRHkdhQPQ+ZtqDq9bTXmxaHez+Qx7m861f/IW1
	 LECBM14NqhqEcOWVHL/tELt/DU+gDOIZxa7xU695F50SyGux81g264nzpA06jUnv5posf
	 U5cByDc98jlQjvuZasdCm2cE/oeIYGFgv1BLIYiogtEP8QsytZDtzIrAqXbMfh8bJf0Vd
	 ze5ubVhc5ESYVC2qzA2p4zEF0Bt75qoKzfbAyEWrzN5AF9nvCPixnKbYnzTGoLCExDA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792697649;
	h=DMARC-Filter:Received:Received:Date:From:To:Cc:Subject:Message-ID:
	 X-Mailer:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-Stat-Signature:X-Rspamd-Server:X-Rspamd-Queue-Id:X-Spam-Status:
	 X-Session-Marker:X-Session-ID:DKIM-Signature:X-HE-Tag:X-HE-Meta;
	bh=XGEmX3rrO6ZNvzuBIE8px3VQySnBhxtd5uAE4qFOZ3E=;
	b=VgZ9y5IfBk3hHhP6/WNTPd3SDAl6v71wz3J88h0TLtOGYkmPxv5bUBSp3x2dIwXPGot0
	 GsB82h4iGLbhn0Eoy+ez/T8asV1LVwlYuTO+A4NHIBLCXou2x2RD6DeVoRvqDvdN4R4pc
	 zCiYIsnmpRYbfPCxYK+1fQiJupMR4JFD9bBd3sR+pEkZy53zd0z8zhPnIVeeD6lrtKmh9
	 iTiZRf2ttbRRUG/8YJ1NR4LnA1Z4qc980wJF5CGZgP7l9KXv/licL144vzYB3NoQ/z4oz
	 SMaNzubWsvKZHETRE1Nkw7OaaWjGfYC4ctqZinhI1EsSDmAkYeeSfS3v2uMXXUrrBvg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=goodmis.org;
	spf=pass smtp.mailfrom=goodmis.org;
	dkim=pass header.d=goodmis.org header.i=@goodmis.org header.a=rsa-sha256 header.s=dkim1 header.b=mPUnPZAd;
	arc=none smtp.remote-ip=216.40.44.14
Received: from relay.hostedemail.com (smtprelay0014.hostedemail.com [216.40.44.14])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6F6D606A32D;
	Thu, 22 Oct 2026 19:34:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A6F6D606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=goodmis.org header.i=@goodmis.org header.a=rsa-sha256 header.s=dkim1 header.b=mPUnPZAd
Received: from omf15.hostedemail.com (lb01a-stub [10.200.18.249])
	by unirelay08.hostedemail.com (Postfix) with ESMTP id 3810314028B;
	Thu, 22 Oct 2026 19:34:02 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf15.hostedemail.com (Postfix) with ESMTPA id 7E6571A;
	Thu, 22 Oct 2026 19:34:00 +0000 (UTC)
Date: Thu, 22 Oct 2026 15:33:59 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: LKML <linux-kernel@vger.kernel.org>, Linux Trace Kernel
 <linux-trace-kernel@vger.kernel.org>
Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, "Mario Limonciello
 (AMD)" <superm1@kernel.org>, Eiichi Tsukata <eiichi.tsukata@nutanix.com>,
 Julia Lawall <Julia.Lawall@inria.fr>
Subject: [PATCH] cpuidle: haltpoll: Only define guest_halt_poll_ns
 tracepoint when used
Message-ID: <20261022153359.2433474b@gandalf.local.home>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Post: <mailto:linux-trace-kernel@vger.kernel.org>
List-Help: <mailto:linux-trace-kernel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-trace-kernel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: xgsddhet115e47bhpbj3xzcwb6rrzg6h
X-Rspamd-Server: rspamout01
X-Rspamd-Queue-Id: 7E6571A
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX18vLfBDtB+csZrmrJXl2v5hKOfb2GVk1tE=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=goodmis.org; h=date:from:to:cc:subject:message-id:mime-version:content-type:content-transfer-encoding; s=dkim1; bh=XGEmX3rrO6ZNvzuBIE8px3VQySnBhxtd5uAE4qFOZ3E=; b=mPUnPZAdnk/I+OBvQlEGXeY1E8bPXz0poRUXB0rU+E6doGEKJ0mCdoLKqT5dUDlzW0lhfXq2GAG9KsyuDAMxr3B8492mB+0mQHLO9+NBaAkAZAwJBeYo9fllwrIB6daxEcc4+3XcSK8q5Dhw3cTv8rgIJ7rupKL9uFoYs5iqK3E=
X-HE-Tag: 1792697640-303787
X-HE-Meta: U2FsdGVkX19Ln0EbZhLvlbjasjnnSE+KqIBHSk8VmNYDbw07S64VppDLmIrjqTQwY45WGtp2q2+wOmwel9WgG0GfyKgbGOvlS4nVuuJRHcgp6+lsAOtC8nlDE4QtzJ0uAaMeln8WkoLQGfSi5uRqBnZh137rUjI+1LPMMg2Ybm99wF1n6G6Xa7v2RjyzTPsf4+j6jQu0sWJlu/9SlQcNe26SZN5PBIBXppDaa8iO9Z1VknjuH7UXqBTYgvMMctFEoq/yVmwS/0LgLDFKW0E4SkCpCHyyOppqsATvFduAtR608DAY16244sOSQ+BXL3UpISHTccjh99GahAs/sa/8m+weF6gQ5dae585138gGAqKajnwHunB30+k/0nillHQB

From: Steven Rostedt <rostedt@goodmis.org>

Tracepoints that are defined take up around 5K each, even if they are not
used. When a tracepoint is used only in code when a specific config is
enabled, their definition must also be only defined when the same config
is enabled otherwise it wastes memory.

The tracepoint guest_halt_poll_ns is only used when CONFIG_CPU_IDLE_GOV_HALTPOLL
is enabled. Guard the definition of that tracepoint with the same config.

Fixes: 0da11bf0cab90 ("cpuidle: haltpoll: Add trace points for guest_halt_poll_ns grow/shrink")
Signed-off-by: Steven Rostedt <rostedt@goodmis.org>
---
 include/trace/events/power.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/include/trace/events/power.h b/include/trace/events/power.h
index 370f8df2fdb4..4d17eb307b6a 100644
--- a/include/trace/events/power.h
+++ b/include/trace/events/power.h
@@ -497,6 +497,7 @@ DEFINE_EVENT(dev_pm_qos_request, dev_pm_qos_remove_request,
 	TP_ARGS(name, type, new_value)
 );
 
+#ifdef CONFIG_CPU_IDLE_GOV_HALTPOLL
 TRACE_EVENT(guest_halt_poll_ns,
 
 	TP_PROTO(bool grow, unsigned int new, unsigned int old),
@@ -525,6 +526,8 @@ TRACE_EVENT(guest_halt_poll_ns,
 	trace_guest_halt_poll_ns(true, new, old)
 #define trace_guest_halt_poll_ns_shrink(new, old) \
 	trace_guest_halt_poll_ns(false, new, old)
+#endif /* CONFIG_CPU_IDLE_GOV_HALTPOLL */
+
 #endif /* _TRACE_POWER_H */
 
 /* This part must be outside protection */
-- 
2.53.0

