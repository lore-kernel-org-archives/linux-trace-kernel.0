Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1CC5156237
	for <linux-trace-kernel@vger.kernel.org>; Tue, 28 Oct 2025 02:46:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761619585; cv=none; b=svgfZ3Qk6yZQ6WPKMcDyj6Ydiw3F62DpBX20fVUYk3WIad9uMAjATuL7M566z2bczHcE1Lqb9zgyfsoKoAJ+ghGmtNT2eaj/DcRkuQ6VrAk075FLLYHitt/R0B7+ygpatl5R0Y3NPl1TCwIB/u0fdrJksa+S39JwJdme1qQ0u+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761619585; c=relaxed/simple;
	bh=UOYJw/eVspCjjDJ5cTEEfQXvffJLvGWWPI1fMjR2cuw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=aCAXp71Vv58yY6HU9NXZx+uQyuEDf9/40dnfXXFDT/7ZcS5vzNp0UVG1sThIKom/tbAZnOGhqQJar2YVfaU95IqcAWXgwXbTK6ocyp9nqIAemOkj74SVv0p5rnvinHfnaV87rI+SgF/LwFjl874D8jUmAr8gkGMuvGa0Lu2iL3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l2lSq/gu; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l2lSq/gu"
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-b550eff972eso3657821a12.3
        for <linux-trace-kernel@vger.kernel.org>; Mon, 27 Oct 2025 19:46:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761619583; x=1762224383; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=62+T33sdSoeClcfbGu1+JvoKnh15kO/tZybU0Fphus8=;
        b=l2lSq/guxhDABCC/+S2O3B69TcHRI8wW0+oP1VsAfV79GZ6sLOEOdko+nklbF/m3YC
         syzAoF4SMv/J85HUxUI8TNShNljaopspEBbxZKeEtZdqDHevckyZ76+6FQKVWYivSSuB
         Sm4kQO3ahZ10tDrNK6yHACx4iAajMP0ai5cU4dNA/EW8QW+qAf47ba2FIKM3koYlxbX3
         OLom4OfWahMtjiVX3XhqdrtTatiqyW7B9wtFEC7VeBxCfSiYzAukM7CAZh8XVG25OZ8F
         fbI9gKXqY/s6GuuHrMpmqtSTmp2mt71v3L1pVxiQsEvtFsW41FzbXu0Xrw2tqgpu8iay
         C06w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761619583; x=1762224383;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=62+T33sdSoeClcfbGu1+JvoKnh15kO/tZybU0Fphus8=;
        b=eBQi7e5YIdfpI1MlOiXeFpPtV13oQrfFyeiF2kXRmPTWujYxjrbH5PtoWosjOHMBE5
         p99wn+Ncv91wzF1A9ybgzoQh94XrzKVny+iVlDjXZIM2x77zEJJ56Y+2fBQmdP82o3XT
         XVlzeYfrvHqVqD7v6EEpIZWyppdsdP3+3Z9hCKsPlehzViKGFe+K6+8juda9W5HMxBHe
         w9nk9OkQ2guSOMe1pJpj7Y865koRhA457Sk52EZV5WXpCamDfGtz302jCGafQjlQRmOh
         CWvoQmDTBCG/7eOALSdinSIYaWE+1rC/u1rrgTuU+MDLyGizbeHjsfvZFMtQVw4tUkdj
         v/qQ==
X-Forwarded-Encrypted: i=1; AJvYcCWyQ/ONFor+MUdbnMIcNBiI56w6r+YDmPRKrU+EbumV8HoRYDCUtMmkrd54C7PYyBmPpS67kKPw5gAzP4vP59WF1MQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YystMpaRHPxmmiA136FJPdn6DOBiJj3vsVnaP/sTgxkVgk/EGGK
	R+cq1llrto78DOsFtQC2jx7RFe+F7nD7zMEHKtAMk6ABrY9BF4B88CXn
X-Gm-Gg: ASbGncsNeI8jAsbWv08LiCDZx91Pg5hTAI+sgc7x0GkhQ3RLrIGCxzuBQvOp1k8ZOb+
	7xaFqHag3HyEfmhZqHtGdSRnyqZOYbsJWzRIGScwpjskuFRzPGSSQfDdL65fS3M3RNV9Z1qTGVF
	0KM6yh9oWxgxqDQ52OQS0m2CnshJa4KnOxT90xaPivUqQHmG7hc6a/MIDHR+l7yS9ShAHbouQyW
	hq3WxFbnaoX46o2c6uddzQ7Dd0IACqzu+AgskZwot70/zDMorvWE4oN/1f/3kxYbq2t5zwZms0j
	ZEd81KAArVq7+dV75OaQmTFEbImWyElJ+fpei+pM6486Gaw7/7mMrdjbHgUMgEIABePevP0ZKq8
	HkfNWBrH9l2MXCEgz+jTOyBed2nmfgRO7CiUU/JuJ959lcLuK3BaGrgfBtuYNqQxI
X-Google-Smtp-Source: AGHT+IHjDra+n/Y/5rpgwd2IMljqC2H80LYbMEG8/KLghcmrk07q4zSyHxZmNxEExoDWDcVO4ATGOw==
X-Received: by 2002:a17:902:da8f:b0:26d:353c:75cd with SMTP id d9443c01a7336-294cb381901mr28107345ad.21.1761619582838;
        Mon, 27 Oct 2025 19:46:22 -0700 (PDT)
