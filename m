Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F050947ECD6
	for <linux-trace-kernel@vger.kernel.org>; Fri, 15 May 2026 13:59:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778853569; cv=none; b=HzmNwuArkRxMqCG5Z6PBJOfxVh2tNFsGsPCNX0rdZwLwGJJ7V0y829MgUlyl1iw2208jM/D6D7vpvMJwz8DxUetJwvLOojHP4JiWVYnWJAr1kStrdjB7L07rB2mgad0ENCO6feBBbQ7yoBn121Gnhf3fcQAmwHGLBaVc7I1q+0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778853569; c=relaxed/simple;
	bh=U6edhbWh87RxESbg8eIhij7NfrChti3tTebLnBZL1n8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=GFLZ7mtvKPhyNBC4tSU420Sc9zvkPKwUS0RQkzFBQIxVE2eLqlB4OYWVOYdlZ+bIEeiD+eoCengiFdPg86JdyERy1V6qSGyGCxM//I/Br91UnM8RElic0BsFFWnBC3TVPdl6zP/Ec2vk5PccRaiU0BAYzqAjjjCI3bO0iQbOvvM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bitbyteword.org; spf=pass smtp.mailfrom=bitbyteword.org; dkim=pass (2048-bit key) header.d=bitbyteword.org header.i=@bitbyteword.org header.b=tVsz3RNu; arc=none smtp.client-ip=209.85.222.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bitbyteword.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bitbyteword.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bitbyteword.org header.i=@bitbyteword.org header.b="tVsz3RNu"
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-9118b952e2bso201014785a.0
        for <linux-trace-kernel@vger.kernel.org>; Fri, 15 May 2026 06:59:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bitbyteword.org; s=google; t=1778853567; x=1779458367; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=s/RNSJDlIzgHrmpqUt03igCYrU2Quge26dPpYnyZoWQ=;
        b=tVsz3RNuz4mNpHK5dwu05b9eZRuBcBofhS8gDICoN8sUgmsktPRqCiZNMSwS2Yqhd2
         XtJ1I2ZAU491xmDg6g8Zwwtwm4ilUyHiVs8P0E0GzvTW7QpadXJGD2hqV/fXPVk/o86N
         tFNEkZ/xMixCK7O/02hn7UKUGq1f+bMPCHI3nw3GKJasF27PHhtnRrKc7Pc/VnTbWhdo
         L8q+hajR29mlartN17rHfkRDe2Qdhvqk9cOFR0Qfy9qSjzl/Em6XKIQZxl5EBV4lOweH
         7Lx93V8PXPPxy+f3t2yhgGgv4m3A5CzZkyXuEGnFIgBRoeT2BK+iFBTc9wRO3VJmn/HW
         o09g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778853567; x=1779458367;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=s/RNSJDlIzgHrmpqUt03igCYrU2Quge26dPpYnyZoWQ=;
        b=ir3+5O3YJy2drBYSXsJQ7xu7Oj9Wl1wvUpTqxqg5UxFGrxMHtg7vY0GC5HjuIoxu4u
         ytFfIbccZc/L7tip+e/p+dI9I3oxKYjsSw5h10E8qT3Shwh6EkqB/dMLi/+jPQ5I5chS
         xoAFAVQJK8ZrL+cfeK2PugMyfucmeBmuNjEn7z6Jf06PmT8XncZwLeKeCsyRQhIqacS4
         1avXv5c1uJmng1QoptE+PC6emSWEu/DTidcLNLyNQ6z2SgCbETWUZEBjhlSf5r7qD6AE
         6qIMLfSKE5/5/Atz5gXnwzwWIeLeR0JTEwS7OKcH+HGYQqiSC2/v609J1qTZSpKHRPtZ
         d0zw==
X-Forwarded-Encrypted: i=1; AFNElJ8cO8KZwlxQ2czspLTVlpbNauiad/RkSVVEgjjv2JZLrNOYzusSnqWs0qEJRVqHIQqG2gQwvoMRrT9HkSIV2E9cjTk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw2HzImyo5CKjbYbYstiGR0CtD4UEIUk7j0Av2OMrvziivg2HWw
	fGUOBH2YDbzPvtpHyY/qE3/RIHB7vnjPiv2Bhfpu8PBKuF+Fiijppcc0QCiEogqETng=
