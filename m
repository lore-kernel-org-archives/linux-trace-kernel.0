Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=111.22.67.151
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794386525;
	b=tK3pc0r3l2sGAtJka3bIqW7NzISwl4ADW9eyhyzt3iOvMBMIbSGnTfmWBwQNr2fm1u60
	 CS07K8Cf7B2UiHn2m0xyVdvtYo3u/gro0hzNA2iDPOMrSqXVAsry4fdan7d1qbVgtXJeT
	 zO6xY21TY+vkyHmHpzJXfZ59uFTIs1Q2ho9EAVkhjDD49LI4fpIwKygaD3CDBV1FGHZXw
	 IhUVUMp2YcmfUXgkKyAQNdiSWITboDeUnJ3Q5cDQ1wepLDC7LnKvf1NXkUa9sSJsnskuU
	 lmz3evh6ZAGQimSi61CtQ8L5E8Fmv6izbzE9yGoUtf/wy3v2uRtphRJiIWO5FlsOJtw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794386525;
	h=DMARC-Filter:DKIM-Signature:X-RM-TagInfo:X-RM-SPAM-FLAG:Received:
	 X-RM-TRANSID:X-RM-TagInfo:X-RM-SPAM-FLAG:Received:X-RM-TRANSID:From:
	 To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=cF82mrHTDZpkaSuHyLbk0Yub3KZp+FUUf62Im0HEdUE=;
	b=auLjGlPMLXlMy4uZAhi4c4y9cm9K++KcUE5aXJGEhSmvoxRQpmhfkr3+w8Y86j5qJkD2
	 oRLAyWUkwKTjLpxt0uk5Bzfe2lW2dtbdz9yog+ByhBtHMIbGfc233fHEPcxC3h4LS6LtE
	 RGO3u8eRMQA5sX8UoKeFhuY4rznR/6/QHF/oUhWEqhA4xF/06EWvtDmJ3VJMTmouUCXG9
	 1QH+i06e14qARYMTEVolzmvr4o0iWsxEmWsYp2QKKhW0QNzDW1XBrKfqHq/IOVuMxG9K4
	 PF9wbGtdGOSlJm23RNdlnjm7NbfE7uHXc571Hu6HcE5BRgy6SThQDWXmfzmuUAbt8mQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=cmss.chinamobile.com;
	spf=pass smtp.mailfrom=cmss.chinamobile.com;
	dkim=pass header.d=cmss.chinamobile.com header.i=@cmss.chinamobile.com header.a=rsa-sha256 header.s=default header.b=XnuCebEs;
	arc=none smtp.remote-ip=111.22.67.151
Received: from cmccmta8.chinamobile.com (cmccmta8.chinamobile.com [111.22.67.151])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1534F606A332;
	Wed, 11 Nov 2026 08:42:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1534F606A332
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=cmss.chinamobile.com header.i=@cmss.chinamobile.com header.a=rsa-sha256 header.s=default header.b=XnuCebEs
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=cmss.chinamobile.com; s=default; l=0;
	h=from:subject:message-id:to:cc:mime-version;
	bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
	b=XnuCebEsmqomfWY1TVEbIs36VXivRfcU6axz05atUi//c2/xCXr6tX5EppRUzdSX8oYPvra7aM3XE
	 hsRjgFgbAp1mu9TaWabif+9e0OEahbR5Bc3kJn6Ua18hkfDk4gVrv32AnREMdlC2BJRIwnzaiKWzcr
	 ZSFKx17epLtE8cEE=
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from spf.mail.chinamobile.com (unknown[10.188.0.87])
	by rmmx-syy-dmz-app06-12006 (RichMail) with SMTP id 2ee66af42a58b69-a37a9;
	Wed, 11 Nov 2026 16:42:02 +0800 (CST)
X-RM-TRANSID:2ee66af42a58b69-a37a9
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from devin-VMware-Virtual-Platform.localdomain (unknown[10.55.1.72])
	by rmsmtp-syy-appsvr05-12005 (RichMail) with SMTP id 2ee56af42a59652-d5ab4;
	Wed, 11 Nov 2026 16:42:02 +0800 (CST)
X-RM-TRANSID:2ee56af42a59652-d5ab4
From: Zhu Jun <zhujun2@cmss.chinamobile.com>
To: rostedt@goodmis.org
Cc: vdonnefort@google.com,
	mhiramat@kernel.org,
	mathieu.desnoyers@efficios.com,
	linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	syzbot+530af6f1e5c230588975@syzkaller.appspotmail.com,
	Zhu Jun <zhujun2@cmss.chinamobile.com>
Subject: [PATCH] ring-buffer: Annotate the speculative iterator event copy
Date: Wed, 11 Nov 2026 16:42:01 +0800
Message-ID: <20261111084201.80984-1-zhujun2@cmss.chinamobile.com>
X-Mailer: git-send-email 2.51.0
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

A non-consuming iterator can copy an event while the writer overwrites
its page. The reader lock only excludes other readers, so KCSAN reports
the memcpy() racing with event reservation.

The iterator already checks the page stamp and committed size after the
copy and retries if the writer entered the page. Mark the speculative
copy as an intentional race; only the validated private copy is used.

Fixes: 785888c544e0 ("ring-buffer: Have rb_iter_head_event() handle concurrent writer")
Signed-off-by: Zhu Jun <zhujun2@cmss.chinamobile.com>
---
 kernel/trace/ring_buffer.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
index 18f023cf1d6f..197015ff715a 100644
--- a/kernel/trace/ring_buffer.c
+++ b/kernel/trace/ring_buffer.c
@@ -3566,7 +3566,8 @@ rb_iter_head_event(struct ring_buffer_iter *iter)
 		/* Writer corrupted the read? */
 		goto reset;
 
-	memcpy(iter->event, event, length);
+	/* The page stamp below detects a concurrent overwrite of this copy. */
+	data_race(memcpy(iter->event, event, length));
 	/*
 	 * If the page stamp is still the same after this rmb() then the
 	 * event was safely copied without the writer entering the page.
-- 
2.51.0