Received: from localhost ([2600:8802:b00:9ce0::f9da])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29498d0a60fsm97375305ad.39.2025.10.27.19.46.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Oct 2025 19:46:22 -0700 (PDT)
From: Chaitanya Kulkarni <ckulkarnilinux@gmail.com>
To: Johannes.Thumshirn@wdc.com
Cc: linux-block@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	martin.petersen@oracle.com,
	dlemoal@kernel.org,
	mathieu.desnoyers@efficios.com,
	mhiramat@kernel.org,
	rostedt@goodmis.org,
	axboe@kernel.dk,
	Chaitanya Kulkarni <ckulkarnilinux@gmail.com>,
	syzbot+153e64c0aa875d7e4c37@syzkaller.appspotmail.com
Subject: [PATCH] blktrace: use debug print to report dropped events
Date: Mon, 27 Oct 2025 19:46:19 -0700
Message-Id: <20251028024619.2906-1-ckulkarnilinux@gmail.com>
X-Mailer: git-send-email 2.40.0
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The WARN_ON_ONCE introduced in
commit f9ee38bbf70f ("blktrace: add block trace commands for zone operations") 
triggers kernel warnings when zone operations are traced with blktrace
version 1. This can spam the kernel log during normal operation with
zoned block devices when userspace is using the legacy blktrace
protocol.

Currently blktrace implementation drops newly added REQ_OP_ZONE_XXX
when blktrace userspce version is set to 1.

Remove the WARN_ON_ONCE and quietly filter these events. Add a
rate-limited debug message to help diagnose potential issues without
flooding the kernel log. The debug message can be enabled via dynamic
debug when needed for troubleshooting.

This approach is more appropriate as encountering zone operations with
blktrace v1 is an expected condition that should be handled gracefully
rather than warned about, since users may be running older blktrace
userspace tools that only support version 1 of the protocol.

With this patch :-
linux-block (for-next) # git log -1 
commit c8966006a0971d2b4bf94c0426eb7e4407c6853f (HEAD -> for-next)
Author: Chaitanya Kulkarni <ckulkarnilinux@gmail.com>
Date:   Mon Oct 27 19:26:53 2025 -0700

    blktrace: use debug print to report dropped events
linux-block (for-next) # cdblktests
blktests (master) # ./check blktrace
blktrace/001 (blktrace zone management command tracing)      [passed]
    runtime  3.805s  ...  3.889s
blktests (master) # dmesg  -c
blktests (master) #  echo "file kernel/trace/blktrace.c +p" > /sys/kernel/debug/dynamic_debug/control
blktests (master) # ./check blktrace
blktrace/001 (blktrace zone management command tracing)      [passed]
    runtime  3.889s  ...  3.881s
blktests (master) # dmesg  -c
[   77.826237] blktrace: blktrace v1 cannot trace zone operation 0x1000190001
[   77.826260] blktrace: blktrace v1 cannot trace zone operation 0x1000190004
[   77.826282] blktrace: blktrace v1 cannot trace zone operation 0x1001490007
[   77.826288] blktrace: blktrace v1 cannot trace zone operation 0x1001890008
[   77.826343] blktrace: blktrace v1 cannot trace zone operation 0x1000190001
[   77.826347] blktrace: blktrace v1 cannot trace zone operation 0x1000190004
[   77.826350] blktrace: blktrace v1 cannot trace zone operation 0x1001490007
[   77.826354] blktrace: blktrace v1 cannot trace zone operation 0x1001890008
[   77.826373] blktrace: blktrace v1 cannot trace zone operation 0x1000190001
[   77.826377] blktrace: blktrace v1 cannot trace zone operation 0x1000190004
blktests (master) #  echo "file kernel/trace/blktrace.c -p" > /sys/kernel/debug/dynamic_debug/control
blktests (master) # ./check blktrace
blktrace/001 (blktrace zone management command tracing)      [passed]
    runtime  3.881s  ...  3.824s
blktests (master) # dmesg  -c 
blktests (master) # 

Reported-by: syzbot+153e64c0aa875d7e4c37@syzkaller.appspotmail.com
Fixes: f9ee38bbf70f ("blktrace: add block trace commands for zone operations")
Signed-off-by: Chaitanya Kulkarni <ckulkarnilinux@gmail.com>
---
 kernel/trace/blktrace.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/kernel/trace/blktrace.c b/kernel/trace/blktrace.c
index 6ad3807a5b73..776ae4190f36 100644
--- a/kernel/trace/blktrace.c
+++ b/kernel/trace/blktrace.c
@@ -364,9 +364,12 @@ static void __blk_add_trace(struct blk_trace *bt, sector_t sector, int bytes,
 		break;
 	}
 
-	if (WARN_ON_ONCE(bt->version == 1 &&
-		     (what >> BLK_TC_SHIFT) > BLK_TC_END_V1))
+	/* Drop trace events for zone operations with blktrace v1 */
+	if (bt->version == 1 && (what >> BLK_TC_SHIFT) > BLK_TC_END_V1) {
+		pr_debug_ratelimited("blktrace v1 cannot trace zone operation 0x%llx\n",
+				(unsigned long long)what);
 		return;
+	}
 
 	if (cgid)
 		what |= __BLK_TA_CGROUP;
-- 
2.40.0

