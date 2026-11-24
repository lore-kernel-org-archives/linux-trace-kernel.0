Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795511593;
	b=Sr4vUaCMqUQc1EodBbE1R559HF2zLuOdRz4chJSU4hO2d9PI50QAKvBlIT8gM01uKWXv
	 GFsgpyufEJwb5fO07vYEqQ2JWdSY5yBVwXzduKtoOwQxtmf+Hnn6Ajnu6pBO6TxG9y1Vz
	 bK4E4rlOKyQbEDCZmQcwNOPMOgLTD+4G9/T7ny+Oc6EdgeR7UPkwDe+Wa0On/ZL0VZIHp
	 6JtKluFPttm2j7PdpeV7iObT8jj5vqcx/cFNaLjj0+VjqXW3x6JR7D7ZIUZFBPFy0VHeU
	 hoZ2xw/0BunALQB82sYYxs70ly9oLXFwy74s/jKxn4J6nbqz4rTYJOBGrLmW/fBMGzw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795511593;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=285F8rEC74nMX2FnbEwp9EQ7OPlK3L+w9+JpHnSwueo=;
	b=rx+OYWwBRRpz+dF+kiQ8YIDM4ALxH1Rkb7wCBM8ed/IILmHBp9jIQY43/AG3kUrUyQZI
	 KHmBGIxcYvnPOzNFXHPQr8i/T1Y51qtNOrYtZiZhKDJ8awgc9AiRP4rd7olgGX/CzbWda
	 q9dyLhZp6KFfbcg0+yJJ1fbZGNnB+4Dq+QvMlZHjN+UJT/l9EZmjydbllF+CRSxJ5JJqO
	 968upu1NJ3w1TnV1uT0q4/YiqWz1aLc2K3u2x6y1DlZDp2afRTp7O+Nyit7O8j1jWysiW
	 4e3iTzD0EAZM0/AewefBjrACU0/T4rBs8VCiqAGNqd/Y9UYTkxXG7DAzr8PiNc8E2fw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="friSTd/w";
	arc=none smtp.remote-ip=209.85.221.49
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44A84606A31E
	for <linux-trace-kernel@vger.kernel.org>; Tue, 24 Nov 2026 09:13:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 44A84606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=friSTd/w
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-48e20ed3b9dso3786108f8f.2
        for <linux-trace-kernel@vger.kernel.org>; Tue, 24 Nov 2026 01:13:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795511591; x=1796116391; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=285F8rEC74nMX2FnbEwp9EQ7OPlK3L+w9+JpHnSwueo=;
        b=friSTd/wC23LUdCRxN5gUfhpqzosug7ADsYKJjMIPbKooCwIRZVm3kva3/zbPUTh7A
         1vBrfDeM1ioBbu1C+f/GKfZOG9NMhQVs3f0EE5MhdV0oONW9HGizBK6Wjwbuuiz9jOOy
         EaPxQGSudCOUBwHxbikdjbLW8zIlRqH6qwDGzatQC+PNfdQcpCB9ItK04QbgSjA+5kk8
         WnM7EhnhsfP60oSm6w57Cn1KGTVRq47US6ktQ7zXx+1uBMavgPYsl2JKJaJ7ClzrtHL5
         bnu+NSPUMGb0w2AuYYEIPWc730iCPLbGdNTHQuMtmT6MiKGjffMLtpWNK9HBH53mNAIR
         6iaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795511592; x=1796116392;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=285F8rEC74nMX2FnbEwp9EQ7OPlK3L+w9+JpHnSwueo=;
        b=FC7bNcyDfETn9Y5TbzWfnWgZqCWedmLfgkboo2XLpwr0cy0q6IkZQfZvhgD6nbmGIA
         uFrD+Q7ZVFQq/CBliBdxs9ZGHwjGm5LnP1MvIyHuwj+VjKMri4I+TlVEmHbaieVhXnBm
         JbtDeNbK1Rti6jakNBDlQHx3kwmBSVYGLQJZiPiqALPSRiTzizzEIblhH5yUNgi9XKjI
         Uh5OGDZYSm4lp/FFF2c2v9XnBD+TdUk3psAdaDPgXBn9U/m8HYJh7fH8cn8UOMV7IQN2
         /UIqj27HEgfle2pI1TjQdZTfW3zh5jLqHnNgoTcWPEX4nmLQK8TVCoe2rFc6S6dH3PEV
         9DVA==
X-Forwarded-Encrypted: i=1; AL+hErENQtHXSsqo1p889BjwLp7aNm6uYnYtasv7r/t3i4vDN93+wRwMwl9cRm1QYmiNGhml5tskJgAXba4IFYqVDiywJbs=@vger.kernel.org
X-Gm-Message-State: APuU4Z+BCk7dXu0KuwnxAvSeTdZdOa19/06wQj0KrZnj9u7jcGqrTYhL
	JnlgL+8ndL3I1lgqO2EZq1D+P6sIjHXJY5O1PIOReMiIB/ll7KogXRX4