X-Gm-Gg: Acq92OH5mD0TnIzybPN/elV2KijHMi9QbqUrQFQBkk4pR/mDHH8wPvDvbNhDJSKnwOB
	t2BPAY9ASSE8dNcja2QTPOxeTq5UelTKMFaJgWDSM7wLVXBB0alUg2ko/RaxwoZcYh+S3wOLWlL
	fRKq2/vZmHO3CKe6mpAghCVHHgWAZZGdw/HEN8UeyX4xFQ2zZbSelzS86M4DhOaGOC/058l/i94
	bsJV5H5cRFIG+0hSPgghD1XlqYMY+Lfxeim0OilHlUEWGfBdFdMn2LYfcGC1abxWj4JAyKqkDVK
	mYpYSfzN6GYxGmmniOGvfj2Hdc7X8ETLPNehAbKqrtsURJEFE3Rvwk0fBQlcY3g86+hon5MQE3Y
	d/W1lfy33TFHa+d95MGGlgMZOVqPcT0G01NkJIpMSPiz7SJq5dtpTyc1za61O7+xZjtYQQUlciw
	YTo2O+ypUCLCtNHZlSbvHtccDARPDu
X-Received: by 2002:a05:620a:45a9:b0:910:87f4:9a26 with SMTP id af79cd13be357-911cde539fbmr690372785a.41.1778853566881;
        Fri, 15 May 2026 06:59:26 -0700 (PDT)
Received: from vinp2.lan ([2607:fb92:1900:6734:902:ab48:6190:9c1e])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8c90874e5e4sm53146416d6.6.2026.05.15.06.59.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 May 2026 06:59:26 -0700 (PDT)
From: "Vineeth Pillai (Google)" <vineeth@bitbyteword.org>
To: MyungJoo Ham <myungjoo.ham@samsung.com>,
	Kyungmin Park <kyungmin.park@samsung.com>,
	Chanwoo Choi <cw00.choi@samsung.com>
Cc: linux-pm@vger.kernel.org,
	Steven Rostedt <rostedt@goodmis.org>,
	linux-trace-kernel@vger.kernel.org,
	Vineeth Pillai <vineeth@bitbyteword.org>,
	Peter Zijlstra <peterz@infradead.org>
Subject: [PATCH v3 04/11] devfreq: Use trace_call__##name() at guarded tracepoint call sites
Date: Fri, 15 May 2026 09:59:20 -0400
Message-ID: <20260515135920.2238808-1-vineeth@bitbyteword.org>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Vineeth Pillai <vineeth@bitbyteword.org>

Replace trace_foo() with the new trace_call__foo() at sites already
guarded by trace_foo_enabled(), avoiding a redundant
static_branch_unlikely() re-evaluation inside the tracepoint.
trace_call__foo() calls the tracepoint callbacks directly without
utilizing the static branch again.

Original v2 series:
https://lore.kernel.org/linux-trace-kernel/20260323160052.17528-1-vineeth@bitbyteword.org/

Parts of the original v2 series have already been merged in mainline.
This patch is being reposted as a follow-up cleanup for the remaining
unmerged pieces.

Suggested-by: Steven Rostedt <rostedt@goodmis.org>
Suggested-by: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Vineeth Pillai (Google) <vineeth@bitbyteword.org>
Assisted-by: Claude:claude-sonnet-4-6
---
 drivers/devfreq/devfreq.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
index 82dd9a43dc62..9f71d9dc4a70 100644
--- a/drivers/devfreq/devfreq.c
+++ b/drivers/devfreq/devfreq.c
@@ -370,7 +370,7 @@ static int devfreq_set_target(struct devfreq *devfreq, unsigned long new_freq,
 	 * change order of between devfreq device and passive devfreq device.
 	 */
 	if (trace_devfreq_frequency_enabled() && new_freq != cur_freq)
-		trace_devfreq_frequency(devfreq, new_freq, cur_freq);
+		trace_call__devfreq_frequency(devfreq, new_freq, cur_freq);
 
 	freqs.new = new_freq;
 	devfreq_notify_transition(devfreq, &freqs, DEVFREQ_POSTCHANGE);
-- 
2.54.0

