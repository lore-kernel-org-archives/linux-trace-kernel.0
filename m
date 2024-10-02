Received: from forwardcorp1d.mail.yandex.net (forwardcorp1d.mail.yandex.net [178.154.239.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1774F1D0E2C;
	Wed,  2 Oct 2024 16:08:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727885342; cv=none; b=sYbnhXmK6C0y1WMtTkFyDv9Yig53pl2dHB7D8hFEhwerTu9HpSWT0EaGqPYTbJPOCD+oz4VNg0xPGh+IO57D0d7w2El/J7vqUNV3CDi2Ekal+l1aV5rkdYdU50xXJ8kedoE7/SEnXGaGdgioKxn60WMOPgutViAV/BUOddSF4jg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727885342; c=relaxed/simple;
	bh=RzR2IgYML2BjBfFi3e8WjlUv5LhzDc1Kx6kdJlVAxG4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fNXHbyZx3EDfRibHOYZYIvMIyS5CC1tibIXU/06ELrgWMPXDHpxdSs8ssq0jvJq78JxZlRj4xariTSUjkCGqqzzELOsNG7n1ULyJ/JA1qFGTVtFyLRuWGjx0rj4ivAzUWe9OdiXaSPGEOYn9cYqUPMBslrqb3JOlSzN9Y5MaO3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex-team.com; spf=pass smtp.mailfrom=yandex-team.com; dkim=pass (1024-bit key) header.d=yandex-team.com header.i=@yandex-team.com header.b=qPH+N7ke; arc=none smtp.client-ip=178.154.239.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex-team.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yandex-team.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex-team.com header.i=@yandex-team.com header.b="qPH+N7ke"
Received: from mail-nwsmtp-smtp-corp-main-56.klg.yp-c.yandex.net (mail-nwsmtp-smtp-corp-main-56.klg.yp-c.yandex.net [IPv6:2a02:6b8:c42:b1cb:0:640:2a1e:0])
	by forwardcorp1d.mail.yandex.net (Yandex) with ESMTPS id 41C2460A74;
	Wed,  2 Oct 2024 19:08:58 +0300 (MSK)
Received: from dellarbn.yandex.net (unknown [10.214.35.248])
	by mail-nwsmtp-smtp-corp-main-56.klg.yp-c.yandex.net (smtpcorp/Yandex) with ESMTPSA id Z8emWD2IhiE0-cMZ3bEDP;
	Wed, 02 Oct 2024 19:08:57 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.com;
	s=default; t=1727885337;
	bh=jFKAUNHTYomsdDtZ7yDs1yniRUoGKOv+DuJ1bapdrNI=;
	h=Message-ID:Date:In-Reply-To:Cc:Subject:References:To:From;
	b=qPH+N7keP7fgNy1yVdHKgLdk6Vbwy5VUI37bXZuORZnoZCxar0lhhrLgbGMX/rOtr
	 LTEiQPxkzr/9Y1AEX6RNxsh7BzoT/zDNJBuWYiGmRAwpny8Drj92A+n8avkCV2ys3e
	 +ZVTj+7zFN+pwSdGU0uASrLQaonWOGPG+JWQX8yM=
Authentication-Results: mail-nwsmtp-smtp-corp-main-56.klg.yp-c.yandex.net; dkim=pass header.i=@yandex-team.com
From: Andrey Ryabinin <arbn@yandex-team.com>
To: linux-kernel@vger.kernel.org
Cc: Alexander Graf <graf@amazon.com>,
	James Gowans <jgowans@amazon.com>,
	Mike Rapoport <rppt@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-mm@kvack.org,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	Eric Biederman <ebiederm@xmission.com>,
	kexec@lists.infradead.org,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	linux-trace-kernel@vger.kernel.org,
	valesini@yandex-team.com,
	Andrey Ryabinin <arbn@yandex-team.com>
Subject: [RFC PATCH 3/7] [hack] purgatory: disable purgatory verification.
Date: Wed,  2 Oct 2024 18:07:18 +0200
Message-ID: <20241002160722.20025-4-arbn@yandex-team.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241002160722.20025-1-arbn@yandex-team.com>
References: <20241002160722.20025-1-arbn@yandex-team.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Yandex-Filter: 1

Kstate changes data in kexec segments after the calculation
of the checksum, so we don't pass purgatroy verification stage.

Disable it for now. Proper solution will be later, in next versions of
the patchset.

Signed-off-by: Andrey Ryabinin <arbn@yandex-team.com>
---
 arch/x86/purgatory/purgatory.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/x86/purgatory/purgatory.c b/arch/x86/purgatory/purgatory.c
index aea47e7939637..cdec5f21282a7 100644
--- a/arch/x86/purgatory/purgatory.c
+++ b/arch/x86/purgatory/purgatory.c
@@ -45,6 +45,8 @@ void purgatory(void)
 {
 	int ret;
 
+	if (IS_ENABLED(CONFIG_KSTATE))
+		return;
 	ret = verify_sha256_digest();
 	if (ret) {
 		/* loop forever */
-- 
2.45.2