X-Gm-Gg: AZFdTZcvaF8QQ6RkeylunOpptDwzYepWlyvY//SgdUbNAdwqlGW1lSra+sbsxF28UJ3
	voriSM2b0MtT14JDWDmaaHRm/p3xw3Fy2vP8kvpEhc+/asvYXr37afG1u0eZs2z8nis2Iecusds
	CNNBEifAt9WEzyHDiMBsT92Org9OUA5SxYGf5fk6aSo5mAnGujMrX10uD8P6qkzqYli0aoD5zlz
	CEGjBGYcDarekRLNOj3zLT0qJK6iHyUDDsTw0xvDz2YbRQQC8NIOOLepYrj87jAcNi9O3GMzDqZ
	k8SN5Y4BbS4mQMvUJnTmCYWoFKz7NXoRxRuL5dA8Y5ePPh8CNsR5lfD/01feQjdVyFRrzdCz+Bh
	el8s9m2MBNXDBg3c99HtEcOwho3V/pa04fSAz2ufrY30eF6cU23OYztCuphTHOxNNYpxFaKJPqO
	2LFIB1gdEVhpdlpEedQjoWgumlYW9jOwaKtqLmVRvArGtmAWE74wV8NiGMvfsd9WN1NWYbYkyD1
	gNcgjvY+lJUFWloL0lPLRPr8FrLxg/YL1nMFlGnYnRt/9PJeXbRso2Vo2OESFfv9xCMEzi4UpJM
	VO01WGXVH0ph90dY6e6Maycu0N/MGZ8=
X-Received: by 2002:a05:6000:4705:b0:4a9:3fba:5eef with SMTP id ffacd0b85a97d-4abb5db6cd8mr25609288f8f.24.1795511591322;
        Tue, 24 Nov 2026 01:13:11 -0800 (PST)
Received: from thinkpad.lan ([2a06:c701:4770:2100:9c14:8a7c:ec54:34])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4ab6baa397asm27559136f8f.48.2026.11.24.01.13.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Nov 2026 01:13:10 -0800 (PST)
From: Avi Weiss <thnkslprpt@gmail.com>
To: mhiramat@kernel.org,
	oleg@redhat.com,
	peterz@infradead.org
Cc: andrii@kernel.org,
	mingo@redhat.com,
	acme@kernel.org,
	namhyung@kernel.org,
	linux-trace-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Avi Weiss <thnkslprpt@gmail.com>
Subject: [PATCH v2] uprobes: avoid postponing return-probe SRCU lease expiration
Date: Tue, 24 Nov 2026 11:12:52 +0200
Message-ID: <20261124091252.567037-1-thnkslprpt@gmail.com>
X-Mailer: git-send-email 2.53.0
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

prepare_uretprobe() reprograms the per-task return-instance timer on every
successfully installed return probe. If a traced outer function remains
active while nested traced calls arrive more frequently than the timeout,
the shared timer keeps moving forward and the outer instance can hold its
SRCU read-side lease indefinitely. This delays unrelated synchronous uprobe
unregister operations that wait for the same SRCU grace period.

Keep the first pending expiry by arming the per-task timer only when it is
not pending. prepare_uretprobe() is the only rearming producer for the
current task's timer. Order return-instance publication before the pending
check, and order the timer core's detach before the callback reads the
return-instance list. These full barriers prevent both sides from missing
an instance at the expiry boundary.

Fixes: dd1a7567784e ("uprobes: SRCU-protect uretprobe lifetime (with timeout)")
Signed-off-by: Avi Weiss <thnkslprpt@gmail.com>
---
v2:
 - use timer_pending() and add_timer() for the per-task single producer
 - explain the actual store/load ordering for the full barriers

 kernel/events/uprobes.c | 18 +++++++++++++++++-
 1 file changed, 17 insertions(+), 1 deletion(-)

diff --git a/kernel/events/uprobes.c b/kernel/events/uprobes.c
index caf444762a27..838e0080ae1b 100644
--- a/kernel/events/uprobes.c
+++ b/kernel/events/uprobes.c
@@ -2052,6 +2052,13 @@ static void ri_timer(struct timer_list *timer)
 	 */
 	raw_write_seqcount_begin(&utask->ri_seqcount);
 
+	/*
+	 * expire_timers() calls detach_timer() before invoking us.
+	 * Order its pending-state store before loading return_instances.
+	 * A publisher that saw the timer pending must be visible here.
+	 */
+	smp_mb();
+
 	for_each_ret_instance_rcu(ri, utask->return_instances)
 		hprobe_expire(&ri->hprobe, false);
 
@@ -2304,7 +2311,16 @@ static void prepare_uretprobe(struct uprobe *uprobe, struct pt_regs *regs,
 	ri->next = utask->return_instances;
 	rcu_assign_pointer(utask->return_instances, ri);
 
-	mod_timer(&utask->ri_timer, jiffies + RI_TIMER_PERIOD);
+	/*
+	 * Order the return-instance store before timer_pending() loads
+	 * the pending state. Either the callback sees this instance or
+	 * we rearm the timer.
+	 */
+	smp_mb();
+	if (!timer_pending(&utask->ri_timer)) {
+		utask->ri_timer.expires = jiffies + RI_TIMER_PERIOD;
+		add_timer(&utask->ri_timer);
+	}
 
 	return;
 free:

base-commit: 6628e7d4c6b25c8d18f1345e3a20d21829aae7e4
